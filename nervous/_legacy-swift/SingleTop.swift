//
//  SingleTop.swift
//  nervousnet
//
//  Created by Ramapriya Sridharan on 06/09/2015.
//  Copyright (c) 2015 ethz. All rights reserved.
//

import UIKit
protocol SingleTop{
    
    func createSensorDescSingleValue(sensorData : SensorUploadSensorData) -> SensorDescSingleValue
   
    func createDummyObject()-> SensorDescSingleValue
    
    var List : Array<SensorUploadSensorData> {get}
    
}
