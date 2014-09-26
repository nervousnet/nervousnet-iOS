//
//  AppDelegate.swift
//  nervous
//
//  Created by Sam Sulaimanov on 10/09/14.
//  Copyright (c) 2014 ethz. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, CLLocationManagerDelegate {
                            
    var window: UIWindow?
    var locationManager: CLLocationManager? //Declaring the locationManager with a question mark is necessary because it is empty when the AppDelegate object is created. This means making it optional. It is created in the didFinishLaunchingWithOptions method. Because it is optional, it is important to use an exclamation mark after its name in following instances, as shown in the code above.

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        
        NSLog("Cooking bacon...")
        
        
        //setup beacon region
        let uuidString = "3C77C2A5-5D39-420F-97FD-E7735CC7F317"
        let beaconIdentifier = "ch.ethz.nervous"
        let beaconUUID:NSUUID = NSUUID(UUIDString: uuidString)
        let beaconRegion:CLBeaconRegion = CLBeaconRegion(proximityUUID: beaconUUID,
            identifier: beaconIdentifier)
        
        
        //location manager
        locationManager = CLLocationManager()
        
        if(locationManager!.respondsToSelector("requestAlwaysAuthorization")) {
            locationManager!.requestAlwaysAuthorization()
        }
        
        locationManager!.delegate = self
        locationManager!.pausesLocationUpdatesAutomatically = false
        
        locationManager!.startMonitoringForRegion(beaconRegion)
        locationManager!.startRangingBeaconsInRegion(beaconRegion)
        locationManager!.startUpdatingLocation()
        
        //permission request
        if(application.respondsToSelector("registerUserNotificationSettings:")) {
            application.registerUserNotificationSettings(
                UIUserNotificationSettings(
                    forTypes: UIUserNotificationType.Alert | UIUserNotificationType.Sound,
                    categories: nil
                )
            )
        }
        
        
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

extension AppDelegate: CLLocationManagerDelegate {
    

    func locationManager(manager: CLLocationManager!, didRangeBeacons beacons: [AnyObject]!,
        inRegion region: CLBeaconRegion!) {
           
            NSLog("Bacon event")
            
            if(beacons.count > 0) {
                
                //encapsulate data in top nest
                let date = NSDate()
                let beaconUpload = SensorUpload.builder()

                beaconUpload.huuid = 0x1
                beaconUpload.luuid = 0xB
                beaconUpload.uploadTime = UInt64(date.timeIntervalSince1970)
                beaconUpload.sensorId = 0x000000000000000B
                
            
                //iterate through found beacons
                for (bNum, beacon) in enumerate(beacons) {
                    
                    NSLog("Bacon! %i", beacon.minor)
                
                    let nextBeacon:CLBeacon = beacon as CLBeacon
                    let beaconMinorId:Int32 = Int32(nextBeacon.minor.integerValue)
                    var beaconMajorId:Int32 = Int32(nextBeacon.major.integerValue)

                    let beaconRSSI:Int32 = Int32(nextBeacon.rssi)

                    let beaconTimestamp = UInt64(date.timeIntervalSince1970)
                  

                    
                    //create beacon list item
                    //according to https://github.com/mosgap/nervous/blob/cb5551d898725b969ff2c3bea37d21fa7ef402a9/android/src/ch/ethz/soms/nervous/android/sensors/SensorDescBLEBeacon.java
                    let beaconList = SensorUploadSensorData.builder()
                    beaconList.recordTime = beaconTimestamp
                    beaconList.valueInt64 = [0, 0, 0, 0, 0]
                    beaconList.valueInt32 = [beaconRSSI, beaconMajorId, beaconMinorId, 0]
                    
                    //add it to our nested protobuf message
                    beaconUpload.sensorValues += [beaconList.build()]
                    
                }
                
                NSLog("Going to the net")
                
                
                let addr = "bitmorse.com"
                let port = 25600
                
                var inp :NSInputStream?
                var out :NSOutputStream?
                var pbSizeB :UInt8
                
                NSStream.getStreamsToHostWithName(addr, port: port, inputStream: &inp, outputStream: &out)

                let inputStream = inp!
                let outputStream = out!
                inputStream.open()
                outputStream.open()
                
                
                beaconUpload.build().writeDelimitedToOutputStream(outputStream)
                
                
                
                
                
                outputStream.close()
                
            }
            
            
            
            
    }
}