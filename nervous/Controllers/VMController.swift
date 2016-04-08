//
//  VMController.swift
//  nervousnet-iOS
//  
//  Created by __DEVNAME__ on 03 Mar 2016.
//  Copyright (c) 2016 ETHZ . All rights reserved.
//
//WARNING - THIS CODE IS AUTOGENERATED BY DEVSKETCH AND CAN BE OVERWRITTEN


import Foundation

///
/// Tells other things when to write wherever. Stores state of the privacy, permissions, frequency in NSUserDefaults.
///

private let _VM = VMController()

class VMController : NSObject {
    
    // save the current state of the system in NSUserDefaults
    let defaults = NSUserDefaults.standardUserDefaults()

    // Server address and port number
    private var address = "inn.ac"
    private var port = 25600
    
    //var ss : SensorStore
    
    /*
     var hasEnabledAccelerometerLocalLogging:AnyObject
     var accelerometerCollectionFrequency:AnyObject
     var hasEnabledAccelerometerRemoteLogging:AnyObject
    */
    
    override init(){
        //super.init()
        self.defaults.setValue(true, forKey: "switchAcc")
        self.defaults.setValue(false, forKey: "switchGyr")
        self.defaults.setValue(false, forKey: "switchMag")
        self.defaults.setValue(false, forKey: "switchBat")
        
        self.defaults.setValue(false, forKey: "logAcc")
        self.defaults.setValue(false, forKey: "logGyr")
        self.defaults.setValue(false, forKey: "logMag")
        self.defaults.setValue(false, forKey: "logBat")
        
        self.defaults.setValue(0.1, forKey: "freqAcc")
        self.defaults.setValue(2.0, forKey: "freqGyr")
        self.defaults.setValue(2.0, forKey: "freqMag")
        
        self.defaults.setBool(false, forKey: "kill")
    }
    
    
    
    class var sharedInstance: VMController {
        return _VM
    }
    
    
    // initialize the initial privacy setting of the sensor
    // sets all the sensors at the same time
    func initialiseSettings(dictPrivacy: [String : Bool] ,dictFreq: [String : Double]) {
 
        for (button,privacy) in dictPrivacy{
            if button == "kill" {
                continue
            }
            self.defaults.setValue(privacy, forKey: "\(button)")
        }
        
        for (button,freq) in dictFreq {
            self.defaults.setValue(freq, forKey: "\(button)")
        }
        
    }
    
    
    // tchange he current privacy setting for each sensor individually
    func updateSettings(button: String, privacy: Bool) {
        
        self.defaults.setValue(privacy, forKey: "\(button)")
        
        //self.ss = nil
        //self.ss = SensorStore()
        
    }
    
    func updateSettings(button: String, freq: Double) {
        
        self.defaults.setValue(freq, forKey: "\(button)")
        
        //self.ss = nil
        //self.ss = SensorStore()
        
    }
    
    
    // this is the control to the master switch
    func setMasterSwitch(button: Bool) {
        
        self.defaults.setBool(button, forKey: "kill")
        
        //self.ss = nil
        //self.ss = SensorStore()
    }
    
    func getMasterSwitch() -> Bool {
        
        return defaults.boolForKey("kill")
    }
    
    

    func initialiseSensors() {
        
        //self.ss = SensorStore()
        //print("started SensorStore....")
    }
    
    
    func getSettings(button: String) -> Dictionary<String,Any> {
        
        var dict = Dictionary<String, Any>()
        
        let fq = self.defaults.doubleForKey("\(button)")
        dict["freq"] = fq
        
        let st = self.defaults.boolForKey("\(button)")
        dict["state"] = st
        
        return dict
    }
}