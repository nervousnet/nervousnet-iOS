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
        super.viewWillAppear(true)
      /*
        CGRect frame = self.collectionView.frame;
        frame.size.width = 150;
        self.collectionView.frame = frame;
        */
        self.collectionView?.reloadData()
        self.navigationController?.navigationBar.viewWithTag(97)?.hidden = false


    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.viewWithTag(97)?.hidden = false
    }

    
    
    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if(section == 0){
            print("can display cells: ")
            print(getNumberOfCellsDisplayable())
            return getNumberOfCellsDisplayable()
        }else if(section == 1){
            return 0
        }else{
            return 0
        }
    
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! MainCVCellCollectionViewCell
        

        
        let screenSize = UIScreen.mainScreen().bounds
        let screenWidth = screenSize.width
        let screenHeight = screenSize.height
        
        cell.backgroundColor = UIColor.orangeColor()
        cell.layer.borderWidth = 10
        cell.layer.borderColor = UIColor.clearColor().CGColor
        cell.frame.size.width = (screenWidth / 2 ) - 20
        cell.frame.size.height = (screenWidth / 2 ) - 20
        
        
        
        if(indexPath.section == 0){
        
            cell.imageView.image = getImageForCell(indexPath)
            cell.textLabel.text = getTextForCell(indexPath)
            
        }else if(indexPath.section == 1){
            
            cell.textLabel.text = "Get Axons"

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


