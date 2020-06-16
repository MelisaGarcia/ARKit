//
//  ViewController.swift
//  RedWallsGreenFloor
//
//  Created by Andrea Dancek on 2020-06-15.
//  Copyright © 2020 Melisa Garcia. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

class ViewController: UIViewController, ARSCNViewDelegate {

    @IBOutlet var sceneView: ARSCNView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the view's delegate
        sceneView.delegate = self
        
        // Show statistics such as fps and timing information
        sceneView.showsStatistics = true
        
        // Create a new scene
        let scene = SCNScene(named: "art.scnassets/ship.scn")!
        
        // Set the scene to the view
        sceneView.scene = scene
        sceneView.debugOptions = [.showFeaturePoints, .showWorldOrigin]
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let configuration = ARWorldTrackingConfiguration()
        configuration.planeDetection = [.horizontal, .vertical]

        sceneView.delegate = self
        

        // Run the view's session
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }
    func createPlanes(planeAnchor: ARPlaneAnchor) -> SCNNode {
           let node = SCNNode()
           
           let geometry = SCNPlane(width:
               CGFloat(planeAnchor.extent.x),height:
               CGFloat(planeAnchor.extent.z))
           node.geometry = geometry
           
           node.eulerAngles.x = -Float.pi / 2
           node.opacity = 0.25
           
           return node
       }
    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor : ARAnchor){
        guard let planeAnchor = anchor as? ARPlaneAnchor
            else {return}
        let wallsAndFloor = createPlanes(planeAnchor: planeAnchor)
        node.addChildNode(wallsAndFloor)
        let planes = wallsAndFloor.geometry
        
        if planeAnchor.alignment == .horizontal{
            planes?.materials.first?.diffuse.contents = UIColor.green
        }else if planeAnchor.alignment == .vertical {
            planes?.materials.first?.diffuse.contents = UIColor.red
        }
    }
    

    // MARK: - ARSCNViewDelegate
    
    func renderer(_renderer: SCNSceneRenderer, didUpdate node: SCNNode, for anchor : ARAnchor){
        guard let planeAnchor = anchor as? ARPlaneAnchor,
        let planeNode = node.childNodes.first,
        let plane = planeNode.geometry as? SCNPlane
        else {return}
        
        planeNode.position = SCNVector3(planeAnchor.center.x, 0, planeAnchor.center.z)
        plane.width = CGFloat(planeAnchor.extent.x)
        plane.height = CGFloat(planeAnchor.extent.z)
    }
/*
    // Override to create and configure nodes for anchors added to the view's session.
    func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
        let node = SCNNode()
     
        return node
    }
*/
    
    func session(_ session: ARSession, didFailWithError error: Error) {
        // Present an error message to the user
        
    }
    
    func sessionWasInterrupted(_ session: ARSession) {
        // Inform the user that the session has been interrupted, for example, by presenting an overlay
        
    }
    
    func sessionInterruptionEnded(_ session: ARSession) {
        // Reset tracking and/or remove existing anchors if consistent tracking is required
        
    }
}
