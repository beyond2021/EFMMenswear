//
//  EFMSwViewController.swift
//  EFMMenswear
//
//  Created by KEEVIN MITCHELL on 2/24/15.
//  Copyright (c) 2015 Parse. All rights reserved.
//

import UIKit
import Parse

class EFMSwViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UIScrollViewDelegate, DownLoadedData {
    
    var pClassName:String!
    
    var EFMImage = UIImage()
    
    // var pHoto = EFMPhoto()
    // var downloader = KeevParseDownloader?()
    
    
    @IBOutlet weak var EFMCollectionView: UICollectionView!
    
    var efmSweaterResultsArray = [AnyObject]()
    
    var ourArray = [AnyObject]()
    
    
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
    
    private struct CollectConstants {
        static let efmViewsWide: CGFloat = 10
        static let efmViewsMargin: CGFloat = 2.0
        static let EFMCellReuseIdentifier: String = "Sweaters "
        
    }
    
    
    func parseDataArray(sender: KeevParseDownloader) -> AnyObject?{
        //  println("Our result is :\(sender.resultsArray)")
        efmSweaterResultsArray = sender.resultsArray
        self.EFMCollectionView.reloadData()
        
        
        
        
        
        
        
        return sender.resultsArray
    }
    func receiveDataStopSpinner(){
        
    }
    func noDataShowError(){
        
        
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Sweaters"
        
        //self.navigationController?.navigationBarHidden = true;
        EFMCollectionView.dataSource = self
        EFMCollectionView.delegate = self
        //loadPhotos()
        // queryParseMethod()
        
        getTheData()
        
        
    }
    
    func getTheData(){
        
        let downloader: KeevParseDownloader = KeevParseDownloader(datasource: self)
        
        downloader.queryParseMethod("Sweaters")
        
        println(downloader.resultsArray)
        self.efmSweaterResultsArray = downloader.resultsArray
        self.EFMCollectionView.reloadData()
        
    }
    
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
       // println("the count is : \(efmKnitsResultsArray.count)")
        return efmSweaterResultsArray.count
        
        
    }
    
    
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        
        
        let cell:KnitsCollectionViewCell = collectionView.dequeueReusableCellWithReuseIdentifier("knitsCell", forIndexPath:indexPath) as! KnitsCollectionViewCell
        
        cell.layer.shouldRasterize = true //scrolling
        cell.layer.rasterizationScale = UIScreen.mainScreen().scale //scrolling
        
        cell.image = nil
        
        
        let queue:dispatch_queue_t = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
        
        dispatch_async(queue, { () -> Void in
            
            var error:NSError?
            
            let imageObject:PFObject = self.efmSweaterResultsArray[indexPath.row] as! PFObject
            
            let imageFile:PFFile = imageObject.objectForKey("Image") as! PFFile
            
            
            imageFile.getDataInBackgroundWithBlock({ (data: NSData?, error: NSError?) -> Void in
                
                let imageData:NSData = data!
                
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
            
            var view:KnitsCollectionViewCell = view as! KnitsCollectionViewCell
            
            var yOffset:CGFloat = ((EFMCollectionView.contentOffset.y - view.frame.origin.y) / 200) * 25
            view.setImageOffset(CGPointMake(0, yOffset))
            
            
            
        }
        
        
    }
    
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier == "sweaterSegue"){
            // check for / catch all visible cell(s)
            for item in EFMCollectionView!.visibleCells() as! [KnitsCollectionViewCell] {
                
                let cell = sender as! KnitsCollectionViewCell
                if let indexPath = self.EFMCollectionView.indexPathForCell(cell){
                    
                    
                    // Grab related PFObject
                    var objectData:PFObject = self.efmSweaterResultsArray[indexPath.row] as! PFObject
                    
                    // Pass PFObject to second ViewController
                    let theDestination = (segue.destinationViewController as! SeaterDetailsVC)
                    theDestination.swag = objectData
                }
            }
        }
    }
    
    
    
      
    
}
