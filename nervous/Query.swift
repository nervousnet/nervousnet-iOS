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

protocol Query {
    
    typealias G : SensorDesc
    
    init(from : UInt64,to:UInt64)
    
    //var  List = Array<SensorUploadSensorData>() // to store the sensor list data
    var List : Array<SensorUploadSensorData> { set get}
    
    func getSensorId() -> UInt64/*{
        //abstract
        var foo : Int64 = 10
        return foo
    }*/
    
    
    func containsReadings() -> Bool
    
    /*{
        if(List.count == 0)  //check for null equivalent
        {return false}
        else
        {return true}
    }*/

    // constructor
        /*{
        
        NervousVM vm =
        //VM.retreive
        if(containsReadings()){
            println("retreived list of size() = /(+getCount())")
        }
        
    }*/
    
    func getCount() -> Int
    /*{
        return List.count
    }*/
    
    func getSensorDescriptorList() -> Array<G>
    /*{
        //abstract
        var foo = Array<G>()
        return foo
    }*/
    
    
    
    
}

