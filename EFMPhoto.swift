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

class EFMPhoto  {
    
    var efmImage: PFFile? { didSet { println("The image is set") } }
    var efmDescription:String { didSet { println("The Description is set") } }
    var efmFeatures:String { didSet { println("The Features is set") } }
    var efmPrice:NSNumber { didSet { println("The Price is set") } }
    var efmTitle:String { didSet { println("The Title is set") } }
    //var deliveryType: DeliveryType
    
    
//    let efmImage = PFFile()
//    let efmDescription = String()
//    let efmFeatures = String()
//    let efmPrice = NSNumber()
//    let efmTitle = String()
//    
    
    init(efmImage:PFFile?, efmTitle: String, efmPrice: NSNumber,  efmDescription: String, efmFeatures: String) {
        self.efmImage = efmImage
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




