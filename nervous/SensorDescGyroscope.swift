//
//  SensorDescGyroscope.swift
//  nervousnet
//
//  Created by Sddhartha on 13/05/15.
//  Copyright (c) 2015 ethz. All rights reserved.
//

import Foundation
import CoreLocation
import CoreMotion

class SensorDescGyroscope : SensorDescVectorValue {
    
    let SENSOR_ID :Int64 = 0x000000000000000B
    
    var sensorIdentifier: Int64 = 0x000000000000000B
    
    var timestamp :UInt64
    var X : Float
    var Y : Float
    var Z : Float
    
    required init(sensorData: SensorUploadSensorData) {
        
        self.timestamp = sensorData.recordTime
        self.X = sensorData.valueFloat[0]
        self.Y = sensorData.valueFloat[1]
        self.Z = sensorData.valueFloat[2]
    }
    
    init(timestamp :UInt64, X :Float, Y :Float, Z :Float){
        
        self.timestamp = timestamp
        self.X = X
        self.Y = Y
        self.Z = Z
    }
    
    init(data: CMGyroData!, error: NSError!,timestamp: UInt64) {
        self.timestamp = timestamp;
        self.X = Float(data.rotationRate.x);
        self.Y = Float(data.rotationRate.y);
        self.Z = Float(data.rotationRate.z);
    }
    
    func getGyrX() -> Float{
        return self.X;
    }
    
    func getGyrY() -> Float{
        return self.Y;
    }
    
    func getGyrZ() -> Float{
        return self.Z;
    }
    
    func toProtoSensor() -> SensorUploadSensorData {
        let builder = SensorUploadSensorData.builder()
        builder.recordTime = timestamp
        builder.valueFloat = [self.X,self.Y,self.Z]
        
        return builder.build()

    }
    
    func getSensorId() -> Int64 {
        return SENSOR_ID;
    }
    
    
    func getValue() -> [Float] {
        return [self.X,self.Y,self.Z];
    }
    
}