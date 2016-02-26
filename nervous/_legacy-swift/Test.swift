////
////  Test.swift
////  nervousnet
////
////  Created by Ramapriya Sridharan on 03/09/2015.
////  Copyright (c) 2015 ethz. All rights reserved.
////
//
//import UIKit
//
//class Test: NSObject {
//    
//    func battMax(){
//        
//        print("create battery query obj")
//        let b = BatteryQuery(from: UInt64.min, to: UInt64.max) //get all values of battery stored.
//        print("get count of list")
//        let c = b.getCount()
//        print("get maximum value")
//        var m = b.getMaxValue()
//        let e = m.getValue()
//        
//        NSLog("this is the number of values: %d",c)
//        NSLog("this is the maximum value: %f %",e*100)//multiply by 100 for percentage
//        NSLog("at timestamp: %u",m.timestamp)
//        
//    }
//    
//    func battMany(){
//        var b = BatteryQuery(from: UInt64.min, to: UInt64.max) //get all values of battery stored.
//        /*println("get count of list")
//        var c = b.getCount()
//        println("battery min")
//        var a = b.getMinValue().getValue()
//        println("battery average")
//        var f = b.getAverage()
//        println("battery sd")
//        var g = b.sd()
//        println("battery variannce")
//        var h = b.variance()
//        
//        
//        
//        NSLog("this is the number of values: %d",c)
//        NSLog("this is the minimum value: %f %",a*100)
//        //multiply by 100 for percentage
//        NSLog("this is the average value: %f %",f[0]*100)
//        NSLog("this is the sd value: %f %", g[0]*100)
//        NSLog("this is the variance value: %f %",h[0]*100)*/
//
//        
//    }
//    
//    func proxValue(){
//        print("in proxValue //")
//        let b = ProximityQuery(from: UInt64.min, to: UInt64.max)
//        var c = b.getMaxValue()
//        let d = c.getValue()
//        NSLog("this is the max proximity: %d",d)
//        NSLog("at timestamp : %u",c.timestamp)
//        
//    }
//    
//    func accValue(){
//        let b = AccelerometerQuery(from: UInt64.min, to: UInt64.max)
//        var c = b.getMaxValue()
//        let d = c.getValue()
//        NSLog("this is the max accelerometer: %d",d)
//        NSLog("at timestamp : %u",c.timestamp)
//
//    }
//    
//    func gyrValue(){
//        let b = GyroscopeQuery(from: UInt64.min, to: UInt64.max)
//        var c = b.getMaxValue()
//        let d = c.getValue()
//        NSLog("this is the max gyr: %d",d)
//        NSLog("at timestamp : %u",c.timestamp)
//        
//    }
//    
//    func magValue(){
//        let b = MagneticQuery(from: UInt64.min, to: UInt64.max)
//        var c = b.getMaxValue()
//        let d = c.getValue()
//        NSLog("this is the max magnetic: %d",d)
//        NSLog("at timestamp : %u",c.timestamp)
//        
//    }
//   
//}
