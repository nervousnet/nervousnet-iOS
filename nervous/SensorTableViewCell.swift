//
//  SensorTableViewCell.swift
//  nervousnet
//
//  Created by Lewin Könemann on 31/05/15.
//  Copyright (c) 2015 ethz. All rights reserved.
//

import UIKit

class SensorTableViewCell: UITableViewCell {
    var SensorID : Int = 0
    @IBOutlet var button: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }

    @IBAction func buttonPressed(sender: UIButton) {
    }
}
