//
//  SensorDescAccelerometer.swift
//  nervousnet
//
//  Created by Sddhartha on 13/05/15.
//  Copyright (c) 2015 ethz. All rights reserved.
//

import Foundation
import CoreLocation
import CoreMotion

class SensorDescAccelerometer : SensorDescVectorValue {
    
    let SENSOR_ID :UInt64 = 0x0000000000000000
    
    var sensorIdentifier: Int64 = 0x0000000000000000
    
    var timestamp :UInt64
    var accX : Float
    var accY : Float
    var accZ : Float
    
    required init(sensorData: SensorUploadSensorData) {
        
        self.timestamp = sensorData.recordTime
        self.accX = sensorData.valueFloat[0]
        self.accY = sensorData.valueFloat[1]
        self.accZ = sensorData.valueFloat[2]
    }
    
    init(timestamp :UInt64, accX :Float, accY :Float, accZ :Float){
        
        self.timestamp = timestamp
        self.accX = accX
        self.accY = accY
        self.accZ = accZ
    }
    
    init(data: CMAccelerometerData!, error: NSError!,timestamp: UInt64) {
        self.timestamp = timestamp;
        self.accX = Float(data.acceleration.x);
        self.accY = Float(data.acceleration.y);
        self.accZ = Float(data.acceleration.z);
    }
    
    func getAccX() -> Float{
        return self.accX;
    }
    
    func getAccY() -> Float{
        return self.accY;
    }
    
    func getAccZ() -> Float{
        return self.accZ;
    }
    
    func toProtoSensor() -> SensorUploadSensorData {
        let builder = SensorUploadSensorData.builder()
        builder.recordTime = timestamp
        builder.valueFloat = [self.accX,self.accY,self.accZ]
        
        return builder.build()
        
    }
    
    func getSensorId() -> UInt64 {
        return SENSOR_ID;
    }
    
    
    func getValue() -> [Float] {
        return [self.accX,self.accY,self.accZ];
    }
    
}