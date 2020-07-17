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
    let anchor = AnchorEntity(plane: .horizontal)
    var dotNode = [Entity]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        arView.debugOptions = [.showFeaturePoints]
        let config = ARWorldTrackingConfiguration()
        config.planeDetection = [.horizontal, .vertical]
        config.environmentTexturing = .automatic
        arView.session.run(config)
    }
    
    @IBAction func onTap(_ sender: UITapGestureRecognizer) {
        let tapLocation = sender.location(in: arView)
        if let result = arView.raycast(
            from: tapLocation,
            allowing: .existingPlaneGeometry, alignment: .horizontal
        ).first {
          addBox(at: result.worldTransform)
        }
        
        
        
    }
    
    func addBox(at tapLocation : simd_float4x4 ) {
        let dot = MeshResource.generateBox(width: 0.04, height: 0.002, depth: 0.04)
//        let dot = MeshResource.generateSphere(radius: 0.05)
        let metalDot = SimpleMaterial.init(color: .gray, isMetallic: true)
        let model = ModelEntity(mesh: dot, materials: [metalDot])

        model.generateCollisionShapes(recursive: true)
        
        model.position = [
            tapLocation.columns.3.x,
            tapLocation.columns.3.y,
            tapLocation.columns.3.z,
        ]
        anchor.addChild(model)
        arView.scene.addAnchor(anchor)

//        dotNode.append(model)
        
        
        
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
