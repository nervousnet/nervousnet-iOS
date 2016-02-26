////
////  NervousAppsViewController.swift
////  nervousnet
////
////  Created by Lewin Könemann on 28/05/15.
////  Copyright (c) 2015 ethz. All rights reserved.
////
//
//import UIKit
//
//
//
//class NervousAppsViewController: UITableViewController {
//    
//    var Apps = ["Nervousnet CCC"]
//    var Descriptions = [    "Where it all started..."]
//    var Links = [   "https://itunes.apple.com/us/app/nervousnet-for-31c3/id942966980?mt=8"]
//    
//    var trial : NSArray = []
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        searchItunesFor("nervous")
//        // Uncomment the following line to preserve selection between presentations
//        // self.clearsSelectionOnViewWillAppear = false
//
//        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
//        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
//    }
//    
//    override func willRotateToInterfaceOrientation(toInterfaceOrientation: UIInterfaceOrientation, duration: NSTimeInterval) {
//        switch toInterfaceOrientation {
//        default:
//            self.tableView.reloadData()
//        }
//    }
//
//
//    // MARK: - Table view data source
//    
//    func searchItunesFor(searchTerm: String) {
//        // The iTunes API wants multiple terms separated by + symbols, so replace spaces with + signs
//        let itunesSearchTerm = searchTerm.stringByReplacingOccurrencesOfString(" ", withString: "+", options: NSStringCompareOptions.CaseInsensitiveSearch, range: nil)
//        
//        // Now escape anything else that isn't URL-friendly
//        if let escapedSearchTerm = itunesSearchTerm.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding) {
//            //let urlPath = "http://itunes.apple.com/search?term=\(escapedSearchTerm)&media=software"
//            let urlPath = "http://itunes.apple.com/search?mediaType=ios&term=nervousnet"
//            let url = NSURL(string: urlPath)
//            let session = NSURLSession.sharedSession()
//            let task = session.dataTaskWithURL(url!, completionHandler: {data, response, error -> Void in
//                print("Task completed")
//                if(error != nil) {
//                    // If there is an error in the web request, print it to the console
//                    print(error.localizedDescription)
//                }
//                var err: NSError?
//                if let jsonResult = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers) as? NSDictionary {
//                    if(err != nil) {
//                        // If there is an error parsing JSON, print it to the console
//                        print("JSON Error \(err!.localizedDescription)")
//                    }
//                    if let results: NSArray = jsonResult["results"] as? NSArray {
//                        dispatch_async(dispatch_get_main_queue(), {
//                            self.trial = results
//                            print(results, terminator: "")
////                            self.appsTableView!.reloadData()
//                        })
//                    }
//                }
//            })
//            
//            // The task is just an object with all these properties set
//            // In order to actually make the web request, we need to "resume"
//            task.resume()
//        }
//    }
//    
//    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
//        // #warning Potentially incomplete method implementation.
//        // Return the number of sections.
//        return 2
//    }
//
//    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        // #warning Incomplete method implementation.
//        // Return the number of rows in the section.
//        if (section == 0)
//        {return 1}
//        else {return Apps.count
//        }
//    }
//
//    private struct Storyboard{
//        static let CellReuseIdentifier = "App"
//        static let NavigationIdentifier = "Navigation"
//    }
//    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
//        
//        if (indexPath.section == 0) {
//            let cell = tableView.dequeueReusableCellWithIdentifier(Storyboard.NavigationIdentifier, forIndexPath: indexPath) as UITableViewCell
//            return cell
//        }
//        else {
//            let cell = tableView.dequeueReusableCellWithIdentifier(Storyboard.CellReuseIdentifier, forIndexPath: indexPath) as! NervousAppTableViewCell
//        // Configure the cell...
//            cell.Description.text = Descriptions [indexPath.row]
//            cell.Name.text = Apps [indexPath.row]
//            cell.Link = Links [indexPath.row]
//            return cell
//        }
//    }
//    
//
//    /*
//    // Override to support conditional editing of the table view.
//    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
//        // Return NO if you do not want the specified item to be editable.
//        return true
//    }
//    */
//
//    /*
//    // Override to support editing the table view.
//    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
//        if editingStyle == .Delete {
//            // Delete the row from the data source
//            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
//        } else if editingStyle == .Insert {
//            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
//        }    
//    }
//    */
//
//    /*
//    // Override to support rearranging the table view.
//    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {
//
//    }
//    */
//
//    /*
//    // Override to support conditional rearranging of the table view.
//    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
//        // Return NO if you do not want the item to be re-orderable.
//        return true
//    }
//    */
//
//    /*
//    // MARK: - Navigation
//
//    // In a storyboard-based application, you will often want to do a little preparation before navigation
//    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//        // Get the new view controller using [segue destinationViewController].
//        // Pass the selected object to the new view controller.
//    }
//    */
//
//}
