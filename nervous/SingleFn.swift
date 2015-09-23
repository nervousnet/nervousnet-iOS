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
    
    //IMPORTANT
    func getSensorDescriptorList() -> Array<SensorDescSingleValue>{
        var descList = Array<SensorDescSingleValue>()
        for sensorData in List {
            descList.append(createSensorDescSingleValue(sensorData))
            
        }
        return descList
    }
    
    func getMinValue()-> SensorDescSingleValue{
        var minSensDesc = createDummyObject()
        var minVal = FLT_MAX
        
        for sensorData in List{
            var sensDesc = createSensorDescSingleValue(sensorData)
            if(sensDesc.getValue() < minVal){
                minVal = sensDesc.getValue()
                minSensDesc = sensDesc
            }
        }
        
        return minSensDesc
    }
    
    
    //get first index of array
    func getAverage()-> Array<Float>{
        var temp = Array<Float>()
        var totalSum : Float = 0
        for sensorData in List{
            var sensDesc = createSensorDescSingleValue(sensorData)
            totalSum += sensDesc.getValue()
            
        }
        var average = totalSum/Float(List.count)
        temp.append(average)
        return temp
    }
    
    
    //get first index of array
    func sd()-> Array<Float>{
        var sd = Array<Float>()
        var temp = variance()
        
        var t = temp[0]
        NSLog("this is the var value: %f %",t)
        t = sqrt(t)
        NSLog("this is the sd value: %f %",t)
        sd.append(t)
        NSLog("this is the sd value: %f %",sd[0])
        return sd
    }
    
    
    //get first index of array
    func variance()-> Array<Float>{
        var sd = Array<Float>()
        var av = getAverage()
        
        var average = av[0]
        NSLog("this is the average value: %f %",av[0])
        var temp : Float = 0
        for sensorData in List{
            var sensDesc = createSensorDescSingleValue(sensorData)
            temp += (average - sensDesc.getValue())*(average - sensDesc.getValue())
        }
        NSLog("this is the temp value: %f %",temp)
        temp = temp/Float(List.count)
        NSLog("this is the temp normalized value: %f %",temp)
        sd.append(temp)
        NSLog("this is the var value: %f %",sd[0])
        return sd
    }
    
    // already constrain by time
    // now constrain by range
    func getTimeRange(desc_list : Array<SensorDescSingleValue>, s : Array<Float>, e : Array<Float>)-> Array<SensorDescSingleValue>{
        var start = s[0]
        var end = e[0]
        
        var answer = Array<SensorDescSingleValue>()
        
        for var i=0; i<desc_list.count ; ++i{
            
            let sensDesc = desc_list[i]
            if(sensDesc.getValue() <= end && sensDesc.getValue() >= start)
            {
                answer.append(sensDesc)
            }
        }
        
        return answer
        
    }
    
    
    
    
    
    
    
    
   
}
