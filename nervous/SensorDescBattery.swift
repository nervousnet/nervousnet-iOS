//
//  SensorsDescBattery.swift
//  nervousnet
//
//  Created by Ramapriya Sridharan on 12/05/2015.
//  Modified by Siddhartha on 15/05/2015
//  Copyright (c) 2015 ethz. All rights reserved.
//

import UIKit

class SensorDescBattery: SensorDescSingleValue {
    
    let SENSOR_ID :Int64 = 0x0000000000000001
    
    var sensorIdentifier: Int64 = 0x0000000000000001
    
    var timestamp: UInt64
    var batteryPercent: Float
    var isCharging: Bool
    var isUsbCharge: Bool
    var isAcCharge: Bool
    
    init(timestamp: UInt64, batteryPercent: Float, isCharging: Bool, isUsbCharge: Bool, isAcCharge: Bool) {
        
        self.timestamp = timestamp
        self.batteryPercent = batteryPercent;
        self.isCharging = isCharging;
        self.isUsbCharge = isUsbCharge;
        self.isAcCharge = isAcCharge;
    }
    
    /*
        override keyword always needed here
    */
    required init(sensorData: SensorUploadSensorData) {
        
        self.timestamp = sensorData.recordTime
        self.batteryPercent = sensorData.valueFloat[0]
        self.isCharging = sensorData.valueBool[0]
        self.isUsbCharge = sensorData.valueBool[1]
        self.isAcCharge = sensorData.valueBool[2]
    }
    
    init (battery: UIDevice, timestamp: UInt64) {
        self.timestamp = timestamp
        self.batteryPercent = battery.batteryLevel
        if UIDeviceBatteryState.Charging.rawValue == 1{
            self.isCharging = true
            self.isUsbCharge = false
            self.isAcCharge = true
        }
        else {
            self.isCharging = false
            self.isUsbCharge = false
            self.isAcCharge = false
        }
    }
    
    /*
        Override keyword needed
    */
    func toProtoSensor() -> SensorUploadSensorData {

        let builder = SensorUploadSensorData.builder()
        
        /*
            Always set the record time! also it's important to put the values in the
            array in the same exact order as in Android
        */
        builder.recordTime = timestamp
        builder.valueFloat = [self.batteryPercent]
        builder.valueBool = [self.isCharging, self.isUsbCharge, self.isAcCharge]
        
        return builder.build()
    }
    
    func getValue() -> Float {
        return self.batteryPercent;
    }
}
