//
//  PrivacyTableView.swift
//  nervousnet
//
//  Created by Lewin Könemann on 29/05/15.
//  Copyright (c) 2015 ethz. All rights reserved.
//

import UIKit

class PrivacyTableView: UITableView {
    
    var Sensors = ["Accelerometer", "Battery"]
    var SensorIDs = [0,1]
    override func numberOfSections() -> Int {
        return 1
    }
    
    override func numberOfRowsInSection(section: Int) -> Int {
        return Sensors.count
    }
    
    let CellIdentifier = "PrivacyCell"
    
    override func cellForRowAtIndexPath(indexPath: NSIndexPath) -> UITableViewCell? {
        let cell = super.dequeueReusableCellWithIdentifier(CellIdentifier, forIndexPath: indexPath) as PrivacyTableViewCell
        cell.Label.text = Sensors[indexPath.row]
        cell.SensorID = SensorIDs[indexPath.row]
        return cell
    }
    
    
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
