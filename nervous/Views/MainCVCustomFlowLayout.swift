//
//  MainCVCustomFlowLayout.swift
//  nervousnet
//
//  Created by Sam Sulaimanov on 08/04/16.
//  Copyright © 2016 ethz. All rights reserved.
//

import UIKit

class MainCVCustomFlowLayout: UICollectionViewFlowLayout {

    override var itemSize: CGSize {
        set {}
        get {
            let numberOfColumns: CGFloat = 3
            
            let itemWidth = (CGRectGetWidth(self.collectionView!.frame) - (numberOfColumns - 1)) / numberOfColumns
            return CGSizeMake(itemWidth, itemWidth)
        }
    }
    
}
