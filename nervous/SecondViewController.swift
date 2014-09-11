//
//  SecondViewController.swift
//  nervous
//
//  Created by Sam Sulaimanov on 10/09/14.
//  Copyright (c) 2014 ethz. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {
                            
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        //creation of a protobuf message for sensordata
        let sensorButton = SensorUpload.builder();
        sensorButton.sensorId = 123;
        sensorButton.huuid = 1;
        sensorButton.luuid = 2;
        sensorButton.uploadTime = 2222;
        sensorButton.sensorId = 22;
        
        
    
        
        let sensorButtonMessage = SensorUploadSensorData.builder();
        sensorButtonMessage.recordTime = 213123;
        
        let sB = sensorButton.build();
        
        println("\(sB.data())")
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

