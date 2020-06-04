//
//  ViewController.swift
//  EggTimer
//
//  Created by Angela Yu on 08/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
//    let eggTime = ["Soft": 300, "Medium": 420, "Hard": 720]
    let eggTime = ["Soft": 3, "Medium": 4, "Hard": 7]
    var timePass = 0
    var totalTime = 0
    var soundEffect: AVAudioPlayer?
    var timer = Timer()
    @IBOutlet weak var mainLabel: UILabel!
    @IBOutlet weak var progressBar: UIProgressView!
    
    
    func getTimer(hardness: String) -> Int{
        return eggTime[hardness]!
    }
    
    @IBAction func hardnessLevel(_ sender: UIButton) {
        timer.invalidate()
        progressBar.progress = 0.0
        timePass = 0
        let hardness = sender.currentTitle!
        mainLabel.text = "How do you like your eggs?"
        
        totalTime = getTimer(hardness: hardness)
        
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
        
    }
    
    func playAlarm(){
        let path = Bundle.main.path(forResource: "alarm_sound.mp3", ofType:nil)!
        let url = URL(fileURLWithPath: path)

        do {
            soundEffect = try AVAudioPlayer(contentsOf: url)
            soundEffect?.play()
        } catch {
            print("Cant play alarm")
        }
        
    }
    
    @objc func updateTimer() {
        
        if timePass < totalTime {
            timePass += 1
            progressBar.progress = Float(timePass) / Float(totalTime)
        }
        else {
            timer.invalidate()
            mainLabel.text = "Time Up !!!"
        }
        
        if progressBar.progress == 1.0 {
            playAlarm()
        }
        
    }
}
