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
//class SensorQueriesBattery<T : SensorDescBattery> : QueryNumSingleValue<SensorDescBattery>{
//    var T : SensorDescBattery
//    init(f :UInt64,t :UInt64){
//        let m = SensorDescBattery(timestamp: 0,batteryPercent: 0,isCharging: false,isUsbCharge: false,isAcCharge: false)
//        T = m
//        super.init(from: f, to: t)
//        
//    }
//    
//    override func getSensorID() -> UInt64 {
//        return T.getSensorId()
//    }
//    
//    override func createDummyObject()->SensorDescBattery{
//        let m = SensorDescBattery(timestamp: 0,batteryPercent: 0,isCharging: false,isUsbCharge: false,isAcCharge: false)
//        return m
//    }
//    
//    override func createSensorDescSingleValue(sensorData: SensorUploadSensorData) -> SensorDescBattery {
//        let m = SensorDescBattery( sensorData : sensorData )
//        return m
//    }
//    
//    
//    
//    
//    
//    
//}
