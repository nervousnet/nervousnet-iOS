//
//  AccelerometerController.swift
//  nervousnet-iOS
//  
//  Created by Sid on 03 Mar 2016.
//  Copyright (c) 2016 ETHZ . All rights reserved.


import Foundation
import CoreMotion
import CoreData
import UIKit

class AccelerometerController : NSObject, SensorProtocol {

    
    private var auth: Int = 0
    
    private var manager: CMMotionManager
    
    private let VM = VMController.sharedInstance
    
    var timestamp: UInt64 = 0
    var x: Float = 0.0
    var y: Float = 0.0
    var z: Float = 0.0
    
    override init() {
        self.manager = CMMotionManager()
    }
    
    
    func requestAuthorization() {
        print("requesting authorization for acc")
        
        let val1 = self.VM.defaults.boolForKey("kill")   //objectForKey("kill") as! Bool
        let val2 = self.VM.defaults.boolForKey("switchAcc")    //objectForKey("switchAcc") as! Bool
        
        if !val1 && val2  {
            if self.manager.accelerometerAvailable {
                self.auth = 1
            }
        }
        else {
            self.auth = 0
        }
    }
    
    func initializeUpdate(freq: Double) {
        
        self.manager.accelerometerUpdateInterval = freq
        self.manager.startAccelerometerUpdates()
        
    }
    
    // requestAuthorization must be before this is function is called
    func startSensorUpdates() {
    
        if self.auth == 0 {
            return
        }
        
        let queue = NSOperationQueue()
        let currentTimeA :NSDate = NSDate()
        
        self.manager.startAccelerometerUpdatesToQueue(queue,withHandler: {data, error in

            self.timestamp = UInt64(currentTimeA.timeIntervalSince1970*1000) // time to timestamp
            //if let data = self.manager.accelerometerData {
            guard let data = data else {
                return
            }
            self.x = Float(data.acceleration.x)
            self.y = Float(data.acceleration.y)
            self.z = Float(data.acceleration.z)

            print("accelerometer")
            print(self.x)

            // store the current data in the CoreData database
            let val = self.VM.defaults.objectForKey("logAcc") as! Bool
            if val {
                let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
                let managedContext = appDelegate.managedObjectContext
                
                let entity = NSEntityDescription.entityForName("Accelerometer", inManagedObjectContext:
                                                                managedContext)
                let acc = NSManagedObject(entity: entity!, insertIntoManagedObjectContext: managedContext)
                
                acc.setValue(NSNumber(unsignedLongLong: self.timestamp) , forKey: "timestamp")
                acc.setValue(self.x, forKey: "x")
                acc.setValue(self.y, forKey: "y")
                acc.setValue(self.z, forKey: "z")
            }
        })
    }

    
    
    func stopSensorUpdates() {
        self.manager.stopAccelerometerUpdates()
        self.auth = 0
    }
}