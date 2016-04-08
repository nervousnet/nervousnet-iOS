//
//  AxonDetailViewController.swift
//  nervousnet
//
//  Created by Sam Sulaimanov on 06/04/16.
//  Copyright © 2016 ethz. All rights reserved.
//

import UIKit
import DownloadButton

class AxonDetailViewController: UIViewController {
    
    var axon: Array<String> = []
    @IBOutlet weak var downloadButton: PKDownloadButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
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



extension AxonDetailViewController: PKDownloadButtonDelegate {
    
    func downloadButtonTapped(downloadButton: PKDownloadButton!, currentState state: PKDownloadButtonState) {
        
        print(state)
        
        switch (state) {
        case PKDownloadButtonState.StartDownload:
            self.downloadButton.state = PKDownloadButtonState.Downloading;
            
            
            break;
        case PKDownloadButtonState.Downloading:
            
            
            let priority = DISPATCH_QUEUE_PRIORITY_DEFAULT
            dispatch_async(dispatch_get_global_queue(priority, 0)) {
                
                if(AxonStore.downloadAndInstall(0)){
                    print("installed successfully")
                }else{
                    print("couldn't install")
                }
                
                dispatch_async(dispatch_get_main_queue()) {
                    // update some UI
                    self.downloadButton.state = PKDownloadButtonState.Downloaded;
                }
            }
            
            break;
        case PKDownloadButtonState.Downloaded:
            self.downloadButton.state =  PKDownloadButtonState.StartDownload
            break;
        default:
            break;
        }
        
    }
    

}
