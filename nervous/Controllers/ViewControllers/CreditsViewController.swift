//
//  CreditsViewController.swift
//  nervous
//
//  Created by Sam Sulaimanov on 28/11/14.
//  Copyright (c) 2014 ethz. All rights reserved.
//

import Foundation

class CreditsViewController: UIViewController  {
    
    @IBAction func closeCreditsView(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}