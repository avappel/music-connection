//
//  PlayerViewController.swift
//  music-connection
//
//  Created by Alex Appel on 1/30/20.
//  Copyright © 2020 Alex Appel. All rights reserved.
//

import UIKit
import SwiftySound
import AVFoundation
var audioPlayer:AVAudioPlayer!

class PlayerViewController: UIViewController {
    
    enum Mode {
        case relax
        case active
        
        var lastComponentURL: String {
            switch self {
            case .relax: return "Relax.mp3"
            case .active: return "Active.mp3"
            }
        }
        
//        var url: URL {
//            switch self {
//            case .relax: return URL.init(fileURLWithPath: "/Relax.mp3")
//            case .active: return URL.init(fileURLWithPath: "/Active.mp3")
////            case .relax: return UserDefaults.standard.url(forKey: "relaxURL") ?? URL.init(fileURLWithPath: "")
////            case .active: return UserDefaults.standard.url(forKey: "activeURL") ?? URL.init(fileURLWithPath: "")
////            case .relax: return Bundle.main.url(forResource: "Relax", withExtension: "mp3")!
////            case .active: return Bundle.main.url(forResource: "Active", withExtension: "mp3")!
//            }
//        }
    }
    

    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var playPauseButton: UIButton!
    @IBOutlet weak var backgroundView: UIView!

    var track: Sound!
    var mode: Mode!


    override var prefersStatusBarHidden: Bool {
        return true
    }

    override func viewWillAppear(_ animated: Bool) {
        Sound.enabled = true
        try! AVAudioSession.sharedInstance().setCategory(.playback, options: .mixWithOthers)

        playPauseButton.setTitle("▶",for: .normal)

        switch mode! {
        case .relax:
            self.view.backgroundColor = UIColor(red: 77/255, green: 100/255, blue: 141/255, alpha: 1)
            textLabel.text = "Relax"
            textLabel.textColor = UIColor(red: 208/255, green: 225/255, blue: 249/255, alpha: 1.0)
            playPauseButton.setTitleColor(UIColor(red: 40/255, green: 54/255, blue: 85/255, alpha: 1.0), for: .normal)

        case .active:
            self.view.backgroundColor = UIColor(red: 133/255, green: 30/255, blue: 62/255, alpha: 1.0)
            textLabel.text = "Active"
            textLabel.textColor = UIColor(red: 222/255, green: 195/255, blue: 195/255, alpha: 1.0)
            playPauseButton.setTitleColor(UIColor(red: 232/255, green: 195/255, blue: 195/255, alpha: 1.0), for: .normal)
        }
        
//        track = Sound(url: mode.url)
//        track.prepare()
        
        // Create document folder url
        let documentsDirectoryURL =  FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        
        // Create destination file url
        let destinationURL = documentsDirectoryURL.appendingPathComponent(mode.lastComponentURL)
        
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: destinationURL)
            guard let player = audioPlayer else {
                print("something wrong with player")
                return
                
            }
            
            player.prepareToPlay()
            player.play()
            print("Should be playing by now")
        } catch let error {
            print("Error")
            print(error.localizedDescription)
        }
    }

    override func viewWillDisappear(_ animated: Bool) {
        Sound.enabled = false
    }

    func play() {
        track.play(numberOfLoops: -1)
    }

    @IBAction func didEdgePan(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }

    @IBAction func togglePausePlay(_ sender: Any) {
//        if track.paused {
//            if track.resume() {
//                playPauseButton.setTitle("❚❚",for: .normal)
//            }
//        } else {
//            track.pause()
//            playPauseButton.setTitle("▶",for: .normal)
//        }
        
        if  audioPlayer.isPlaying{
            audioPlayer.pause()
        }else{
         audioPlayer.play()
         }
    }
}
