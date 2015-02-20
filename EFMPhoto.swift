//
//  KnitPhoto.swift
//  EFMMenswear
//
//  Created by KEEVIN MITCHELL on 2/15/15.
//  Copyright (c) 2015 Parse. All rights reserved.
//

import Foundation
import Parse


/*
enum DeliveryType {
    case toDelivered
    case pickUp
    
}
func ==(lhs: DeliveryType, rhs: DeliveryType) -> Bool {
    switch(lhs, rhs) {
    case (.toDelivered(let lhsVal), .toDelivered(let rhsVal)):
        return true
    case (.pickUp, .pickUp):
        return true
    default: return false
    }
}
*/

class EFMPhoto : NSObject {
    
//    var efmImage: PFFile?
//    var efmDescription:String
//    var efmFeatures:String
//    var efmPrice:NSNumber
//    var efmTitle:String
   // var deliveryType: DeliveryType
    
    
    let efmImage = PFFile()
    let efmDescription = String()
    let efmFeatures = String()
    let efmPrice = NSNumber()
    let efmTitle = String()
    
    
    init(efmImage:PFFile?, efmTitle: String, efmPrice: NSNumber,  efmDescription: String, efmFeatures: String) {
        self.efmImage = efmImage!
        self.efmTitle = efmTitle
        self.efmPrice = efmPrice
      //  self.deliveryType = deliveryType
        self.efmDescription = efmDescription
        self.efmFeatures = efmFeatures
    }
    
        
    var priceString: NSString {
        let dollarFormatter: NSNumberFormatter = NSNumberFormatter()
        dollarFormatter.minimumFractionDigits = 2;
        dollarFormatter.maximumFractionDigits = 2;
        return dollarFormatter.stringFromNumber(efmPrice)!
    }
}




