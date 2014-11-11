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
    
    func downloadMapData() -> Void {
        
        
        
        let mapJSONURL = "http://www.nervous.ethz.ch/app_data/map-sn.json"
        var sessionManager = AFHTTPRequestOperationManager()
        sessionManager.requestSerializer.cachePolicy = NSURLRequestCachePolicy.ReloadIgnoringLocalAndRemoteCacheData
        
        //core data
        let appDelegate:AppDelegate = (UIApplication.sharedApplication().delegate as AppDelegate)
        let context:NSManagedObjectContext = appDelegate.managedObjectContext!
        
        let mapNodeEntity = NSEntityDescription.entityForName("MapNode", inManagedObjectContext: context)
        let mapEdgeEntity = NSEntityDescription.entityForName("MapEdge", inManagedObjectContext: context)
        
        
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
                            
                                //add node event
                                let newMapNode = MapNode(entity: mapNodeEntity!, insertIntoManagedObjectContext: context)
                                
                                let nodeUUID :NSString! = r?.allValues[0].allKeys[0] as? NSString
                                let nodeProp :NSDictionary = r?.allValues[0].allValues[0] as NSDictionary
                            
                            
                                //TODO: check if UUID exists in db!
                                newMapNode.uuid = NSNumber(longLong: Int64(nodeUUID.integerValue))
                            
                            
                            
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
                            
                                //write to core data db
                                context.save(nil)
                            
                            
                        }
                        
                        
                        
                        
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


