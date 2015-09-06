//
//  GyroscopeQuery.swift
//  nervousnet
//
//  Created by Ramapriya Sridharan on 06/09/2015.
//  Copyright (c) 2015 ethz. All rights reserved.
//

import UIKit

//
//  GyroscopeQuery.swift
//  nervousnet
//
//  Created by Ramapriya Sridharan on 06/09/2015.
//  Copyright (c) 2015 ethz. All rights reserved.
//

import UIKit

class GyroscopeQuery: NSObject {
    
    var List : Array<SensorUploadSensorData>
    
    // have to pass object of type G along with timestamps
    init(from timestamp_from :UInt64,to timestamp_to : UInt64){
        
        let vm = NervousVM.sharedInstance
        //dummy object
        
        //dummy retreive
        //self.List = vm.retrieve(0x0000000000000002, fromTimeStamp: 0, toTimeStamp: 0)
        //actual retreive
        self.List = vm.retrieve(0x0000000000000002, fromTimeStamp: timestamp_from, toTimeStamp: timestamp_to)
        
        /*if(containsReading()){
        NSLog("this is the variable value: %d")
        }*/
    }
    
    func getSensorID() -> UInt64{
        return 0x0000000000000002
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
    
    func createSensorDescVectorValue(sensorData : SensorUploadSensorData) -> SensorDescGyroscope{
        var m = SensorDescGyroscope( sensorData : sensorData )
        return m
    }
    
    func getSensorDescriptorList() -> Array<SensorDescGyroscope>{
        var descList = Array<SensorDescGyroscope>()
        for sensorData in List {
            descList.append(createSensorDescVectorValue(sensorData))
            
        }
        return descList
    }
    
    func createDummyObject()-> SensorDescGyroscope{
        var m = SensorDescGyroscope(timestamp: 0,gyrX: 0,gyrY: 0,gyrZ: 0)
        return m
    }
    
    func getMaxValue()-> SensorDescGyroscope{
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

