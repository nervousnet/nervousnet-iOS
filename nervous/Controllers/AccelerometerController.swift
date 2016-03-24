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
    
    let manager: CMMotionManager
    
    var timestamp: UInt64 = 0
    var x: Float = 0.0
    var y: Float = 0.0
    var z: Float = 0.0
    
    override init() {
        self.manager = CMMotionManager()
    }
    
    func requestAuthorization() {
        print("requesting authorization for acc")
        self.auth = 1
    }
    

    func startSensorUpdates(freq: Double) {

        requestAuthorization()
        
        if self.auth == 0 {
            return
        }
        
        self.manager.accelerometerUpdateInterval = freq
        let currentTimeA :NSDate = NSDate()
        
        self.timestamp = UInt64(currentTimeA.timeIntervalSince1970*1000) // time to timestamp
        if let data = self.manager.accelerometerData {
            self.x = Float(data.acceleration.x)
            self.y = Float(data.acceleration.y)
            self.z = Float(data.acceleration.z)
        }
    }

    func stopSensorUpdates() {
        self.manager.stopAccelerometerUpdates()
    }

}