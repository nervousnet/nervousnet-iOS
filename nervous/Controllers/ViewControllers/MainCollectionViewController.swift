//
//  MainCollectionViewController.swift
//  nervousnet
//
//  Created by Sam Sulaimanov on 03/04/16.
//  Copyright © 2016 ethz. All rights reserved.
//

import Foundation
import UIKit

class MainCollectionViewController: UICollectionViewController  {
    
    private let reuseIdentifier = "MainCVCell"
    private let sectionInsets = UIEdgeInsets(top: 50.0, left: 20.0, bottom: 50.0, right: 20.0)
    
    func getNumberOfCellsDisplayable() -> Int {
        return 30;
    }
}

extension MainCollectionViewController {
    
    //1
    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    //2
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return getNumberOfCellsDisplayable();
    }
    
    //3
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        //1
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! MainCVCellCollectionViewCell
        //2
        cell.backgroundColor = UIColor.orangeColor()
        //3
        cell.imageView.image = UIImage(imageLiteral: "3rd-floor-0")
        
        return cell
    }}