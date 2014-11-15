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

class MapViewController: UIViewController, RMMapViewDelegate, FilterButtonDelegate {
    
    var mapView :RMMapView!  //make this accessible so everyone can edit the map
    
    @IBOutlet var mapUIView :UIView!
    @IBOutlet weak var refreshMapButton: UIButton!
    
    @IBAction func btnSettingsAction(sender: AnyObject) {
    
        
        var svc = self.storyboard?.instantiateViewControllerWithIdentifier("SensorViewController") as SensorViewController
        
        svc.modalTransitionStyle = UIModalTransitionStyle.CoverVertical
        svc.modalPresentationStyle = UIModalPresentationStyle.Custom
        svc.view.backgroundColor = UIColor.whiteColor().colorWithAlphaComponent(0.6)
        
        self.presentViewController(svc, animated: true, completion: nil)
        
    }
    
    func filterButtonPressed(buttonTag: Int) {
        
        NSLog(buttonTag.description)
        
        var mapLayer :NSString = "blank"
        
        if(buttonTag == 2){
            mapLayer = "cch0"
        }else if(buttonTag == 3){
            mapLayer = "cch1"
        }else if(buttonTag == 4){
            mapLayer = "cch2"
        }else if(buttonTag == 5){
            mapLayer = "blank"
        }
        
        if(buttonTag != 1){
            mapView.tileSource = RMMBTilesSource(tileSetResource: mapLayer)
            mapView.removeAllAnnotations()
        }
    }
    
    @IBAction func mapReset(sender: AnyObject) {
        
        //redownload the map (if stale) and center on me
        var bc :String? = String(BeaconSingleton.shareInstance.count)
        
        var mapData = MapDataController()
        mapData.downloadMapData()
        
        
        /*
        var circle :RMCircleAnnotation = RMCircleAnnotation(mapView: mapView, centerCoordinate: mapView.centerCoordinate, radiusInMeters: 10)
        circle.lineColor = UIColor.redColor()
        circle.fillColor = UIColor.orangeColor().colorWithAlphaComponent(0.3)
        circle.clusteringEnabled = true
        
        mapView.addAnnotation(circle)
        */
        
        
        var mapNodes = mapData.getMapNodes()
        var markers : [RMAnnotation] = []
        
        
        for mapNode in mapNodes{
            
            //NSLog(mapNode.allValues[2].description)
            
            //RMPointAnnotation(mapView: mapView, coordinate: CLLocationCoordinate2DMake(mapNode.allValues[3] as CLLocationDegrees, mapNode.allValues[2] as CLLocationDegrees), andTitle: mapNode.allValues[1].description)
            
           var marker = RMAnnotation(mapView: mapView, coordinate: CLLocationCoordinate2DMake(mapNode.allValues[3] as CLLocationDegrees, mapNode.allValues[2] as CLLocationDegrees), andTitle: mapNode.allValues[1].description)
            
            
            if(mapNode.allValues.count == 7){
                marker.userInfo = mapData.getNodeEdges(mapNode.allValues[6].description) //place connected edges here
            }else{
                marker.userInfo = NSArray()
            }
            
           markers.append(marker)
            
        }
        
        mapView.removeAllAnnotations()
        mapView.addAnnotations(markers)

        self.mapEdgeLayer()
       
    }
    
    
    func mapEdgeLayer() -> Void {

        for marker in mapView.annotations {
            
            var m : RMAnnotation = marker as RMAnnotation
            
            if(m.title == "Phone"){
                
            
                var edge : RMShape = RMShape(view: self.mapView)
                edge.lineWidth = 3.0
                edge.lineColor = UIColor.orangeColor()
                
                edge.moveToCoordinate(m.coordinate)
                
                            
                for connectedNode in m.userInfo as NSArray {
                    
                    var connectedNodeProp: NSArray = connectedNode[1] as NSArray
                    
                    if(connectedNodeProp.count > 0){
                        
                        
                        var connectedNodeLat = connectedNodeProp.objectAtIndex(0).allValues[2].doubleValue
                        var connectedNodeLon = connectedNodeProp.objectAtIndex(0).allValues[3].doubleValue
                        
                

                        edge.addLineToCoordinate(CLLocationCoordinate2DMake(connectedNodeLon, connectedNodeLat))


                        var anl : RMAnnotation = RMAnnotation(mapView: self.mapView, coordinate: CLLocationCoordinate2DMake(connectedNodeLon, connectedNodeLat), andTitle: "edge")
                        
                        anl.layer = edge
                        
                        
                        self.mapView.addAnnotation(anl)
                        
                    }
                    
                    
                }
                

            }
            
        }
    }
    

    
    func mapView(mapView: RMMapView!, layerForAnnotation annotation: RMAnnotation!) -> RMMapLayer! {

        
        var phoneMarker: RMMarker = RMMarker(UIImage: UIImage(named: "first"))
        phoneMarker.canShowCallout = true
    
        
        var beaconMarker: RMMarker = RMMarker(UIImage: UIImage(named: "second"))
        beaconMarker.canShowCallout = true

        NSLog("modding map")

        if(annotation.title == "Phone"){
             return phoneMarker
        }else if(annotation.title == "edge"){
             NSLog("edgy")
             return annotation.layer
        }else{
             return beaconMarker
        }
        
        
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        refreshMapButton.layer.cornerRadius = 25
        
        let cchTileSource :RMMBTilesSource = RMMBTilesSource(tileSetResource: "blank") //default tile source
        
        
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
        
        var cchMapBGView :UIView! = UIView()
        cchMapBGView.backgroundColor = UIColor(red: 0.878, green: 0.878, blue: 0.878, alpha: 1)
        
        cchMapView.backgroundView = cchMapBGView
        
        cchMapView.bouncingEnabled = true
        
        mapView = cchMapView
        mapView.delegate = self

        self.mapUIView.addSubview(mapView)
        
        
        
        
        let filterButton = FilterButtonView(frame: CGRectZero)
        filterButton.delegate = self
        
        self.mapUIView.addSubview(filterButton)
        
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}