//
//  KnitsCollectionViewCell.swift
//  EFMMenswear
//
//  Created by KEEVIN MITCHELL on 2/15/15.
//  Copyright (c) 2015 Parse. All rights reserved.
//

import UIKit

class KnitsCollectionViewCell: UICollectionViewCell {
    
    var imageView:UIImageView!
    
    
    var image:UIImage!{
        get{
            return self.image
        }
        set{
            self.imageView.image = newValue
            if imageOffset != nil{
                setImageOffset(imageOffset)
            } else
            {
                setImageOffset(CGPointMake(0, 0))
            }
                }
            }
    
    var imageOffset:CGPoint!
    
    
    override init(frame:CGRect){
        super.init(frame:frame)
        
        setUpImageView()
    }
    
    
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setUpImageView()
        
    }
    func setUpImageView(){
        self.clipsToBounds = true
        imageView = UIImageView(frame:CGRectMake(self.bounds.origin.x,  self.bounds.origin.y, 375, 562 ))
        imageView.contentMode = UIViewContentMode.ScaleAspectFill
        imageView.clipsToBounds = false
        self.addSubview(imageView)
        
    }
    
    
    func setImageOffset(imageOffset:CGPoint){
        
        self.imageOffset = imageOffset
        if imageView != nil{
            let frame:CGRect = imageView.bounds
            //Next let create an offset frame
            let offset:CGRect = CGRectOffset(frame, self.imageOffset.x - 25, self.imageOffset.y)
            imageView.frame = offset
        }
    }
}
