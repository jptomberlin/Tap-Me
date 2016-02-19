//
//  ViewController.swift
//  Tap Me
//
//  Created by JP TOMBERLIN on 2/17/16.
//  Copyright © 2016 JP TOMBERLIN. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    
    @IBAction func buttonPressed() {
        count++
        scoreLabel.text = "Score \n\(count)"
    }
    
    @IBOutlet weak var timeLabel: UILabel!
    
    @IBOutlet weak var scoreLabel: UILabel!
    
    var count = 0
    
    var seconds = 0
    
    var timer = NSTimer()
    
    func setupGame() {
        seconds = 30
        count = 0
        
        timeLabel.text = "Time: \(seconds)"
        scoreLabel.text = "Score: \(count)"
        
        timer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: Selector("subtractTime"), userInfo: nil, repeats: true)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(patternImage: UIImage(named: "bg_tile.png")!)
        scoreLabel.backgroundColor = UIColor(patternImage: UIImage(named: "field_score.png")!)
        timeLabel.backgroundColor = UIColor(patternImage: UIImage(named: "field_time.png")!)
        
        setupGame()
        
        func setupAudioPlayerWithFile(file:NSString, type:NSString) -> AVAudioPlayer?  {
            //1
            let path = NSBundle.mainBundle().pathForResource(file as String, ofType: type as String)
            let url = NSURL.fileURLWithPath(path!)
            
            //2
            var audioPlayer:AVAudioPlayer?
            
            // 3
            do {
                try audioPlayer = AVAudioPlayer(contentsOfURL: url)
            } catch {
                print("Player not available")
            }
            
            return audioPlayer
        }
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func subtractTime() {
        seconds--
        timeLabel.text = "Time: \(seconds)"
        
        if(seconds == 0)  {
            timer.invalidate()
            let alert = UIAlertController(title: "Time is up!",
                message: "You scored \(count) points",
                preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "Play Again", style: UIAlertActionStyle.Default, handler: {
                action in self.setupGame()
            }))
            presentViewController(alert, animated: true, completion:nil)
        }
    }
    
    var buttonBeep : AVAudioPlayer?
    var secondBeep : AVAudioPlayer?
    var backgroundMusic : AVAudioPlayer?


}

