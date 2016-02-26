////
////  Query.swift
////  nervousnet
////
////  Created by Ramapriya Sridharan on 20/05/2015.
////  Copyright (c) 2015 ethz. All rights reserved.
////
//
//import UIKit
//
////
//// Created by Ramapriya Sridharan on 19/05/15.
//// Copyright (c) 2015 ethz. All rights reserved.
////
//
//import Foundation
//
//protocol Query {
//    
//    typealias G : SensorDesc // G can be any sensor descriptor
//    
//    init(from : UInt64,to:UInt64) // init gives data b/w timestamps from and to
//    
//    var List : Array<SensorUploadSensorData> { set get} // List contains data from VM
//    
//    func getSensorId() -> UInt64 // id of sensor
//    
//    
//    func containsReadings() -> Bool // if it has more than 1 reading
//    
//   
//    
//    func getCount() -> Int // length of list
//  
//    
//    func getSensorDescriptorList() -> Array<G> // get the List in for the sensordesc
//  
//    
//    
//    
//    
//}
//
