//
//  SensorStore.swift
//  nervousnet-iOS
//  
//  Copyright (c) 2016 ETHZ . All rights reserved.
//


import Foundation
import CoreLocation
import CoreMotion

///
/// Provides functionality to access Sensor data (historical or live).
/// Inits sensor objects. Also uploads sensor data to the server.
///
class SensorStore : NSObject, BeaconControllerDelegate {
    
    let Gyroscope : GyroscopeController
    let Battery : BatteryController
    let Magnetometer : MagnetometerController
    //let Proximity : ProximityController
    let Accelerometer : AccelerometerController
    let Beacon : BeaconController
    let BLE : BLEController
    let GPS : GPSController
    
    var timerAcc = NSTimer()
    
    let VM = VMController.sharedInstance
    
    
    //initialise all sensor controllers
    override init(){
        self.Gyroscope = GyroscopeController.sharedInstance
        self.Gyroscope.initializeUpdate(self.VM.defaults.doubleForKey("freqGyr"))
        
        self.Battery = BatteryController.sharedInstance
        self.Battery.initializeUpdate()
        
        self.Magnetometer = MagnetometerController.sharedInstance
        self.Magnetometer.initializeUpdate(self.VM.defaults.doubleForKey("freqMag"))
        
        //self.Proximity = ProximityController()
        
        self.Accelerometer = AccelerometerController.sharedInstance
        self.Accelerometer.initializeUpdate(self.VM.defaults.doubleForKey("freqAcc"))
        
        
        self.BLE = BLEController.sharedInstance
        
        self.GPS = GPSController.sharedInstance
        self.GPS.initializeUpdate(self.VM.defaults.doubleForKey("freqGPS"))

				// BEACONS
				self.Beacon = BeaconController.sharedInstance

				super.init()
    }
    
    
    // MARK: delegate callbacks
    func controller(controller: BeaconController, didRangeBeacons: [CLBeacon]) {
        //here are new beacons: didRangeBeacons, do something with them
        
//        print("\(didRangeBeacons.count) beacons found!");

//			if didRangeBeacons.count > 0 {
//				let b = didRangeBeacons.first
//				print(b.debugDescription)
//			}
    }
    
    func controller() {
        self.Accelerometer.requestAuthorization()
        self.Accelerometer.startSensorUpdates()
        
        self.Gyroscope.requestAuthorization()
        self.Gyroscope.startSensorUpdates()
        
        self.Magnetometer.requestAuthorization()
        self.Magnetometer.startSensorUpdates()
        
        self.Battery.requestAuthorization()
        self.Battery.startSensorUpdates()
        
        self.GPS.requestAuthorization()
        self.GPS.startSensorUpdates()

				self.Beacon.delegate = self;
				self.Beacon.requestAuthorization()
//				self.Beacon.startSensorUpdates()

    }
}
