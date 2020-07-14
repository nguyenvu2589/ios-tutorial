//
//  ViewController.swift
//  ARRuler
//
//  Created by Vu Nguyen on 7/13/20.
//  Copyright © 2020 Vu Nguyen. All rights reserved.
//

import UIKit
import RealityKit
import ARKit

class ViewController: UIViewController {
    
    @IBOutlet var arView: ARView!
//    let anchor = AnchorEntity(plane: .horizontal, minimumBounds: [0.5, 0.5])
    var dotNode = [Entity]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        arView.debugOptions = [.showFeaturePoints]
//        arView.scene.addAnchor(anchor)
        
        // Load the "Box" scene from the "Experience" Reality File
//        let boxAnchor = try! Experience.loadBox()
        
        // Add the box anchor to the scene
//        arView.scene.anchors.append(boxAnchor)
    }
    
    
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touchLocation = touches.first?.location(in: arView) {
            // get 3d location
            let hitTestResult = arView.hitTest(touchLocation, types: .featurePoint)
            if let hitResult = hitTestResult.first {
                addBox(at: hitResult)
                
            }
        }
        
    }
    
    func addBox(at hitResult : ARHitTestResult) {
//        let box = MeshResource.generateBox(width: 0.04, height: 0.002, depth: 0.04)
        let dot = MeshResource.generateSphere(radius: 0.05)
        let metalDot = SimpleMaterial.init(color: .gray, isMetallic: true)
        let model = ModelEntity(mesh: dot, materials: [metalDot])
        
        print(hitResult.worldTransform.columns.3, "current pos" )
        
        model.generateCollisionShapes(recursive: true)
        model.position = [
            hitResult.worldTransform.columns.3.x,
            hitResult.worldTransform.columns.3.y,
            hitResult.worldTransform.columns.3.z
        ]
//        anchor.addChild(model)
//        arView.installGestures(for: model)
        
        arView.installGestures(.init(arrayLiteral: [.rotation, .scale]), for: model)
        dotNode.append(model)
        
        if dotNode.count >= 2{
            calculate()
        }
    }
    
    func calculate(){
        let start = dotNode[0]
        let end = dotNode[1]
        let a = end.position.x - start.position.x
        let b = end.position.y - start.position.y
        let c = end.position.y - start.position.z
        
        let distance = sqrt(pow(a, 2) + pow(b,2) + pow(c,2))
        print(abs(distance))
    }
}
