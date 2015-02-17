//
//  EFMDownLoader.swift
//  EFMMenswear
//
//  Created by KEEVIN MITCHELL on 2/15/15.
//  Copyright (c) 2015 Parse. All rights reserved.
//

import Foundation
import Parse

class EFMDownLoader: NSObject {
    
    func searchDatabase(department:String, completion:(department:String!, efmResults:NSMutableArray!, error:NSError!) ->()){
        
        
//        let queue:dispatch_queue_t = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
//        //Next dispatch asyncronously our que with the main thread
//        dispatch_async(queue, {
        
        let query = PFQuery(className: department)
        query.findObjectsInBackgroundWithBlock {
            (objects: [AnyObject]!, error: NSError!) -> Void in
            if error == nil {
                // The find succeeded.
                NSLog("Successfully retrieved \(objects.count) scores.")
                // Do something with the found objects
                for object in objects {
                    NSLog("This is the found result %@", object.objectId)
                   // let photoArray:NSData = objects[KnitsImage] as NSData
                //   let resultsDictionary:NSDictionary = object as NSDictionary
                    
                    
                    var efmPhoto:KnitPhoto = KnitPhoto()
                    //efmPhoto = object as KnitPhoto
                    
                    
                    
                    efmPhoto.efmDescription = object.objectForKey("Description") as String
                    efmPhoto.efmTitle = object.objectForKey("Title") as String
                    efmPhoto.efmFeatures = object.objectForKey("FeaturesAndBenifits") as String
                    efmPhoto.efmPrice = object.objectForKey("Price") as Double
                
                }
                completion(department: department, efmResults: nil, error: error)
                
            } else {
                // Log details of the failure
                NSLog("Error: %@ %@", error, error.userInfo!)
                completion(department: department, efmResults: nil, error: error)
            }
        }
      
    // })
            
    }
            
}
