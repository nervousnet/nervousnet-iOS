////
////  GraphSetupViewController.swift
////  nervousnet
////
////  Created by Lewin Könemann on 31/05/15.
////  Copyright (c) 2015 ethz. All rights reserved.
////
//
//import UIKit
//
//class GraphSetupViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
//    
//    
//    @IBOutlet var tableView: UITableView!
//    var table_data = Array<TableData>()
//    var Sensors = ["Accelerometer", "Battery", "Gyroscope", "Magnetic", "Proximity"]
//    var SensorIDs : [Int] = [0, 1, 2, 5, 6]
//    var transitionTo: String = " "
//    
//    struct TableData
//    {
//        var section:String = ""
//        var data = Array<String>()
//        init(){}
//    }
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        tableView.dataSource = self
//        tableView.dataSource = self
//        // Do any additional setup after loading the view.
//    }
//    
//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//        // Dispose of any resources that can be recreated.
//    }
//    
//    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
//    {
//        let cell = tableView.dequeueReusableCellWithIdentifier("sensor", forIndexPath: indexPath) as! SensorTableViewCell
//        cell.button.setTitle( Sensors[indexPath.row], forState: UIControlState.Normal )
//        cell.SensorID = SensorIDs [indexPath.row]
//        return cell
//        
//    }
//    
//    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
//    {
//        return Sensors.count
//    }
//    
//    func numberOfSectionsInTableView(tableView: UITableView) -> Int
//    {
//        return 1
//    }
//    
//    @IBAction func selection(sender: UIButton) {
//        
//        self.transitionTo = sender.currentTitle!
//        let  targetVC : SensorStatisticsViewController = UIStoryboard(name: "Latest", bundle: NSBundle.mainBundle()).instantiateViewControllerWithIdentifier("graphen") as! SensorStatisticsViewController
//        targetVC.sensorId = self.transitionTo
//        self.presentViewController(targetVC, animated: true, completion: nil)
//        
//    }
////    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
////            print("hallo" + self.transitionTo + "hallo")
////            var target = segue.destinationViewController as SensorStatisticsViewController
////            target.sensorId = self.transitionTo
////    }
//    
//    
//    //showGraph
//    /*
//    // MARK: - Navigation
//    
//    // In a storyboard-based application, you will often want to do a little preparation before navigation
//    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//    // Get the new view controller using segue.destinationViewController.
//    // Pass the selected object to the new view controller.
//    }
//    */
//    
//}
