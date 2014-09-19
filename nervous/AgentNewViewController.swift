//
//  AgentNewViewController.swift
//  nervous
//
//  Created by Sam Sulaimanov on 11/09/14.
//  Copyright (c) 2014 ethz. All rights reserved.
//

import UIKit

class AgentNewViewController: UIViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func closePopOver(sender: AnyObject) {
        self.dismissViewControllerAnimated(true,nil)

    }
    
    
}
