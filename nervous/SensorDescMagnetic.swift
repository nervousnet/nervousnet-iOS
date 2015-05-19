//
//  SensorDescMagnetic.swift
//  nervousnet
//
//  Created by Siddhartha on 15/05/15.
//  Copyright (c) 2015 ethz. All rights reserved.
//

import Foundation
import CoreLocation
import CoreMotion

class SensorDescMagnetic : SensorDescVectorValue {
    
    let SENSOR_ID :Int64 = 0x000000000000000B
    
    var sensorIdentifier: Int64 = 0x000000000000000B
    
    var timestamp :UInt64
    var magX : Float
    var magY : Float
    var magZ : Float
    
    required init(sensorData: SensorUploadSensorData) {
        
        self.timestamp = sensorData.recordTime
        self.magX = sensorData.valueFloat[0]
        self.magY = sensorData.valueFloat[1]
        self.magZ = sensorData.valueFloat[2]
    }
    
    init(timestamp :UInt64, magX :Float, magY :Float, magZ :Float){
        
        self.timestamp = timestamp
        self.magX = magX
        self.magY = magY
        self.magZ = magZ
    }
    
    init(data: CMMagnetometerData!, error: NSError!,timestamp: UInt64) {
        self.timestamp = timestamp;
        self.magX = Float(data.magneticField.x);
        self.magY = Float(data.magneticField.y);
        self.magZ = Float(data.magneticField.z);
    }
    
    func getMagX() -> Float{
        return self.magX;
    }
    
    func getMagY() -> Float{
        return self.magY;
    }
    
    func getMagZ() -> Float{
        return self.magZ;
    }
    
    func toProtoSensor() -> SensorUploadSensorData {
        let builder = SensorUploadSensorData.builder()
        builder.recordTime = timestamp
        builder.valueFloat = [self.magX,self.magY,self.magZ]
        
        return builder.build()
        
    }
    
    func getSensorId() -> Int64 {
        return SENSOR_ID;
    }
    
    
    func getValue() -> [Float] {
        return [self.magX,self.magY,self.magZ];
    }
    
}
