//
//  SecondCustomSegue.swift
//  CustomSegues
//
//  Created by KEEVIN MITCHELL on 12/30/14.
//  Copyright (c) 2014 Beyond 2021. All rights reserved.
//

import UIKit

class SecondCustomSegue: UIStoryboardSegue {
    
    override func perform() {
        let firstVCView = sourceViewController.view as UIView!
        let thirdVCView = destinationViewController.view as UIView!
        
        
        let window = UIApplication.sharedApplication().keyWindow
        window?.insertSubview(thirdVCView, belowSubview: firstVCView)
        
        thirdVCView.transform = CGAffineTransformScale(thirdVCView.transform, 0.001, 0.001)
        //As you see, we scale down both its width and height. We don’t set these values to zero, as this would have no effect at all. A really small value though is good for our purposes
        
        
        UIView.animateWithDuration(0.5, animations: { () -> Void in
            firstVCView.transform = CGAffineTransformScale(thirdVCView.transform, 0.001, 0.001)
            
            }) { (Finished) -> Void in
                
                UIView.animateWithDuration(0.5, animations: { () -> Void in
                    thirdVCView.transform = CGAffineTransformIdentity
                    
                    }, completion: { (Finished) -> Void in
                        
                        firstVCView.transform = CGAffineTransformIdentity
                        self.sourceViewController.presentViewController(self.destinationViewController as UIViewController, animated: false, completion: nil)
                        
                        //When the first animation takes place, the first view becomes really small, and this looks like a zoom-out effect. In the completion handler, we begin a new animation where we revert the view of the destination view controller to its normal. Lastly, once this animation is over too, we bring the first view to its normal state, and we present without any further animation the third view controller.                        
                        
                })
        }
        
    }
}
