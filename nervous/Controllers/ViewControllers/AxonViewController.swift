//
//  AxonViewController.swift
//  nervousnet
//
//  Created by Sam Sulaimanov on 06/04/16.
//  Copyright © 2016 ethz. All rights reserved.
//

import UIKit

class AxonViewController: UIViewController {

    @IBOutlet weak var axonWebView: UIWebView!
    var axonName = "nil";

    @IBAction func reinstallAxon(sender: AnyObject) {
        //remove and download
        if(AxonStore.getRemoteAxonList().count > 0){
        
            AxonStore.removeLocalAxon(axonName)
            AxonStore.downloadAndInstall(AxonStore.getRemoteAxonIndexByName(axonName))
            
            axonWebView.reload()
        }
        
    }
    
    @IBAction func closeAxonButton(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: {
					let beaconController = BeaconController.sharedInstance
					beaconController.stopSensorUpdates()
				});
    }
    
    override func viewWillAppear(animated: Bool) {
        //hide status bar
        UIApplication.sharedApplication().setStatusBarHidden(true, withAnimation: UIStatusBarAnimation.Fade);
    }
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
			
        print("firing up the axon...")
        let url = AxonStore.getLocalAxonURL(axonName);
        let request = NSURLRequest(URL: url!)

				let beacons = AxonStore.getLocalAxonBeacons(axonName)
			if beacons.count > 0 {
				let beaconController = BeaconController.sharedInstance
				beaconController.addBeaconData(beacons)
				beaconController.startSensorUpdates()
			}

        axonWebView.loadRequest(request);
        axonWebView.scrollView.bounces = false;
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
