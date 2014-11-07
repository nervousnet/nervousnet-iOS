//
//  FilterButtonView.swift
//  nervous
//
//  Created by Jan Hug on 28.10.14.
//  Copyright (c) 2014 ethz. All rights reserved.
//

import UIKit

class FilterButtonView: UIView {
    
    var buttonSize: CGFloat = 50
    var margin: CGFloat = 10
    var numberOfButtons = 5
    var opened = false

    override init(frame: CGRect) {
        super.init(frame: frame)
        positionView()
        createButtons()
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    func positionView() {
       let screenWidth = UIScreen.mainScreen().bounds.width
        let screenHeight = UIScreen.mainScreen().bounds.height
        
        self.frame.origin.x = screenWidth - buttonSize - margin
        self.frame.origin.y = 0
        self.frame.size.width = buttonSize
        self.frame.size.height = buttonSize
        
    }
    
    
    
    func showFilterButtons() {
        for index in 2...numberOfButtons {
            UIView.animateWithDuration(0.5, delay: NSTimeInterval(Double(index - 1) * 0.05), usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: nil, animations: {
                NSLog(".") //༼;´༎ຶ ۝ ༎ຶ༽
                self.viewWithTag(index)?.transform = CGAffineTransformMakeScale(1, 1)
                }, completion: { finished in
                    self.opened = true
            })
        }
        
        
        self.frame.size.height = 240
        self.frame.origin.y = self.frame.origin.y - 240
        self.layer.backgroundColor = UIColor.redColor().CGColor
        
    }
    
    
    
    func hideFilterButtons() {
        for index in 2...numberOfButtons {
            UIView.animateWithDuration(0.18, delay: 0.05, options: nil, animations: {
               
                self.viewWithTag(index)?.transform = CGAffineTransformMakeScale(0.001, 0.001)
                self.viewWithTag(index)?.alpha = 0
                }, completion: { finished in
                    self.opened = false
                    self.viewWithTag(index)?.transform = CGAffineTransformMakeScale(0, 0)
                    self.viewWithTag(index)?.alpha = 1
            })
        }
    }
    
    
    
    func createButtons() {
        for index in 0...numberOfButtons - 1 {
            var btnImageName :String = "maps"
            let button = UIButton(frame: CGRect(x: 0,
                                                y: ((CGFloat(index) * buttonSize) + (CGFloat(index) * margin)) * -1,
                                            width: buttonSize,
                                           height: buttonSize))
            
            button.addTarget(self, action: "buttonAction:", forControlEvents: UIControlEvents.TouchUpInside)
            button.setTitle((index + 1).description, forState: UIControlState.Normal)
            button.tag = index + 1
            
            if (index > 0) {
                button.transform = CGAffineTransformMakeScale(0, 0)
                
                
                switch(button.tag){
                    case 2:
                        btnImageName = "1st-floor-"
                        break
                    
                    case 3:
                        btnImageName = "2nd-floor-"
                        break
                    
                    case 4:
                        btnImageName = "3rd-floor-"
                        break
                    
                    case 5:
                        btnImageName = "relations-"
                    break
                    
                    default:
                        btnImageName = "close"
                        break

                }
                
                button.backgroundColor = UIColor.whiteColor()
            } else {
                button.backgroundColor = UIColor.orangeColor()
            }
            
            button.setImage(UIImage(named: btnImageName+"0"), forState: UIControlState.Normal)
            button.setImage(UIImage(named: btnImageName+"1"), forState: UIControlState.Highlighted)

            
            button.layer.cornerRadius = buttonSize / 2
            self.addSubview(button)
        }
        
    }
    
    
    
    func buttonAction(sender: UIButton!) {
        switch sender.tag {
        case 1:
            if opened == false {
                showFilterButtons()
            } else {
                hideFilterButtons()
            }
        default:
            NSLog("nüt du")
        }
    }

}