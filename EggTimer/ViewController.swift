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
    var player: AVAudioPlayer!
    
    let eggTimes : [String : Float] = ["Soft": 3.0, "Medium": 420.0, "Hard": 720.0]
    
    var secondsRemaining = 60
    var timer = Timer()
    var totalTime : Float = 0
    var secondsPassed : Float = 0
    var eggType: String? = nil
    
    @IBOutlet weak var progressPercentage: UILabel!
    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBAction func keyPressed(_ sender: UIButton) {
        
        secondsRemaining = 0
        secondsPassed = 0
        timer.invalidate()
        let hardness = sender.currentTitle!
        eggType = hardness
        totalTime = eggTimes[hardness]!
        
                
        timer = Timer.scheduledTimer(timeInterval: 1.0, target:self, selector: #selector(updateTimer), userInfo:nil, repeats: true)
    }
    
    @objc func updateTimer() {
        if secondsPassed < totalTime {
            secondsPassed += 1
            secondsRemaining = Int(totalTime - secondsPassed)
            titleLabel.text = "\(eggType!): \(secondsRemaining) seconds remaining"
            let progress = Float(secondsPassed / totalTime)
            progressBar.progress = progress
            let roundedProgress = round(100*progress)/100
            progressPercentage.text = "\(roundedProgress*100)%"
        } else {
            titleLabel.text = "Done!"
            playSound()
            }
        }
    func playSound() {
        let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3")
        player = try! AVAudioPlayer(contentsOf: url!)
        player.play()
    }
}
