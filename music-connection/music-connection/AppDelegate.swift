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



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
      let needTo = url.startAccessingSecurityScopedResource()
        print("here")
      do {
        let data = try Data(contentsOf: url)
        let contents = String(
          data: data,
          encoding: String.Encoding.utf8
        )

        print(contents)
      } catch(let error) { print(error) }

      if needTo {
        url.stopAccessingSecurityScopedResource()
      }

      return true
    }
    
//    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
//
//        print("here")
//        return true
//
////        let needTo = url.startAccessingSecurityScopedResource()
////
////        do {
//////            let data = try Data(contentsOf: url)
//////            let contents = String(data: data, encoding: String.Encoding.utf8)
////            let unzipDirectory = try Zip.quickUnzipFile(url) // Unzip
////
////            print(unzipDirectory.absoluteString)
////
////        } catch(let error) {
////            print(error)
////        }
////
////        if needTo {
////            url.stopAccessingSecurityScopedResource()
////        }
////
////        return true
//    }
}
