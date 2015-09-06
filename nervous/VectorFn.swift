//
//  VectorFn.swift
//  nervousnet
//
//  Created by Ramapriya Sridharan on 06/09/2015.
//  Copyright (c) 2015 ethz. All rights reserved.
//

import UIKit

class VectorFn: NSObject {
    
    func createSensorDescVectorValue(sensorData : SensorUploadSensorData) -> SensorDescVectorValue{
        var m = SensorDescAccelerometer(timestamp: 0, accX: 0, accY: 0, accZ: 0)
        return m
    }
    
    func createDummyObject()-> SensorDescVectorValue{
        var m = SensorDescAccelerometer(timestamp: 0, accX: 0, accY: 0, accZ: 0)
        return m
    }
    
    var List : Array<SensorUploadSensorData> = []
    
    func getMaxValue()-> SensorDescVectorValue{
    var maxSensDesc = createDummyObject()
    var maxVal = FLT_MIN
    
    for sensorData in List{
    var sensDesc = createSensorDescVectorValue(sensorData)
    var temp = sensDesc.getValue()
    var f :Float = 0
    for var i = 0;i < temp.count;++i{
    f += temp[i]
    }
    if(f > maxVal){
    maxVal = f
    maxSensDesc = sensDesc
    }
    }
    
    return maxSensDesc
    }
   
}
