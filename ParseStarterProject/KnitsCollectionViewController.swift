//
//  KnitsCollectionViewController.swift
//  EFMMenswear
//
//  Created by KEEVIN MITCHELL on 2/13/15.
//  Copyright (c) 2015 Parse. All rights reserved.
//

import UIKit
import Parse

class KnitsCollectionViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UIScrollViewDelegate, DownLoadedData {
    
//    let sectionInsets = UIEdgeInsets(top: 10.0, left: 10.0, bottom: 10.0, right: 10.0)
    
    let sectionInsets = UIEdgeInsets(top: 0.05, left: 0.05, bottom: 0.05, right: 0.05)
    
    let titles = ["Sand Harbor, Lake Tahoe - California","Beautiful View of Manhattan skyline.","Watcher in the Fog","Great Smoky Mountains Na"]
    var pClassName:String!
    
    var EFMImage = UIImage()
    
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    @IBOutlet weak var EFMCollectionView: UICollectionView!
    var efmKnitsResultsArray = [AnyObject]()
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
        static let EFMCellReuseIdentifier: String = "knitsCell "
         }

    
    func parseDataArray(sender: KeevParseDownloader) -> AnyObject?{
        
        efmKnitsResultsArray = sender.resultsArray
        self.EFMCollectionView.reloadData()
               return sender.resultsArray
    }
    func receiveDataStopSpinner(){
      println("the data is received")
        
    }
    
    func noDataShowError(){
      println("the data has an error")
        
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        EFMCollectionView.addPullToRefresh({ [weak self] in
            // some code
            sleep(1)
            self?.EFMCollectionView.reloadData()
        })
        navigationController!.navigationBar.barTintColor = UIColor.grayColor()
        tabBarController!.tabBar.barTintColor = UIColor.clearColor()
        tabBarController!.tabBar.tintColor = UIColor.redColor()
        self.title = "KNITS"
        EFMCollectionView.dataSource = self
        EFMCollectionView.delegate = self
        
        getTheData()
               }
    
    
    override func viewWillAppear(animated: Bool) {
        
      //spinner.startAnimating()
        
    }
    
    override func viewDidLayoutSubviews(){
        super.viewDidLayoutSubviews()
        
    }

    
    
    func animateTable() {
        EFMCollectionView.reloadData()
        
        let cells = EFMCollectionView.visibleCells()
        let tableHeight: CGFloat = EFMCollectionView.bounds.size.height
        
        for i in cells {
            let cell: KnitsCollectionViewCell = i as KnitsCollectionViewCell
            cell.transform = CGAffineTransformMakeTranslation(0, tableHeight)
        }
        
        var index = 0
        
        for a in cells {
            let cell: KnitsCollectionViewCell = a as KnitsCollectionViewCell
            UIView.animateWithDuration(1.5, delay: 0.05 * Double(index), usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: nil, animations: {
                cell.transform = CGAffineTransformMakeTranslation(0, 0);
                }, completion: nil)
            
            index += 1
        }
    }
    
//  }

    
    
    
    
    
    func getTheData(){
        
        let downloader: KeevParseDownloader = KeevParseDownloader(datasource: self)
        
        downloader.queryParseMethod("Knits")
        
        println(downloader.resultsArray)
        self.efmKnitsResultsArray = downloader.resultsArray
       // spinner.stopAnimating()
        self.EFMCollectionView.reloadData()        
        
    }
    
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        println("the count is : \(efmKnitsResultsArray.count)")
        return efmKnitsResultsArray.count
        
        
    }
    
    
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        
        
        let cell:KnitsCollectionViewCell = collectionView.dequeueReusableCellWithReuseIdentifier("knitsCell", forIndexPath:indexPath) as KnitsCollectionViewCell
        
        cell.layer.shouldRasterize = true //scrolling
        cell.layer.rasterizationScale = UIScreen.mainScreen().scale //scrolling
        
        cell.image = nil
        
        
        let queue:dispatch_queue_t = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
       
        dispatch_async(queue, { () -> Void in
            
            var error:NSError?
            
            let imageObject:PFObject = self.efmKnitsResultsArray[indexPath.row] as PFObject
            
            let imageFile:PFFile = imageObject.objectForKey("Image") as PFFile
            
            
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
            
            // EFMCollectionView.contentOffset.y = 3
            
            
        }
        
        
        
    
        
        
        
        
        
    }
    
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if(segue.identifier == "showDetail"){
            // check for / catch all visible cell(s)
            for item in EFMCollectionView!.visibleCells() as [KnitsCollectionViewCell] {
                
                let cell = sender as KnitsCollectionViewCell
                 if let indexPath = self.EFMCollectionView.indexPathForCell(cell){
                
                
                // Grab related PFObject
                var objectData:PFObject = self.efmKnitsResultsArray[indexPath.row] as PFObject
                
                // Pass PFObject to second ViewController
                let theDestination = (segue.destinationViewController as EFMDetailsViewController)
              theDestination.swag = objectData
                }
                if segue.identifier == "idFirstSegueUnwind" {
                    let firstViewController = segue.destinationViewController as KnitsCollectionViewController
                    
                    
                }
            }
        }
    }
    
  
    func collectionView(collectionView: UICollectionView!,
        layout collectionViewLayout: UICollectionViewLayout!,
        sizeForItemAtIndexPath indexPath: NSIndexPath!) -> CGSize {
//            return CGSize(width: 300, height :500)
            
           // return CGSize(width: EFMCollectionView.frame.width * 0.80, height :EFMCollectionView.frame.height * 0.80)
            return CGSize(width: EFMCollectionView.frame.width * 0.99, height :EFMCollectionView.frame.height * 0.99)
    }
    
    func collectionView(collectionView: UICollectionView!,
        layout collectionViewLayout: UICollectionViewLayout!,
        insetForSectionAtIndex section: Int) -> UIEdgeInsets {
            return sectionInsets
    }
    

    
   
    
}
