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

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        return true
    }

    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        let needTo = url.startAccessingSecurityScopedResource()
        do {
            let data = try Data(contentsOf: url)
            print(data)
        } catch {
            print(error)
        }

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
