//
//  SensorProtocol.swift
//  nervousnet-iOS
//  
//  
//  Copyright (c) 2016 ETHZ . All rights reserved.
//


import Foundation
import CoreMotion

protocol SensorProtocol {
    
    func requestAuthorization()
    
    func startSensorUpdates()
        
    func stopSensorUpdates()
}

