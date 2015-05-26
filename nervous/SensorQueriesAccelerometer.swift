//
//  SensorQueriesAccelerometer.swift
//  nervousnet
//
//  Created by Ramapriya Sridharan on 25/05/2015.
//  Copyright (c) 2015 ethz. All rights reserved.
//

import UIKit

class SensorQueriesAccelerometer<T : SensorDescAccelerometer> : QueryNumVectorValue<SensorDescAccelerometer>{
    
    var T : SensorDescAccelerometer
    init(f :UInt64,t :UInt64){
        var m = SensorDescAccelerometer(timestamp: 0, accX: 0, accY: 0, accZ: 0)
        T = m
        super.init(from: f, to: t)
        
    }
    
    override func getSensorID() -> UInt64 {
        return T.getSensorId()
    }
    
    override func createDummyObject()->SensorDescAccelerometer{
        var m = SensorDescAccelerometer(timestamp: 0, accX: 0, accY: 0, accZ: 0)
        return m
    }
    
    override func createSensorDescVectorValue(sensorData: SensorUploadSensorData) -> SensorDescAccelerometer{
        var m = SensorDescAccelerometer( sensorData : sensorData )
        return m
    }
    
    
    
    
    
    
}
