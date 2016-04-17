//
//  GPSController.swift
//  nervousnet
//
//  Created by spadmin on 09/04/16.
//  Copyright © 2016 ethz. All rights reserved.
//

import Foundation
import CoreLocation
import CoreData
import UIKit

private let _GPS = GPSController()
class GPSController : NSObject, SensorProtocol, CLLocationManagerDelegate {
    
    
    private var auth: Int = 0
    
    private var manager: CLLocationManager
    
    private let VM = VMController.sharedInstance
    
    internal var timestamp: UInt64 = 0
    internal var lat: Double = 0.0
    internal var long: Double = 0.0
    
    
    internal var freq: Double = 0.0
    private var timerGPS = NSTimer()
    
    override init() {
        self.manager = CLLocationManager()
        super.init()
        self.manager.delegate = self
        self.manager.requestWhenInUseAuthorization()
        self.manager.requestAlwaysAuthorization()
    }
    
    class var sharedInstance: GPSController {
        return _GPS
    }
    
    
    func requestAuthorization() {
        print("requesting authorization for gps")
        
        let val1 = self.VM.defaults.boolForKey("kill")   //objectForKey("kill") as! Bool
        let val2 = self.VM.defaults.boolForKey("switchGPS")    //objectForKey("switchAcc") as! Bool
        
        if !val1 && val2  {
            if CLLocationManager.locationServicesEnabled() {
                self.auth = 1
            }
        }
        else {
            self.auth = 0
        }
    }
    
    func initializeUpdate(freq: Double) {
        
        self.freq = freq
        self.manager.desiredAccuracy = kCLLocationAccuracyBest
        self.manager.startUpdatingLocation()
    }
    
    // requestAuthorization must be before this is function is called
    func startSensorUpdates() {
        
        if self.auth == 0 {
            return
        }
        
        self.timerGPS = NSTimer.scheduledTimerWithTimeInterval(self.freq, target: self, selector: #selector(GPSController.newLocation), userInfo: nil, repeats: true)
        
    }
    
    func newLocation() {

        self.manager.startUpdatingLocation()
        
        let authorizationStatus = CLLocationManager.authorizationStatus()
        switch authorizationStatus {
            case .Authorized:
                print("authorized")
                if let locValue:CLLocationCoordinate2D = self.manager.location!.coordinate {
                    self.lat = locValue.latitude
                    self.long = locValue.longitude
                    self.manager.stopUpdatingLocation()
                } else {
                }
            case .AuthorizedWhenInUse:
                print("authorized when in use")
                if let locValue:CLLocationCoordinate2D = self.manager.location!.coordinate {
                    self.lat = locValue.latitude
                    self.long = locValue.longitude
                    self.manager.stopUpdatingLocation()
                } else {
                }
            case .Denied:
                print("denied")
            case .NotDetermined:
                print("not determined")
            case .Restricted:
                print("restricted")
        }
        
        let currentTimeA :NSDate = NSDate()
        self.timestamp = UInt64(currentTimeA.timeIntervalSince1970*1000)
    }
    
    
    
    func stopSensorUpdates() {
        self.manager.stopUpdatingLocation()
        self.timerGPS.invalidate()
        self.auth = 0
    }
}