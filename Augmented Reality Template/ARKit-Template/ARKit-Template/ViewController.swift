//
//  ViewController.swift
//  ARKit-Template
//
//  Created by Andrea Dancek on 2020-06-12.
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
                
//        debug options
//        sceneView.debugOptions = [.showWorldOrigin] Shows XYZ axis from the world's origin that works as a coordinate system
//        sceneView.debugOptions = [.showFeaturePoints] Shows a system of tracking points that attach to the surfaces.
//        sceneView.debugOptions = [.showCameras] Shows in the field the camera nodes
//        sceneView.debugOptions = [.showCreases] Displays a non smooth surface on the 3D models that are affected by surface division.
//        sceneView.debugOptions = [.showWireframe] Renders each wireframes over the 3D models
//        sceneView.debugOptions = [.renderAsWireframe] Renders JUST the wireframe of the 3D models
//        sceneView.debugOptions = [.showSkeletons]
//        sceneView.debugOptions = [.showBoundingBoxes] Shows a visual representation of boundiung boxes around 3D objects
//        sceneView.debugOptions = [.showConstraints]
//        sceneView.debugOptions = [.showLightExtents] Shows a selection of a region of what's been affected by a SCNLight
//        sceneView.debugOptions = [.showPhysicsFields] Shows a region of region of what's been affected by a SCNPhysicsField
//        sceneView.debugOptions = [.showPhysicsShapes]
//        sceneView.debugOptions = [.showLightInfluences] Shows the location of the SCNLight in the view

        
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
