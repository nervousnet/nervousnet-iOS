//
//  MapDataController.swift
//  nervous
//
//  Created by Sam Sulaimanov on 07/11/14.
//  Copyright (c) 2014 ethz. All rights reserved.
//

import Foundation

class MapDataController {
    
    func downloadMapData() -> Void {
        
        
        
        let mapJSONURL = "http://www.nervous.ethz.ch/app_data/map-sn.json"
        
        var sessionManager = AFHTTPRequestOperationManager()
        
        sessionManager.requestSerializer.cachePolicy = NSURLRequestCachePolicy.ReloadIgnoringLocalAndRemoteCacheData
        
        
        sessionManager.GET(mapJSONURL, parameters: nil, success: {
            
                (task: NSOperation!, responseObject: AnyObject!) in NSLog("downloaded map-sn.json" + responseObject.description)
            
        }, failure: {
                
                (task: NSOperation!, responseObject: AnyObject!) in NSLog("error downloading map-sn.json" + responseObject.description)

        })
        
    }
    
    
    
}


