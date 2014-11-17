//
//  MapDataController.swift
//  nervous
//
//  Created by Sam Sulaimanov on 07/11/14.
//  Copyright (c) 2014 ethz. All rights reserved.
//

import Foundation
import CoreData

class MapDataController {
    //core data
    lazy var managedObjectContext : NSManagedObjectContext? = {
        let appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        if let managedObjectContext = appDelegate.managedObjectContext {
            return managedObjectContext
        }
        else {
            return nil
        }
    }()
    
    
    var nervousDataURL = "http://www.nervous.ethz.ch/app_data/"
    
    
    func getNode(nodeUUID :NSString, level: Int) -> NSManagedObject {
        
        
        var fetchRequest = NSFetchRequest(entityName: "MapNode")
        fetchRequest.resultType = NSFetchRequestResultType.ManagedObjectResultType
        fetchRequest.fetchLimit = 1
        fetchRequest.predicate = NSPredicate(format: "uuid = %@ AND level = %i", nodeUUID, level)
        var fetchResults = managedObjectContext!.executeFetchRequest(fetchRequest, error: nil) as [NSManagedObject]
        
        
        let mapNodeEntity = NSEntityDescription.entityForName("MapNode", inManagedObjectContext: managedObjectContext!)

        if(fetchResults.count == 1){
          NSLog("returning node!")
            
            return fetchResults.last!
        }else{
            NSLog("creating node!")
            //add node
            let newMapNode = MapNode(entity: mapNodeEntity!, insertIntoManagedObjectContext: self.managedObjectContext!)
            newMapNode.level = level
            
            return newMapNode
        }
        
    }
    
    
    func getEdge(sourceUUID :NSString?, targetUUID :NSString?, level:Int) -> NSManagedObject {
        
        let fetchRequest = NSFetchRequest(entityName: "MapEdge")
        
        fetchRequest.fetchLimit = 1
        fetchRequest.resultType = NSFetchRequestResultType.ManagedObjectResultType
        fetchRequest.predicate = NSPredicate(format: "source_uuid=%@ AND target_uuid=%@ AND level = %i", sourceUUID!, targetUUID!, level)
        
        var fetchResults:NSArray = managedObjectContext!.executeFetchRequest(fetchRequest, error: nil) as NSArray!
        
        if(fetchResults.count == 1){
            NSLog("returning edge")
            return fetchResults.lastObject as NSManagedObject
        }else{
            NSLog("adding new edge")
            //add node
            let mapEdgeEntity = NSEntityDescription.entityForName("MapEdge", inManagedObjectContext: managedObjectContext!)
            let newMapEdge = MapEdge(entity: mapEdgeEntity!, insertIntoManagedObjectContext: self.managedObjectContext!)
            
            newMapEdge.id = NSNumber(unsignedInt: arc4random())
            newMapEdge.setValue(level, forKey:"level")
            return newMapEdge
        }
        
    }
    
    
    func hasNode(nodeUUID :String, level: Int) -> Bool {
        
        let fetchRequest = NSFetchRequest(entityName: "MapNode")
        
        fetchRequest.fetchLimit = 1
        fetchRequest.resultType = NSFetchRequestResultType.CountResultType
        fetchRequest.predicate = NSPredicate(format: "uuid=%@ AND level=%i", nodeUUID, level)
        
        let fetchResults = managedObjectContext!.countForFetchRequest(fetchRequest, error: nil)
        
        return fetchResults == 1 ? true : false
    }
    
    
    
    
    func hasEdge(sourceUUID :NSString?, targetUUID :NSString?, level:Int) -> Bool {
 
        let fetchRequest = NSFetchRequest(entityName: "MapEdge")
        
        fetchRequest.includesPendingChanges = true
        
        fetchRequest.fetchLimit = 1
        fetchRequest.resultType = NSFetchRequestResultType.CountResultType
        fetchRequest.predicate = NSPredicate(format: "source_uuid=%@ AND target_uuid=%@  AND level=%i", sourceUUID!, targetUUID!, level)
        
        let fetchResults = managedObjectContext!.countForFetchRequest(fetchRequest, error: nil)
        return fetchResults == 1 ? true : false

    }
    
    
    
    func getMapNodes(level:Int) -> NSArray {
        let fetchRequest = NSFetchRequest(entityName: "MapNode")
        
        fetchRequest.fetchLimit = 100
        fetchRequest.returnsObjectsAsFaults = false
        fetchRequest.includesPropertyValues = true
        fetchRequest.resultType = NSFetchRequestResultType.DictionaryResultType
        fetchRequest.predicate = NSPredicate(format: "level = %i", level)

        let fetchResults = managedObjectContext!.executeFetchRequest(fetchRequest, error: nil) as NSArray!
        
        
        return fetchResults
        
    }
    
    
    
    func deleteMapNode(nodeUUID:NSString, level:Int) -> Void {
        
        self.deleteMapEdge(nodeUUID, level: level)
        
        let fetchRequest = NSFetchRequest(entityName: "MapNode")
        
        fetchRequest.fetchLimit = 1
        fetchRequest.predicate = NSPredicate(format: "uuid = %@ AND level=%i", nodeUUID, level)
        let fetchResults = managedObjectContext!.executeFetchRequest(fetchRequest, error: nil) as NSArray!
        
        for fetchResult in fetchResults {
            managedObjectContext!.deleteObject(fetchResult as NSManagedObject)
        }
        
    }
    
    func deleteMapNodes(level:Int) -> Void {
        NSLog("clearing nodes on level %i",level)

        let fetchRequest = NSFetchRequest(entityName: "MapNode")
        
        fetchRequest.fetchLimit = 1
        fetchRequest.predicate = NSPredicate(format: "level=%i", level)
        let fetchResults = managedObjectContext!.executeFetchRequest(fetchRequest, error: nil) as NSArray!
        
        for fetchResult in fetchResults {
            managedObjectContext!.deleteObject(fetchResult as NSManagedObject)
        }
        
    }
    
    
    func deleteMapEdge(sourceUUID:NSString, level:Int) -> Void {
        let fetchRequest = NSFetchRequest(entityName: "MapEdge")
        
        fetchRequest.fetchLimit = 1
        fetchRequest.predicate = NSPredicate(format: "source_uuid=%@  AND level=%i", sourceUUID, level)
        let fetchResults = managedObjectContext!.executeFetchRequest(fetchRequest, error: nil) as NSArray!
        
        for fetchResult in fetchResults {
            managedObjectContext!.deleteObject(fetchResult as NSManagedObject)
            
        }
        
    }
    
    func deleteMapEdges(level:Int) -> Void {
        
        NSLog("clearing edges on level %i",level)
        
        let fetchRequest = NSFetchRequest(entityName: "MapEdge")
        
        fetchRequest.fetchLimit = 1
        fetchRequest.predicate = NSPredicate(format: "level=%i", level)
        let fetchResults = managedObjectContext!.executeFetchRequest(fetchRequest, error: nil) as NSArray!
        
        for fetchResult in fetchResults {
            managedObjectContext!.deleteObject(fetchResult as NSManagedObject)
            
        }
        
    }
    
    

    
    
    
    func getNodeEdges(nodeUUID :NSString, level:Int) -> NSArray {
        let fetchRequest = NSFetchRequest(entityName: "MapEdge")
        
        fetchRequest.fetchLimit = 200
        fetchRequest.returnsObjectsAsFaults = false
        fetchRequest.includesPropertyValues = true
        fetchRequest.resultType = NSFetchRequestResultType.DictionaryResultType
        fetchRequest.predicate = NSPredicate(format: "(source_uuid=%@) AND (level=%i)", nodeUUID, level)
        let fetchResults = managedObjectContext!.executeFetchRequest(fetchRequest, error: nil) as NSArray!
        var nodeEdgeResults: [NSArray] = []
        
        NSLog("getNodeEdges: queried all edges")
        
        
        for fetchResult in fetchResults{
            
            //get lat/lon of target node
            let nodeRequest = NSFetchRequest(entityName: "MapNode")
            
            nodeRequest.fetchLimit = 100
            nodeRequest.returnsObjectsAsFaults = false
            nodeRequest.includesPropertyValues = true
            nodeRequest.resultType = NSFetchRequestResultType.DictionaryResultType
            nodeRequest.predicate = NSPredicate(format: "(uuid=%@) AND (level=%i)", fetchResult.valueForKey("target_uuid") as NSString, level) //[id, source_uuid, target_uuid, timestamp, weight]
            
            NSLog("getNodeEdges: queried nodes per edge")
            
            var nodeResult:NSArray! = managedObjectContext!.executeFetchRequest(nodeRequest, error: nil) as NSArray!
            
            nodeEdgeResults.append([fetchResult.valueForKey("weight") as Float, nodeResult])
        }
        
        
        
        
        return nodeEdgeResults
        
    }
    
    /*
    func downloadSensorData() -> NSArray {
        NSLog("attempting sensor json download")
        
        
        var sessionManager = AFHTTPRequestOperationManager()
        sessionManager.requestSerializer.cachePolicy = NSURLRequestCachePolicy.ReloadIgnoringLocalAndRemoteCacheData
        
        var mapSensorJSONURL = nervousDataURL + "sensors.json"
        var mapSensors:[NSArray] = []

        sessionManager.GET(mapSensorJSONURL, parameters: nil, success: {
            (task: NSOperation!, responseObject: AnyObject!) in
            
            
            if (responseObject.isKindOfClass(NSArray)) {
                NSLog("downloaded map json. saving to core data.")
                
                
                for row in responseObject as NSArray {
                    if(row.isKindOfClass(NSDictionary)){
                        mapSensors.append(row as NSArray)
                    }
                }
            }
            
            
        }, failure: {
                (task: NSOperation!, responseObject: AnyObject!) in
                NSLog("error downloading sensor metadata: " + responseObject.description)
                
                
        })
        
        return mapSensors

    }
    */
    
        
    
    
    func downloadMapData(level:Int) -> Void {
        
        NSLog("attempting node json download for level %i", level)
        
        //allow the download only every 5 minutes
        let defaults :NSUserDefaults = NSUserDefaults.standardUserDefaults()
        let timeNow = Int(NSDate().timeIntervalSince1970)
        
       // if(defaults.integerForKey("map_timestamp") < (timeNow-300)){
        if(true){
            defaults.setInteger(timeNow, forKey: "map_timestamp")
            var mapJSONURL = ""

       
            if(level == 0){
                mapJSONURL = nervousDataURL + "map-sn.json"
            }else if(level == 1){
                mapJSONURL = nervousDataURL + "map-0.json"
            }else if(level == 2){
                mapJSONURL = nervousDataURL + "map-1.json"
            }else if(level == 3){
                mapJSONURL = nervousDataURL + "map-2.json"
            }
            
            
            var sessionManager = AFHTTPRequestOperationManager()
            sessionManager.requestSerializer.cachePolicy = NSURLRequestCachePolicy.ReloadIgnoringLocalAndRemoteCacheData
            
            
            let mapNodeEntity = NSEntityDescription.entityForName("MapNode", inManagedObjectContext: managedObjectContext!)
            let mapEdgeEntity = NSEntityDescription.entityForName("MapEdge", inManagedObjectContext: managedObjectContext!)
            
            
            sessionManager.GET(mapJSONURL, parameters: nil, success: {
                (task: NSOperation!, responseObject: AnyObject!) in
                
                
                if (responseObject.isKindOfClass(NSArray)) {
                    NSLog("downloaded map json. saving to core data.")

                    
                    for row in responseObject as NSArray {
                        
                        
                        
                        if(row.isKindOfClass(NSDictionary)){
                            
                            let r : NSDictionary? = row as? NSDictionary
                            let eventType = r?.allKeys[0] as? NSString

                            
                            if(eventType == "an") {
                                
                                    let nodeUUID :NSString! = r?.allValues[0].allKeys[0] as? NSString
                                    let nodeProp :NSDictionary = r?.allValues[0].allValues[0] as NSDictionary
                                
                                
                                    //check if UUID exists in db!
                                    if(self.hasNode(nodeUUID, level: level)){
                                        NSLog("node skipped")
                                        continue;
                                    }else{
                                        
                                        if(nodeUUID.description == "" || nodeUUID.integerValue == 0){
                                            continue;
                                        }
                                        
                                        NSLog("node added")

                                    }
                                
                                    //add node event
                                    let newMapNode = MapNode(entity: mapNodeEntity!, insertIntoManagedObjectContext: self.managedObjectContext!)
                                
                                
                                    newMapNode.uuid = nodeUUID
                                    newMapNode.level = level
                                
                                
                                    for (nodeKey,nodeVal) in nodeProp {
                                    
                                        switch nodeKey.description {
                                            case "label":
                                                newMapNode.label = nodeVal.description
                                                break;
                                
                                            case "color":
                                                newMapNode.color = NSNumber(longLong: 0) //TODO
                                                break;
                                                
                                            case "size":
                                                newMapNode.size = NSNumber(longLong: 0) //TODO
                                                break;
                                                
                                            case "lat":
                                                newMapNode.lat = NSNumber(float: nodeVal.floatValue)

                                                break;
                                            
                                            case "lon":
                                                newMapNode.lon = NSNumber(float: nodeVal.floatValue)

                                                break;
                                            
                                            default:
                                                break;
                                        
                                        }
                                    }
                                
                                
                                
                                
                            }else if(eventType == "ae"){
                                
                                let edgeProp :NSDictionary = r?.allValues[0].allValues[0] as NSDictionary
                                var sourceUUID :NSString = ""
                                var targetUUID :NSString = ""
                                var weight :NSNumber?
                                
                                
                                for (edgeKey,edgeVal) in edgeProp {
                                    
                                    switch edgeKey.description {
                                        case "source":
                                            sourceUUID = edgeVal.description
                                            break;
                                            
                                        case "target":
                                            targetUUID = edgeVal.description
                                            break;
                                            
                                        case "weight":
                                            weight = NSNumber(int: edgeVal.intValue)
                                            break;
                                        
                                        default:
                                            break;
                                            
                                    }
                                
                                }
                                
                                //check if UUID exists in db!
                                if(self.hasEdge(sourceUUID, targetUUID: targetUUID, level: level)){
                                    NSLog("edge skipped")
                                    NSLog(sourceUUID)
                                    NSLog(targetUUID)
                                    continue;
                                }else{
                                    NSLog("edge added")
                                    NSLog(sourceUUID)
                                    NSLog(targetUUID)
                                }
                                
                                let newMapEdge = MapEdge(entity: mapEdgeEntity!, insertIntoManagedObjectContext: self.managedObjectContext!)
                                
                                newMapEdge.source_uuid = sourceUUID
                                newMapEdge.target_uuid = targetUUID
                                newMapEdge.weight = weight
                                newMapEdge.level = level
                                
                                
                            }else if(eventType == "cn"){
                                
                                
                                let nodeUUID :NSString = r!.allValues[0].allKeys[0] as NSString
                                let nodeProp :NSDictionary = r?.allValues[0].allValues[0] as NSDictionary
                                
                                NSLog("CN: node %@ on level %i", nodeUUID, level)
                                
                                var editableNode = self.getNode(nodeUUID, level: level)
                            
                                editableNode.setValue(nodeUUID, forKey: "uuid")
                                editableNode.setValue(level, forKey: "level")

                                
                                for (nodeKey,nodeVal) in nodeProp {
                                    
                                    switch nodeKey.description {
                                        case "label":
                                            editableNode.setValue(nodeVal.description, forKey: "label")
                                            break;
                                            
                                        case "color":
                                            //editableNode.setValue(NSNumber(longLong: 0, ) //TODO
                                            break;
                                            
                                        case "size":
                                            //editableNode.size = NSNumber(longLong: 0) //TODO
                                            break;
                                            
                                        case "lat":
                                            editableNode.setValue(NSNumber(float: nodeVal.floatValue), forKey: "lat")
                                            
                                            break;
                                            
                                        case "lon":
                                            editableNode.setValue(NSNumber(float: nodeVal.floatValue), forKey: "lon")
                                            
                                            break;
                                        
                                        
                                        case "level":
                                            editableNode.setValue(NSNumber(int: nodeVal.intValue), forKey: "level")
                                        
                                            break;
                                        
                                        default:
                                            break;
                                        
                                    }
                                }



                            
                                
                                
                            }else if(eventType == "ce"){
                                
                                
                                let edgeProp :NSDictionary = r?.allValues[0].allValues[0] as NSDictionary
                                var sourceUUID :NSString = ""
                                var targetUUID :NSString = ""
                                var weight :NSNumber?
                                var levelE :NSNumber?

                                
                                for (edgeKey,edgeVal) in edgeProp {
                                    
                                    switch edgeKey.description {
                                    case "source":
                                        sourceUUID = edgeVal.description
                                        break;
                                        
                                    case "target":
                                        targetUUID = edgeVal.description
                                        break;
                                        
                                    case "weight":
                                        weight = NSNumber(float: edgeVal.floatValue)
                                        break;
                                        
                                        
                                    case "level":
                                        levelE = level  //TODO, json event should contain level attribute?
                                        break;
                                        
                                    default:
                                        break;
                                        
                                    }
                                    
                                }
                                
                                var editableEdge = self.getEdge(sourceUUID, targetUUID: targetUUID, level: level)
                                editableEdge.setValue(weight, forKey: "weight")
                                editableEdge.setValue(targetUUID, forKey: "target_uuid")
                                editableEdge.setValue(sourceUUID, forKey: "source_uuid")
                                editableEdge.setValue(level, forKey: "level")

                            }else if(eventType == "dn"){
                                
                                
                                let nodeUUID :NSString! = r?.allValues[0].allKeys[0] as? NSString
                                self.deleteMapNode(nodeUUID, level: level)
                            
                            }
                            
                            
                            
                            //write to core data db for every json event
                            self.managedObjectContext!.save(nil)
                            

                            
                            
                            
                        }else{
                            NSLog("no dict")
                        }
                        
                    }
                    
                }else{
                    NSLog("other")

                }
                
                
                

            }, failure: {
                (task: NSOperation!, responseObject: AnyObject!) in
                NSLog("error downloading map metadata: " + responseObject.description)
                

            })
        
        }
    }
    
    
    
}