//
//  TestSingleFn.swift
//  nervousnet
//
//  Created by Ramapriya Sridharan on 06/09/2015.
//  Copyright (c) 2015 ethz. All rights reserved.
//

import UIKit

class TestSingleFn: NSObject {
   
    
    func createDummyObject()-> SensorDescSingleValue{
        var m = SensorDescSingleValue(sensorData)
        return m
    }
    
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
