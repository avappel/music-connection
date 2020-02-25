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
        do {
            let data = try Data(contentsOf: url)
            print(data)
            let unzipDirectory = try Zip.quickUnzipFile(url)
            print(unzipDirectory)
            print(unzipDirectory.absoluteString)
            let relaxURL = URL.init(fileURLWithPath: unzipDirectory.absoluteString + "/Relax.mp3")
            let activeURL = URL.init(fileURLWithPath: unzipDirectory.absoluteString + "/Active.mp3")
            let urlList = [relaxURL, activeURL]
            importFiles(urlList: urlList)
                        
        } catch {
            print(error)
        }

        if needTo {
            url.stopAccessingSecurityScopedResource()
        }

        return true
    }
    
    func importFiles(urlList: [URL]) {
        for url in urlList {
            // create your document folder url
            let documentsDirectoryURL =  FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
            
            // lets create your destination file url
            let destinationURL = documentsDirectoryURL.appendingPathComponent(url.lastPathComponent)
            
            // to check if it exists before downloading it
            if FileManager.default.fileExists(atPath: destinationURL.path) {
                print("The file already exists at path")
                
                // if the file doesn't exist
            } else {
                
                // you can use NSURLSession.sharedSession to download the data asynchronously
                URLSession.shared.downloadTask(with: url, completionHandler: { (location, response, error) -> Void in
                    guard let location = location, error == nil else { return }
                    do {
                        // after downloading your file you need to move it to your destination url
                        try FileManager.default.moveItem(at: location, to: destinationURL)
                        print("File moved to documents folder")
                    } catch let error as NSError {
                        print(error.localizedDescription)
                    }
                }).resume()
            }
        }
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
