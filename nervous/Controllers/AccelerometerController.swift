//
//  AccelerometerController.swift
//  nervousnet-iOS
//  
//  Created by Sid on 03 Mar 2016.
//  Copyright (c) 2016 ETHZ . All rights reserved.


import Foundation
import CoreMotion

class AccelerometerController : NSObject, SensorProtocol {
    
    override init() {
        self.manager = CMMotionManager()
    }
    
    func startSensorUpdates(manager: CMMotionManager, Double : freq) {
        self.manager.accelerometerUpdateInterval = freq
        manager.startAccelerometerUpdatesToQueue(NSOperationQueue.mainQueue()) {
            [weak self](data: CMAccelerometerData!, error: NSError!) in
            var currentTimeA :NSDate = NSDate()
            var sensorDescAcc = SensorDescAccelerometer (
                timestamp: UInt64(currentTimeA.timeIntervalSince1970*1000), // time to timestamp
                accX : Float(data.acceleration.x),
                accY : Float(data.acceleration.y),
                accZ : Float(data.acceleration.z)
            )
        }
    }

    func stopSensorUpdates() {
        self.manager.stopAccelerometerUpdates()
    }
}

