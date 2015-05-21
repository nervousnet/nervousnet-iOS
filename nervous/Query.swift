//
//  Query.swift
//  nervousnet
//
//  Created by Ramapriya Sridharan on 20/05/2015.
//  Copyright (c) 2015 ethz. All rights reserved.
//

import UIKit

//
// Created by Ramapriya Sridharan on 19/05/15.
// Copyright (c) 2015 ethz. All rights reserved.
//

import Foundation

class Query <G : SensorDesc>{
    
    var  List = Array<SensorUploadSensorData>() // to store the sensor list data
    
    func getSensorId() -> Int64{
        //abstract
        var foo : Int64 = 10
        return foo
    }
    
    
    func containsReadings() -> Bool{
        if(List.count == 0)  //check for null equivalent
        {return false}
        else
        {return true}
    }

    
    init(timestamp_from : UInt64, timestamp_to : UInt64,file : String){
        
        //create instance of VM
        //VM.retreive
        if(containsReadings()){
            println("retreived list of size() = /(+getCount())")
        }
        
    }
    
    func getCount() -> Int{
        return List.count
    }
    
    func getSensorDescriptorList() -> Array<G>{
        //abstract
        var foo = Array<G>()
        return foo
    }
    
    
    
    
}

