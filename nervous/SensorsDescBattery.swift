//
//  SensorsDescBattery.swift
//  nervousnet
//
//  Created by Ramapriya Sridharan on 12/05/2015.
//  Copyright (c) 2015 ethz. All rights reserved.
//

import UIKit

class SensorsDescBattery: SensorDesc {
    
    let SENSOR_ID:Int64 = 0x0000000000000001;
    
    var batteryPercent :Float;
    var isCharging : boolean;
    var isUsbCharge :boolean;
    var isAcCharge : boolean;
    
    init(timestamp: Float, batteryPercent:boolean,
        isCharging:boolean, isUsbCharge:boolean,
        isAcCharge : boolean) {
    self.batteryPercent = batteryPercent;
    self.isCharging = isCharging;
    self.isUsbCharge = isUsbCharge;
    self.isAcCharge = isAcCharge;
    }
    
    init(SensorData sensorData) {//check this
    self.batteryPercent = sensorData.getValueFloat(0);
    self.isCharging = sensorData.getValueBool(0);
    self.isUsbCharge = sensorData.getValueBool(1);
    self.isAcCharge = sensorData.getValueBool(2);
    }
    
    func getBatteryPercent() -> float {
    return batteryPercent;
    }
    
    func isCharging() -> boolean {//equ in ios
    return isCharging;
    }
    
    func isUsbCharge() -> boolean {
    return isUsbCharge;
    }
    
    func isAcCharge() ->boolean {
    return isAcCharge;
    }
    
    func toProtoSensor() -> SensorUploadSensorData {//check this
    let sdb = SensorUploadSensorData.newBuilder();
    sdb.recordTime = self.timestamp
    sdb.float(getBatteryPercent());
    sdb.bool(isCharging());
    sdb.bool(isUsbCharge());
    sdb.bool(isAcCharge());
    return sdb.build();
    }
    
    
    func getSensorId() -> float {
    return SENSOR_ID;
    }
    
    
    func getValue() -> float {
    return batteryPercent;
    }
   
}
