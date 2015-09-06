//
//  SingleFn.swift
//  nervousnet
//
//  Created by Ramapriya Sridharan on 06/09/2015.
//  Copyright (c) 2015 ethz. All rights reserved.
//

import UIKit

class SingleFn {
    
    
    func createSensorDescSingleValue(sensorData : SensorUploadSensorData) -> SensorDescSingleValue{
        var m = SensorDescBattery(timestamp: UInt64(0),batteryPercent: Float(0),isCharging: false,isUsbCharge: false,isAcCharge: false)
        return m
    }
    
    func createDummyObject()-> SensorDescSingleValue{
        var m = SensorDescBattery(timestamp: UInt64(0),batteryPercent: Float(0),isCharging: false,isUsbCharge: false,isAcCharge: false)
        return m
    }
    
    var List : Array<SensorUploadSensorData> = []
    
    func getMaxValue()-> SensorDescSingleValue{
        var maxSensDesc = createDummyObject()
        var maxVal = FLT_MIN
        
        for sensorData in List{
            var sensDesc = createSensorDescSingleValue(sensorData)
            if(sensDesc.getValue() > maxVal){
                maxVal = sensDesc.getValue()
                maxSensDesc = sensDesc
            }
        }
        
        return maxSensDesc
    }
   
}
