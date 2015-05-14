////
////  SensorViewController.swift
////  nervous
////
////  Created by Sam Sulaimanov on 28/09/14.
////  Copyright (c) 2014 ethz. All rights reserved.
////
//
//import UIKit
//import CoreData
//
//class SensorViewController: UIViewController, UITableViewDataSource, UITableViewDelegate  {
//    
//    var items: [[String]] = [["sensorview_setting_0", "Put my phone", "on map"], ["sensorview_setting_1", "Allow others", "to see me"]] //do not change order yet ::TODO
//    
//    
//    
//    let defaults :NSUserDefaults = NSUserDefaults.standardUserDefaults()
//

/*import UIKit
import CoreData

class SensorViewController: UIViewController, UITableViewDataSource, UITableViewDelegate  {
    
    var items: [[String]] = [["sensorview_setting_0", "Put my phone", "on map"], ["sensorview_setting_1", "Allow others", "to see me"]] //do not change order yet ::TODO
    
    
    
    let defaults :NSUserDefaults = NSUserDefaults.standardUserDefaults()

    
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
        
        cell.textLabel!.text = "\(items[indexPath.row][1]) \(items[indexPath.row][2])"
        
        cell.backgroundColor = UIColor.clearColor()
        
        //activation switch
        var sensorSwitch :UISwitch = UISwitch()
        sensorSwitch.tag = indexPath.row
        sensorSwitch.frame = CGRectMake(cell.bounds.width-60, 14, 44, 44)
        sensorSwitch.addTarget(self, action: Selector("stateChanged:"), forControlEvents: UIControlEvents.ValueChanged)
        if(defaults.integerForKey(items[indexPath.row][0]) == 0){
            sensorSwitch.on = false
        }else{
            sensorSwitch.on = true
        }
        
        cell.addSubview(sensorSwitch)
        
        return cell
    }
    

    func stateChanged(switchState: UISwitch) {
        if switchState.on {
            defaults.setInteger(1, forKey: items[switchState.tag][0])
            NSLog("%@ switched on", items[switchState.tag][0])
            
            
        } else {
            defaults.setInteger(0, forKey: items[switchState.tag][0])
            NSLog("%@ switched off", items[switchState.tag][0])

        }
    }

}*/
//    
//    @IBAction func closeSensorView(sender: AnyObject) {
//        self.dismissViewControllerAnimated(true, completion: nil)
//    }
//    @IBOutlet var tableView: UITableView?
//
//    func closeView(sender: AnyObject) {
//        self.dismissViewControllerAnimated(true, completion: nil)
//
//    }
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//    }
//    
//    override func viewWillAppear(animated: Bool) {
//        self.tableView?.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
//
//    }
//    
//
//    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return items.count
//    }
////    
////    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
////        var cell = tableView.dequeueReusableCellWithIdentifier("cell") as UITableViewCell
////        
////        cell.textLabel.text = "\(items[indexPath.row][1]) \(items[indexPath.row][2])"
////        
////        cell.backgroundColor = UIColor.clearColor()
////        
////        //activation switch
////        var sensorSwitch :UISwitch = UISwitch()
////        sensorSwitch.tag = indexPath.row
////        sensorSwitch.frame = CGRectMake(cell.bounds.width-60, 14, 44, 44)
////        sensorSwitch.addTarget(self, action: Selector("stateChanged:"), forControlEvents: UIControlEvents.ValueChanged)
////        if(defaults.integerForKey(items[indexPath.row][0]) == 0){
////            sensorSwitch.on = false
////        }else{
////            sensorSwitch.on = true
////        }
////        
////        cell.addSubview(sensorSwitch)
////        
////        return cell
////    }
//    
//
//    func stateChanged(switchState: UISwitch) {
//        if switchState.on {
//            defaults.setInteger(1, forKey: items[switchState.tag][0])
//            NSLog("%@ switched on", items[switchState.tag][0])
//            
//            
//        } else {
//            defaults.setInteger(0, forKey: items[switchState.tag][0])
//            NSLog("%@ switched off", items[switchState.tag][0])
//
//        }
//    }
//
//}
