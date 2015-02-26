//
//  TrousersDeatailVC.swift
//  EFMMenswear
//
//  Created by KEEVIN MITCHELL on 2/24/15.
//  Copyright (c) 2015 Parse. All rights reserved.
//

import UIKit
import Parse
import PassKit

extension TrousersDeatailVC: PKPaymentAuthorizationViewControllerDelegate {
    func paymentAuthorizationViewController(controller: PKPaymentAuthorizationViewController!, didAuthorizePayment payment: PKPayment!, completion: ((PKPaymentAuthorizationStatus) -> Void)!) {
        completion(PKPaymentAuthorizationStatus.Success)
    }
    
    func paymentAuthorizationViewControllerDidFinish(controller: PKPaymentAuthorizationViewController!) {
        controller.dismissViewControllerAnimated(true, completion: nil)
    }
}

class TrousersDeatailVC: UIViewController {
    let SupportedPaymentNetworks = [PKPaymentNetworkVisa, PKPaymentNetworkMasterCard, PKPaymentNetworkAmex]
    let ApplePaySwagMerchantID = "merchant.com.EFMMerchantID" // Fill in your merchant ID here!
    
    @IBOutlet weak var applePayButton: UIButton!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var efmImageView: UIImageView!
    @IBOutlet weak var featureLabel: UILabel!
    let shippingPrice: NSDecimalNumber = NSDecimalNumber(string: "5.0")
    var deliveryType: DeliveryType = DeliveryType.toDelivered
    
    var swag: PFObject! {
        didSet {
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
        
        applePayButton.hidden = !PKPaymentAuthorizationViewController.canMakePaymentsUsingNetworks(SupportedPaymentNetworks)
        self.configureView()
        efmImageView.image = nil
        let queue:dispatch_queue_t = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
        dispatch_async(queue, { () -> Void in
            var error:NSError?
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
    
  
    
    @IBAction func applePay(sender: AnyObject) {
        let request = PKPaymentRequest()
        
        //
        request.merchantIdentifier = ApplePaySwagMerchantID
        request.supportedNetworks = SupportedPaymentNetworks
        request.merchantCapabilities = PKMerchantCapability.Capability3DS
        request.countryCode = "US"
        request.currencyCode = "USD"
        //
        let efmTitle = swag.objectForKey("Title") as String!
        let price = swag.objectForKey("Price") as NSNumber
        var priceString: NSString {
            let dollarFormatter: NSNumberFormatter = NSNumberFormatter()
            dollarFormatter.minimumFractionDigits = 2;
            dollarFormatter.maximumFractionDigits = 4;
            return dollarFormatter.stringFromNumber(price)!
        }
        
        
        var priceNumber =  NSDecimalNumber( string: priceString)
        
        switch (deliveryType) {
        case DeliveryType.toDelivered:
            request.requiredShippingAddressFields = PKAddressField.PostalAddress | PKAddressField.Phone
        case DeliveryType.pickUp:
            request.requiredShippingAddressFields = PKAddressField.Email
        }
        request.requiredShippingAddressFields = PKAddressField.All
        
        var summaryItems = [PKPaymentSummaryItem]()
        summaryItems.append(PKPaymentSummaryItem(label: efmTitle, amount: priceNumber))
        
        if (deliveryType == DeliveryType.toDelivered) {
            summaryItems.append(PKPaymentSummaryItem(label: "Shipping", amount: priceNumber))
        }
        
        summaryItems.append(PKPaymentSummaryItem(label: "EFM Menswear", amount: total()))
        
        request.paymentSummaryItems = summaryItems
        let applePayController = PKPaymentAuthorizationViewController(paymentRequest: request)
        
        
        self.presentViewController(applePayController, animated: true, completion: nil)
        
        
        applePayController.delegate = self
    }
    
    func total() -> NSDecimalNumber {
        
        let price = swag.objectForKey("Price") as NSNumber
        var priceString: NSString {
            let dollarFormatter: NSNumberFormatter = NSNumberFormatter()
            dollarFormatter.minimumFractionDigits = 2;
            dollarFormatter.maximumFractionDigits = 4;
            return dollarFormatter.stringFromNumber(price)!
            
        }
        var priceNumber =  NSDecimalNumber( string: priceString)
        
        if (deliveryType == DeliveryType.toDelivered) {
            
            return priceNumber.decimalNumberByAdding(shippingPrice)
        } else {
            return priceNumber
        }
    }
    
    
    
    
    @IBAction func swipeBack(sender: UISwipeGestureRecognizer) {
        
        navigationController!.popViewControllerAnimated(true)
        
        
    }
    
}
