//
//  ViewController.swift
//  WhatFlower
//
//  Created by Vu Nguyen on 7/3/20.
//  Copyright © 2020 Vu Nguyen. All rights reserved.
//

import UIKit
import CoreML
import Vision
import Alamofire
import SwiftyJSON


class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var displayImage: UIImageView!
    @IBOutlet weak var displayLabel: UILabel!
    
    
    let imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
        imagePicker.sourceType = .camera
        imagePicker.allowsEditing = true
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            guard let ciImage = CIImage(image: image) else {
                fatalError("Can't convert to CIImage")
            }
            imageProcess(image: ciImage)
            displayImage.image = image
            imagePicker.dismiss(animated: true, completion: nil)
        }
        
    }
    
    func imageProcess(image: CIImage) {
        guard let model = try? VNCoreMLModel(for: FlowerClassifier().model) else {
            fatalError("Loading CoreML Model Failed.")
        }
        let request = VNCoreMLRequest(model: model) { (request, error) in
            guard let results = request.results as? [VNClassificationObservation] else {
                fatalError("Model failed to process image")
            }
            if let firstResult = results.first {
                self.navigationItem.title = firstResult.identifier.capitalized
                print(firstResult.identifier)
                self.getFlowerDetailFromWiki(flowerName: firstResult.identifier)
                
            }
        }
        let handler = VNImageRequestHandler(ciImage: image)
        
        do {
            try handler.perform([request])
        } catch {
            print (error)
        }
        
    }
    @IBAction func cameraButtonPressed(_ sender: UIBarButtonItem) {
        present(imagePicker, animated: true, completion: nil)
    }
    
    func getFlowerDetailFromWiki(flowerName: String) {
        let wikipediaURl = "https://en.wikipedia.org/w/api.php"

        let parameters : [String:String] = [
        "format" : "json",
        "action" : "query",
        "prop" : "extracts",
        "exintro" : "",
        "explaintext" : "",
        "titles" : flowerName,
        "indexpageids" : "",
        "redirects" : "1",
        ]
        let request = AF.request(wikipediaURl, parameters: parameters)
        request.responseJSON { (data) in
            let result = JSON(data.value!)
            let page_id = result["query"]["pageids"][0].stringValue
            self.displayLabel.text = result["query"]["pages"][page_id]["extract"].stringValue
            print(data)
            
            
        }
    }
    
}

