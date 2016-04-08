//
//  ControlPanelTableViewController.swift
//  nervousnet
//
//  Created by Sam Sulaimanov on 04/04/16.
//  Copyright © 2016 ethz. All rights reserved.
//

import UIKit

class ControlPanelTableViewController: UITableViewController {
    
    var controlPanelOptions = [
        "nervousnet Space": ["NervousnetSpaceTableViewController", UIImage(imageLiteral: "nn")],
        "Sensors": ["NervousnetSpaceTableViewController", UIImage(imageLiteral: "nn")],
        "Settings":["NervousnetSpaceTableViewController", UIImage(imageLiteral: "nn")],
        "Help": ["NervousnetSpaceTableViewController", UIImage(imageLiteral: "nn")]
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    self.navigationController?.navigationBar.viewWithTag(97)?.hidden = true
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
        return controlPanelOptions.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("ControlPanelCell", forIndexPath: indexPath)
        
        let image = Array(controlPanelOptions.values)[indexPath.row][1] as! UIImage
        let title = Array(controlPanelOptions.keys)[indexPath.row]
        
        let titleLabel : UILabel = self.view.viewWithTag(100) as! UILabel
        let imageView : UIImageView = self.view.viewWithTag(101) as! UIImageView
        
        titleLabel.text = title
        imageView.image = image
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let nextViewController = Array(controlPanelOptions.values)[indexPath.row][0] as! String
        let nextViewControllerObj = self.storyboard?.instantiateViewControllerWithIdentifier(nextViewController)
        
        self.navigationController?.pushViewController(nextViewControllerObj!, animated: true)
    
        
    }
  
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
