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
    
    @IBOutlet weak var axonImageView: UIImageView!
    @IBOutlet weak var downloadButton: PKDownloadButton!
    
    @IBOutlet weak var axonTextView: UITextView!
    @IBOutlet weak var axonSubtitle: UILabel!
    @IBOutlet weak var axonTitle: UILabel!
    
    @IBOutlet weak var axonURL: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        downloadButton.delegate = self
        
        print("opened details of: ")
        print(axon[0])
        
        //let arrayOfStrings: [String] = [axon["name"].stringValue, axon["title"].stringValue, axon["description"].stringValue, axon["icon"].stringValue, axon["repository"]["url"].stringValue, axon["author"].stringValue]

        
        
        axonTitle.text = axon[1]
        axonSubtitle.text = axon[5]
        axonTextView.text = axon[2]
        axonURL.text = "GitHub: \(axon[4])"

        axonImageView.image = UIImage(data: NSData(base64EncodedString: axon[3], options: NSDataBase64DecodingOptions(rawValue: 0))!)
        

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
            
            
            let priority = DISPATCH_QUEUE_PRIORITY_DEFAULT
            dispatch_async(dispatch_get_global_queue(priority, 0)) {
                
                if(AxonStore.downloadAndInstall(AxonStore.getRemoteAxonIndexByName(self.axon[0]))){
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
        case PKDownloadButtonState.Downloading:
            print("cancelling download not yet implemented")
            break;
            
            
        case PKDownloadButtonState.Downloaded:
            self.downloadButton.state =  PKDownloadButtonState.StartDownload
            break;
        default:
            break;
        }
        
    }
    

}
