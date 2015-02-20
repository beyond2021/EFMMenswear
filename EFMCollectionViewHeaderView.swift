//
//  EFMCollectionViewHeaderView.swift
//  EFMMenswear
//
//  Created by KEEVIN MITCHELL on 2/16/15.
//  Copyright (c) 2015 Parse. All rights reserved.
//

import UIKit


class EFMCollectionViewHeaderView: UICollectionReusableView {
    
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var backGroundImageView: UIImageView!
    
    var highLighted = false
    var defaultPadding :UIEdgeInsets{
        set{
            if UIEdgeInsetsEqualToEdgeInsets(defaultPadding, padding){
               // return
                padding = defaultPadding
                self.setNeedsDisplay()
                return
            }
            
        }
        get{
       return UIEdgeInsetsZero
        }
    }
    
    
    var padding = UIEdgeInsets(top: 0,left: 0,bottom: 0,right: 0)
    //var pinned = true
    var backgroundColorWhenPinned = UIColor.darkGrayColor()
    var bottomBorderColor = UIColor.clearColor()
    
    private var pinned = true
    var bottomBorderCollorBeforePinning = UIColor.darkGrayColor()
    
    
    override func applyLayoutAttributes(layoutAttributes:UICollectionViewLayoutAttributes){
        //if layoutAttributes.isKindOfClass(<#aClass: AnyClass#>)
      //  self.hidden = false
     //   self.userInteractionEnabled = true
    //    self.padding = self.defaultPadding
        
        
        
    }
    override init(frame: CGRect) {
        
        bottomBorderColor = UIColor.darkGrayColor()
        backgroundColorWhenPinned = UIColor.lightGrayColor()
        
        //var constraints = NSMutableArray()
        super.init()
        backgroundColor = UIColor.clearColor()
          }

    required init(coder aDecoder: NSCoder) {
        //fatalError("init(coder:) has not been implemented")
        super.init(coder: aDecoder)
    }
    
     override func prepareForReuse() {
        pinned = false
        bottomBorderColor = UIColor.clearColor()
        backgroundColorWhenPinned = UIColor.darkGrayColor()
        
    }
    
    
    
    
}
