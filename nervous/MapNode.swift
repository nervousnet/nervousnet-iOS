//
//  MapNode.swift
//  nervous
//
//  Created by Sam Sulaimanov on 10/11/14.
//  Copyright (c) 2014 ethz. All rights reserved.
//

import Foundation
import UIKit
import CoreData

@objc(MapNode)
class MapNode: NSManagedObject {
    
    @NSManaged var uuid: NSNumber
    @NSManaged var color: NSNumber
    @NSManaged var label: String
    @NSManaged var size: NSNumber
    @NSManaged var timestamp: NSNumber
    @NSManaged var lat: NSNumber
    @NSManaged var lon: NSNumber

    
    
}