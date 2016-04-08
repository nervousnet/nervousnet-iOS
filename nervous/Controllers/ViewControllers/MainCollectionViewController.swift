//
//  MainCollectionViewController.swift
//  nervousnet
//
//  Created by Sam Sulaimanov on 03/04/16.
//  Copyright © 2016 ethz. All rights reserved.
//

import Foundation
import UIKit


class MainCollectionViewController: UICollectionViewController, UIGestureRecognizerDelegate  {
    
    /* view controller routing */
    private let nextViewController = "ControlPanelTableViewController"
    @IBAction func handleSwipe(recognizer:UISwipeGestureRecognizer){

        let nextViewControllerObj = self.storyboard?.instantiateViewControllerWithIdentifier(nextViewController) as? ControlPanelTableViewController
        self.navigationController?.pushViewController(nextViewControllerObj!, animated: true)
    }
   
    
    @IBAction func handleLongPress(recognizer:UILongPressGestureRecognizer){

        let longPressLocation = recognizer.locationInView(self.collectionView)

        
        if(recognizer.state != UIGestureRecognizerState.Ended){
            return
        }
        
        if let indexPath = self.collectionView?.indexPathForItemAtPoint(longPressLocation) {
            let cell = self.collectionView?.cellForItemAtIndexPath(indexPath) as! MainCVCellCollectionViewCell
            
            print("long pressed and item!",  cell.textLabel.text)
        }

    }
    

    /* cell handling */
    private let reuseIdentifier = "MainCVCell"
    private let sectionInsets = UIEdgeInsets(top: 50.0, left: 20.0, bottom: 50.0, right: 20.0)
    
    
    func getNumberOfCellsDisplayable() -> Int {
        return AxonStore.getInstalledAxonsList().count;
    }
    
    func getTextForCell(cellIndex: NSIndexPath) -> String {
        return AxonStore.getLocalAxon(cellIndex.row)[1]
    }
    
    
    func getNameForCell(cellIndex: NSIndexPath) -> String {
        return AxonStore.getLocalAxon(cellIndex.row)[0]
    }
    
    
    
    func getImageForCell(cellIndex: NSIndexPath) -> UIImage {
        
        let imageData = NSData(base64EncodedString: AxonStore.getLocalAxon(cellIndex.row)[3], options: NSDataBase64DecodingOptions(rawValue: 0))
        
        return UIImage(data: imageData!)!
    }
    


}

extension MainCollectionViewController {
    
    override func viewWillAppear(animated: Bool) {
        self.collectionView?.reloadData()
    }
    
    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 2
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if(section == 0){
            return getNumberOfCellsDisplayable()
        }else if(section == 1){
            return 2
        }else{
            return 0
        }
    
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! MainCVCellCollectionViewCell
        
        
        if(indexPath.section == 0){
            cell.backgroundColor = UIColor.orangeColor()
        
            cell.imageView.image = getImageForCell(indexPath)
            cell.textLabel.text = getTextForCell(indexPath)
            
        }else if(indexPath.section == 1){
            
            
        }
        
        return cell
    }
    
    
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        if(indexPath.section == 0){
            performSegueWithIdentifier("axonViewControllerSegue", sender: self.getNameForCell(indexPath))
        }
        
    }
    
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "axonViewControllerSegue" {
            
            if let axonViewController = segue.destinationViewController as? AxonViewController {
                axonViewController.axonName = (sender as? String)!;
            }
            
        }
    }

}


