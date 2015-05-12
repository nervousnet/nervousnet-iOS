//
//  SensorDescAccelerometer.swift
//  nervousnet
//
//  Created by Ramapriya Sridharan on 12/05/2015.
//  Copyright (c) 2015 ethz. All rights reserved.
//

import UIKit

class SensorDescAccelerometer: SensorDesc {/*
    
    public static final long SENSOR_ID = 0x0000000000000000L
    
    private final float accX
    private final float accY
    private final float accZ
    
    public SensorDescAccelerometerNew(final long timestamp, final float accX, final float accY, final float accZ) {
    super(timestamp);
    this.accX = accX;
    this.accY = accY;
    this.accZ = accZ;
    }
    
    public SensorDescAccelerometerNew(SensorData sensorData) {
    super(sensorData);
    this.accX = sensorData.getValueFloat(0);
    this.accY = sensorData.getValueFloat(1);
    this.accZ = sensorData.getValueFloat(2);
    }
    
    public float getAccX() {
    return accX;
    }
    
    public float getAccY() {
    return accY;
    }
    
    public float getAccZ() {
    return accZ;
    }
    
    @Override
    public SensorData toProtoSensor() {
    SensorData.Builder sdb = SensorData.newBuilder();
    sdb.setRecordTime(getTimestamp());
    sdb.addValueFloat(getAccX());
    sdb.addValueFloat(getAccY());
    sdb.addValueFloat(getAccZ());
    return sdb.build();
    }
    
    @Override
    public long getSensorId() {
    return SENSOR_ID;
    }
    
    @Override
    public ArrayList<Float> getValue() {
    // TODO Auto-generated method stub
    ArrayList<Float> arrayList = new ArrayList<Float>();
    arrayList.add(accX);
    arrayList.add(accY);
    arrayList.add(accZ);
    return arrayList; // 3 values returned
    }
*/
   
}
