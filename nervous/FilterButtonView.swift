//
//  FilterButtonView.swift
//  nervous
//
//  Created by Jan Hug on 28.10.14.
//  Copyright (c) 2014 ethz. All rights reserved.
//

import UIKit

class FilterButtonView: UIView {
    
    var buttonSize: CGFloat = 40
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
        self.frame.origin.y = screenHeight - buttonSize - margin - 30 // 30 BECAUSE SHITTY TOOLBAR
        self.frame.size.width = buttonSize
        self.frame.size.height = buttonSize
    }
    
    
    
    func showFilterButtons() {
        for index in 2...numberOfButtons {
            UIView.animateWithDuration(0.5, delay: NSTimeInterval(Double(index - 1) * 0.05), usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: nil, animations: {
                NSLog("try to remove this...")
                self.viewWithTag(index)?.transform = CGAffineTransformMakeScale(1, 1)
                }, completion: { finished in
                    self.opened = true
            })
        }
    }
    
    
    
    func hideFilterButtons() {
        for index in 2...numberOfButtons {
            UIView.animateWithDuration(0.18, delay: 0.05, options: nil, animations: {
                NSLog("try to remove this...")
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
            let button = UIButton(frame: CGRect(x: 0,
                                                y: ((CGFloat(index) * buttonSize) + (CGFloat(index) * margin)) * -1,
                                            width: buttonSize,
                                           height: buttonSize))
            
            button.addTarget(self, action: "buttonAction:", forControlEvents: UIControlEvents.TouchUpInside)
            button.setTitle((index + 1).description, forState: UIControlState.Normal)
            button.tag = index + 1
            
            if (index > 0) {
                button.transform = CGAffineTransformMakeScale(0, 0)
                button.backgroundColor = UIColor.orangeColor()
            } else {
                button.backgroundColor = UIColor.blackColor()
            }
            
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