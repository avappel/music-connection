//
//  AppDelegate.swift
//  music-connection
//
//  Created by Alex Appel on 1/30/20.
//  Copyright © 2020 Alex Appel. All rights reserved.
//

import UIKit
import Zip

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    let defaults = UserDefaults.standard
    
    

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        return true
    }

    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        let needTo = url.startAccessingSecurityScopedResource()

        defer {
            if needTo {
                url.stopAccessingSecurityScopedResource()
            }
        }

        do {
            let data = try Data(contentsOf: url)
            let unzipDirectory = try Zip.quickUnzipFile(url)
            let relaxURL = unzipDirectory.appendingPathComponent("Relax.mp3")
            let activeURL = unzipDirectory.appendingPathComponent("Active.mp3")
            UserDefaults.standard.set(relaxURL, forKey: "relaxURL")
            UserDefaults.standard.set(activeURL, forKey: "activeURL")
        } catch {
            print(error)
        }

        return true
    }
}
