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
        }
        
    }
    
    
    func getHUUID() -> UInt64 {
        return UInt64(defaults.integerForKey("huuid"))
    }
    
    
    func getLUUID() -> UInt64 {
        return UInt64(defaults.integerForKey("luuid"))
    }
    
    
    func generateUUID() -> Bool {
        
        if(defaults.integerForKey("huuid") != 0){
            return false
            
        }else{
            
            defaults.setInteger(Int(arc4random()), forKey: "huuid")
            defaults.setInteger(Int(arc4random()), forKey: "luuid")
            defaults.synchronize()
            
            return true
        }
        
        
    
    }
    
    
}