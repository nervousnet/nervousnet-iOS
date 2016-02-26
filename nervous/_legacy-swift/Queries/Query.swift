//
// Created by Ramapriya Sridharan on 19/05/15.
// Copyright (c) 2015 ethz. All rights reserved.
//

import Foundation

class Query <G : SensorDesc>{

    var  List = Array<SensorUploadSensorData>() // to store the sensor list data

    func getSensorId() -> Int64{
        //abstract
    }

    init(timestamp_from : UInt64, timestamp_to : Uint64,file : NSFileHandle){
        //create instance of VM
        //VM.retreive
        if(containsReadings()){
            println("retreived list of size() = "+getCount())
        }

    }

    func containsReadings() -> boolean{
        if(List == nil)  //check for null equivalent
        {return false}
        else
        {return true}
    }

    func getCount() -> Int{
        return List.count
    }

    func getSensorDescriptorList() -> Array<G>{
        //abstract
    }




}
