////
////  MapViewController.swift
////  nervous
////
////  Created by Sam Sulaimanov on 20/09/14.
////  Copyright (c) 2014 ethz. All rights reserved.
////
//import Foundation
//import UIKit
//import SpriteKit
//import CoreBluetooth
//import CoreLocation
//
//class MapViewController: UIViewController, RMMapViewDelegate, FilterButtonDelegate, CBPeripheralManagerDelegate, CLLocationManagerDelegate {
//    
//    let defaults :NSUserDefaults = NSUserDefaults.standardUserDefaults()
//
//    var ownBeaconRegion :CLBeaconRegion!
//    var ownBeaconPManager :CBPeripheralManager!
//    var ownBeaconData :NSDictionary!
//    
//    var mapView :RMMapView!  //make this accessible so everyone can edit the map
//    
//    var levelSelected:Int! = 0
//    
//    @IBOutlet var mapUIView :UIView!
//    @IBOutlet weak var refreshMapButton: UIButton!
//    
//    @IBAction func btnSettingsAction(sender: AnyObject) {
//    
//        
//        var svc = self.storyboard?.instantiateViewControllerWithIdentifier("SensorViewController") as SensorViewController
//        
//        svc.modalTransitionStyle = UIModalTransitionStyle.CoverVertical
//        svc.modalPresentationStyle = UIModalPresentationStyle.Custom
//        svc.view.backgroundColor = UIColor.whiteColor().colorWithAlphaComponent(0.6)
//        
//        self.presentViewController(svc, animated: true, completion: nil)
//        
//    }
//    
//    
//    
//    func filterButtonPressed(buttonTag: Int) {
//        
//        NSLog(buttonTag.description)
//        
//        var mapLayer :NSString = "blank"
//        
//        if(buttonTag == 2){
//            mapLayer = "cch0"
//            levelSelected = 1
//            mapView.zoom = 17.5
//
//        }else if(buttonTag == 3){
//            mapLayer = "cch1"
//            levelSelected = 2
//            mapView.zoom = 17.5
//
//        }else if(buttonTag == 4){
//            mapLayer = "cch2"
//            levelSelected = 3
//            mapView.zoom = 17.5
//
//        }else if(buttonTag == 5){
//            mapLayer = "blank"
//            levelSelected = 0
//            mapView.zoom = 16
//
//
//        }
//        
//        if(buttonTag != 1){
//            mapView.tileSource = RMMBTilesSource(tileSetResource: mapLayer)
//            self.mapReset(self)
//        }
//    }
//    
//    @IBAction func mapReset(sender: AnyObject) {
//        
//        
//        //redownload the map (if stale) and center on me
//        var nvm = NervousVM()
//        var mapData = MapDataController()
//        
//        
//        //clear database
//        mapData.deleteMapNodes(levelSelected)
//        mapData.deleteMapEdges(levelSelected)
//        
//        mapData.downloadMapData(levelSelected)
//        
//        
//        var mapNodes = mapData.getMapNodes(levelSelected)
//        var markers : [RMAnnotation] = []
//                    
//        for mapNode in mapNodes{
//                
//            var marker = RMAnnotation(mapView: mapView, coordinate: CLLocationCoordinate2DMake(mapNode.objectForKey("lat") as CLLocationDegrees, mapNode.objectForKey("lon") as CLLocationDegrees), andTitle: mapNode.objectForKey("label") as String)
//            
//            
//            if(mapNode.allValues.count == 8){
//                NSLog("adding edges to map marker %@", mapNode.valueForKey("uuid") as NSString)
//                marker.userInfo = mapData.getNodeEdges(mapNode.valueForKey("uuid") as NSString, level: levelSelected) //place connected edges here
//                
//                if(mapNode.valueForKey("uuid") as NSString == defaults.valueForKey("uuidString") as NSString){
//                    marker.title = "You"
//
//                    mapView.setZoom(19, atCoordinate: marker.coordinate, animated: true)
//                }
//                NSLog("got nodes edges")
//                
//                
//            }else{
//                marker.userInfo = NSArray()
//            }
//            
//            markers.append(marker)
//            
//        }
//        
//        if(mapView.annotations.count > 0){
//            mapView.removeAllAnnotations()
//        }
//        
//        mapView.addAnnotations(markers)
//        
//        
//        self.mapPOILayer()
//        self.mapSensorLayer()
//
//        self.mapEdgeLayer()
//    }
//    
//    
//    
//    func mapEdgeLayer() -> Void {
//        NSLog("attempting to draw edges")
//        
//        for marker in mapView.annotations {
//            
//            var m : RMAnnotation = marker as RMAnnotation
//            
//            if(m.title?.rangeOfString("Phone") != nil || m.title? == "You"){
//                NSLog("connecting %f,%f with %i beacon(s)", m.coordinate.latitude, m.coordinate.longitude, m.userInfo.count)
//                
//                var anls : [RMAnnotation] = []
//                
//                for connectedNode in m.userInfo as NSArray {
//                    
//                    NSLog("iterate through connected beacons")
//                    
//                    var connectedNodeProp: NSArray = connectedNode[1] as NSArray
//                    var weight : Float = connectedNode[0] as Float
//                    
//                    
//                    
//                    if(connectedNodeProp.count > 0){
//                        
//                        var connectedNodeLat = connectedNodeProp.objectAtIndex(0).objectForKey("lat") as Double
//                        var connectedNodeLon = connectedNodeProp.objectAtIndex(0).objectForKey("lon") as Double
//
//                        
//                        var edge :RMShape = RMShape(view: self.mapView)
//                        edge.lineWidth = weight*2
//                        edge.lineColor = UIColor(red:0.761, green:0.761, blue:0.761, alpha: 1)
//                        
//                        edge.moveToCoordinate(m.coordinate)
//                        edge.drawsAsynchronously = true
//
//                        edge.addLineToCoordinate(CLLocationCoordinate2DMake(connectedNodeLat, connectedNodeLon))
//                        NSLog("drawing edge at %f,%f -- %f,%f with weight %f", m.coordinate.latitude, m.coordinate.longitude, connectedNodeLat, connectedNodeLon, weight)
//
//
//                        var anl : RMAnnotation = RMAnnotation(mapView: self.mapView, coordinate: CLLocationCoordinate2DMake(connectedNodeLat, connectedNodeLon), andTitle: "edge")
//                        
//                        
//                        anl.layer = edge
//                        
//                        
//                        var phoneRadius:RMCircleAnnotation = RMCircleAnnotation(mapView: mapView, centerCoordinate: m.coordinate, radiusInMeters: 10.0)
//                        phoneRadius.lineWidth = 2
//                        phoneRadius.lineColor = UIColor.orangeColor()
//                        phoneRadius.fillColor = UIColor.orangeColor().colorWithAlphaComponent(0.4)
//                        
//                       // anls.append(phoneRadius)
//                        anls.append(anl)
//                        
//                    }
//                    
//                    
//                }
//                
//                self.mapView.addAnnotations(anls)
//
//
//
//            }
//            
//        }
//    }
//    
//    
//    func mapSensorLayer() -> Void {
//        var mapData = MapDataController()
//        mapData.downloadSensorData()
//        
//        /*for marker in mapView.annotations {
//            
//            if(marker.title == "Beacon"){
//                
//                if(m.userInfo == 4){
//                    //sensor beacon!
//                    
//                    default.
//                    //change label!
//                    m.title = "Sensor:flowerpower:1:2:4:5"
//                }
//            
//            }
//        }*/
//        
//        NSLog("drawing maps sensor layer")
//        if(defaults.dictionaryForKey("mapSensor_level"+levelSelected.description) != nil){
//            NSLog("found data for sensor layer")
//            var sensorNodes = enumerate(defaults.dictionaryForKey("mapSensor_level"+levelSelected.description)!)
//            
//            for (i,sensorNode) in sensorNodes {
//                
//                for sN in sensorNode.1 as NSArray {
//                    
//                    var latS : Double = (sN.objectForKey("data")! as NSArray).lastObject!.valueForKey("lat") as Double
//                    var lonS : Double = (sN.objectForKey("data")! as NSArray).lastObject!.valueForKey("lon") as Double
//
//                    
//            
//                    //THIS IS A HACK! ::TODO
//                    var fertilizer :Float = (sN.objectForKey("data")! as NSArray).lastObject!.valueForKey("fertilizer") as Float
//                    var health :Float = (sN.objectForKey("data")! as NSArray).lastObject!.valueForKey("health") as Float
//
//                    var soil:Float  = (sN.objectForKey("data")! as NSArray).lastObject!.valueForKey("soil_moisture")  as Float
//                    var temperature:Float  = (sN.objectForKey("data")! as NSArray).lastObject!.valueForKey("air_temperature") as Float
//                    var light :Float = (sN.objectForKey("data")! as NSArray).lastObject!.valueForKey("light") as Float
//                    var label :String = (sN.objectForKey("data")! as NSArray).lastObject!.valueForKey("label") as String
//                    var title :String
//                    
//                    if(soil > 0 && temperature > 0){
//                        title = "\(label)\(soil.description)%, \(temperature.description)°C"
//                    }else if(temperature > 0){
//                        title = "\(label)\(soil.description)%, \(temperature.description)°C"
//                    }else{
//                        title = "\(label)"
//                    }
//                    
//                    var sNA : RMAnnotation = RMAnnotation(mapView: self.mapView, coordinate: CLLocationCoordinate2DMake(latS, lonS), andTitle: title)
//                    
//                    if(health>0){
//                        sNA.userInfo = "plant:healthy"
//                    }else{
//                        sNA.userInfo = "plant:unhealthy"
//                    }
//                    self.mapView.addAnnotation(sNA)
//
//
//                    
//                }
//                
//            }
//            
//        }
//        
//        
//    }
//    
//    
//    func mapPOILayer() -> Void {
//
//        
//        var mapData = MapDataController()
//        mapData.downloadPOIData()
//        NSLog("drawing maps static/poi layer")
//        if(defaults.dictionaryForKey("mapPOI_level"+levelSelected.description) != nil){
//            NSLog("found data for static layer")
//            var staticNodes = enumerate(defaults.dictionaryForKey("mapPOI_level"+levelSelected.description)!)
//            
//            for (i,staticNode) in staticNodes {
//
//            
//            
//                
//                for sN in staticNode.1 as NSArray {
//                    
//                    var sNA : RMAnnotation = RMAnnotation(mapView: self.mapView, coordinate: CLLocationCoordinate2DMake(sN.valueForKey("lat") as Double, sN.valueForKey("lon") as Double), andTitle: sN.valueForKey("title") as NSString)
// 
//                    
//                    self.mapView.addAnnotation(sNA)
//                    
//                }
//            
//            
//            
//            }
//            
//            
//        }
//        
//    }
//
//    
//    func mapView(mapView: RMMapView!, layerForAnnotation annotation: RMAnnotation!) -> RMMapLayer! {
//        
//        
//        var phoneMarker: RMMarker = RMMarker(UIImage: UIImage(named: "marker-1"))
//        phoneMarker.canShowCallout = true
//        
//       /* var beaconRadius = RMCircle(view: mapView, radiusInMeters: 10.0)
//        beaconRadius.lineColor = UIColor.redColor()
//        beaconRadius.lineWidthInPixels = 5.0
//        beaconRadius.fillColor = UIColor.redColor().colorWithAlphaComponent(0.2)
//        phoneMarker.position = annotationn.position
//        beaconRadius.addSublayer(phoneMarker)
//        */
//        
//        var beaconMarker: RMMarker = RMMarker(UIImage: UIImage(named: "marker-0"))
//        beaconMarker.canShowCallout = true
//        
//        
//        var originalMarker:UIImage = UIImage(named: "marker-1")!
//        var originalPH:UIImage = UIImage(named: "sensor-0")!
//        var originalPUH:UIImage = UIImage(named: "sensor-1")!
//
//        
//        var youMarker: RMMarker = RMMarker(UIImage: UIImage(named: "you-marker"))
//        youMarker.canShowCallout = true
//        
//
//        var locationMarker: RMMarker = RMMarker(UIImage: UIImage(CGImage: originalMarker.CGImage, scale: (originalMarker.scale*1.5), orientation: originalMarker.imageOrientation))
//        locationMarker.canShowCallout = true
//
//        var plantHealthyMarker: RMMarker = RMMarker(UIImage: UIImage(CGImage: originalPH.CGImage, scale: (originalPH.scale*4), orientation: originalPH.imageOrientation))
//        plantHealthyMarker.canShowCallout = true
//        
//        var plantUnHealthyMarker: RMMarker = RMMarker(UIImage: UIImage(CGImage: originalPUH.CGImage, scale: (originalPUH.scale*4), orientation: originalPUH.imageOrientation))
//        plantUnHealthyMarker.canShowCallout = true
//        
//
//        
//        
//        
//        NSLog("modding map")
//
//        if(annotation.title?.rangeOfString("Phone") != nil){
//             return phoneMarker
//        }else if(annotation.title? == "You"){
//            return youMarker
//        }else if(annotation.title? == "edge"){
//             NSLog("edgy")
//             return annotation.layer
//        }else if((annotation.title?.rangeOfString("Beacon")) != nil){
//             return beaconMarker
//        }else if(annotation.userInfo == nil){
//            return locationMarker
//        }else if(annotation.userInfo.description == "plant:healthy"){
//            return plantHealthyMarker
//        }else if(annotation.userInfo.description == "plant:unhealthy"){
//            return plantUnHealthyMarker
//        }else{
//            return locationMarker
//        }
//        
//        
//    }
//    
//    
//    func peripheralManagerDidUpdateState(peripheral: CBPeripheralManager!) {
//
//        if (peripheral.state == CBPeripheralManagerState.PoweredOn)
//        {
//            // Bluetooth is on
//            NSLog("started beacon bcast")
//            
//            self.ownBeaconPManager.startAdvertising(self.ownBeaconData)
//            
//        }
//        else if (peripheral.state == CBPeripheralManagerState.PoweredOff)
//        {
//            NSLog("BLUETOOTH OFF: stopped beacon bcast")
//
//            self.ownBeaconPManager.stopAdvertising()
//        }
//        else if (peripheral.state == CBPeripheralManagerState.Unsupported)
//        {
//            NSLog("unsupported")
//        }
//    }
//    
//    
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        //setup beacon region
//        let beaconUUIDString = "3C77C2A5-5D39-420F-97FD-E7735CC7F317"
//        let beaconIdentifier = "ch.ethz.nervous"
//        let beaconUUID:NSUUID? = NSUUID(UUIDString: beaconUUIDString)
//        
//
//        
//        //put phones beacon on map / broadcast a beacon
//        if(defaults.integerForKey("sensorview_setting_1") == 1){
//            let nvm = NervousVM()
//
//            let beaconMinor:CLBeaconMinorValue = nvm.getBeaconMinor()
//            let beaconMajor:CLBeaconMajorValue = 33091
//            //let beaconMajor:CLBeaconMajorValue = 33092 for static
//            
//            self.ownBeaconRegion = CLBeaconRegion(proximityUUID: beaconUUID, major: beaconMajor, minor:beaconMinor, identifier: beaconIdentifier)
//            self.ownBeaconData = self.ownBeaconRegion.peripheralDataWithMeasuredPower(nil)
//            self.ownBeaconPManager = CBPeripheralManager(delegate: self, queue: nil)
//        }
//        
//        
//        
//    }
//    
//    
//    
//    
//    
//    override func viewWillAppear(animated: Bool) {
//        super.viewWillAppear(animated)
//        
//        refreshMapButton.layer.cornerRadius = 25
//        
//        let cchTileSource :RMMBTilesSource = RMMBTilesSource(tileSetResource: "blank") //default tile source
//        
//        
//        let cchMapView :RMMapView = RMMapView(frame: self.view.bounds, andTilesource: cchTileSource)
//        
//
//        cchMapView.centerCoordinate = CLLocationCoordinate2DMake(9.986 as CLLocationDegrees, 53.5624 as CLLocationDegrees)
//        
//        cchMapView.userInteractionEnabled = true
//        // default zoom
//        cchMapView.zoom = 16
//        // hard code minimal zoom. Try to run in without it to see what happens.
//        cchMapView.minZoom = 16
//        // hide MapBox logo
//        cchMapView.showLogoBug = false
//        cchMapView.hideAttribution = true
//        cchMapView.autoresizingMask = UIViewAutoresizing.FlexibleHeight | UIViewAutoresizing.FlexibleWidth
//        cchMapView.adjustTilesForRetinaDisplay = false
//        
//        var cchMapBGView :UIView! = UIView()
//        cchMapBGView.backgroundColor = UIColor(red: 0.878, green: 0.878, blue: 0.878, alpha: 1)
//        
//        cchMapView.backgroundView = cchMapBGView
//        
//        cchMapView.bouncingEnabled = true
//        
//        mapView = cchMapView
//        mapView.delegate = self
//
//        self.mapUIView.addSubview(mapView)
//        
//        
//        let filterButton = FilterButtonView(frame: CGRectZero)
//        filterButton.delegate = self
//        
//        self.mapUIView.addSubview(filterButton)
//        
//        
//    }
//    
//    
//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//        // Dispose of any resources that can be recreated.
//    }
//    
//}