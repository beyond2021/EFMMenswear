//
//  MainView.swift
//  EFMMenswear
//
//  Created by KEEVIN MITCHELL on 3/2/15.
//  Copyright (c) 2015 Parse. All rights reserved.
//

import UIKit

class MainView: UIView {
    let applePayButton: UIButton!
    let descriptionLabel: UILabel!
    let featureLabel: UILabel!
    let priceLabel:UILabel!
    
    
    var descriptionString : String!
    var featureString : String!
    var priceString : String!
    
    
      init(applePayButton: UIButton!,  descriptionString : String!, featureString : String!, priceString : String!  ) {
        
        super.init(frame: CGRect(x: 0, y: 0, width: 400, height: 600))
        
        let image = UIImage(named: "ApplePaySwagButton") as UIImage?
        let applePayButton  = UIButton.buttonWithType(UIButtonType.Custom) as UIButton
        applePayButton.frame = CGRectMake(75, 560, 160, 34)
        applePayButton.setImage(image, forState: .Normal)
        
        
        applePayButton.setTitle("Buy With Apple Pay", forState: UIControlState.Normal)
        
         let descriptionLabel = UILabel(frame: CGRectMake(18, 90, 250, 40))
        descriptionLabel.numberOfLines = 0
        descriptionLabel.lineBreakMode = NSLineBreakMode.ByWordWrapping
        //        label.font = font
               descriptionLabel.text = descriptionString
        
                descriptionLabel.textAlignment = .Left
        
                descriptionLabel.textColor = UIColor.whiteColor()
                descriptionLabel.shadowColor = UIColor.blackColor()
                descriptionLabel.font = UIFont(name: "HelveticaNeue", size: CGFloat(14))
        
        
        
        descriptionLabel.sizeToFit()
        
        
        let featureLabel = UILabel(frame: CGRectMake(18, 280, 250, 60))
        featureLabel.numberOfLines = 0
        featureLabel.lineBreakMode = NSLineBreakMode.ByWordWrapping
        featureLabel.textAlignment = NSTextAlignment.Left
                featureLabel.textAlignment = .Left
        featureLabel.text = featureString
        
                featureLabel.textColor = UIColor.whiteColor()
                featureLabel.shadowColor = UIColor.blackColor()
                featureLabel.font = UIFont(name: "HelveticaNeue", size: CGFloat(14))
        
        featureLabel.sizeToFit()
        
        let priceLabel = UILabel(frame: CGRectMake(100, 520, 260, 60))
        priceLabel.textAlignment = NSTextAlignment.Left
        priceLabel.textAlignment = .Left
        priceLabel.text = priceString
        
        priceLabel.textColor = UIColor.redColor()
        priceLabel.shadowColor = UIColor.blackColor()
        priceLabel.font = UIFont(name: "HelveticaNeue", size: CGFloat(22))
        priceLabel.sizeToFit()
        
       // priceLabel.center = self.center
        
        
        self.addSubview(featureLabel)
        self.addSubview(descriptionLabel)
        
        self.addSubview(applePayButton)
        self.addSubview(priceLabel)
             self.backgroundColor = UIColor.clearColor()
        
        
    }

    
    
    
    
    
//    var s: String?
//    var i: Int?
//    init(s: String, i: Int) {
//        self.s = s
//        self.i = i
//        super.init(frame: CGRect(x: 0, y: 0, width: 400, height: 900))
//        self.backgroundColor = UIColor.redColor()
//        
//        
//    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func awakeFromNib()
    {
//        var cropButtons : UIButton = UIButton(frame: CGRectMake(70, 150, 160 , 158))
//        cropButtons.setTitle("Crop Image", forState: UIControlState.Normal)
//        cropButtons.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
//        self.addSubview(cropButtons)
        
    }
    
    
    

    
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
