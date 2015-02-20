//
//  KeevParseDownloader.swift
//  EFMMenswear
//
//  Created by KEEVIN MITCHELL on 2/19/15.
//  Copyright (c) 2015 Parse. All rights reserved.
//

import Foundation
import Parse

class KeevParseDownloader: NSObject {
    
    struct resultsObject {
        
    
    }
    
    var resultsArray = [AnyObject]()
    
    func queryParseMethod(pClassName: String){
        let query = PFQuery(className: pClassName)
                query.findObjectsInBackgroundWithBlock {
            (objects: [AnyObject]!, error: NSError!) -> Void in
            if error == nil {
                
                NSLog("Successfully retrieved \(objects.count) scores.")
                // Do something with the found objects
                for object in objects {
               //     NSLog("%@", object.objectId)
                                    var  efmPhoto = EFMPhoto(efmImage: object.objectForKey(pClassName) as? PFFile,
                    
                    
                    efmTitle: object.objectForKey("Title") as String,
                    efmPrice: object.objectForKey("Price") as NSNumber,
                    efmDescription: object.objectForKey("Description") as String,
                    efmFeatures: object.objectForKey("FeaturesAndBenifits") as String)
                    
//                     NSLog(" The title is :%@", efmPhoto.efmTitle)
//                    NSLog(" The title is :%@", efmPhoto.efmPrice)
//                    NSLog(" The title is :%@", efmPhoto.efmDescription)
//                    NSLog(" The title is :%@", efmPhoto.efmFeatures)
                    
                    
                    
                    
                   self.resultsArray.append(efmPhoto)


                    
                    
                     NSLog("%@", self.resultsArray)
                }

                
            } else {
                // Log details of the failure
                NSLog("Error: %@ %@", error, error.userInfo!)
            }
        }
        
        
    }
    
    
    func searchFlickrForParseString(pClassName:String, completion:(pClassName:String!, parseData:NSMutableArray!, error:NSError!) ->()){
        
        let queue:dispatch_queue_t = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
                dispatch_async(queue, {
            
            
            var error:NSError?
            
                             
            if error != nil{
                
                completion(pClassName: pClassName, parseData: nil, error: error)
                
            }else{
                
                let parseData:NSMutableArray = NSMutableArray()
                
                let query = PFQuery(className: pClassName)
                query.findObjectsInBackgroundWithBlock {
                    (objects: [AnyObject]!, error: NSError!) -> Void in
                    if error == nil {
                        
                        NSLog("Successfully retrieved \(objects.count) scores.")
                       
                        for object in objects {
                            
                            //let photoDictionary:NSDictionary = object as NSDictionary
                            
                            var  efmPhoto = EFMPhoto(efmImage : object.objectForKey(pClassName) as? PFFile,
                                
                                
                                efmTitle : object.objectForKey("Title") as String,
                                efmPrice : object.objectForKey("Price") as NSNumber,
                                efmDescription: object.objectForKey("Description") as String,
                                efmFeatures: object.objectForKey("FeaturesAndBenifits") as String)
                            
                         
                            
                            
                            //                                                NSLog(" The title is :%@", efmPhoto.efmTitle)
//                                              NSLog(" The title is :%@", efmPhoto.efmPrice)
//                                                NSLog(" The title is :%@", efmPhoto.efmDescription)
//                                               NSLog(" The title is :%@", efmPhoto.efmFeatures)
                            
                            
                           //  NSLog("This are the objects :%@", efmPhoto)
                         //   self.resultsArray = Objects
                           self.resultsArray.append(efmPhoto)
                            parseData.addObject(efmPhoto)
//                            parseData.addObject(efmPhoto.efmPrice)
//                            parseData.addObject(efmPhoto.efmTitle)
//                            parseData.addObject(efmPhoto.efmDescription)
                           // parseData.addObject(efmPhoto.efmImage) as PFFile
                            
                          //  NSLog("This is the results array :%@", self.resultsArray)
                         //   let resultsDictionary:NSDictionary! = object as NSDictionary
                            
                            
                            
                        }
                       
                        
                    } else {
                        // Log details of the failure
                        NSLog("Error: %@ %@", error, error.userInfo!)
                    }

                
                
                        completion(pClassName: pClassName, parseData: parseData, error: nil)
                        
                        
                        
                    }
                    
                    
                }
                
                
                
                
            })
            
            
            
        }

        }



        
        
    
  