//
//  AxonStore.swift
//  nervousnet-iOS
//  
//  Created by Sam Sulaimanov on 03 Mar 2016.
//  Copyright (c) 2016 ETHZ . All rights reserved.
//


import Foundation
import JSON


///
/// Axon Store gets Axon information from the local disk.
///
class AxonStore : NSObject {

    let includedAxonDir = "\(NSBundle.mainBundle().resourcePath)/Assets/included-axons/"
    let remoteAxonRepositoryZip = "https://github.com/nervousnet/nervousnet-axons/archive/master.zip"
    
    func getAxons() {
        
        //parse json
        
        /*
        var users: AnyObject?
        do {
            users = try JSON.from("users.json")
        } catch {
            // Handle error
        }
        
        */
        
        /*
        guard let url = NSURL(string: "http://httpbin.org/get") else { return }
        let request = NSURLRequest(URL: url)
        NSURLSession.sharedSession().dataTaskWithRequest(request) { data, _, error in
        do {
        let JSON = try data?.toJSON() as? [String : AnyObject]
        print(JSON)
        } catch {
        // Handle error
        }
        }.resume()
        */



    }

    func getAxon() {
        
        
    }
    
    private func getRemoteAxons() {
        
        //download remoteAxonRepositoryZip
        
        //unpack it
    
        //Get documents directory URL
        /*
        let fileManager = NSFileManager.defaultManager()
        let documentsDirectory = fileManager.URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).first
        
        print(documentsDirectory)
        print(TableData[row][0])
        
        
        
        
        
        
        let sourceUrl = NSURL(string:"http://nervousnet.ethz.ch/nervous-developers/uploaded_apps/\(TableData[row][0]).zip")!
        
        //Get the file name and create a destination URL
        let fileName = sourceUrl.lastPathComponent!
        let destinationURL = documentsDirectory!.URLByAppendingPathComponent(fileName)
        
        //Hold this file as an NSData and write it to the new location
        if let fileData = NSData(contentsOfURL: sourceUrl) {
            fileData.writeToURL(destinationURL, atomically: false)   // true
            print(destinationURL.path!)
        }
        
        
        do {
            let appName = TableData[row][0]
            let appZipFile = destinationURL
            let unzipDirectory = try Zip.quickUnzipFile(appZipFile) // Unzip
            let installedJSAppsDir = "\(NSHomeDirectory())/Documents/nervous-installed-jsapps"
            print(unzipDirectory.path)
            
            do {
                try fileManager.createDirectoryAtPath(installedJSAppsDir, withIntermediateDirectories: true, attributes: nil);
            } catch let err as NSError {
                print(err)
                print("install dir already exists, not creating")
            }
            
            do {
                try fileManager.moveItemAtPath(unzipDirectory.path!, toPath: "\(installedJSAppsDir)/\(appName)")
            } catch let err as NSError {
                print(err)
                print("unable to move app to install path")
            }
            
            
            displayAlertWithTitle("App Installed", message: "Your app is installed and accessible from your apps tab.");
        }
        catch {
            print("Something went wrong")
        }
        */
        
        
    }

}

