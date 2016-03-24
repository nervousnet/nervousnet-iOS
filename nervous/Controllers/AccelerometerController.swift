//
//  AccelerometerController.swift
//  nervousnet-iOS
//  
//  Created by Sid on 03 Mar 2016.
//  Copyright (c) 2016 ETHZ . All rights reserved.


import Foundation
import CoreMotion

class AccelerometerController : NSObject, SensorProtocol {
    
    var auth: Int = 0
    
    var timestamp: UInt64
    var x: Float
    var y: Float
    var z: Float
    
    override init() {
        //self.manager = CMMotionManager()
    }
    
    func requestAuthorization() {
        print("requesting authorization for acc")
        self.auth = 0
    }
    
    func startSensorUpdates(manager: CMMotionManager, Double : freq) {
        requestAuthorization()
        
        if self.auth == 0 {
            return
        }
        
        self.manager.accelerometerUpdateInterval = freq
        manager.startAccelerometerUpdatesToQueue(NSOperationQueue.mainQueue()) {
            [weak self](data: CMAccelerometerData!, error: NSError!) in
            var currentTimeA :NSDate = NSDate()
            timestamp = UInt64(currentTimeA.timeIntervalSince1970*1000) // time to timestamp
            self.x = Float(data.acceleration.x)
            self.y = Float(data.acceleration.y)
            self.z = Float(data.acceleration.z)
        }
    }

    func stopSensorUpdates(manager: CMMotionManager) {
        self.manager.stopAccelerometerUpdates()
    }
}