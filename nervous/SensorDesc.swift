//
//  SensorDesc.swift
//  nervous
//
//  Created by Sam Sulaimanov on 27/09/14.
//  Copyright (c) 2014 ethz. All rights reserved.
//

import Foundation


protocol SensorDesc {
    
   // var timestamp :UInt64 {get}
    
  //  func getSensorIdentifier -> Int64
    //func toProtoSensor() -> SensorUploadSensorData
    
    var timestamp :UInt64
    
    init(timestamp :UInt64)
    {
    self.timestamp = timestamp;
    }
    
    init(SensorData : sensorData)
    {
    self.timestamp = sensorData.getRecordTime();
    }
    
    func getDataColumns() -> String
    
    
    func getSensorId() -> UInt64;
    
    func getTimestamp()-> UInt64 {
    return timestamp;
    }
    
    
    func toProtoSensor() -> SensorDesc{};
    
}
