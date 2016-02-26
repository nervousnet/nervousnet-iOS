//
//  PrivacyTableViewCell.swift
//  nervousnet
//
//  Created by Lewin Könemann on 29/05/15.
//  Copyright (c) 2015 ethz. All rights reserved.
//

import UIKit

class PrivacyTableViewCell: UITableViewCell {

    @IBOutlet var Share: UISwitch!
    @IBOutlet var Log: UISwitch!
    @IBOutlet var Label: UILabel!
    
    var SensorID : Int = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func LogChange(sender: UISwitch) {
    }

    @IBAction func ShareChange(sender: UISwitch) {
    }
}
