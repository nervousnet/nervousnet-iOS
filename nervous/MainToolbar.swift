//
//  MainToolbar.swift
//  nervous
//
//  Created by Sam Sulaimanov on 28/10/14.
//  Copyright (c) 2014 ethz. All rights reserved.
//

import Foundation


class MainToolbar :UIToolbar {
    
    override init(){
        super.init()
        self.applyTranslucentBackground()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.applyTranslucentBackground()
        
    }
    
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
        self.applyTranslucentBackground()

    }
    
    override func drawRect(rect: CGRect) { }
    
    func applyTranslucentBackground() {
        self.backgroundColor = UIColor.whiteColor().colorWithAlphaComponent(0)
        self.opaque = false
        self.translucent = true
    }

}

