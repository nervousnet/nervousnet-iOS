//
//  SensorDesc.swift
//  nervous
//
//  Created by Sam Sulaimanov on 27/09/14.
//  Copyright (c) 2014 ethz. All rights reserved.
//

import Foundation

class SensorDesc{
    
    
    
    var timestamp: UInt64
    
    func getSensorId() -> Int64{
        
        var foo :Int64 = 0
        return foo
    
    }
    
    init(sensorData: SensorUploadSensorData)
    {
        //self.timestamp = sensorData.getRecordTime() //define function in VM
        self.timestamp = 0;
    }
    
    init(timestamp : UInt64)
    {
        self.timestamp = timestamp
    }
    
    func toProtoSensor() -> SensorUploadSensorData
    {
        var sens :SensorUploadSensorData = 0
        return sens
    }
}