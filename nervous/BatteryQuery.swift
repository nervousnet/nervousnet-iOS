//
//  BatteryQuery.swift
//  nervousnet
//
//  Created by Ramapriya Sridharan on 04/09/2015.
//  Copyright (c) 2015 ethz. All rights reserved.
//

import UIKit

class BatteryQuery : SingleFn {
    
    
    //var List : Array<SensorUploadSensorData>
    
    // have to pass object of type G along with timestamps
    init(from timestamp_from :UInt64,to timestamp_to : UInt64){
        
        let vm = NervousVM.sharedInstance
        //dummy object
        super.init()
        //dummy retreive
        //self.List = vm.retrieve(0x0000000000000001, fromTimeStamp: 0, toTimeStamp: 0)
        //only needed if using some functions from this class
        //actual retreive
        self.List = vm.retrieve(0x0000000000000001, fromTimeStamp: timestamp_from, toTimeStamp: timestamp_to)
       
        /*if(containsReading()){
            NSLog("this is the variable value: %d",getCount())
        }*/
    }
    
    func getSensorID() -> UInt64{
        return 0x0000000000000001
    }

    func getCount() -> Int
    {
        return List.count
    }
    
    func containsReading() -> Bool{
        
        if(List.count == 0)  //check for null equivalent
        {return false}
        else
        {return true}
    }
    
    override func createSensorDescSingleValue(sensorData : SensorUploadSensorData) -> SensorDescSingleValue{
        var m = SensorDescBattery( sensorData : sensorData )
        return m
    }
    
    func getSensorDescriptorList() -> Array<SensorDescSingleValue>{
        var descList = Array<SensorDescSingleValue>()
        for sensorData in List {
            descList.append(createSensorDescSingleValue(sensorData))
            
        }
        return descList
    }
    
    override func createDummyObject()-> SensorDescSingleValue{
        var m = SensorDescBattery(timestamp: UInt64(0),batteryPercent: Float(0),isCharging: false,isUsbCharge: false,isAcCharge: false)
        return m
    }
    
    /*func getMaxValue()-> SensorDescBattery{
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
    }*/
  
   
}
