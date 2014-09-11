//
//  FirstViewController.swift
//  nervous
//
//  Created by Sam Sulaimanov on 10/09/14.
//  Copyright (c) 2014 ethz. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {
                            
    
    @IBOutlet var mapWebView: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        var url = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("map", ofType: "html")!)
        
        var request = NSURLRequest(URL: url)
        
        mapWebView.scrollView.bounces = false;
        mapWebView.scrollView.scrollEnabled = false;
        
        mapWebView.loadRequest(request)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

