//
//  SensorDescInformation.swift
//  nervousnet
//
//  Created by Lewin Könemann on 8/23/15.
//  Copyright (c) 2015 ethz. All rights reserved.
//

import Foundation

class SensorDescInformation{

    let SENSOR_ID : UInt64 = 0x0000000000000010

    var sensorIdentifier: Int64 = 0x0000000000000010

    var timestamp: UInt64
    var timeInterval: Int64
    var targetSensor: Int64
    
    required init (sensorData: SensorUploadSensorData){
        self.timestamp = sensorData.recordTime
        self.timeInterval = sensorData.valueInt64[0]
        self.targetSensor = sensorData.valueInt64[1]
    }
}