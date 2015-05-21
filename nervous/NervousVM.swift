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

class NervousVM {
    
    let defaults :NSUserDefaults = NSUserDefaults.standardUserDefaults()
    
    init(){
        
        
            var genUUID = self.generateUUID()
        
        
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
    

}