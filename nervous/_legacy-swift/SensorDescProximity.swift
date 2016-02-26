////
////  SensorDescProximity.swift
////  nervousnet
////
////  Created by Siddhartha on 15/05/15.
////  Copyright (c) 2015 ethz. All rights reserved.
////
//
//import UIKit
//
//class SensorDescProximity: SensorDescSingleValue {
//    
//    let SENSOR_ID :UInt64 = 0x0000000000000006
//    
//    var sensorIdentifier: Int64 = 0x0000000000000006
//    
//    var timestamp: UInt64
//    var proximity: Float
//    var isClose: Bool
//    
//    init(timestamp: UInt64, proximity: Float, isClose : Bool) {
//        
//        self.timestamp = timestamp
//        self.proximity = proximity
//        self.isClose = isClose
//    }
//    
//    /*
//    override keyword always needed here
//    */
//    required init(sensorData: SensorUploadSensorData) {
//        
//        self.timestamp = sensorData.recordTime
//        self.proximity = sensorData.valueFloat[0]
//        self.isClose = sensorData.valueBool[0]
//    }
//    
//    init (phone: UIDevice, timestamp: UInt64) {
//        self.timestamp = timestamp
//        self.proximity = 0
//        self.isClose = phone.proximityState
//    }
//    
//    /*
//    Override keyword needed
//    */
//    func toProtoSensor() -> SensorUploadSensorData {
//        
//        let builder = SensorUploadSensorData.builder()
//        
//        /*
//        Always set the record time! also it's important to put the values in the
//        array in the same exact order as in Android
//        */
//        builder.recordTime = timestamp
//        builder.valueFloat = [self.proximity]
//        builder.valueBool = [self.isClose]
//        
//        return builder.build()
//    }
//    
//    func getSensorId() -> UInt64 {
//        return SENSOR_ID;
//    }
//    
//    func getValue() -> Float {
//        return self.proximity;
//    }
//}
