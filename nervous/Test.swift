//
//  Test.swift
//  nervousnet
//
//  Created by Ramapriya Sridharan on 03/09/2015.
//  Copyright (c) 2015 ethz. All rights reserved.
//

import UIKit

class Test: NSObject {
    
    func battMax(){
        
        println("create battery query obj")
        var b = BatteryQuery(from: UInt64.min, to: UInt64.max) //get all values of battery stored.
        println("get count of list")
        var c = b.getCount()
        println("get maximum value")
        var m = b.getMaxValue()
        var e = m.getValue()
        
        NSLog("this is the number of values: %d",c)
        NSLog("this is the maximum value: %f %",e*100)//multiply by 100 for percentage
        NSLog("at timestamp: %u",m.timestamp)
        
    }
    
    func proxValue(){
        println("in proxValue //")
        var b = ProximityQuery(from: UInt64.min, to: UInt64.max)
        var c = b.getMaxValue()
        var d = c.getValue()
        NSLog("this is the max proximity: %d",d)
        NSLog("at timestamp : %u",c.timestamp)
        
    }
    
    func accValue(){
        var b = AccelerometerQuery(from: UInt64.min, to: UInt64.max)
        var c = b.getMaxValue()
        var d = c.getValue()
        NSLog("this is the max accelerometer: %d",d)
        NSLog("at timestamp : %u",c.timestamp)

    }
    
    func gyrValue(){
        var b = GyroscopeQuery(from: UInt64.min, to: UInt64.max)
        var c = b.getMaxValue()
        var d = c.getValue()
        NSLog("this is the max gyr: %d",d)
        NSLog("at timestamp : %u",c.timestamp)
        
    }
    
    func magValue(){
        var b = MagneticQuery(from: UInt64.min, to: UInt64.max)
        var c = b.getMaxValue()
        var d = c.getValue()
        NSLog("this is the max magnetic: %d",d)
        NSLog("at timestamp : %u",c.timestamp)
        
    }
   
}
