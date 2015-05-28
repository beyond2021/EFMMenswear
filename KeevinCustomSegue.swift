//
//  KeevinCustomSegue.swift
//  EFMMenswear
//
//  Created by KEEVIN MITCHELL on 2/24/15.
//  Copyright (c) 2015 Parse. All rights reserved.
//

import UIKit


class KeevinCustomSegue: UIStoryboardSegue {
    override func perform() {
        // Assign the source and destination views to local variables.
        var firstVCView = self.sourceViewController.view as UIView!
        var secondVCView = self.destinationViewController.view as UIView!
        
       
        let screenWidth = UIScreen.mainScreen().bounds.size.width
        let screenHeight = UIScreen.mainScreen().bounds.size.height
        
        
        
        
        secondVCView.frame = CGRectMake(0.0, screenHeight, screenWidth, screenHeight)
        
        
              let window = UIApplication.sharedApplication().keyWindow
        window?.insertSubview(secondVCView, aboveSubview: firstVCView)
        
        
        UIView.animateWithDuration(0.4, delay: 0.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 3.0, options: UIViewAnimationOptions.CurveEaseInOut, animations: ({
            // do stuff
            firstVCView.frame = CGRectOffset(firstVCView.frame, 0.0, -screenHeight)
            secondVCView.frame = CGRectOffset(secondVCView.frame, 0.0, -screenHeight)
            
            
        }), completion: {
            (value: Bool) in
            self.sourceViewController.presentViewController(self.destinationViewController as! UIViewController,
                animated: false,
                completion: nil)
        })
        
        
        
    }
    

}
