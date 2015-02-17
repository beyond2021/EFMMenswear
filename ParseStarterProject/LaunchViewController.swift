//
//  LaunchViewController.swift
//  EFMMenswear
//
//  Created by KEEVIN MITCHELL on 2/12/15.
//  Copyright (c) 2015 Parse. All rights reserved.
//

import UIKit

let appearance = UITabBarItem.appearance()


class LaunchViewController: UIViewController, UINavigationControllerDelegate {
    
    var knitsButton = UIButton()
    var outerwearButton = UIButton()
    var sweaterButton = UIButton()
    var trouserButton = UIButton()
    var shopOnlineButton = UIButton()
    var websiteButton = UIButton()
    
    let websiteButtonWidth: CGFloat = 100
    var url = NSURL()
    
    var timer = NSTimer()
    
    private struct EFMConstants {
        static let webSiteUrl: String = "http:efmmenswear.com/"
    }
    
    @IBOutlet weak var launchImageView: UIImageView!
    var alertView: UIView!
    
    func createView() {
        
       // appearance.selectedImage = UIImage(named: "first-selected")!.imageWithRenderingMode(.AlwaysOriginal)
       
        
        // Create a red view
        let alertWidth: CGFloat = view.bounds.width
        let alertHeight: CGFloat = view.bounds.height
        let alertViewFrame: CGRect = CGRectMake(0, 0, alertWidth, alertHeight)
        alertView = UIView(frame: alertViewFrame)
        alertView.backgroundColor = UIColor.redColor()
        
        // Create an image view and add it to this view
        let imageView = UIImageView(frame: CGRectMake(0, 0, alertWidth, alertHeight))
        imageView.image = UIImage(named: "EFM_Launch.jpg")
        imageView.contentMode =  .ScaleAspectFill
        alertView.addSubview(imageView)
        
        // Create a button and set a listener on it for when it is tapped. Then the button is added to the alert view
        let button = UIButton.buttonWithType(UIButtonType.Custom) as UIButton
        button.setTitle("Dismiss", forState: UIControlState.Normal)
        button.backgroundColor = UIColor.clearColor()
        let buttonWidth: CGFloat = alertWidth/2
        let buttonHeight: CGFloat = 40
        button.frame = CGRectMake(alertView.center.x - buttonWidth/2, alertView.center.y - buttonHeight/2, buttonWidth, buttonHeight)
        
        button.addTarget(self, action: Selector("dismissAlert"), forControlEvents: UIControlEvents.TouchUpInside)
        
        
        knitsButton = UIButton.buttonWithType(UIButtonType.Custom) as UIButton
        knitsButton.setTitleColor(UIColor.lightGrayColor(), forState: UIControlState.Normal)
        knitsButton.setTitleColor(UIColor.redColor(), forState: UIControlState.Highlighted)
        knitsButton.titleLabel!.font =  UIFont(name: "HelveticaNeue-UltraLight", size: 30)
        
        
        knitsButton.setTitle("Knits", forState: UIControlState.Normal)
        knitsButton.backgroundColor = UIColor.clearColor()
        
        
        
        knitsButton.frame = CGRectMake(alertView.center.x - buttonWidth/2, alertView.center.y - buttonHeight/2 , buttonWidth, buttonHeight)
        
        knitsButton.addTarget(self, action: Selector("knits"), forControlEvents: UIControlEvents.TouchUpInside)
        
        outerwearButton = UIButton.buttonWithType(UIButtonType.Custom) as UIButton
        outerwearButton.titleLabel!.font =  UIFont(name: "HelveticaNeue-UltraLight", size: 30)
        outerwearButton.setTitle("Outerwear", forState: UIControlState.Normal)
        outerwearButton.backgroundColor = UIColor.clearColor()
        outerwearButton.setTitleColor(UIColor.lightGrayColor(), forState: UIControlState.Normal)
        outerwearButton.setTitleColor(UIColor.redColor(), forState: UIControlState.Highlighted)
        let outerwearButtonWidth: CGFloat = alertWidth/2
        let outerwearButtonHeight: CGFloat = 40
        outerwearButton.frame = CGRectMake(alertView.center.x - outerwearButtonWidth/2, alertView.center.y - outerwearButtonHeight/2 + 50, outerwearButtonWidth, outerwearButtonHeight)
        
        outerwearButton.addTarget(self, action: Selector("dismissAlert"), forControlEvents: UIControlEvents.TouchUpInside)
        
        
        sweaterButton = UIButton.buttonWithType(UIButtonType.Custom) as UIButton
        sweaterButton.titleLabel!.font =  UIFont(name: "HelveticaNeue-UltraLight", size: 30)
        sweaterButton.setTitle("Sweaters", forState: UIControlState.Normal)
        sweaterButton.backgroundColor = UIColor.clearColor()
        sweaterButton.setTitleColor(UIColor.lightGrayColor(), forState: UIControlState.Normal)
        sweaterButton.setTitleColor(UIColor.redColor(), forState: UIControlState.Highlighted)
        sweaterButton.frame = CGRectMake(alertView.center.x - buttonWidth/2, alertView.center.y - buttonHeight/2 + 100, buttonWidth, buttonHeight)
        
        sweaterButton.addTarget(self, action: Selector("dismissAlert"), forControlEvents: UIControlEvents.TouchUpInside)
        
        
        trouserButton = UIButton.buttonWithType(UIButtonType.Custom) as UIButton
        trouserButton.titleLabel!.font =  UIFont(name: "HelveticaNeue-UltraLight", size: 30)
        trouserButton.setTitle("Trousers", forState: UIControlState.Normal)
        trouserButton.backgroundColor = UIColor.clearColor()
        trouserButton.setTitleColor(UIColor.lightGrayColor(), forState: UIControlState.Normal)
        trouserButton.setTitleColor(UIColor.redColor(), forState: UIControlState.Highlighted)
        trouserButton.frame = CGRectMake(alertView.center.x - buttonWidth/2, alertView.center.y - buttonHeight/2 + 150, buttonWidth, buttonHeight)
        
        trouserButton.addTarget(self, action: Selector("dismissAlert"), forControlEvents: UIControlEvents.TouchUpInside)
        
        shopOnlineButton = UIButton.buttonWithType(UIButtonType.Custom) as UIButton
        shopOnlineButton.titleLabel!.font =  UIFont(name: "HelveticaNeue-UltraLight", size: 30)
        shopOnlineButton.setTitle("ShopOnline", forState: UIControlState.Normal)
        shopOnlineButton.backgroundColor = UIColor.clearColor()
        shopOnlineButton.setTitleColor(UIColor.lightGrayColor(), forState: UIControlState.Normal)
        shopOnlineButton.setTitleColor(UIColor.redColor(), forState: UIControlState.Highlighted)
        shopOnlineButton.frame = CGRectMake(alertView.center.x - buttonWidth/2, alertView.center.y - buttonHeight/2 + 200, buttonWidth, buttonHeight)
        
        shopOnlineButton.addTarget(self, action: Selector("dismissAlert"), forControlEvents: UIControlEvents.TouchUpInside)
        
        let image = UIImage(named: "EFMLOGO.jpg") as UIImage!
        websiteButton = UIButton.buttonWithType(UIButtonType.Custom) as UIButton
       // websiteButton.setTitle("Website", forState: UIControlState.Normal)
        websiteButton.setImage(image, forState: .Normal)
            websiteButton.backgroundColor = UIColor.clearColor()
        websiteButton.setNeedsLayout()
        websiteButton.setTitleColor(UIColor.lightGrayColor(), forState: UIControlState.Normal)
        websiteButton.setTitleColor(UIColor.redColor(), forState: UIControlState.Highlighted)
        websiteButton.frame = CGRectMake(alertView.center.x + buttonWidth/4, alertView.center.y - buttonHeight - 220, websiteButtonWidth, buttonHeight)
        
        websiteButton.addTarget(self, action: Selector("webSite"), forControlEvents: UIControlEvents.TouchUpInside)
        
        
        
        
        
        
        //When we created the button, we added a listener to it. When the button is tapped, dismissAlert() is called.
        
        //  alertView.addSubview(button)
        alertView.addSubview(knitsButton)
        alertView.addSubview(sweaterButton)
        alertView.addSubview(outerwearButton)
        alertView.addSubview(trouserButton)
        alertView.addSubview(shopOnlineButton)
        alertView.addSubview(websiteButton)
        
        view.addSubview(alertView)
    }
    
    func dismissAlert() {
        /*
        In the below, we create frames that represent what we want for the two stages of animating the view. smallFrame shrinks to half the size of alertView, maintaining the center point and finalFrame has a position at the bottom of the screen, out of view.
        
        We use a Keyframe animation with two keyframes. The first sets alertView’s frame to smallFrame and the second to finalFrame. The result will be that the alertView will shrink to half its size and then fall out of view. Notice I have put such a large number for the duration – 4 seconds. You can change this, I just wanted the animation running in slow-motion for the demo
        
        */
        
        let bounds = alertView.bounds
        let smallFrame = CGRectInset(alertView.frame, alertView.frame.size.width / 4, alertView.frame.size.height / 4)
        let finalFrame = CGRectOffset(smallFrame, 0, bounds.size.height)
        
        let snapshot = alertView.snapshotViewAfterScreenUpdates(false)
        snapshot.frame = alertView.frame
        view.addSubview(snapshot)
        alertView.removeFromSuperview()
        
        /*
        The animation isn’t quite what we expected. You can see the red alertView animate as expected, but the scale of its children doesn’t change. Changing the parent’s frame, doesn’t automatically change its children’s frames.
        
        We’ll use a feature introduced in iOS 7 called UIView snapshots to fix the animation. This allows you to take a snapshot of a UIView together with its hierarchy and render it into a new UIView.
        */
        
        
        //        UIView.animateKeyframesWithDuration(4, delay: 0, options: .CalculationModeCubic, animations: {
        //
        //            UIView.addKeyframeWithRelativeStartTime(0.0, relativeDuration: 0.5) {
        //                self.alertView.frame = smallFrame
        //            }
        //
        //            UIView.addKeyframeWithRelativeStartTime(0.5, relativeDuration: 0.5) {
        //                self.alertView.frame = finalFrame
        //            }
        //            }, completion: nil)
        UIView.animateKeyframesWithDuration(4, delay: 0, options: .CalculationModeCubic, animations: {
            UIView.addKeyframeWithRelativeStartTime(0.0, relativeDuration: 0.5) {
                snapshot.frame = smallFrame
            }
            UIView.addKeyframeWithRelativeStartTime(0.5, relativeDuration: 0.5) {
                snapshot.frame = finalFrame
            }
            }, completion: nil)
        
        
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
         self.navigationController?.navigationBarHidden = true;
        
      
        
        createView()
        
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return navigationController?.navigationBarHidden == true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if let identifier = segue.identifier{
            switch identifier{
                
                case "showKnits":
                    if let vc = segue.destinationViewController as? KnitsCollectionViewController{
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
    func knits(){
         dismissAlert()
        //self.performSegueWithIdentifier("showKnits", sender: self )
        timer = NSTimer.scheduledTimerWithTimeInterval(0.9, target: self, selector: Selector("newVC"), userInfo: nil, repeats: true)
    }
    func webSite(){
        dismissAlert()
        UIApplication.sharedApplication().openURL(NSURL(string: EFMConstants.webSiteUrl)!)
        
    }
    func newVC(){
       self.performSegueWithIdentifier("showKnits", sender: self )
        
    }
    
}




    


