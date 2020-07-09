//
//  ViewController.swift
//  WhatDog
//
//  Created by Vu Nguyen on 7/8/20.
//  Copyright © 2020 Vu Nguyen. All rights reserved.
//

import UIKit
import CoreML
import Vision

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {


    @IBOutlet weak var displayLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    let imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        imagePicker.sourceType = .camera
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            guard let ciImage = CIImage(image: image) else {
                fatalError("Can't convert to CIImage")
            }
            imageProcess(image: ciImage)
            imageView.image = image
            imagePicker.dismiss(animated: true, completion: nil)
            
        }
    }
    func imageProcess(image: CIImage) {
        guard let model = try? VNCoreMLModel(for: DogBreedClassifier_1().model) else {
            fatalError("Loading CoreML Model Failed.")
        }
        let request = VNCoreMLRequest(model: model) { (request, error) in
            guard let results = request.results as? [VNClassificationObservation] else {
                fatalError("Model failed to process image")
            }
            if let firstResult = results.first {
                let confidence = firstResult.confidence * 100.00
                self.displayLabel.text = "\(firstResult.identifier.capitalized) with \(confidence)% confidence"
                self.displayLabel.textAlignment = .justified
            }
        }
        let handler = VNImageRequestHandler(ciImage: image)
        
        do {
            try handler.perform([request])
        } catch {
            print (error)
        }
    }
    
    @IBAction func cameraPressed(_ sender: Any) {
        present(imagePicker, animated: true, completion: nil)
    }

}

