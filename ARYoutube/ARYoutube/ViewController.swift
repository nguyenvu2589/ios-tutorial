//
//  ViewController.swift
//  ARYoutube
//
//  Created by Vu Nguyen on 7/21/20.
//  Copyright © 2020 Vu Nguyen. All rights reserved.
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
        sceneView.autoenablesDefaultLighting = true
        
        // Show statistics such as fps and timing information
        sceneView.showsStatistics = true
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARImageTrackingConfiguration()
        if let imageToTrack = ARReferenceImage.referenceImages(inGroupNamed: "WhiteBoard", bundle: .main ) {
            configuration.trackingImages = imageToTrack
            configuration.maximumNumberOfTrackedImages = 1
        }
        
        // Run the view's session
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }
    func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
        let node = SCNNode()
        if let imageAnchor = anchor as? ARImageAnchor {
            let videoNode = SKVideoNode(url: URL(fileURLWithPath: "https://www.youtube.com/watch?v=vUFOaWhGn8I"))
            videoNode.play()
            let videoScene = SKScene(size: CGSize(width: 480, height: 360))
            
            videoScene.addChild(videoNode)
            
            let plan = SCNPlane(width: imageAnchor.referenceImage.physicalSize.width, height: imageAnchor.referenceImage.physicalSize.height)
            plan.firstMaterial?.diffuse.contents = videoScene
            let planNode = SCNNode(geometry: plan)
            planNode.eulerAngles.x = -.pi / 2
            node.addChildNode(planNode)
            
        }
        return node
    }
}
