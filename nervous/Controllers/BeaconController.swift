//
//  BeaconController.swift
//  nervousnet-iOS
//
//  Created by Sam Sulaimanov on 03 Mar 2016.
//  Copyright (c) 2016 ETHZ . All rights reserved.
//


import Foundation
import CoreLocation

protocol BeaconControllerDelegate {
    func controller(controller: BeaconController, didRangeBeacons: [CLBeacon])
}


let _sharedInstance = BeaconController()

class BeaconController : NSObject, SensorProtocol{
    
    var delegate: BeaconControllerDelegate?
    let locationManager : CLLocationManager
    let beaconRegion : CLBeaconRegion
//		let beaconUUIDString = NSUUID(UUIDString: "3C77C2A5-5D39-420F-97FD-E7735CC7F317")!
		let beaconUUIDString = NSUUID(UUIDString: "B9407F30-F5F8-466E-AFF9-25556B57FE6D")!
    let beaconIdentifier = "ch.ethz.nervous"
    let beaconMajor:CLBeaconMajorValue = 33091
	
		var beaconData = [AnyObject]()
	
    override init() {
        self.locationManager = CLLocationManager()
        self.beaconRegion = CLBeaconRegion(proximityUUID: beaconUUIDString, identifier: beaconIdentifier)
    }
    
		class var sharedInstance: BeaconController {
			return _sharedInstance
		}
	
    func requestAuthorization() {
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
			
			self.beaconData = beacons.map({ (beacon) -> [String:String] in
					return ["uuid": beacon.proximityUUID.UUIDString, "major": String(beacon.major), "minor": String(beacon.minor), "proximity": String(beacon.proximity.rawValue), "accuracy": String(format:"%f", beacon.accuracy)]
				})
			
        //send new beacons to delegates
        if let delegate = self.delegate {
            delegate.controller(self, didRangeBeacons: beacons)
        }
   
    }
}