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

class NervousVM {
    
    let defaults :NSUserDefaults = NSUserDefaults.standardUserDefaults()
    var accFreq : Double = 30
    var gyrFreq : Double = 30
    var magFreq : Double = 30
    var batFreq : Double = 30
    var proFreq : Double = 30
    
    init(){
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
        switch sensorID {
        case 0:
            self.accFreq = freq
        case 1:
            self.batFreq = freq
        case 2:
            self.gyrFreq = freq
        case 5:
            self.magFreq = freq
        case 6:
            self.proFreq = freq
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
    

}