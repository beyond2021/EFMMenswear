//
//  KnitPhoto.swift
//  EFMMenswear
//
//  Created by KEEVIN MITCHELL on 2/15/15.
//  Copyright (c) 2015 Parse. All rights reserved.
//

import Foundation
import Parse



struct ShippingMethod {
    let price: NSDecimalNumber
    let title: String
    let description: String
    
    init(price: NSDecimalNumber, title: String, description: String) {
        self.price = price
        self.title = title
        self.description = description
    }
    
    static let ShippingMethodOptions = [
        ShippingMethod(price: NSDecimalNumber(string: "5.00"), title: "Carrier Pigeon", description: "You'll get it someday."),
        ShippingMethod(price: NSDecimalNumber(string: "100.00"), title: "Racecar", description: "Vrrrroom! Get it by tomorrow!"),
        ShippingMethod(price: NSDecimalNumber(string: "9000000.00"), title: "Rocket Ship", description: "Look out your window!"),
        ShippingMethod(price: NSDecimalNumber(string: "0.00"), title: "Pick it up at the store", description: "285 West broadway suite 620 NY 10013"),
    ]
}

enum DeliveryType {
    case toDelivered(method: ShippingMethod)
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


class EFMPhoto  {
    
    var efmImage: PFFile? { didSet { print("The image is set") } }
    var efmDescription:String { didSet { print("The Description is set") } }
    var efmFeatures:String { didSet { print("The Features is set") } }
    var efmPrice:NSNumber { didSet { print("The Price is set") } }
    var efmTitle:String { didSet { print("The Title is set") } }
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




