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
    
    

    
    @IBAction func btnSettingsAction(sender: AnyObject) {
        
        var svc = self.storyboard?.instantiateViewControllerWithIdentifier("SensorViewController") as SensorViewController
        
        svc.modalTransitionStyle = UIModalTransitionStyle.CoverVertical
        svc.modalPresentationStyle = UIModalPresentationStyle.Custom
        svc.view.backgroundColor = UIColor.whiteColor().colorWithAlphaComponent(0.6)
                

        
        self.presentViewController(svc, animated: true, completion: nil)
        
    }
    
    
    
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
        
        self.view.addSubview(cchMapView)
        
        
        cchMapView.addAnnotation(RMPointAnnotation(mapView: cchMapView, coordinate: cchMapView.centerCoordinate, andTitle: "Na nu na na"))

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}