//
//  SensorViewController.swift
//  nervous
//
//  Created by Sam Sulaimanov on 28/09/14.
//  Copyright (c) 2014 ethz. All rights reserved.
//

import UIKit
import CoreData

class SensorViewController: UIViewController, UITableViewDataSource, UITableViewDelegate  {
    
    var items: [[String]] = [["Phone", "Map"], ["Room", "Map"], ["Motion", "Tone"], ["Room", "Map"], ["Room", "Map"], ["Room", "Map"], ["Room", "Map"], ["Room", "Map"], ["Room", "Map"], ["Room", "Map"], ["Room", "Map"], ["Room", "Map"], ["Room", "Map"], ["Room", "Map"], ["Room", "Map"], ["Room", "Map"], ["Room", "Map"], ["Room", "Map"], ["Room", "Map"], ["Room", "Map"], ["Room", "Map"], ["Room", "Map"], ["Room", "Map"], ["Room", "Map"], ["Room", "Map"], ["Room", "Map"]]

    
    @IBAction func clearDatabase(){
        let appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        
        var storeCoordinator:NSPersistentStoreCoordinator = appDelegate.persistentStoreCoordinator!
        var store:NSPersistentStore = storeCoordinator.persistentStores.last as NSPersistentStore
        var storeURL:NSURL = store.URL!
        storeCoordinator.removePersistentStore(store, error: nil)
        NSFileManager.defaultManager().removeItemAtPath(storeURL.path!, error: nil)
        
    }
    
    
    @IBAction func closeSensorView(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    @IBOutlet var tableView: UITableView?

    func closeView(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)

    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(animated: Bool) {
        self.tableView?.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")

    }
    

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("cell") as UITableViewCell
        
        cell.textLabel.text = "If \(items[indexPath.row][0]) then \(items[indexPath.row][1])"
        
        cell.backgroundColor = UIColor.clearColor()
        
        
        //activation switch
        var sensorSwitch :UISwitch = UISwitch()
        sensorSwitch.on = false
        sensorSwitch.frame = CGRectMake(cell.bounds.width-60, 14, 44, 44)
        
        cell.addSubview(sensorSwitch)
        
        return cell
    }
    
    // UITableViewDelegate methods
    
    func tableView(tableView: UITableView!, didSelectRowAtIndexPath indexPath: NSIndexPath!) {
        
        let alert = UIAlertController(title: "Item selected", message: "You selected item \(indexPath.row)", preferredStyle: UIAlertControllerStyle.Alert)
        
        alert.addAction(UIAlertAction(title: "OK",
            style: UIAlertActionStyle.Default,
            handler: {
                (alert: UIAlertAction!) in println("An alert of type \(alert.style.hashValue) was tapped!")
        }))
        
        self.presentViewController(alert, animated: true, completion: nil)
        
    }

}