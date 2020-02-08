//
//  ViewController.swift
//  music-connection
//
//  Created by Alex Appel on 1/30/20.
//  Copyright © 2020 Alex Appel. All rights reserved.
//

import UIKit
import AVFoundation
import SwiftySound


class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(appMovedToBackground), name: UIApplication.willResignActiveNotification, object: nil)

    }
    
    @objc func appMovedToBackground() {
        print("App moved to background!")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let playerVC = segue.destination as! PlayerViewController
        
        switch segue.identifier! {
            case "showRelax":
                playerVC.mode = .relax
            case "showActive":
                playerVC.mode = .active
            default: break
        }
    }
    
}
