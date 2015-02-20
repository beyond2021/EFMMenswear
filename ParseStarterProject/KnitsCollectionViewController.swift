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
    
    var pClassName:String!
    
    var EFMImage = UIImage()
   // var downloader = KeevParseDownloader?()
    
    
    @IBOutlet weak var EFMCollectionView: UICollectionView!
 
     var efmKnitsResultsArray = [AnyObject]()
    
    
   
    var largePhotoIndexPath : NSIndexPath? {
        didSet {
            //2
            var indexPaths = [NSIndexPath]()
            if largePhotoIndexPath != nil {
                indexPaths.append(largePhotoIndexPath!)
            }
            if oldValue != nil {
                indexPaths.append(oldValue!)
            }
            //3
            EFMCollectionView.performBatchUpdates({
                self.EFMCollectionView.reloadItemsAtIndexPaths(indexPaths)
                return
                }){
                    completed in
                    //4
                    if self.largePhotoIndexPath != nil {
                        self.EFMCollectionView.scrollToItemAtIndexPath(
                            self.largePhotoIndexPath!,
                            atScrollPosition: .CenteredVertically,
                            animated: true)
                    }
            }
        }
    }

    
    
    
    
    
    var imageFilesArray:NSMutableArray! = NSMutableArray()
    var imageArray:NSMutableArray! = NSMutableArray()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "KNITS"
        
        //self.navigationController?.navigationBarHidden = true;
        EFMCollectionView.dataSource = self
        EFMCollectionView.delegate = self
        //loadPhotos()
        queryParseMethod()
        
       // getTheData()
        
          }
    
    func getTheData(){
        
        let downloader: KeevParseDownloader = KeevParseDownloader()
        
        downloader.queryParseMethod("Knits")
        
        println(downloader.resultsArray)
        self.efmKnitsResultsArray = downloader.resultsArray
        self.EFMCollectionView.reloadData()        
        
    }
    
    func loadPhotos(){
        
        let downloader: KeevParseDownloader = KeevParseDownloader()
        
        pClassName = "Knits"
        
        downloader.searchFlickrForParseString(pClassName, completion: {(pClassName:String!, parseData:NSMutableArray!, error:NSError!) ->() in
            
            if error == nil{
                
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    
                    self.efmKnitsResultsArray = parseData
                    self.EFMCollectionView.reloadData()
                    downloader.description
                    
                  //  println("Parse data is : \(downloader.efmPrice)") as NSNumber
                    
                })
            }
            
        })
        
    }
    

    
    
    
    
    
    
    func queryParseMethod(){
        let query = PFQuery(className: "Knits")
        
        
        query.findObjectsInBackgroundWithBlock {
            (objects: [AnyObject]!, error: NSError!) -> Void in
            if error == nil {
                
                self.efmKnitsResultsArray = objects as Array
                
                self.EFMCollectionView.reloadData()
                               
               
                /*
               
                NSLog("Successfully retrieved \(objects.count) scores.")
                // Do something with the found objects
                for object in objects {
                    NSLog("%@", object.objectId)
                    
                    
                    
                   let  efmPhoto = EFMPhoto(image: UIImage?(), efmTitle: String(), efmPrice: NSDecimalNumber(), deliveryType: DeliveryType(), efmDescription: String(), efmFeatures: String())
                    //efmPhoto = object as KnitPhoto
                    
                    
                    
                    efmPhoto.efmDescription = object.objectForKey("Description") as String
                    efmPhoto.efmTitle = object.objectForKey("Title") as String
                    efmPhoto.efmFeatures = object.objectForKey("FeaturesAndBenifits") as String
                    efmPhoto.efmPrice = object.objectForKey("Price") as Double

                    
                 //   self.efmKnitsResultsArray.addObject(object)
                    
                    
                }
*/

            } else {
                // Log details of the failure
                NSLog("Error: %@ %@", error, error.userInfo!)
            }
        }
        
        
    }
    
    
    
    
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        println("the count is : \(efmKnitsResultsArray.count)")
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
                
            //let image:UIImage = UIImage(data: imageData)!
                self.EFMImage = UIImage(data: imageData)!
            
            
            dispatch_async(dispatch_get_main_queue(), {
                
               // cell.image = image
                cell.image = self.EFMImage
                
                
                let yOffset:CGFloat = ((collectionView.contentOffset.y - cell.frame.origin.y) / 200) * 5
                
                cell.imageOffset = CGPointMake(0, yOffset)
                
                
            })
            
        })
             })
        return cell
    }
    
   
    
    
  
    func scrollViewDidScroll(scrollView: UIScrollView) {
        
        for view in EFMCollectionView.visibleCells(){
            
            var view:KnitsCollectionViewCell = view as KnitsCollectionViewCell
            
            var yOffset:CGFloat = ((EFMCollectionView.contentOffset.y - view.frame.origin.y) / 200) * 25
            view.setImageOffset(CGPointMake(0, yOffset))
            
            
            
        }
        
        
    }

    
    /*
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if let identifier = segue.identifier{
            switch identifier{
                
            case "showDetail":
                if let vc = segue.destinationViewController as? EFMDetailsViewController{
                    // vc.property1 =
                    // vc. callMethodToSetUp(...;)
                    // let create a new  MVC
                    // Call Methods and set properties.
                    // The outlets have NOT been set yet.
                   
                    
                }
            default: break
                
            }
            
            
        }
        
        
    }
*/
    
    
    
    /*
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
       
        
        let newVC = EFMDetailsViewController()
        newVC.efmImageView.image = EFMImage
        
        let imageObject:PFObject = self.efmKnitsResultsArray[indexPath.row] as PFObject
        
       
        
       
    }
*/
    
    
    
    /*
   
    func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
        let headerView:EFMCollectionViewHeaderView = collectionView.dequeueReusableSupplementaryViewOfKind(UICollectionElementKindSectionHeader, withReuseIdentifier: "EFMCollectionViewHeaderView", forIndexPath: self.efmKnitsResultsArray[indexPath.section] as NSIndexPath) as EFMCollectionViewHeaderView
        
        return headerView
    }
*/
    
    /*

    func collectionView(collectionView: UICollectionView,
        viewForSupplementaryElementOfKind kind: String,
        atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
            //1
            switch kind {
                //2
            case UICollectionElementKindSectionHeader:
                //3
                let headerView =
                collectionView.dequeueReusableSupplementaryViewOfKind(kind,
                    withReuseIdentifier: "EFMCollectionViewHeaderView",
                    forIndexPath: indexPath)
                    as EFMCollectionViewHeaderView
                headerView.backButton.addTarget(self, action: "back", forControlEvents: UIControlEvents.TouchUpInside)
                
             //   headerView.label.text = searches[indexPath.section].searchTerm
                return headerView
            default:
                //4
                assert(false, "Unexpected element kind")
            }
    }*/
    func back(){
        println("back button was pressed")
        
    }
    
    


}
