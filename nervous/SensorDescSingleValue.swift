//
//  SensorDescSingleValue.swift
//  nervousnet
//
//  Created by Siddhartha on 15/05/15.
//  Copyright (c) 2015 ethz. All rights reserved.
//

import Foundation

protocol SensorDescSingleValue : SensorDesc {
    
    func getValue() -> Float
}