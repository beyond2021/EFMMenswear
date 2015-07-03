//
//  FirstCustomSegueUnwind.swift
//  CustomSegues
//
//  Created by KEEVIN MITCHELL on 12/30/14.
//  Copyright (c) 2014 Beyond 2021. All rights reserved.
//
/*
When creating custom segues, it’s always necessary to implement both ways of navigation: From the source view controller to the destination, and back. It’s almost unlikely to build the one way only. Now that we have implemented the segue so it shows the second view controller animated in the fashion we desire, we must make the application capable of doing the exact opposing thing. The segue that performs the backward navigation, is called unwind segue.

To simply put it, an unwind segue is… a segue just like a normal one, but its configuration it’s a bit more complex. Certain steps are required to be done, but yet everything consists of a standard programming technique. Note two things:

An unwind segue usually comes in pair with a normal custom segue.
To make the unwind segue work we must override the perform method again, and apply any custom logic and animation we want or required by the app. However, the transitioning effect when navigating back to the source view controller doesn’t have to be the same to the normal segue’s.

The implementation of an unwind segue is parted from four steps. These are:

The creation of an IBAction method, which can optionally execute some code when the unwind segue is performed. This method can have any name you want, and it’s not mandatory to contain anything. It’s required though to be defined, even if it remains empty, so the unwind segue can be defined.
The unwind segue creation, and the configuration of its settings. It’s not exactly the same to what we did in the previous segue in the Interface Builder, but you’ll see in a while how it is done.
The implementation of the custom logic by overriding the perform method in a subclass of the UIStoryboardSegue class.
The definition of a specific method provided by the UIViewController class, so the system knows what the unwind segue that is about to be performed is.

You might find all these confusing at the moment, but as we’ll move forward you’ll perfectly get the meaning of everything.

Let’s get started by defining the IBAction method I mentioned in the first step above. This action method is always implemented in the initial view controller to which we want to navigate. As I said, the body of it can be empty, but you must constantly have in mind that you can’t proceed if you don’t define at least one such method. It’s not necessary to have as many such action methods as the unwind segues existing in your app. In most cases, simply defining one such action method and checking which the unwind segue that makes the call is, it is more than enough.
In action now, open the ViewController.swift file. There, add the following code:

*/

import UIKit

class FirstCustomSegueUnwind: UIStoryboardSegue {
    
    
    override func perform() {
        // Assign the source and destination views to local variables.
        let secondVCView = self.sourceViewController.view as UIView!
        let firstVCView = self.destinationViewController.view as UIView!
        
        let screenHeight = UIScreen.mainScreen().bounds.size.height
        //Notice that this time the source view controller is the Second View Controller, and the destination is the View Controller. Continuing, here we won’t specify the initial state of any view at all, we’ll just add the view of the first view controller (the one we want to return to) to the window’s subviews:
        
        let window = UIApplication.sharedApplication().keyWindow
        window?.insertSubview(firstVCView, aboveSubview: secondVCView)
        
        
        // Animate the transition.
        UIView.animateWithDuration(0.4, animations: { () -> Void in
            firstVCView.frame = CGRectOffset(firstVCView.frame, 0.0, screenHeight)
            secondVCView.frame = CGRectOffset(secondVCView.frame, 0.0, screenHeight)
            
            }) { (Finished) -> Void in
                
                self.sourceViewController.dismissViewControllerAnimated(false, completion: nil)
        }
//By changing the y-point (changing the offset in the Y axis) of both views, we manage to place them in their new positions within the predefined animation duration. When the transition is over, we just dismiss the second view controller without any other animation, and we’re over. Right next you’re given this method implemented in one piece:        
        
        
        
    }
    
    
   
}
