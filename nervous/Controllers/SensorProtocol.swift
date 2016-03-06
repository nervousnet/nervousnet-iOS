//
//  SensorProtocol.swift
//  nervousnet-iOS
//  
//  
//  Copyright (c) 2016 ETHZ . All rights reserved.
//


import Foundation

protocol SensorProtocol {
    
    func requestAuthorization()
    
    func startSensorUpdates()
    
    func stopSensorUpdates()

}

