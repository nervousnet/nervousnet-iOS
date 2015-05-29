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
    var address = "inn.ac"
    var port = 25600
    
    // Timers for different sensors
    var timerA = NSTimer()
    var timerB = NSTimer()
    var timerP = NSTimer()
    
    // Timer for pushing to the server
    var timerD = NSTimer()
    
    // Boolean for logging buttons
    var logA : Bool = true
    var logG : Bool = true
    var logM : Bool = true
    var logB : Bool = true
    var logP : Bool = true
    
    // Boolean for sharing buttons
    var shareA : Bool = true
    var shareG : Bool = true
    var shareM : Bool = true
    var shareB : Bool = true
    var shareP : Bool = true
    
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
    // and create threds to execute the collection with
    // the chosen frequencies.
    func setFrequency(sensorID : Int, freq : Double) {
        var db = SQLiteSensorsDB.sharedInstance
        var VM = NervousVM.sharedInstance
        switch sensorID {
        case 0:
            self.accFreq = freq
            self.manager.stopAccelerometerUpdates()
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
                    //println(temp)
                    if(VM.getLogSwitch(0)) {
                        //println(data.acceleration.x)
                        db.store(0x0000000000000000, timestamp: sensorDescAcc.timestamp, sensorData: sensorDescAcc.toProtoSensor())
                    }
                }
            }
        case 1:
            self.batFreq = freq
            self.timerB.invalidate()
            self.timerB = NSTimer.scheduledTimerWithTimeInterval(freq, target: self, selector: Selector("batteryCollection"), userInfo: nil, repeats: true)
        case 2:
            self.gyrFreq = freq
            self.manager.stopGyroUpdates()
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
                    /*println("==================")
                    println(data.rotationRate.x)
                    println(data.rotationRate.y)
                    println(data.rotationRate.z)
                    println("==================")*/
                    if(VM.getLogSwitch(2)) {
                        db.store(0x0000000000000002, timestamp: sensorDescGyr.timestamp, sensorData: sensorDescGyr.toProtoSensor())
                    }
                }
            }
        case 5:
            self.magFreq = freq
            self.manager.stopMagnetometerUpdates()
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
                    //println(data.magneticField.x)
                    if(VM.getLogSwitch(5)) {
                        db.store(0x0000000000000005, timestamp: sensorDescMag.timestamp, sensorData: sensorDescMag.toProtoSensor())
                    }
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
        if(self.logB) {
            //println(UIDevice.currentDevice().batteryLevel)
            db.store(0x0000000000000001, timestamp: sensorDescBat.timestamp, sensorData: sensorDescBat.toProtoSensor())
        }
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
        if(self.logP) {
            db.store(0x0000000000000006, timestamp: sensorDescProx.timestamp, sensorData: sensorDescProx.toProtoSensor())
        }
        UIDevice.currentDevice().proximityMonitoringEnabled = false
    }
    
    // Push the data collected to the server
    func pushToServer() {
        // println("+=+=+=+=+=+=+=+=+=+=+=+=+=+=")
        // UUID
        var huuid : UInt64 = getHUUID()
        var luuid : UInt64 = getLUUID()
        
        var db = SQLiteSensorsDB.sharedInstance
        var currentTime :NSDate = NSDate()
        var timestamp :UInt64 = UInt64(currentTime.timeIntervalSince1970*1000)
        //println(VM.getHUUID())
        
        // Accelerometer
        if(self.shareA) {
            let accSensor = SensorUpload.builder()
            accSensor.huuid = huuid //phone huuid
            accSensor.luuid = luuid //phone luuid
            accSensor.uploadTime = timestamp
            accSensor.sensorId = 0x0000000000000000
            var sensorDataArrayA: [SensorUploadSensorData] = db.retrieve(0x0000000000000000, fromTimestamp: (timestamp - 60000), toTimestamp: timestamp)
            accSensor.sensorValues = sensorDataArrayA
            dispatch_async(dispatch_get_main_queue()) {
                var upA = UploadTask(pbSensorupload: accSensor.build())
                upA.writeToRouter()
            }
        }
        
        // Gyroscope
        if(self.shareG) {
            let gyrSensor = SensorUpload.builder()
            gyrSensor.huuid = huuid
            gyrSensor.luuid = luuid
            gyrSensor.uploadTime = timestamp
            gyrSensor.sensorId = 0x0000000000000002
            var sensorDataArrayG: [SensorUploadSensorData] = db.retrieve(0x0000000000000002, fromTimestamp: (timestamp - 60000), toTimestamp: timestamp)
            gyrSensor.sensorValues = sensorDataArrayG
            dispatch_async(dispatch_get_main_queue()) {
                var upG = UploadTask(pbSensorupload: gyrSensor.build())
                upG.writeToRouter()
            }
        }
    
        // Magnetic
        if(self.shareM) {
            let magSensor = SensorUpload.builder()
            magSensor.huuid = huuid
            magSensor.luuid = luuid
            magSensor.uploadTime = timestamp
            magSensor.sensorId = 0x0000000000000005
            var sensorDataArrayM: [SensorUploadSensorData] = db.retrieve(0x0000000000000005, fromTimestamp: (timestamp - 60000), toTimestamp: timestamp)
            magSensor.sensorValues = sensorDataArrayM
            dispatch_async(dispatch_get_main_queue()) {
                var upM = UploadTask(pbSensorupload: magSensor.build())
                upM.writeToRouter()
            }
        }
        
        // Battery
        if(self.shareB) {
            let batSensor = SensorUpload.builder()
            batSensor.huuid = huuid
            batSensor.luuid = luuid
            batSensor.uploadTime = timestamp
            batSensor.sensorId = 0x0000000000000001
            var sensorDataArrayB: [SensorUploadSensorData] = db.retrieve(0x0000000000000001, fromTimestamp: (timestamp - 60000), toTimestamp: timestamp)
            batSensor.sensorValues = sensorDataArrayB
            dispatch_async(dispatch_get_main_queue()) {
                var upB = UploadTask(pbSensorupload: batSensor.build())
                upB.writeToRouter()
            }
            /*for sensorData in sensorDataArrayB {
            var retSensDesc = SensorDescBattery(sensorData: sensorData)
            NSLog("\((retSensDesc as SensorDesc).timestamp)")
            NSLog("\(retSensDesc.batteryPercent) \(retSensDesc.isCharging)")
            }*/
        }
        
        // Proximity
        if(self.shareP) {
            let proSensor = SensorUpload.builder()
            proSensor.huuid = huuid
            proSensor.luuid = luuid
            proSensor.uploadTime = timestamp
            proSensor.sensorId = 0x0000000000000006
            var sensorDataArrayP: [SensorUploadSensorData] = db.retrieve(0x0000000000000006, fromTimestamp: (timestamp - 60000), toTimestamp: timestamp)
            proSensor.sensorValues = sensorDataArrayP
            dispatch_async(dispatch_get_main_queue()) {
                var upP = UploadTask(pbSensorupload: proSensor.build())
                upP.writeToRouter()
            }
            /*for sensorData in sensorDataArrayP {
            var retSensDesc = SensorDescProximity(sensorData: sensorData)
            NSLog("\((retSensDesc as SensorDesc).timestamp)")
            NSLog("\(retSensDesc.proximity)")
            }*/
        }
        // println("+=+=+=+=+=+=+=+=+=+=+=+=+=+=")
    }
    
    // Timer to push to the server
    func pushToServerTimer() {
        var timerD = NSTimer.scheduledTimerWithTimeInterval(60.5, target: self, selector: Selector("pushToServer"), userInfo: nil, repeats: true)
    }
    
    // if the main switch(center of the start screen) is on or off
    func killSwitch(state : Bool) {
        if(state) {
            self.timerD.invalidate()
            self.timerA.invalidate()
            self.timerB.invalidate()
            self.timerP.invalidate()
            self.manager.stopAccelerometerUpdates()
            self.manager.stopGyroUpdates()
            self.manager.stopMagnetometerUpdates()
        }
        else {
            self.setFrequency(0, freq: self.accFreq)
            self.setFrequency(1, freq: self.batFreq)
            self.setFrequency(2, freq: self.gyrFreq)
            self.setFrequency(5, freq: self.magFreq)
            self.setFrequency(6, freq: self.proFreq)
            self.pushToServer()
        }
    }
    
    // takes logging booleans for different sensors from the UI
    func setLogSwitch(SensorID : Int, logging : Bool) {
        switch SensorID {
        case 0:
            self.logA = logging
        case 1:
            self.logB = logging
        case 2:
            self.logG = logging
        case 5:
            self.logM = logging
        case 6:
            self.logP = logging
        default:
            println("")
        }
    }

    // takes sharing booleans for different sensors from the UI
    func setShareSwitch(SensorID : Int, sharing : Bool) {
        switch SensorID {
        case 0:
            self.shareA = sharing
        case 1:
            self.shareB = sharing
        case 2:
            self.shareG = sharing
        case 5:
            self.shareM = sharing
        case 6:
            self.shareP = sharing
        default:
            println("")
        }
    }
    
    // get the current state of the logging switch
    func getLogSwitch(SensorID : Int) -> Bool {
        switch SensorID {
        case 0:
            return self.logA
        case 1:
            return self.logB
        case 2:
            return self.logG
        case 5:
            return self.logM
        case 6:
            return self.logP
        default:
            return true
        }
    }

    
    // get the current state of the sharing switch
    func getShareSwitch(SensorID : Int) -> Bool {
        switch SensorID {
        case 0:
            return self.shareA
        case 1:
            return self.shareB
        case 2:
            return self.shareG
        case 5:
            return self.shareM
        case 6:
            return self.shareP
        default:
            return true
        }
    }
}