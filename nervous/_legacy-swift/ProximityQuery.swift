////
////  ProximityQuery.swift
////  nervousnet
////
////  Created by Ramapriya Sridharan on 06/09/2015.
////  Copyright (c) 2015 ethz. All rights reserved.
////
//
//import UIKit
//
//class ProximityQuery: SingleFn {
//    
//    //override var List : Array<SensorUploadSensorData>
//    
//    // have to pass object of type G along with timestamps
//    init(from timestamp_from :UInt64,to timestamp_to : UInt64){
//        
//        let vm = NervousVM.sharedInstance
//        //dummy object
//        super.init()
//        //dummy retreive
//        //self.List = vm.retrieve(0x0000000000000006, fromTimeStamp: 0, toTimeStamp: 0)
//        //actual retreive
//        self.List = vm.retrieve(0x0000000000000006, fromTimeStamp: timestamp_from, toTimeStamp: timestamp_to)
//        
//        /*if(containsReading()){
//            NSLog("this is the variable value: %d")
//        }*/
//    }
//    
//    func getSensorID() -> UInt64{
//        return 0x0000000000000006
//    }
//    
//    func getCount() -> Int
//    {
//        return List.count
//    }
//    
//    func containsReading() -> Bool{
//        
//        if(List.count == 0)  //check for null equivalent
//        {return false}
//        else
//        {return true}
//    }
//    
//    
//    /*func createSensorDescSingleValue(sensorData : SensorUploadSensorData) -> SensorDescSingleValue{
//        var m : SensorDescBattery
//        return m
//    }
//    
//    func createDummyObject()-> SensorDescSingleValue{
//        var m : SensorDescBattery
//        return m
//    }
//    
//    var List : Array<SensorUploadSensorData> = []*/
//    
//    override func createSensorDescSingleValue(sensorData : SensorUploadSensorData) -> SensorDescSingleValue{
//        let m = SensorDescProximity( sensorData : sensorData )
//        return m
//    }
//    
//    override func getSensorDescriptorList() -> Array<SensorDescSingleValue>{
//        var descList = Array<SensorDescSingleValue>()
//        for sensorData in List {
//            descList.append(createSensorDescSingleValue(sensorData))
//            
//        }
//        return descList
//    }
//    
//    override func createDummyObject()-> SensorDescSingleValue{
//        let m = SensorDescProximity(timestamp: 0,proximity: 0,isClose: true)
//        return m
//    }
//    
//    /*func getMaxValue()-> SensorDescProximity{
//        var maxSensDesc = createDummyObject()
//        var maxVal = FLT_MIN
//        
//        for sensorData in List{
//            var sensDesc = createSensorDescSingleValue(sensorData)
//            if(sensDesc.getValue() > maxVal){
//                maxVal = sensDesc.getValue()
//                maxSensDesc = sensDesc
//            }
//        }
//        
//        return maxSensDesc
//    }*/
//   
//}
