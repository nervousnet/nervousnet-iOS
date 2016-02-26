////
////  SensorDescGyroscope.swift
////  nervousnet
////
////  Created by Sddhartha on 13/05/15.
////  Copyright (c) 2015 ethz. All rights reserved.
////
//
//import Foundation
//import CoreLocation
//import CoreMotion
//
//class SensorDescGyroscope : SensorDescVectorValue {
//    
//    let SENSOR_ID :UInt64 = 0x0000000000000002
//    
//    var sensorIdentifier: Int64 = 0x0000000000000002
//    
//    var timestamp :UInt64
//    var gyrX : Float
//    var gyrY : Float
//    var gyrZ : Float
//    
//    required init(sensorData: SensorUploadSensorData) {
//        
//        self.timestamp = sensorData.recordTime
//        self.gyrX = sensorData.valueFloat[0]
//        self.gyrY = sensorData.valueFloat[1]
//        self.gyrZ = sensorData.valueFloat[2]
//    }
//    
//    init(timestamp :UInt64, gyrX :Float, gyrY :Float, gyrZ :Float){
//        
//        self.timestamp = timestamp
//        self.gyrX = gyrX
//        self.gyrY = gyrY
//        self.gyrZ = gyrZ
//    }
//    
//    init(data: CMGyroData!, error: NSError!,timestamp: UInt64) {
//        self.timestamp = timestamp;
//        self.gyrX = Float(data.rotationRate.x);
//        self.gyrY = Float(data.rotationRate.y);
//        self.gyrZ = Float(data.rotationRate.z);
//    }
//    
//    func getGyrX() -> Float{
//        return self.gyrX;
//    }
//    
//    func getGyrY() -> Float{
//        return self.gyrY;
//    }
//    
//    func getGyrZ() -> Float{
//        return self.gyrZ;
//    }
//    
//    func toProtoSensor() -> SensorUploadSensorData {
//        let builder = SensorUploadSensorData.builder()
//        builder.recordTime = timestamp
//        builder.valueFloat = [self.gyrX,self.gyrY,self.gyrZ]
//        
//        return builder.build()
//
//    }
//    
//    func getSensorId() -> UInt64 {
//        return SENSOR_ID;
//    }
//    
//    
//    func getValue() -> [Float] {
//        return [self.gyrX,self.gyrY,self.gyrZ];
//    }
//    
//}