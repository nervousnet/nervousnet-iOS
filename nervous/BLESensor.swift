//
//  BLESensor.swift
//  nervous
//
//  Created by Sam Sulaimanov on 27/09/14.
//  Copyright (c) 2014 ethz. All rights reserved.
//

import Foundation
import CoreLocation

class BeaconSingleton: NSObject {
    
    var count: Int = 0
    
    class var shareInstance: BeaconSingleton {
        get {
            struct Static {
                static var instance: BeaconSingleton? = nil
                static var token: dispatch_once_t = 0
            }
            dispatch_once(&Static.token, {
                Static.instance = BeaconSingleton()
            })
            return Static.instance!
        }
    }
    
}

class BLESensor {
    
    init(beacons :[AnyObject], region :CLRegion){
        
        
        let nvm :NervousVM = NervousVM()
        var currentTime :NSDate = NSDate()
        
        if(beacons.count > 0) {
 
            BeaconSingleton.shareInstance.count = beacons.count
            
            NSLog("%i", BeaconSingleton.shareInstance.count)
            
            
            let date = NSDate()
            let beaconSensor = SensorUpload.builder()
            
            beaconSensor.huuid = nvm.getHUUID() //phone huuid
            beaconSensor.luuid = nvm.getLUUID() //phone luuid

            beaconSensor.uploadTime = UInt64(currentTime.timeIntervalSince1970*1000)
            beaconSensor.sensorId = 0x000000000000000B
            
            
            //iterate through found beacons
            for (bNum, beacon) in enumerate(beacons) {
                
                let beaconTimestamp = UInt64(currentTime.timeIntervalSince1970*1000)
                
                //add to nested protobuf message
                beaconSensor.sensorValues += [SensorDescBLEBeacon(beacon: beacon as CLBeacon, timestamp: beaconTimestamp).toProtoSensor()]
                
                NSLog("Found beacon. %i", beacon.minor)
                
            }
            
            dispatch_async(dispatch_get_main_queue()) {

                let up = UploadTask(pbSensorupload: beaconSensor.build())
                up.writeToRouter()
            
            }
        
            
        }
    }
     

}