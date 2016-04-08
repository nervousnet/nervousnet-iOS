//
//  BLEController.swift
//  nervousnet-iOS
//
//  Created by Sam on 03 Mar 2016.
//  Copyright (c) 2016 ETHZ . All rights reserved.
//


import Foundation
import UIKit
import CoreBluetooth

private let _BLE = BLEController()
class BLEController : NSObject, SensorProtocol,  CBCentralManagerDelegate, CBPeripheralDelegate{
    
    private var auth: Int = 0
    private let VM = VMController.sharedInstance
    
    var timestamp: UInt64 = 0
    var activeCentralManager: CBCentralManager?
    var activePeripheral: CBPeripheral?
    var blepacketCommaCounter = 0
    var blepacket = ""
    
    override init() {
        super.init()
        print("init ble")
        
        activeCentralManager = CBCentralManager(delegate: self, queue: nil)
        activeCentralManager?.delegate = self
        activePeripheral?.delegate = self
        
    }
    
    class var sharedInstance: BLEController {
        return _BLE
    }
    
    func requestAuthorization() {
        print("requesting authorization for BLE")
        
        let val1 = self.VM.defaults.boolForKey("kill")         //objectForKey("kill") as! Bool
        let val2 = self.VM.defaults.boolForKey("switchBLE")    //objectForKey("switchMag") as! Bool
        
        if !val1 && val2  {
            self.auth = 1
        }
        else {
            self.auth = 0
        }
    }
    
    func initializeUpdate(freq: Double) {
        
    }
    
    // requestAuthorization must be before this is function is called
    func startSensorUpdates() {
        
        if self.auth == 0 {
            return
        }
        
    }
    
    func stopSensorUpdates() {
        
        self.auth = 0
    }
    
    
    func centralManagerDidUpdateState(central: CBCentralManager) {
        
        let c = central
        if c.state == CBCentralManagerState.PoweredOn {
            print("Bluetooth ON")
            central.scanForPeripheralsWithServices(nil, options: nil)
            
        }else {
            print("Bluetooth switched off or not initialized")
        }
        
    }
    
    
    func centralManager(central: CBCentralManager, didDiscoverPeripheral peripheral: CBPeripheral, advertisementData: [String : AnyObject], RSSI: NSNumber) {
        
        print(RSSI)
        
        if(peripheral.name == "mars"){
            activePeripheral = peripheral
            print("connecting to mars...")

            // Stop looking for more peripherals.
            activeCentralManager!.stopScan()
            // Connect to this peripheral.
            activeCentralManager!.connectPeripheral(activePeripheral!, options: nil)
            
        }
        
    }
    
    
    func centralManager(central: CBCentralManager, didConnectPeripheral peripheral: CBPeripheral) {
        print("connected to mars...")

        activePeripheral?.delegate = self
        activePeripheral?.discoverServices(nil)

        
    }
    
    func peripheral(peripheral: CBPeripheral, didDiscoverServices error: NSError?) {
        //peripheral.setNotifyValue(true, forCharacteristic: nil)

        print("found services")
        for service:CBService in (activePeripheral?.services)! {
            
            activePeripheral?.discoverCharacteristics(nil, forService: service)
        
        }
        
        
    }
    
    
    func peripheral(peripheral: CBPeripheral, didDiscoverCharacteristicsForService service: CBService, error: NSError?) {
        
        for char in service.characteristics! {
            activePeripheral?.setNotifyValue(true, forCharacteristic: char)
        }
        
    }
    
    func peripheral(peripheral: CBPeripheral, didUpdateValueForCharacteristic characteristic: CBCharacteristic, error: NSError?) {

        if let characteristicValue = characteristic.value{
            let datastring = NSString(data: characteristicValue, encoding: NSUTF8StringEncoding)
            
            let commacount = (datastring!.componentsSeparatedByString(",").count - 1)
            
            self.blepacketCommaCounter += commacount
            self.blepacket += datastring as! String
            //we want to see 19 commas
        }
        
        if(self.blepacketCommaCounter == 19){
            print("full packet received")
            print(self.blepacket)
            self.blepacket = ""
            self.blepacketCommaCounter = 0
        }
    }

}
