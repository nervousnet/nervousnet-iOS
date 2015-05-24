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
            Example usage of the Storage Engine
            -----------------------------------------------------------------------------------
        */
        
        /*
            Important! all constructor arguments and method call arguments need to be named argument
        */
        /*var sensorDesc = SensorDescBattery (
            timestamp: 123,
            batteryPercent: 0.3,
            isCharging: true,
            isUsbCharge: true,
            isAcCharge: false
        )
        
        /*
            Gettint the db instance
        */
        var db = SQLiteSensorsDB.sharedInstance
        
        /*
            Important! all method call arguments need to be named argument, but the first one can't! lol
        */
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
        

        //let manager = CMMotionManager()
        //SensorCollection.sensorActivate(manager)
        //SensorCollection.sensorActivate(CMMotionManager())
        //dispatch_async(dispatch_get_global_queue(Int(QOS_CLASS_BACKGROUND.value), 0)) { // 1
        //
        //    dispatch_async(dispatch_get_main_queue()) { // 2
        //        SensorCollection.sensorActivate(CMMotionManager())
        //        println("hello")
        //    }
        //}
        /*
        --------------------------------------------------------------------------------------
        */
        
        // The core motion manager. Should be same manager for all sensors for consistency.
        let manager = CMMotionManager()
        
        // The DataBase Instance
        var db = SQLiteSensorsDB.sharedInstance
        
        
        // +++++++++++++++++++++++++++++++++++++++++++++++++++
        // Fetching and Pushing the data of individual sensors
        // +++++++++++++++++++++++++++++++++++++++++++++++++++
        
        // Accelerometer
        if manager.accelerometerAvailable {
            manager.accelerometerUpdateInterval = 30  // fetching interval in seconds.
            manager.startAccelerometerUpdatesToQueue(NSOperationQueue.mainQueue()) {
                [weak self](data: CMAccelerometerData!, error: NSError!) in
                var currentTimeA :NSDate = NSDate()
                var sensorDescAcc = SensorDescAccelerometer (
                    timestamp: UInt64(currentTimeA.timeIntervalSince1970*1000), // time to timestamp
                    accX : Float(data.acceleration.x),
                    accY : Float(data.acceleration.y),
                    accZ : Float(data.acceleration.z)
                )
                // push the data to the database
                db.store(0x0000000000000000, timestamp: sensorDescAcc.timestamp, sensorData: sensorDescAcc.toProtoSensor())
                println("Accelerometer")
            }
        }
        
        // Gyroscope
        println(manager.gyroAvailable)
        if manager.gyroAvailable {
            manager.gyroUpdateInterval = 30
            manager.startGyroUpdatesToQueue(NSOperationQueue.mainQueue()) {
                [weak self](data: CMGyroData!, error: NSError!) in
                var currentTimeG :NSDate = NSDate()
                var sensorDescGyr = SensorDescGyroscope (
                    timestamp: UInt64(currentTimeG.timeIntervalSince1970*1000), // time to timestamp
                    gyrX : Float(data.rotationRate.x),
                    gyrY : Float(data.rotationRate.y),
                    gyrZ : Float(data.rotationRate.z)
                )
                db.store(0x0000000000000002, timestamp: sensorDescGyr.timestamp, sensorData: sensorDescGyr.toProtoSensor())
                println("Gyroscope")
            }
        }
        
        // Magnetic
        if manager.magnetometerAvailable {
            manager.magnetometerUpdateInterval = 30
            manager.startMagnetometerUpdatesToQueue(NSOperationQueue.mainQueue()) {
                [weak self](data: CMMagnetometerData!, error: NSError!) in
                var currentTimeM :NSDate = NSDate()
                var sensorDescMag = SensorDescMagnetic (
                    timestamp: UInt64(currentTimeM.timeIntervalSince1970*1000), // time to timestamp
                    magX : Float(data.magneticField.x),
                    magY : Float(data.magneticField.y),
                    magZ : Float(data.magneticField.z)
                )
                db.store(0x0000000000000005, timestamp: sensorDescMag.timestamp, sensorData: sensorDescMag.toProtoSensor())
            }
        }
        
        // Battery
        var timerB = NSTimer.scheduledTimerWithTimeInterval(30, target: self, selector: Selector("batteryCollection"), userInfo: nil, repeats: true)
        
        // Proximity
        var timerP = NSTimer.scheduledTimerWithTimeInterval(30, target: self, selector: Selector("proximityCollection"), userInfo: nil, repeats: true)
        
        // Push the data to te server
        // The function reads the last minute from the database using the current time
        var timerD = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: Selector("pushToServer"), userInfo: nil, repeats: true)
        
        
        
        //setup beacon region
        let beaconUUIDString = "3C77C2A5-5D39-420F-97FD-E7735CC7F317"
        let beaconIdentifier = "ch.ethz.nervousnet"
        let beaconUUID:NSUUID? = NSUUID(UUIDString: beaconUUIDString)
        
        NSLog("Cooking bacon...")
        
        
        let beaconRegion : CLBeaconRegion = CLBeaconRegion(proximityUUID: beaconUUID,
            identifier: beaconIdentifier)
        
        //do scan when display comes on
        beaconRegion.notifyEntryStateOnDisplay = true
        
        

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
    
    // Battery
    func batteryCollection() {
        var db = SQLiteSensorsDB.sharedInstance
        UIDevice.currentDevice().batteryMonitoringEnabled = true // start the battery data collection
        var currentTimeB :NSDate = NSDate()
        var isCharging: Bool
        var isUsbCharge: Bool
        var isAcCharge: Bool
        
        if UIDeviceBatteryState.Charging.rawValue == 3{ // doubt check this if '3' is correct
            isCharging = true
            isUsbCharge = false
            isAcCharge = true
        }
        else {
            isCharging = false
            isUsbCharge = false
            isAcCharge = false
        }
        var sensorDescBat = SensorDescBattery (
            timestamp: UInt64(currentTimeB.timeIntervalSince1970*1000), // time to timestamp
            batteryPercent : Float(UIDevice.currentDevice().batteryLevel),
            isCharging : isCharging,
            isUsbCharge : isUsbCharge,
            isAcCharge : isAcCharge
        )
        db.store(0x0000000000000001, timestamp: sensorDescBat.timestamp, sensorData: sensorDescBat.toProtoSensor())
        UIDevice.currentDevice().batteryMonitoringEnabled = false
    }
    
    // Proximity
    func proximityCollection() {
        //println("Battery");
        var db = SQLiteSensorsDB.sharedInstance
        UIDevice.currentDevice().proximityMonitoringEnabled = true // start the battery data collection
        var currentTimeP :NSDate = NSDate()
        var sensorDescProx = SensorDescProximity (
            timestamp: UInt64(currentTimeP.timeIntervalSince1970*1000), // time to timestamp
            proximity : 0,
            isClose : UIDevice.currentDevice().proximityState
        )
        db.store(0x0000000000000006, timestamp: sensorDescProx.timestamp, sensorData: sensorDescProx.toProtoSensor())
        UIDevice.currentDevice().proximityMonitoringEnabled = false
    }
    
    // Push to the server
    func pushToServer() {
        // Generate the VM object and get the UUIDs
        var VM = NervousVM.sharedInstance
        let huuid : UInt64 = VM.getHUUID()
        let luuid : UInt64 = VM.getLUUID()
        
        var db = SQLiteSensorsDB.sharedInstance
        var currentTime :NSDate = NSDate()
        var timestamp :UInt64 = UInt64(currentTime.timeIntervalSince1970*1000)
        println(VM.getHUUID())
        
        // Accelerometer
        let accSensor = SensorUpload.builder()
        accSensor.huuid = huuid //phone huuid
        accSensor.luuid = luuid //phone luuid
        accSensor.uploadTime = timestamp
        accSensor.sensorId = 0x0000000000000000
        var sensorDataArrayA: [SensorUploadSensorData] = db.retrieve(0x0000000000000000, fromTimestamp: (timestamp - 60000), toTimestamp: timestamp)
        accSensor.sensorValues = sensorDataArrayA
        dispatch_async(dispatch_get_main_queue()) {
            
            let upA = UploadTask(pbSensorupload: accSensor.build())
            upA.writeToRouter()
        }
        
        // Gyroscope
        let gyrSensor = SensorUpload.builder()
        gyrSensor.huuid = huuid
        gyrSensor.luuid = luuid
        gyrSensor.uploadTime = timestamp
        gyrSensor.sensorId = 0x0000000000000002
        var sensorDataArrayG: [SensorUploadSensorData] = db.retrieve(0x0000000000000002, fromTimestamp: (timestamp - 60000), toTimestamp: timestamp)
        gyrSensor.sensorValues = sensorDataArrayG
        dispatch_async(dispatch_get_main_queue()) {
            
            let upG = UploadTask(pbSensorupload: gyrSensor.build())
            upG.writeToRouter()
        }
        
        // Magnetic
        let magSensor = SensorUpload.builder()
        magSensor.huuid = huuid
        magSensor.luuid = luuid
        magSensor.uploadTime = timestamp
        magSensor.sensorId = 0x0000000000000005
        var sensorDataArrayM: [SensorUploadSensorData] = db.retrieve(0x0000000000000005, fromTimestamp: (timestamp - 60000), toTimestamp: timestamp)
        magSensor.sensorValues = sensorDataArrayM
        dispatch_async(dispatch_get_main_queue()) {
            
            let upM = UploadTask(pbSensorupload: magSensor.build())
            upM.writeToRouter()
        }
        
        // Battery
        let batSensor = SensorUpload.builder()
        batSensor.huuid = huuid
        batSensor.luuid = luuid
        batSensor.uploadTime = timestamp
        batSensor.sensorId = 0x0000000000000001
        var sensorDataArrayB: [SensorUploadSensorData] = db.retrieve(0x0000000000000001, fromTimestamp: (timestamp - 60000), toTimestamp: timestamp)
        batSensor.sensorValues = sensorDataArrayB
        dispatch_async(dispatch_get_main_queue()) {
            
            let upB = UploadTask(pbSensorupload: batSensor.build())
            upB.writeToRouter()
        }

        // Proximity
        let proSensor = SensorUpload.builder()
        proSensor.huuid = huuid
        proSensor.luuid = luuid
        proSensor.uploadTime = timestamp
        proSensor.sensorId = 0x0000000000000006
        var sensorDataArrayP: [SensorUploadSensorData] = db.retrieve(0x0000000000000006, fromTimestamp: (timestamp - 60000), toTimestamp: timestamp)
        proSensor.sensorValues = sensorDataArrayP
        dispatch_async(dispatch_get_main_queue()) {
            
            let upP = UploadTask(pbSensorupload: proSensor.build())
            upP.writeToRouter()
        }
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
