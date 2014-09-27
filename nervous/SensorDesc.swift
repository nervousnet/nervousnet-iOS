//
//  SensorDesc.swift
//  nervous
//
//  Created by Sam Sulaimanov on 27/09/14.
//  Copyright (c) 2014 ethz. All rights reserved.
//

import Foundation


protocol SensorDesc {
    
    var timestamp :UInt64 {get}
    
  //  func getSensorIdentifier -> Int64
    func toProtoSensor() -> SensorUploadSensorData
    
}
