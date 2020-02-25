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
        
        if UserDefaults.standard.url(forKey: "relaxURL") == nil ||  UserDefaults.standard.url(forKey: "activeURL") == nil {
            // create the alert
            let alert = UIAlertController(title: "My Title", message: "This is my message.", preferredStyle: UIAlertController.Style.alert)
            // add an action (button)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            // show the alert
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if UserDefaults.standard.url(forKey: "relaxURL") == nil ||  UserDefaults.standard.url(forKey: "activeURL") == nil {
            // create the alert
            let alert = UIAlertController(title: "My Title", message: "This is my message.", preferredStyle: UIAlertController.Style.alert)
            // add an action (button)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            // show the alert
            self.present(alert, animated: true, completion: nil)
        }
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
