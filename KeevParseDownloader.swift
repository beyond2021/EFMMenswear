//
//  KeevParseDownloader.swift
//  EFMMenswear
//
//  Created by KEEVIN MITCHELL on 2/19/15.
//  Copyright (c) 2015 Parse. All rights reserved.
//

import Foundation
import Parse


protocol DownLoadedData: class  {
    func parseDataArray(sender: KeevParseDownloader) -> AnyObject?
    func receiveDataStopSpinner()
    func noDataShowError()
    
    
}

class KeevParseDownloader {
    
    struct resultsObject {
        
    
    }
    
    weak var  datasource: DownLoadedData?
       var resultsArray = [AnyObject]()
       init(datasource:DownLoadedData){
        self.datasource = datasource
                   }
    
    func queryParseMethod(pClassName: String){
        let query = PFQuery(className: pClassName)
        query.findObjectsInBackgroundWithBlock {
            (objects: [AnyObject]!, error: NSError!) -> Void in
            if error == nil {
                self.resultsArray = objects
                self.datasource!.parseDataArray(self)
                self.datasource!.receiveDataStopSpinner()
               // NSLog("Successfully retrieved \(objects.count) scores.")
                for object in objects {
                }
            } else {
                // Log details of the failure
                NSLog("Error: %@ %@", error, error.userInfo!)
                self.datasource!.noDataShowError()
            }
        }
        }
    }





  