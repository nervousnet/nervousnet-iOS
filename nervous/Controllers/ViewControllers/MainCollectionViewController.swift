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
    
    /* view controller routing */
    private let nextViewController = "ControlPanelTableViewController"
    @IBAction func handleSwipe(recognizer:UISwipeGestureRecognizer){

        let nextViewControllerObj = self.storyboard?.instantiateViewControllerWithIdentifier(nextViewController) as? ControlPanelTableViewController
        self.navigationController?.pushViewController(nextViewControllerObj!, animated: true)
    }
   
    

    /* cell handling */
    private let reuseIdentifier = "MainCVCell"
    private let sectionInsets = UIEdgeInsets(top: 50.0, left: 20.0, bottom: 50.0, right: 20.0)
    
    
    func getNumberOfCellsDisplayable() -> Int {
        return 30;
    }
    
    func getTextForCell(cellIndex: NSIndexPath) -> String {
        return "\(cellIndex.row) text for cell"
    }
    
    
    func getImageForCell(cellIndex: NSIndexPath) -> UIImage {
        return UIImage(imageLiteral: "3rd-floor-0")
    }
    


}

extension MainCollectionViewController {
    
    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return getNumberOfCellsDisplayable();
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
    
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! MainCVCellCollectionViewCell
    
        cell.backgroundColor = UIColor.orangeColor()
    
        cell.imageView.image = getImageForCell(indexPath)
        cell.textLabel.text = getTextForCell(indexPath)
        
        
        return cell
    }
}


