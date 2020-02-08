//
//  PlayerViewController.swift
//  music-connection
//
//  Created by Alex Appel on 1/30/20.
//  Copyright © 2020 Alex Appel. All rights reserved.
//

import UIKit
import SwiftySound

class PlayerViewController: UIViewController {

    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var playPauseButton: UIButton!
    @IBOutlet weak var backgroundView: UIView!

    var track = Sound(url: URL(fileURLWithPath: "Relax.mp3"))
    
    @IBAction func togglePausePlay(_ sender: Any) {
        if track!.paused {
//            Sound.stopAll()
//            Sound.enabled = false
            track?.resume()
            playPauseButton.setTitle("❚❚",for: .normal)
        }
        else {
            self.track?.pause()
            playPauseButton.setTitle("▶",for: .normal)
        }
    }
    
    enum Mode {
        case relax
        case active
    }

    var mode: Mode!

    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    func play() {
        Sound.enabled = true
        
        Sound.category = .playback
        
        switch mode! {
        case .relax:
//            track = Sound(url: URL(fileURLWithPath: "Relax.mp3"))
            track = Sound(url: Bundle.main.url(forResource: "Relax", withExtension: "mp3")!)
            
            textLabel.text = "Relax"
            
            self.view.backgroundColor = UIColor(red: 77/255, green: 100/255, blue: 141/255, alpha: 1)
            textLabel.textColor = UIColor(red: 208/255, green: 225/255, blue: 249/255, alpha: 1.0)
            playPauseButton.setTitleColor(UIColor(red: 40/255, green: 54/255, blue: 85/255, alpha: 1.0), for: .normal)
        
        case .active:
//            Sound.play(file: "Active.mp3")
//            track = Sound(url: URL(fileURLWithPath: "Active.mp3"))
            track = Sound(url: Bundle.main.url(forResource: "Active", withExtension: "mp3")!)
            
            textLabel.text = "Active"
            
            self.view.backgroundColor = UIColor(red: 133/255, green: 30/255, blue: 62/255, alpha: 1.0)
            textLabel.textColor = UIColor(red: 222/255, green: 195/255, blue: 195/255, alpha: 1.0)
            playPauseButton.setTitleColor(UIColor(red: 232/255, green: 195/255, blue: 195/255, alpha: 1.0), for: .normal)
        }
        track?.play()
    }

    override func viewDidLoad() {
        playPauseButton.setTitle("❚❚",for: .normal)
        play()
    }

    override func viewDidAppear(_ animated: Bool) {
//        Sound.stopAll()
//        Sound.enabled = true
//
////        let colorSet: WaveView.ColorSet
////        switch mode! {
////        case .relax:
////            colorSet = WaveView.relaxColorSet
////        case .active:
////            colorSet = WaveView.activeColorSet
////        }
////        self.view = WaveView(colorSet: colorSet, frame: self.view.frame)
//
//        switch mode! {
//        case .relax:
//            Sound.play(file: "Relax.mp3")
//        case .active:
//            Sound.play(file: "Active.mp3")
//        }
        
    }

    override func viewDidDisappear(_ animated: Bool) {
        Sound.enabled = false
        Sound.stopAll()
    }

    @IBAction func didEdgePan(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
