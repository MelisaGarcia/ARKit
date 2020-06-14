//
//  ViewController.swift
//  SceneKit-Primitives
//
//  Created by Andrea Dancek on 2020-06-13.
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
       
        sceneView.autoenablesDefaultLighting = true
//        sceneView.debugOptions = [.showWorldOrigin]
        
        loadCampus()
        loadSecondBuilding()
        loadTreesRow()
            
    }
    func loadCampus (){
        let scene = SCNScene(named: "art.scnassets/campus.scn")!
        
        sceneView.scene = scene
    }
    func loadSecondBuilding(){
        let baseNode = SCNNode()

        let SecondBuildingBase = SCNBox(width: 1.5, height : 1.0, length: 1.0, chamferRadius: 0.0)
        SecondBuildingBase.firstMaterial?.diffuse.contents = UIColor.brown
        baseNode.geometry = SecondBuildingBase
        baseNode.scale = SCNVector3(0.5, 0.5, 0.5)
        let basePosition = SCNVector3(-0.8, -0.5, -2.0)
        baseNode.position = basePosition
        sceneView.scene.rootNode.addChildNode(baseNode)


        let roofNode = SCNNode()

        let secondBuildingRoof = SCNCone(topRadius: 0.0, bottomRadius: 0.8, height: 1.0)
        secondBuildingRoof.firstMaterial?.diffuse.contents = UIColor.red
        roofNode.geometry = secondBuildingRoof
        roofNode.scale =  SCNVector3(0.5, 0.5, 0.5)
        let roofPosition = SCNVector3(-0.8, 0.03, -2.0)
        roofNode.position = roofPosition
        sceneView.scene.rootNode.addChildNode(roofNode)

    }

    func loadTreesRow(){
        let trunkNode = SCNNode()
        
        let trunkGeometry = SCNCylinder(radius: 0.05, height: 0.5)
        trunkGeometry.firstMaterial?.diffuse.contents = UIColor.brown
        trunkNode.geometry = trunkGeometry
        trunkNode.scale =  SCNVector3(0.5, 0.5, 0.5)
        let trunkPosition = SCNVector3(0.0, -0.5, -1.0)
        trunkNode.position = trunkPosition
        
        sceneView.scene.rootNode.addChildNode(trunkNode)
        
        let crownNode = SCNNode ()
        
        let crownGeometry = SCNSphere(radius: 0.5)
        crownGeometry.firstMaterial?.diffuse.contents = UIColor.green
        crownNode.geometry = crownGeometry
        
        crownNode.scale =  SCNVector3(0.5, 0.5, 0.5)
        let crownPosition = SCNVector3(0.0, 0.2, -0.1)
        crownNode.position = crownPosition
        
        trunkNode.addChildNode(crownNode)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration()

        // Run the view's session
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }

    // MARK: - ARSCNViewDelegate
    
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
