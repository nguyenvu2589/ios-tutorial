//
//  ViewController.swift
//  Poke3D
//
//  Created by Vu Nguyen on 7/15/20.
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
        if let imageToTrack = ARReferenceImage.referenceImages(inGroupNamed: "Cards", bundle: .main){
            configuration.trackingImages = imageToTrack
            configuration.maximumNumberOfTrackedImages = 3
            
        }
        
        // Run the view's session
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }

//     Found the card
    func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
        let node = SCNNode()
        if let imageAnchor = anchor as? ARImageAnchor {
            let plan = SCNPlane(width: imageAnchor.referenceImage.physicalSize.width, height: imageAnchor.referenceImage.physicalSize.height)
            plan.firstMaterial?.diffuse.contents = UIColor(white: 1.0, alpha: 0.5)
            let planNode = SCNNode(geometry: plan)
            planNode.eulerAngles.x = -.pi / 2
            node.addChildNode(planNode)
            
            if let detectedImage = imageAnchor.referenceImage.name{
                if detectedImage == "ace_of_spade" {
                    renderMonster(planNode: planNode, monsterType: "cyborg.usdz", scale: 0.15)
                }
                if (detectedImage == "dollar-bill-front" || detectedImage == "dollar-bill-back") {
                    
                    renderMonster(planNode: planNode, monsterType: "snake_dancing.usdz", scale: 0.25)
                }
                if detectedImage == "jack_of_heart" {
                    renderMonster(planNode: planNode, monsterType: "monster.usdz", scale: 0.05)
                }
            }
        }
        return node
    }
    
    func renderMonster (planNode : SCNNode, monsterType : String, scale: Float) {
        if let monsterScene = SCNScene(named: "art.scnassets/\(monsterType)") {
           
            
            if let monsterNode = monsterScene.rootNode.childNodes.first{
                // adding material
                // material
//                let material = SCNMaterial()
//                material.diffuse.contents = UIImage(named: "girl_diffuse.png")
//                monsterNode.geometry?.materials = [material]
                
                monsterNode.eulerAngles.x = .pi / 2
                monsterNode.scale.x = scale
                monsterNode.scale.y = scale
                monsterNode.scale.z = scale
                
                planNode.addChildNode(monsterNode)
            }
            
        }
    }
}
