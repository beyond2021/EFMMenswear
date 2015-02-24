//
//  OuterwearDetailsVC.swift
//  EFMMenswear
//
//  Created by KEEVIN MITCHELL on 2/24/15.
//  Copyright (c) 2015 Parse. All rights reserved.
//

import UIKit
import Parse

class OuterwearDetailsVC: UIViewController {
    
    @IBOutlet weak var navBar: UINavigationBar!
    
    @IBOutlet weak var doneButton: UIBarButtonItem!
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBAction func DoneAction(sender: AnyObject) {
    }
    
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var priceLabel: UILabel!
    //  @IBOutlet weak var priceLabel: UILabel!
    
    @IBOutlet weak var efmImageView: UIImageView!
    
    @IBOutlet weak var applePayButtonLabel: UIButton!
    
    @IBOutlet weak var applePayButtonAction: UIButton!
    
    @IBOutlet weak var featureLabel: UILabel!
    
    
    
    var swag: PFObject! {
        didSet {
            // Update the view.
            println("The swag is set")
            
            
            self.configureView()
        }
    }
    
    func configureView() {
        
        if (!self.isViewLoaded()) {
            return
        }
        self.title = swag.objectForKey("Title") as String!
        let price = swag.objectForKey("Price") as NSNumber
        
        var priceString: NSString {
            let dollarFormatter: NSNumberFormatter = NSNumberFormatter()
            dollarFormatter.minimumFractionDigits = 2;
            dollarFormatter.maximumFractionDigits = 2;
            return dollarFormatter.stringFromNumber(price)!
            
            
            
        }
        
        
        
        self.priceLabel.text = "$" + priceString
        self.descriptionLabel.text = swag.objectForKey("Description") as String!
        self.featureLabel.text = swag.objectForKey("Features") as String!
        
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //  println("The freaking title is \(efmTitle)")
        
        self.configureView()
        
        
        //Getting the image
        efmImageView.image = nil
        
        
        let queue:dispatch_queue_t = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
        
        dispatch_async(queue, { () -> Void in
            
            var error:NSError?
            
            //let imageObject:PFObject = self.efmKnitsResultsArray[indexPath.row] as PFObject
            
            let imageFile:PFFile = self.swag.objectForKey("Image") as PFFile
            
            
            imageFile.getDataInBackgroundWithBlock({ (data: NSData!, error: NSError!) -> Void in
                
                let imageData:NSData = data
                
                let image:UIImage = UIImage(data: imageData)!
                
                
                dispatch_async(dispatch_get_main_queue(), {
                    
                    self.efmImageView.image = image
                    
                })
                
            })
        })
        
        
        
    }
    
    @IBAction func purchase(sender: UIButton) {
        // TODO: - Fill in implementation
    }


}
