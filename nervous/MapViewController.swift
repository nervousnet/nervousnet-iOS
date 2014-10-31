//
//  MapViewController.swift
//  nervous
//
//  Created by Sam Sulaimanov on 20/09/14.
//  Copyright (c) 2014 ethz. All rights reserved.
//
import Foundation
import UIKit
import SpriteKit

class MapViewController: UIViewController {
    
    var mapView :RMMapView!  //make this accessible so everyone can edit the map
    
    
    @IBAction func btnSettingsAction(sender: AnyObject) {
    
        
        var svc = self.storyboard?.instantiateViewControllerWithIdentifier("SensorViewController") as SensorViewController
        
        svc.modalTransitionStyle = UIModalTransitionStyle.CoverVertical
        svc.modalPresentationStyle = UIModalPresentationStyle.Custom
        svc.view.backgroundColor = UIColor.whiteColor().colorWithAlphaComponent(0.6)
        
        self.presentViewController(svc, animated: true, completion: nil)
        
    }
    
    
    @IBAction func mapReset(sender: AnyObject) {
        
        //redownload the map (if stale) and center on me
        var bc :String? = String(BeaconSingleton.shareInstance.count)
        mapView.addAnnotation(RMPointAnnotation(mapView: mapView, coordinate: mapView.centerCoordinate, andTitle: bc))
        
        
        /*
        var circle :RMCircleAnnotation = RMCircleAnnotation(mapView: mapView, centerCoordinate: mapView.centerCoordinate, radiusInMeters: 10)
        circle.lineColor = UIColor.redColor()
        circle.fillColor = UIColor.orangeColor().colorWithAlphaComponent(0.3)
        circle.clusteringEnabled = true
        
        mapView.addAnnotation(circle)
        */
        
    }
    
    
    
    
    
    /*
    func mapLoad(manager:AFHTTPRequestOperationManager, layer:Int){
        
        
        
        var mapLayerJSONURLs:[[String]] = [[""], [""], [""], [""]]
        
        manager.GET(mapLayerJSONURLs[layer], parameters: nil, success: {
                operation, responseObject in
                
                if let quote = responseObject?.objectForKey("query")?.objectForKey("results")?.objectForKey("quote") as? NSDictionary {
                    
                    let symbol = quote.objectForKey("Symbol") as? String
                    let lastTradePriceOnly = quote.objectForKey("LastTradePriceOnly") as? String
                    
                    println("results: \(symbol) @ \(lastTradePriceOnly)")
                } else {
                    println("no quote")
                }
            },
            failure: {
                operation, error in
                
                println("Error: " + error.localizedDescription)
        })
    }
    */
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        
        
        
        
        let cchTileSource :RMMBTilesSource = RMMBTilesSource(tileSetResource: "CCH31c3")
        let cchMapView :RMMapView = RMMapView(frame: self.view.bounds, andTilesource: cchTileSource)
        

        cchMapView.centerCoordinate = CLLocationCoordinate2DMake(9.986 as CLLocationDegrees, 53.5624 as CLLocationDegrees)
        
        cchMapView.userInteractionEnabled = true
        // default zoom
        cchMapView.zoom = 16
        // hard code minimal zoom. Try to run in without it to see what happens.
        cchMapView.minZoom = 16
        // hide MapBox logo
        cchMapView.showLogoBug = false
        cchMapView.hideAttribution = true
        cchMapView.autoresizingMask = UIViewAutoresizing.FlexibleHeight | UIViewAutoresizing.FlexibleWidth
        cchMapView.adjustTilesForRetinaDisplay = false
        
        
        mapView = cchMapView

        self.view.addSubview(mapView)
        
        
        let filterButton = FilterButtonView(frame: CGRectZero)
        self.view.addSubview(filterButton)
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}