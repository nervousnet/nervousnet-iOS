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
        
        if(self.generateUUID()){
            NSLog("created new uuid")
        }else{
            NSLog("uuid exists")
            NSLog(getHUUID().description)
            NSLog(getLUUID().description)
            
            
            
        }
        
    }
    
    
    func getHUUID() -> NSInteger {
        return defaults.integerForKey("huuid")
    }
    
    
    func getLUUID() -> NSInteger {
        return defaults.integerForKey("luuid")
    }
    
    
    func generateUUID() -> Bool {
        
        if(defaults.integerForKey("huuid") != 0){
            
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
            
            
            defaults.setInteger(HUUIDBytes, forKey: "huuid")
            defaults.setInteger(LUUIDBytes, forKey: "luuid")
            defaults.synchronize()
            
            return true
        }
        
        
    
    }
    
    
}