//
//  KnitsCollectionViewController.swift
//  EFMMenswear
//
//  Created by KEEVIN MITCHELL on 2/13/15.
//  Copyright (c) 2015 Parse. All rights reserved.
//

import UIKit
import Parse

class KnitsCollectionViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UIScrollViewDelegate {
    @IBOutlet weak var EFMCollectionView: UICollectionView!
 
     var efmKnitsResultsArray = [AnyObject]()
    
    
    var imageFilesArray:NSMutableArray! = NSMutableArray()
    var imageArray:NSMutableArray! = NSMutableArray()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.navigationController?.navigationBarHidden = true;
        EFMCollectionView.dataSource = self
        EFMCollectionView.delegate = self
      //  loadPhotos()
        queryParseMethod()
          }
    
    
    
    func queryParseMethod(){
        let query = PFQuery(className: "Knits")
        
        
        query.findObjectsInBackgroundWithBlock {
            (objects: [AnyObject]!, error: NSError!) -> Void in
            if error == nil {
                
                self.efmKnitsResultsArray = objects as Array
                
                self.EFMCollectionView.reloadData()
               
                NSLog("Successfully retrieved \(objects.count) scores.")
                // Do something with the found objects
                for object in objects {
                    NSLog("%@", object.objectId)
                    
                    
                    
                    var efmPhoto:KnitPhoto = KnitPhoto()
                    //efmPhoto = object as KnitPhoto
                    
                    
                    
                    efmPhoto.efmDescription = object.objectForKey("Description") as String
                    efmPhoto.efmTitle = object.objectForKey("Title") as String
                    efmPhoto.efmFeatures = object.objectForKey("FeaturesAndBenifits") as String
                    efmPhoto.efmPrice = object.objectForKey("Price") as Double

                    
                 //   self.efmKnitsResultsArray.addObject(object)
                    
                    
                }
            } else {
                // Log details of the failure
                NSLog("Error: %@ %@", error, error.userInfo!)
            }
        }
        
        
    }
    
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return efmKnitsResultsArray.count
        
        
    }
    
    
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        
        
        let cell:KnitsCollectionViewCell = collectionView.dequeueReusableCellWithReuseIdentifier("knitsCell", forIndexPath:indexPath) as KnitsCollectionViewCell
        
        
        cell.image = nil
        
        
        let queue:dispatch_queue_t = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
       
        dispatch_async(queue, { () -> Void in
            
            var error:NSError?
            
            let imageObject:PFObject = self.efmKnitsResultsArray[indexPath.row] as PFObject
            
            let imageFile:PFFile = imageObject.objectForKey("knitImage") as PFFile
            
            
            imageFile.getDataInBackgroundWithBlock({ (data: NSData!, error: NSError!) -> Void in
                
            let imageData:NSData = data
                
            let image:UIImage = UIImage(data: imageData)!
            
            
            dispatch_async(dispatch_get_main_queue(), {
                
                cell.image = image
                
                
                
                let yOffset:CGFloat = ((collectionView.contentOffset.y - cell.frame.origin.y) / 200) * 5
                
                cell.imageOffset = CGPointMake(0, yOffset)
                
                
            })
            
        })
             })
        return cell
    }
    
    //WE need this scrollview delegate method for the cell parallax
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        // here we got through all the views in the collect and set the offset
        for view in EFMCollectionView.visibleCells(){
            //next we say that each view is a collectionView cell
            var view:KnitsCollectionViewCell = view as KnitsCollectionViewCell
            
            // next we set the y offset. yje collection view content offset in the y direction minus view . fram.origin in the Y direction divided by the height of the imageview minus 25
            
            
            var yOffset:CGFloat = ((EFMCollectionView.contentOffset.y - view.frame.origin.y) / 200) * 25
            view.setImageOffset(CGPointMake(0, yOffset))
            
            
            
        }
        
        
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        //
    }
    
    /*
    func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
        let headerView:EFMCollectionViewHeaderView = collectionView.dequeueReusableSupplementaryViewOfKind(UICollectionElementKindSectionHeader, withReuseIdentifier: "EFMCollectionViewHeaderView", forIndexPath: self.efmKnitsResultsArray[indexPath.section] as NSIndexPath) as EFMCollectionViewHeaderView
        
        return headerView
    }
*/
    
    func setupBackButton(){
        
        
    }
    


}
