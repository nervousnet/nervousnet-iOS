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
    
    
    func hasNode(nodeUUID :String) -> Bool {
        
        let fetchRequest = NSFetchRequest(entityName: "MapNode")
        
        fetchRequest.fetchLimit = 1
        fetchRequest.resultType = NSFetchRequestResultType.CountResultType
        fetchRequest.predicate = NSPredicate(format: "uuid=%@", nodeUUID)
        
        let fetchResults = managedObjectContext!.countForFetchRequest(fetchRequest, error: nil)
        
        return fetchResults == 1 ? true : false
    }
    
    
    func hasEdge(sourceUUID :NSString?, targetUUID :NSString?) -> Bool {
 
        let fetchRequest = NSFetchRequest(entityName: "MapEdge")
        
        fetchRequest.fetchLimit = 1
        fetchRequest.resultType = NSFetchRequestResultType.CountResultType
        fetchRequest.predicate = NSPredicate(format: "source_uuid=%@ AND target_uuid=%@", sourceUUID!, targetUUID!)
        
        let fetchResults = managedObjectContext!.countForFetchRequest(fetchRequest, error: nil)
        return fetchResults == 1 ? true : false

    }
    
    
    
    func getMapNodes() -> NSArray {
        let fetchRequest = NSFetchRequest(entityName: "MapNode")
        
        fetchRequest.fetchLimit = 100
        fetchRequest.returnsObjectsAsFaults = false
        fetchRequest.includesPropertyValues = true
        fetchRequest.resultType = NSFetchRequestResultType.DictionaryResultType
        
        let fetchResults = managedObjectContext!.executeFetchRequest(fetchRequest, error: nil) as NSArray!
        
        return fetchResults
        
    }
    
    
    func getNodeEdges(nodeUUID :String) -> NSArray {
        let fetchRequest = NSFetchRequest(entityName: "MapEdge")
        
        fetchRequest.fetchLimit = 200
        fetchRequest.returnsObjectsAsFaults = false
        fetchRequest.includesPropertyValues = true
        fetchRequest.resultType = NSFetchRequestResultType.DictionaryResultType
        fetchRequest.predicate = NSPredicate(format: "source_uuid = %@", nodeUUID)
        let fetchResults = managedObjectContext!.executeFetchRequest(fetchRequest, error: nil) as NSArray!
        var nodeEdgeResults: [NSArray] = []
        
        
        for fetchResult in fetchResults{
            
            //get lat/lon of target node
            let nodeRequest = NSFetchRequest(entityName: "MapNode")
            
            nodeRequest.fetchLimit = 10
            nodeRequest.returnsObjectsAsFaults = false
            nodeRequest.includesPropertyValues = true
            nodeRequest.resultType = NSFetchRequestResultType.DictionaryResultType
            nodeRequest.predicate = NSPredicate(format: "uuid=%@", fetchResult.allValues[2].description)
            
            var nodeResult:NSArray = managedObjectContext!.executeFetchRequest(nodeRequest, error: nil) as NSArray!
            
            nodeEdgeResults.append([fetchResult, nodeResult])
        }
        
        
        
        
        return nodeEdgeResults
        
    }
    
    
    
    func downloadMapData() -> Void {
        
        //allow the download only every 5 minutes
        let defaults :NSUserDefaults = NSUserDefaults.standardUserDefaults()
        let timeNow = Int(NSDate().timeIntervalSince1970)
        
        if(defaults.integerForKey("map_timestamp") < (timeNow-300)){
            
            defaults.setInteger(timeNow, forKey: "map_timestamp")
            
       
            let mapJSONURL = "http://www.nervous.ethz.ch/app_data/map-sn.json"
            var sessionManager = AFHTTPRequestOperationManager()
            sessionManager.requestSerializer.cachePolicy = NSURLRequestCachePolicy.ReloadIgnoringLocalAndRemoteCacheData
            
            let mapNodeEntity = NSEntityDescription.entityForName("MapNode", inManagedObjectContext: managedObjectContext!)
            let mapEdgeEntity = NSEntityDescription.entityForName("MapEdge", inManagedObjectContext: managedObjectContext!)
            
         
            
            
            sessionManager.GET(mapJSONURL, parameters: nil, success: {
                (task: NSOperation!, responseObject: AnyObject!) in
                NSLog("downloaded map metadata. saving to core data. ")
                
                
                if (responseObject.isKindOfClass(NSArray)) {
                    NSLog("array")

                    
                    for row in responseObject as NSArray {
                        
                        
                        if(row.isKindOfClass(NSDictionary)){
                            
                            let r : NSDictionary? = row as? NSDictionary
                            let eventType = r?.allKeys[0] as? NSString

                            
                            if(eventType == "an") {
                                    let nodeUUID :NSString! = r?.allValues[0].allKeys[0] as? NSString
                                    let nodeProp :NSDictionary = r?.allValues[0].allValues[0] as NSDictionary
                                
                                
                                    //check if UUID exists in db!
                                    if(self.hasNode(nodeUUID)){
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
                                if(self.hasEdge(sourceUUID, targetUUID: targetUUID)){
                                    NSLog("edge skipped")
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