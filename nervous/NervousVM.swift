//
//  NervousVM.swift
//  nervous
//
//  Created by Sam Sulaimanov on 27/09/14.
//  Extended by Siddhartha
//  Copyright (c) 2014 ethz. All rights reserved.
//

import Foundation
import UIKit
import CoreMotion

// Instantiate the VM for global use as a singleton
private let _VM = NervousVM()

class NervousVM : NSObject{
    
    let defaults :NSUserDefaults = NSUserDefaults.standardUserDefaults()
    
    // Motion manager
    let manager = CMMotionManager()
    
    // Frequencies of the sensors
    var accFreq : Double = 30
    var gyrFreq : Double = 30
    var magFreq : Double = 30
    var batFreq : Double = 30
    var proFreq : Double = 30
    
    // Server address and port number
    var address = "www.inn.ac"
    var port = 25600
    
    // Timers for different sensors
    var timerA = NSTimer()
    var timerB = NSTimer()
    var timerP = NSTimer()
    
    override init(){
            super.init()
            var genUUID = self.generateUUID()
    }
    
    class var sharedInstance: NervousVM {
        return _VM
    }
    
    func pad(string : String, toSize: Int) -> String {
        var padded = string
        for i in 0..<toSize - countElements(string) {
            padded = "0" + padded
        }
        return padded
    }
    

    
    func getHUUID() -> UInt64 {
        let generated = defaults.boolForKey("generatedUUID")
        
        if(generated){
            let huuid : UInt64 = UInt64(defaults.integerForKey("huuid"))
            
            return huuid
        }else{
            return 0
        }
    }
    
    
    func getLUUID() -> UInt64 {
        let generated = defaults.boolForKey("generatedUUID")
        
        if(generated){
            let luuid : UInt64 = UInt64(defaults.integerForKey("luuid"))
            
            return luuid
        }else{
            return 0
        }
    }
    
    
    func getBeaconMinor() -> CLBeaconMinorValue {
        let generated = defaults.boolForKey("generatedUUID")
        
        if(generated){
            let minor :CLBeaconMinorValue = CLBeaconMinorValue(defaults.integerForKey("beaconminor"))

            return minor
        }else{
            return 0
        }
    }
    
    
    func generateUUID() -> Bool {
        
        let generated = defaults.boolForKey("generatedUUID")
        
        if(generated == true){
            
            
            
            //String representation of uuid
            NSLog("starting generation of uuid string")
            let huuidRaw = getHUUID()
            let luuidRaw = getLUUID()
            
            
            let uuidString = pad(String(huuidRaw, radix: 16), toSize:16) + pad(String(luuidRaw, radix: 16), toSize:16)
            NSLog("UUID: %@", uuidString.uppercaseString)
            
            defaults.setValue(uuidString.uppercaseString, forKey: "uuidString")
            
            return false
            
        }else{
            
            NSLog("generating a new uuid")
            
            let LUUID:Int = Int(arc4random_uniform(1234567890)+123456)
            let HUUID:Int = Int(arc4random_uniform(1234567890)+234567)

            let beaconMinor :Int = Int(arc4random_uniform(7000)+200)
            
            defaults.setBool(true, forKey: "generatedUUID")
            
            defaults.setInteger(HUUID, forKey: "huuid")
            defaults.setInteger(LUUID, forKey: "luuid")
            defaults.setInteger(beaconMinor, forKey: "beaconminor")
            
            
            return true
        }
        
        
    
    }
    
    // to retrieve the data from the database once the value has been fetched and stored
    // using the fetchPushAndSend() function.
    func retrieve(SENSOR_ID : UInt64,fromTimeStamp : UInt64,toTimeStamp : UInt64) -> [SensorUploadSensorData] {
        
        var db = SQLiteSensorsDB.sharedInstance
        
        var sensorDataArray: [SensorUploadSensorData] =
        db.retrieve(SENSOR_ID, fromTimestamp: fromTimeStamp, toTimestamp: toTimeStamp)
        
        return sensorDataArray;
    }
    
    // set frequecies for collecting sensor information
    func setFrequency(sensorID : Int, freq : Double) {
        var db = SQLiteSensorsDB.sharedInstance
        switch sensorID {
        case 0:
            self.accFreq = freq
            manager.stopAccelerometerUpdates()
            if manager.accelerometerAvailable {
                manager.accelerometerUpdateInterval = freq
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
                }
            }
        case 1:
            self.batFreq = freq
            self.timerB.invalidate()
            self.timerB = NSTimer.scheduledTimerWithTimeInterval(freq, target: self, selector: Selector("batteryCollection"), userInfo: nil, repeats: true)
        case 2:
            self.gyrFreq = freq
            manager.stopGyroUpdates()
            if manager.gyroAvailable {
                manager.gyroUpdateInterval = freq
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
                }
            }
        case 5:
            self.magFreq = freq
            manager.stopMagnetometerUpdates()
            if manager.magnetometerAvailable {
                manager.magnetometerUpdateInterval = freq
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
        case 6:
            self.proFreq = freq
            self.timerP.invalidate()
            self.timerP = NSTimer.scheduledTimerWithTimeInterval(freq, target: self, selector: Selector("proximityCollection"), userInfo: nil, repeats: true)
        default:
            println("")
        }
    }
    
    // get frequencies after the frequencies are set using the UI
    func getFrequency(sensorID : Int) -> Double {
        switch sensorID {
        case 0:
            return self.accFreq
        case 1:
            return self.batFreq
        case 2:
            return self.gyrFreq
        case 5:
            return self.magFreq
        case 6:
            return self.proFreq
        default:
            return 30
        }
    }
    
    // set the server address and port number
    func setServer(address : String, port : Int) {
        self.address = address
        self.port = port
    }
    
    // get the server address
    func getServerAddress() -> String {
        return self.address
    }
    
    // get the port number
    func getServerPort() -> Int {
        return self.port
    }
    
    // Battery
    func batteryCollection() {
        var db = SQLiteSensorsDB.sharedInstance
        UIDevice.currentDevice().batteryMonitoringEnabled = true // start the battery data collection
        var currentTimeB :NSDate = NSDate()
        var isCharging: Bool
        var isUsbCharge: Bool
        var isAcCharge: Bool
        
        if UIDeviceBatteryState.Charging.rawValue == 1{ // doubt check this if '1' is correct
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
        var db = SQLiteSensorsDB.sharedInstance
        UIDevice.currentDevice().proximityMonitoringEnabled = true // start the battery data collection
        var currentTimeP :NSDate = NSDate()
        var sensorDescProx = SensorDescProximity (
            timestamp: UInt64(currentTimeP.timeIntervalSince1970*1000), // time to timestamp
            proximity : 0, // must be checked
            isClose : UIDevice.currentDevice().proximityState
        )
        db.store(0x0000000000000006, timestamp: sensorDescProx.timestamp, sensorData: sensorDescProx.toProtoSensor())
        UIDevice.currentDevice().proximityMonitoringEnabled = false
    }

}