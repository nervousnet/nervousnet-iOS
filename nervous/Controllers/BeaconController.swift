//
//  BeaconController.swift
//  nervousnet-iOS
//
//  Created by Sam Sulaimanov on 03 Mar 2016.
//  Copyright (c) 2016 ETHZ . All rights reserved.
//


import Foundation
import CoreLocation

class BeaconController : NSObject, SensorProtocol{
    
    let locationManager : CLLocationManager
    let beaconRegion : CLBeaconRegion
    let beaconUUIDString = NSUUID(UUIDString: "3C77C2A5-5D39-420F-97FD-E7735CC7F317")!
    let beaconIdentifier = "ch.ethz.nervous"
    let beaconMajor:CLBeaconMajorValue = 33091
    
    override init() {
        self.locationManager = CLLocationManager()
        self.beaconRegion = CLBeaconRegion(proximityUUID: beaconUUIDString, identifier: beaconIdentifier)

    }
    
    
    func requestAuthorisation() {
        locationManager.requestAlwaysAuthorization()
    }
    
    
    func startSensorUpdates() {
        locationManager.delegate = self
        locationManager.startMonitoringForRegion(beaconRegion)
        locationManager.startRangingBeaconsInRegion(beaconRegion)
    }
    
    
    func stopSensorUpdates() {
        locationManager.stopMonitoringForRegion(beaconRegion)
        locationManager.stopRangingBeaconsInRegion(beaconRegion)
    }
    
}

extension BeaconController: CLLocationManagerDelegate {
    
    func locationManager(manager: CLLocationManager, monitoringDidFailForRegion region: CLRegion?, withError error: NSError) {
        print("Failed monitoring region: \(error.description)")
    }
    
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        print("Location manager failed: \(error.description)")
    }
    
    func locationManager(manager: CLLocationManager, didRangeBeacons beacons: [CLBeacon], inRegion region: CLBeaconRegion) {
        
        for (_, b) in beacons.enumerate() {
            print("Found beacon with minor %i", b.minor)
        }
    }
}