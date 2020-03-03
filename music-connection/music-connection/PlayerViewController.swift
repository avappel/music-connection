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
import MediaPlayer

class PlayerViewController: UIViewController {
    
    enum Mode {
        case relax
        case active
        
        var url: URL {
            switch self {
            case .relax: return UserDefaults.standard.url(forKey: "relaxURL") ?? URL.init(fileURLWithPath: "")
            case .active: return UserDefaults.standard.url(forKey: "activeURL") ?? URL.init(fileURLWithPath: "")
            }
        }
        
        var title: String {
            switch self {
            case .relax: return "Relax Soundtrack"
            case .active: return "Active Soundtrack"
            }
        }
    }
    

    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var playPauseButton: UIButton!
    @IBOutlet weak var backgroundView: UIView!

    var track: Sound!
    var mode: Mode!
    
    var audioPlayer:AVAudioPlayer!


    override var prefersStatusBarHidden: Bool {
        return true
    }

    override func viewWillAppear(_ animated: Bool) {
        Sound.enabled = true
        try! AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.playback)
//        try! AVAudioSession.sharedInstance().setCategory(.playback, options: .mixWithOthers)
        UIApplication.shared.beginReceivingRemoteControlEvents()

        playPauseButton.setTitle("❚❚",for: UIControl.State.normal)


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
        
        do {
            self.audioPlayer = try AVAudioPlayer(contentsOf: mode.url)
            guard let player = self.audioPlayer else {
                print("Error with player")
                return
            }
            player.prepareToPlay()
            play()
            setupRemoteTransportControls()
        } catch let error {
            print("Error with playback")
            print(error.localizedDescription)
        }
        
        updateNowPlaying()
        updateUI()
    }
    
    func updateUI() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
            if self.audioPlayer.isPlaying {
                self.playPauseButton.setTitle("❚❚",for: UIControl.State.normal)
            }
            else {
                self.playPauseButton.setTitle("▶",for: UIControl.State.normal)
            }
            
            self.updateUI()
        })
    }

    override func viewWillDisappear(_ animated: Bool) {
        Sound.enabled = false
    }

//    func play() {
//        track.play(numberOfLoops: -1)
//    }

    @IBAction func didEdgePan(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }

    @IBAction func togglePausePlay(_ sender: Any) {
        if self.audioPlayer.isPlaying {
            pause()
        }
        else {
            play()
        }
    }
        
    func setupRemoteTransportControls() {
        print("in setup")
        
        // Get the shared MPRemoteCommandCenter
        let commandCenter = MPRemoteCommandCenter.shared()

        // Add handler for Play Command
        commandCenter.playCommand.addTarget { [unowned self] event in
            print("Play command - is playing: \(self.audioPlayer.isPlaying)")
            if !self.audioPlayer.isPlaying {
                self.audioPlayer.play()
                return .success
            }
            return .commandFailed
        }

        // Add handler for Pause Command
        commandCenter.pauseCommand.addTarget { [unowned self] event in
            print("Pause command - is playing: \(self.audioPlayer.isPlaying)")
            if self.audioPlayer.isPlaying {
                self.audioPlayer.pause()
                return .success
            }
            return .commandFailed
        }
    }

    func play() {
        self.audioPlayer.play()
        playPauseButton.setTitle("❚❚",for: UIControl.State.normal)
        updateNowPlaying()
        print("Play - current time: \(audioPlayer.currentTime) - is playing: \(self.audioPlayer.isPlaying)")
    }

    func pause() {
        self.audioPlayer.pause()
        playPauseButton.setTitle("▶",for: UIControl.State.normal)
        updateNowPlaying()
        print("Pause - current time: \(self.audioPlayer.currentTime) - is playing: \(self.audioPlayer.isPlaying)")
    }

    func updateNowPlaying() {
        
        var nowPlayingInfo = [String : Any]()
        
        nowPlayingInfo[MPMediaItemPropertyTitle] = mode.title

        nowPlayingInfo[MPNowPlayingInfoPropertyElapsedPlaybackTime] = self.audioPlayer.currentTime
        nowPlayingInfo[MPMediaItemPropertyPlaybackDuration] = self.audioPlayer.duration
        nowPlayingInfo[MPNowPlayingInfoPropertyPlaybackRate] = self.audioPlayer.rate

        // Set the metadata
        MPNowPlayingInfoCenter.default().nowPlayingInfo = nowPlayingInfo
    }
}
