////
////  SensorQueriesBattery.swift
////  nervousnet
////
////  Created by Ramapriya Sridharan on 23/05/2015.
////  Copyright (c) 2015 ethz. All rights reserved.
////
//
//import UIKit
//
//class SensorQueriesProximity<T : SensorDescProximity> : QueryNumSingleValue<SensorDescProximity>{
//    var T : SensorDescProximity
//    init(f :UInt64,t :UInt64){
//        let m = SensorDescProximity(timestamp: 0,proximity: 0,isClose: true) //Random
//        T = m
//        super.init(from: f, to: t)
//        
//    }
//    
//    override func getSensorID() -> UInt64 {
//        return T.getSensorId()
//    }
//    
//    override func createDummyObject()->SensorDescProximity{
//        let m = SensorDescProximity(timestamp: 0,proximity: 0,isClose: true)
//        return m
//    }
//    
//    override func createSensorDescSingleValue(sensorData: SensorUploadSensorData) -> SensorDescProximity {
//        let m = SensorDescProximity( sensorData : sensorData )
//        return m
//    }
//    
//    
//    
//    
//    
//    
//}
