//
//  NervousnetSpaceTableViewController.swift
//  nervousnet
//
//  Created by Sam Sulaimanov on 05/04/16.
//  Copyright © 2016 ethz. All rights reserved.
//

import UIKit
import SwiftyJSON
import MRProgress
import Zip

class NervousnetSpaceTableViewController: UITableViewController {
    

    var TableData = Array<Array<String>>()
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        MRProgressOverlayView.showOverlayAddedTo(self.view, title: "Getting Axons..", mode: MRProgressOverlayViewMode.Indeterminate, animated: true)
        
        let priority = DISPATCH_QUEUE_PRIORITY_DEFAULT
        dispatch_async(dispatch_get_global_queue(priority, 0)) {
            // download app store listing in the background and hide progress bar
            self.TableData = AxonStore.getRemoteAxonList()
            
            dispatch_async(dispatch_get_main_queue()) {
                self.tableView.reloadData()
                MRProgressOverlayView.dismissOverlayForView(self.view, animated: true)
            }
        }
        
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return TableData.count
    }
    
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("appstoreCell", forIndexPath: indexPath) 
        
        let imageData = NSData(base64EncodedString: TableData[indexPath.row][3], options: NSDataBase64DecodingOptions(rawValue: 0))
        let image = UIImage(data: imageData!)
        
        
        //get labels within the cell
        let lbl : UILabel? = cell.contentView.viewWithTag(1) as? UILabel
        lbl?.text = TableData[indexPath.row][1];
        
        let txtv : UITextView? = cell.contentView.viewWithTag(2) as? UITextView
        txtv?.text = TableData[indexPath.row][2];
        
        let imgview : UIImageView? = cell.contentView.viewWithTag(3) as? UIImageView
        imgview?.image = image
        
        return cell
    }
    
    
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        navigationController!.performSegueWithIdentifier("axonDetailViewControllerSegue", sender: TableData[indexPath.row])
    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
       if segue.identifier == "axonDetailViewControllerSegue" {
            
            if let axonDetailViewController = segue.destinationViewController as? AxonDetailViewController {
                axonDetailViewController.axon = sender as! Array<String>
            }
            
        }
        
    }
    
    /*
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */


}
