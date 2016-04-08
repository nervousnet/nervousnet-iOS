//
//  AxonStore.swift
//  nervousnet-iOS
//  
//  Created by Sam Sulaimanov on 03 Mar 2016.
//  Copyright (c) 2016 ETHZ . All rights reserved.
//


import Foundation
import SwiftyJSON
import Zip

///
/// Axon Store gets Axon information from the local disk.
///
class AxonStore : NSObject {

    static let includedAxonDir = "\(NSBundle.mainBundle().resourcePath)/Assets/included-axons/"
    static let remoteAxonTestingRepo = "https://api.github.com/repos/nervousnet/nervousnet-axons/contents/testing?ref=master"
    static let remoteAxonRepoZipSuffix = "/archive/master.zip"
    static let installedAxonsDir = "\(NSHomeDirectory())/Documents/nervousnet-installed-axons"
    static let singleAxonRootURL = "http://localhost:8080/nervousnet-axons"
    static let axonIndexFile = "axon.html"

    static var remoteAxonList = Array<Array<String>>()
    
    
    class func getInstalledAxonsList() -> Array<Array<String>>{
        var installedAxons = Array<Array<String>>()
        let filemanager:NSFileManager = NSFileManager()
        let files = filemanager.enumeratorAtPath(installedAxonsDir)
        
        while let file = files?.nextObject() {
            if(file.hasSuffix("/package.json")){
                let appPackageJSON = JSON(data: NSData(contentsOfFile: "\(installedAxonsDir)/\(file)")!)
                
                let arrayOfStrings: [String] = [appPackageJSON["name"].string!, appPackageJSON["title"].string!, appPackageJSON["description"].string!, appPackageJSON["icon"].string!];
                
                installedAxons.append(arrayOfStrings)
            }
        }
        
        return installedAxons
    }
    
    
    
    // download axon in a blocking fashion
    class func downloadAndInstall(axonIndex: Int) -> Bool {
    
        let axon = getRemoteAxon(axonIndex)
        
        //Get documents directory URL
        let fileManager = NSFileManager.defaultManager()
        let documentsDirectory = fileManager.URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).first
        let sourceUrl = NSURL(string: "\(axon[4])/\(remoteAxonRepoZipSuffix)")!
        
        
        //Get the file name and create a LOCAL destination URL
        let fileName = sourceUrl.lastPathComponent!
        let destinationURL = documentsDirectory!.URLByAppendingPathComponent(fileName)
        
        //Hold this file as an NSData and write it to the new location
        if let fileData = NSData(contentsOfURL: sourceUrl) {
            fileData.writeToURL(destinationURL, atomically: false)   // true
            print(destinationURL.path!)
        }else{
            print("couldn't download repo zip")
            return false
        }
        
        
        do {
            let axonName = axon[0]
            let axonZipFile = destinationURL
            let unzipDirectory = try Zip.quickUnzipFile(axonZipFile) // Unzip
            
            do {
                try fileManager.createDirectoryAtPath(installedAxonsDir, withIntermediateDirectories: true, attributes: nil);
            } catch let err as NSError {
                print(err)
                print("install dir already exists, not creating")
                
                return false

            }
            
            do {
                try fileManager.moveItemAtPath(unzipDirectory.path!, toPath: "\(installedAxonsDir)/\(axonName)")
            } catch let err as NSError {
                print(err)
                print("unable to move axon to install path")
                
                return false

            }
            
            
            return true
            
        }
        catch let err as NSError {
            print(err)
            print("Something went wrong")
            
            return false
        }
        

    }

    
    class func getRemoteAxon(axonIndex: Int) -> Array<String> {
        return remoteAxonList[axonIndex]
    }

    
    class func getLocalAxon(axonIndex: Int) -> Array<String> {
        return getInstalledAxonsList()[axonIndex]
    }

    
    class func getLocalAxonURL(axonName: String) -> NSURL? {
        let url = NSURL(string: "\(singleAxonRootURL)/\(axonName)/\(axonIndexFile)")
        return url
    }
    
    
    //blocking task, TODO: implement caching
    class func getRemoteAxonList() -> Array<Array<String>>{
        
        let endpoint = NSURL(string: remoteAxonTestingRepo)
    
        if let data = NSData(contentsOfURL: endpoint!) {

            let json = JSON(data: data);
            remoteAxonList = Array<Array<String>>()
            
            //get the individual package details by going through the jsons in the repo
            for (_,axon_metadata) in json{
                
                let axon_json_url = NSURL(string: axon_metadata["download_url"].stringValue)
                let axon_json = NSData(contentsOfURL: axon_json_url!)
                let axon = JSON(data: axon_json!);
                let arrayOfStrings: [String] = [axon["name"].stringValue, axon["title"].stringValue, axon["description"].stringValue, axon["icon"].stringValue, axon["repository"]["url"].stringValue, axon["author"].stringValue]
                remoteAxonList.append(arrayOfStrings)
            }
        }else{
            print("cannot download remote axon list")
        }
        
        return remoteAxonList
    }

}

