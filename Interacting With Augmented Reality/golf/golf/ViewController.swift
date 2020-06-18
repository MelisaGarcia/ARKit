//
//  ViewController.swift
//  golf
//
//  Created by Andrea Dancek on 2020-06-18.
//  Copyright © 2020 Melisa Garcia. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

class ViewController: UIViewController, ARSCNViewDelegate {
    
    var golfAdded = false

    @IBOutlet var sceneView: ARSCNView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the view's delegate
        sceneView.delegate = self
        
        // Show statistics such as fps and timing information
        sceneView.showsStatistics = true
        
        // Create a new scene
        let scene = SCNScene(named: "art.scnassets/golf.scn")!
        
        // Set the scene to the view
        sceneView.scene = scene
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration()
        configuration.planeDetection = .horizontal

        // Run the view's session
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }
    func addField(result: ARHitTestResult){
        let golfScene = SCNScene(named: "art.scnassets/golf.scn")
        
        guard let golfNode = golfScene?.rootNode.childNode(withName: "Golf", recursively: false) else{
            return
        }
        
        let planePostition = result.worldTransform.columns.3
        golfNode.position = SCNVector3(planePostition.x,planePostition.y, planePostition.z)
        
        sceneView.scene.rootNode.addChildNode(golfNode)
    }
    func createGolfBall(){
        guard let currentFrame = sceneView.session.currentFrame else {return}
        
        let ball = SCNNode(geometry: SCNSphere( radius: 0.10))
        ball.geometry?.firstMaterial?.diffuse.contents = UIColor.white
        
        let cameraTransform = SCNMatrix4(currentFrame.camera.transform)
        ball.transform = cameraTransform
        
        sceneView.scene.rootNode.addChildNode(ball)
    }

    @IBAction func ScreenTapped(_ sender: UITapGestureRecognizer) {
        if !golfAdded {
            let touchLocation = sender.location(in: sceneView)
            let hitTestResult = sceneView.hitTest(touchLocation, types: [.existingPlane])
            if let result = hitTestResult.first{
                addField(result: result)
                golfAdded = true
            }
            
        }else{
            createGolfBall()
        }
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
