//
//  SensorCollection.swift
//  nervousnet
//
//  Created by Siddhartha on 21/05/15.
//  Copyright (c) 2015 ethz. All rights reserved.
//

import Foundation
import UIKit
import CoreMotion


class SensorCollection {
    
    init() {}
    
    // Function to 'fetch' the data from the sensors(hardware) in the phone
    // and 'push' it to the database.See AppDelegate.swift for the call.
    class func sensorActivate(manager : CMMotionManager) {
        // The core motion manager. Should be same manager for all sensors for
        // consistency.
        // let manager = CMMotionManager()
        
        // The DataBase Instance
        // It is a Singleton and should never be instantiated twice
        var db = SQLiteSensorsDB.sharedInstance
        
        
        // +++++++++++++++++++++++++++++++++++++++++++++++++++
        // Fetching and Pushing the data of individual sensors
        // +++++++++++++++++++++++++++++++++++++++++++++++++++
        
        // Accelerometer
        if manager.accelerometerAvailable {
            manager.accelerometerUpdateInterval = 1  // fetching interval in seconds.
            manager.startAccelerometerUpdatesToQueue(NSOperationQueue.mainQueue()) {
                (data: CMAccelerometerData!, error: NSError!) in
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
                (data: CMGyroData!, error: NSError!) in
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
        //sprintln(manager.magnetometerAvailable)
        if manager.magnetometerAvailable {
            manager.magnetometerUpdateInterval = 30
            manager.startMagnetometerUpdatesToQueue(NSOperationQueue.mainQueue()) {
                (data: CMMagnetometerData!, error: NSError!) in
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
        
        // Proximity
        UIDevice.currentDevice().proximityMonitoringEnabled = true // start the battery data collection
        var currentTimeP :NSDate = NSDate()
        var sensorDescProx = SensorDescProximity (
            timestamp: UInt64(currentTimeP.timeIntervalSince1970*1000), // time to timestamp
            proximity : 0,
            isClose : UIDevice.currentDevice().proximityState
        )
        db.store(0x0000000000000006, timestamp: sensorDescProx.timestamp, sensorData: sensorDescProx.toProtoSensor())
        
        
    }
    
}