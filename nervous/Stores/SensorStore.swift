//
//  SensorStore.swift
//  nervousnet-iOS
//  
//  Copyright (c) 2016 ETHZ . All rights reserved.
//


import Foundation
import CoreLocation

///
/// Provides functionality to access Sensor data (historical or live).
/// Inits sensor objects. Also uploads sensor data to the server.
///
class SensorStore : BeaconControllerDelegate {
    
    let Gyroscope = GyroscopeController();
    let Battery = BatteryController();
    let Magnetometer = MagnetometerController();
    let Proximity = ProximityController();
    let Accelerometer = AccelerometerController();
    let Beacon = BeaconController();
    
    
    //initialise all sensor controllers
    init(){
        
        //attach delegates
        Beacon.delegate = self;
        
        
        Beacon.requestAuthorization()
        Beacon.startSensorUpdates()
        
    }
    
    
    
    // MARK: delegate callbacks
    func controller(controller: BeaconController, didRangeBeacons: [CLBeacon]) {
        //here are new beacons: didRangeBeacons, do something with them
        
        print("%d beacons found!", didRangeBeacons.count);
    }
}

