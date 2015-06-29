//
//  AppDelegate.swift
//  nervous
//
//  Created by Sam Sulaimanov on 10/09/14.
//  Extended by Siddhartha
//  Copyright (c) 2014 ethz. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation
import CoreData
import CoreMotion

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, CLLocationManagerDelegate {
    
    let defaults :NSUserDefaults = NSUserDefaults.standardUserDefaults()

    
    var window: UIWindow?
    var locationManager: CLLocationManager? //Declaring the locationManager with a question mark is necessary because it is empty when the AppDelegate object is created. This means making it optional. It is created in the didFinishLaunchingWithOptions method. Because it is optional, it is important to use an exclamation mark after its name in following instances, as shown in the code above.
 
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        
        /*
        db.store(0x0000000000000001, timestamp: sensorDesc.timestamp, sensorData: sensorDesc.toProtoSensor())
        
        var sensorDataArray: [SensorUploadSensorData] =
            db.retrieve(0x0000000000000001, fromTimestamp: 0, toTimestamp: 200)
        
        for sensorData in sensorDataArray {
            var retSensDesc = SensorDescBattery(sensorData: sensorData)

            /*
                You need to cast the object to the protocol in order to access inherited methods xD
                This language is so evil
            */
            NSLog("\((retSensDesc as SensorDesc).timestamp)")
            NSLog("\(retSensDesc.batteryPercent) \(retSensDesc.isCharging)")
        }*/
        
        /*
        --------------------------------------------------------------------------------------
        */
        
        // The core motion manager. Should be same manager for all sensors for consistency.
        let manager = CMMotionManager()
        var VM = NervousVM.sharedInstance
        
        // The DataBase Instance
        // It is a Singleton and should never be instantiated twice
        var db = SQLiteSensorsDB.sharedInstance
        
        // +++++++++++++++++++++++++++++++++++++++++++++++++++
        // Fetching and Pushing the data of individual sensors
        // +++++++++++++++++++++++++++++++++++++++++++++++++++
        VM.setFrequency(0, freq: 1) // default is 30 seconds.
        VM.setFrequency(1, freq: 1)// The values will change
        VM.setFrequency(2, freq: 1) // according to the UI
        VM.setFrequency(5, freq: 1) // inputs.
        VM.setFrequency(6, freq: 1)
        
        // Push the data to te server
        VM.pushToServerTimer()
        // The function reads the last minute from the database using the current time
        //var timerD = NSTimer.scheduledTimerWithTimeInterval(60.5, target: self, selector: Selector("pushToServer"), userInfo: nil, repeats: true)
        
        
        
        //setup beacon region
        let beaconUUIDString = "3C77C2A5-5D39-420F-97FD-E7735CC7F317"
        let beaconIdentifier = "ch.ethz.nervousnet"
        let beaconUUID:NSUUID? = NSUUID(UUIDString: beaconUUIDString)
        
        //NSLog("Cooking bacon...")
        
        
        let beaconRegion : CLBeaconRegion = CLBeaconRegion(proximityUUID: beaconUUID,
            identifier: beaconIdentifier)
        
        //do scan when display comes on
        beaconRegion.notifyEntryStateOnDisplay = true
        
        

//            //location manager
//            locationManager = CLLocationManager()
//
//
//            if(locationManager!.respondsToSelector("requestAlwaysAuthorization")) {
//                locationManager!.requestAlwaysAuthorization()
//            }
//            
//            
//            locationManager!.delegate = self
//            locationManager!.pausesLocationUpdatesAutomatically = false
//            
//            locationManager!.startMonitoringForRegion(beaconRegion)
//            locationManager!.startRangingBeaconsInRegion(beaconRegion)
//
//            locationManager!.startUpdatingLocation()
        
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
    
    
    // MARK: - Core Data stack
    
    lazy var applicationDocumentsDirectory: NSURL = {
        // The directory the application uses to store the Core Data store file. This code uses a directory named "ch.ethz.na" in the application's documents Application Support directory.
        let urls = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)
        return urls[urls.count-1] as NSURL
        }()
    
    lazy var managedObjectModel: NSManagedObjectModel = {
        // The managed object model for the application. This property is not optional. It is a fatal error for the application not to be able to find and load its model.
        let modelURL = NSBundle.mainBundle().URLForResource("nervous", withExtension: "momd")!
        return NSManagedObjectModel(contentsOfURL: modelURL)!
        }()
    
    lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator? = {
        // The persistent store coordinator for the application. This implementation creates and return a coordinator, having added the store for the application to it. This property is optional since there are legitimate error conditions that could cause the creation of the store to fail.
        
        // Create the coordinator and store
        var coordinator: NSPersistentStoreCoordinator? = NSPersistentStoreCoordinator(managedObjectModel: self.managedObjectModel)
        let url = self.applicationDocumentsDirectory.URLByAppendingPathComponent("nervous.sqlite")
        var error: NSError? = nil
        var failureReason = "There was an error creating or loading the application's saved data."
        if coordinator!.addPersistentStoreWithType(NSSQLiteStoreType, configuration: nil, URL: url, options: nil, error: &error) == nil {
            coordinator = nil
            // Report any error we got.
            let dict = NSMutableDictionary()
            dict[NSLocalizedDescriptionKey] = "Failed to initialize the application's saved data"
            dict[NSLocalizedFailureReasonErrorKey] = failureReason
            dict[NSUnderlyingErrorKey] = error
            error = NSError(domain: "YOUR_ERROR_DOMAIN", code: 9999, userInfo: dict)
            // Replace this with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog("Unresolved error \(error), \(error!.userInfo)")
            abort()
        }
        
        return coordinator
        }()

        lazy var managedObjectContext: NSManagedObjectContext? = {
            // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.) This property is optional since there are legitimate error conditions that could cause the creation of the context to fail.
            let coordinator = self.persistentStoreCoordinator
            if coordinator == nil {
                return nil
            }
            var managedObjectContext = NSManagedObjectContext()
            managedObjectContext.persistentStoreCoordinator = coordinator
            return managedObjectContext
            }()

        // MARK: - Core Data Saving support

        func saveContext () {
            if let moc = self.managedObjectContext {
                var error: NSError? = nil
                if moc.hasChanges && !moc.save(&error) {
                    // Replace this implementation with code to handle the error appropriately.
                    // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                    NSLog("Unresolved error \(error), \(error!.userInfo)")
                    abort()
                }
            }
        }

}


extension AppDelegate: CLLocationManagerDelegate {
    
    
    func locationManager(manager: CLLocationManager!, didRangeBeacons beacons: [AnyObject]!,
        inRegion region: CLBeaconRegion!) {
            
            if(defaults.integerForKey("sensorview_setting_0") == 1){
                
                
                BLESensor(beacons: beacons, region: region)
                
                
            }
            
    }
}
