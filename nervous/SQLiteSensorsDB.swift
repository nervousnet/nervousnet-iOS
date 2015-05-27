//
//  DB.swift
//  nervousnet
//
//  Created by Simone on 09/04/15.
//  Copyright (c) 2015 ethz. All rights reserved.
//

import Foundation

private let _SensorsDBSharedInstance = SQLiteSensorsDB()

private let _createTableStatement = "CREATE TABLE Sensors (timestamp, sensor_id, content BLOB)"
private let _dropTableStatement = "DROP TABLE Sensors"
private let _retrieveSensorsQuery = "SELECT content FROM Sensors WHERE timestamp >= ? AND timestamp <= ? AND sensor_id = ?"
private let _insertSensorStatement = "INSERT INTO Sensors VALUES (?,?,?)"

/*
    USAGE example:
    let db = SQLiteSensorsDB.sharedInstance
    let sens = SensorDescBLEBeacon (
        timestamp: 1234321, rssi: 1, mac: 2, advertisementMSB: 3, advertisementLSB: 4,
        bleuuidMSB: 5, bleuuidLSB: 6, major: 7, minor: 8, txpower: 9)

    db.store(111, timestamp: 1234321, sensorData: sens.toProtoSensor())

    let messages = db.retrieve(111, fromTimestamp: 1000000, toTimestamp: 2000000)
*/

class SQLiteSensorsDB: SensorsDB {
    
    init() {
        //NSLog("Creating table Sensors")
        SQLiteDB.sharedInstance().execute(_createTableStatement)
        //NSLog("Table Sensors successfully created (or already existent)")
    }
    
    class var sharedInstance: SQLiteSensorsDB {
        return _SensorsDBSharedInstance
    }
    
    func retrieve(sensorId: UInt64, fromTimestamp: UInt64, toTimestamp: UInt64) -> [SensorUploadSensorData] {
        
        let result = SQLiteDB.sharedInstance().query(_retrieveSensorsQuery,
            parameters:[
                NSNumber(unsignedLongLong: fromTimestamp),
                NSNumber(unsignedLongLong: toTimestamp),
                NSNumber(unsignedLongLong: sensorId)
            ]
        )
        
        //NSLog("Query returned \(result.count) rows")
    
        var messages : [SensorUploadSensorData] = []
        
        for row in result {

            let column : SQLColumn! = row["content"]
            let data : NSData! = column.asData()
            
            let count = data.length / sizeof(Byte)
            
            var bytes = [Byte](count: count, repeatedValue: 0)
            
            data.getBytes(&bytes, length:count * sizeof(Byte))
            
            let message : SensorUploadSensorData! = SensorUploadSensorData.parseFromData(bytes)
            
            messages += [message]
        }
        
        return messages
    }
    
    func store(sensorId: UInt64, timestamp: UInt64, sensorData: SensorUploadSensorData) {
        
        let data = sensorData.data()
        
        //NSLog("Storing sensor \(sensorId) at timestamp \(timestamp) in DB")
        
        let result = SQLiteDB.sharedInstance().execute(_insertSensorStatement,
            parameters:[
                NSNumber(unsignedLongLong:timestamp),
                NSNumber(unsignedLongLong:sensorId),
                NSData(bytes: data, length: data.count)
            ])
        
        //NSLog("Insert query executed with result code \(result)")
    }
}