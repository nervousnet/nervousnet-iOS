//
//  nervousnetWebapp+CoreDataProperties.swift
//  nervousnet
//
//  Created by Lewin Könemann on 03/03/16.
//  Copyright © 2016 ethz. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension nervousnetWebapp {

    @NSManaged var token: NSNumber?
    @NSManaged var accAccess: NSNumber?
    @NSManaged var batAccess: NSNumber?
    @NSManaged var magAccess: NSNumber?
    @NSManaged var gyrAccess: NSNumber?
    @NSManaged var proxAccess: NSNumber?

}
