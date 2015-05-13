//
//  SensorDescGyroscope.swift
//  nervousnet
//
//  Created by spadmin on 13/05/15.
//  Copyright (c) 2015 ethz. All rights reserved.
//

import Foundation
import CoreLocation

class SensorDescgyroscope : SensorDesc {
    
    let SENSOR_ID :Int64 = 0x000000000000000B
    
    var timestamp :UInt64
    var X :Int32
    var Y :Int32
    var Z :Int32
    
    init(timestamp :UInt64, X :Int32, Y :Int32, Z :Int32){
        
        
        self.X = X
        self.Y = Z
        self.Z = Z
        self.timestamp = timestamp
    }

    
    func toProtoSensor() -> SensorUploadSensorData {
        
    }
    
}