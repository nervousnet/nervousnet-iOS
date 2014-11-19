//
//  NervousVM.swift
//  nervous
//
//  Created by Sam Sulaimanov on 27/09/14.
//  Copyright (c) 2014 ethz. All rights reserved.
//

import Foundation

class NervousVM {
    
    let defaults :NSUserDefaults = NSUserDefaults.standardUserDefaults()
    
    init(){
        var genUUID = self.generateUUID()
    }
    
    
    func getHUUID() -> UInt64 {
        return UInt64(defaults.integerForKey("huuid"))
    }
    
    
    func getLUUID() -> UInt64 {
        return UInt64(defaults.integerForKey("luuid"))
    }
    
    
    func getBeaconMinor() -> CLBeaconMinorValue {
        return CLBeaconMinorValue(defaults.integerForKey("beaconminor"))
    }
    
    func generateUUID() -> Bool {
        
        if(defaults.objectForKey("huuid") != nil && defaults.integerForKey("huuid") != 0 && defaults.integerForKey("beaconminor") != 0){
            
            return false
            
        }else{
            
            var UUIDBytes: UInt8  = 0
            var LUUIDBytes: NSInteger = 0
            var HUUIDBytes: NSInteger = 0
            
            var newUUID:NSUUID = NSUUID()
            newUUID.getUUIDBytes(&UUIDBytes)
            
            let newUUIDData = NSData(bytes: &UUIDBytes, length: 16)
            newUUIDData.getBytes(&LUUIDBytes, range: NSMakeRange(0, 7))
            newUUIDData.getBytes(&HUUIDBytes, range: NSMakeRange(7, 7))
            
            /*var LUUID = NSData(bytes: &LUUIDBytes, length: 8).getBytes
            var HUUID = NSData(bytes: &HUUIDBytes, length: 8)
            */
            
            var beaconMinor :NSInteger = (NSInteger(arc4random()) % (255 - 1025)) + 255
            
            defaults.setInteger(HUUIDBytes, forKey: "huuid")
            defaults.setInteger(LUUIDBytes, forKey: "luuid")
            defaults.setInteger(beaconMinor, forKey: "beaconminor")
            defaults.synchronize()
            
            return true
        }
        
        
    
    }
    
    
}