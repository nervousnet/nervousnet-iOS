//
//  SensorDetailController.swift
//  nervous
//
//  Created by Sam Sulaimanov on 28/10/14.
//  Copyright (c) 2014 ethz. All rights reserved.
//

import Foundation

class SensorDetailController:UIViewController,UIPickerViewDataSource, UIPickerViewDelegate {
    
    
    
    @IBAction func saveSensorDetail(sender: AnyObject) {
        
        self.dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    
    var ifSensors :[[String]] = [["Beacon", "near","Tell Jan","immediate"],["Motion","te2st","tes34t","tes5t"],["Other","tes2t","t2est","2test","tedst"]]
    
    var thenSensors :[[String]] = [["Beacon", "te1st","te1st","t1est"],["Motion","te2st","tes34t","tes5t"],["Other","tes2t","t2est","2test","tedst"]]
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 3
    }
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        if(pickerView.tag == 0){
            return ifSensors.count

        }else{
            return thenSensors.count

        }
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        
        
        if(pickerView.tag == 0){
            return ifSensors[row][component]
            
        }else{
            return thenSensors[row][component]
            
        }

    }

    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int){
        
        if(pickerView.tag == 0){
            
            ifSensors = [["LOL", "WAT","WAT","immediate"],["WAT","WAT","WAT","tes5t"],["Other","WAT","t2est","2test","tedst"]]
            
        }
        
        pickerView.reloadAllComponents()
        
    }

    
    

}