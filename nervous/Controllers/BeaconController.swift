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

		var beaconRegions = [CLBeaconRegion]()
		var beaconData = [AnyObject]()
	
	var _tmpBeacons = [String:AnyObject]()
	
    override init() {
        self.locationManager = CLLocationManager()
    }
    
		class var sharedInstance: BeaconController {
			return _sharedInstance
		}
	
    func requestAuthorization() {
        locationManager.requestAlwaysAuthorization()
    }
	
	func getdata() -> [AnyObject] {
		var xx = [AnyObject]()
		_tmpBeacons.keys.forEach({ (key:String) in
			xx.append(_tmpBeacons[key]!)
		})
		return xx
	}
	
	func addBeaconData(data:[[String:String]]) {
		beaconRegions = []
		data.forEach { (kv:[String:String]) in
			let br = CLBeaconRegion(proximityUUID: NSUUID(UUIDString: kv["uuid"]!)!, identifier: kv["identity"]!)
			beaconRegions.append(br)
		}
	}
		
    func startSensorUpdates() {
        locationManager.delegate = self
			for beaconRegion in beaconRegions {
				locationManager.startMonitoringForRegion(beaconRegion)
				locationManager.startRangingBeaconsInRegion(beaconRegion)
			}
    }
	
    func stopSensorUpdates() {
			for beaconRegion in beaconRegions {
				locationManager.stopMonitoringForRegion(beaconRegion)
				locationManager.stopRangingBeaconsInRegion(beaconRegion)
			}
			beaconData = []
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
				let bb = ["uuid": beacon.proximityUUID.UUIDString, "major": String(beacon.major), "minor": String(beacon.minor), "proximity": String(beacon.proximity.rawValue), "accuracy": String(format:"%f", beacon.accuracy)]
				_tmpBeacons[bb["uuid"]!] = bb
				return bb
				})
			
			
        //send new beacons to delegates
        if let delegate = self.delegate {
            delegate.controller(self, didRangeBeacons: beacons)
        }
   
    }
}