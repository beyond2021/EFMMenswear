//
//  SeaterDetailsVC.swift
//  EFMMenswear
//
//  Created by KEEVIN MITCHELL on 2/24/15.
//  Copyright (c) 2015 Parse. All rights reserved.
//

import UIKit
import Parse
import PassKit

extension SeaterDetailsVC: PKPaymentAuthorizationViewControllerDelegate {
//    func paymentAuthorizationViewController(controller: PKPaymentAuthorizationViewController!, didAuthorizePayment payment: PKPayment!, completion: ((PKPaymentAuthorizationStatus) -> Void)!) {
//        completion(PKPaymentAuthorizationStatus.Success)
//    }
    
    func paymentAuthorizationViewController(controller: PKPaymentAuthorizationViewController!, didAuthorizePayment payment: PKPayment!, completion: ((PKPaymentAuthorizationStatus) -> Void)!) {
        //completion(PKPaymentAuthorizationStatus.Success)
        
        // 1
        let shippingAddress = self.createShippingAddressFromRef(payment.shippingAddress)
        
        // 2
        Stripe.setDefaultPublishableKey("pk_test_10iie7Xp98twCbxCC0njHt8L")  // Replace With Your Own Key!
        
        STPAPIClient.sharedClient().createTokenWithPayment(payment, completion: { (token: STPToken!, error: NSError!) -> Void in
            
            
            //   })
            if (error != nil) {
                println(error)
                completion(PKPaymentAuthorizationStatus.Failure)
                return
            }
            
            
            
            // })
            // 4
            let shippingAddress = self.createShippingAddressFromRef(payment.shippingAddress)
            
            // 5
            let url = NSURL(string: "http://10.0.0.133:5000/pay")  // Replace with computers local IP Address!
            let request = NSMutableURLRequest(URL: url!)
            request.HTTPMethod = "POST"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.setValue("application/json", forHTTPHeaderField: "Accept")
            
            // 6
            
            
            
            // })
            
            let body = ["stripeToken": token.tokenId,
                
                "amount": self.total().decimalNumberByMultiplyingBy(NSDecimalNumber(string: "100")),
                
                
                "description": self.swag!.description,
                "shipping": [
                    "city": shippingAddress.City!,
                    "state": shippingAddress.State!,
                    "zip": shippingAddress.Zip!,
                    "firstName": shippingAddress.FirstName!,
                    "lastName": shippingAddress.LastName!]
            ]
            
            var error: NSError?
            request.HTTPBody = NSJSONSerialization.dataWithJSONObject(body, options: NSJSONWritingOptions(), error: &error)
            
            // 7
            NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue()) { (response, data, error) -> Void in
                if (error != nil) {
                    completion(PKPaymentAuthorizationStatus.Failure)
                } else {
                    completion(PKPaymentAuthorizationStatus.Success)
                }
            }
        })
        
    }
    
    
    
    
    func paymentAuthorizationViewControllerDidFinish(controller: PKPaymentAuthorizationViewController!) {
        controller.dismissViewControllerAnimated(true, completion: nil)
    }
    func paymentAuthorizationViewController(controller: PKPaymentAuthorizationViewController!, didSelectShippingAddress address: ABRecord!, completion: ((PKPaymentAuthorizationStatus, [AnyObject]!, [AnyObject]!) -> Void)!) {
        completion(PKPaymentAuthorizationStatus.Success, nil, calculateSummaryItemsFromSwag(swag))
        let shippingAddress = createShippingAddressFromRef(address)
        switch (shippingAddress.State, shippingAddress.City, shippingAddress.Zip) {
        case (.Some(let state), .Some(let city), .Some(let zip)):
            completion(PKPaymentAuthorizationStatus.Success, nil, nil)
        default:
            completion(PKPaymentAuthorizationStatus.InvalidShippingPostalAddress, nil, nil)
        }
        
    }
    
}






class SeaterDetailsVC: UIViewController {
    
    let SupportedPaymentNetworks = [PKPaymentNetworkVisa, PKPaymentNetworkMasterCard, PKPaymentNetworkAmex]
    let ApplePaySwagMerchantID = "merchant.com.EFMMerchantID" // Fill in your merchant ID here!
    
    @IBOutlet weak var applePayButton: UIButton!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var efmImageView: UIImageView!
    @IBOutlet weak var featureLabel: UILabel!
    let shippingPrice: NSDecimalNumber = NSDecimalNumber(string: "20.0")
    var deliveryType: DeliveryType = DeliveryType.toDelivered(method: ShippingMethod.ShippingMethodOptions.first!)
    
    
    
    var swag: PFObject! {
        didSet {
            self.configureView()
        }
    }
    
    func configureView() {
        
        
        if (!self.isViewLoaded()) {
            return
        }
       
        self.title = swag.objectForKey("Title") as! String!
        let price = swag.objectForKey("Price") as! NSNumber
        
        
        var priceString: NSString {
            let dollarFormatter: NSNumberFormatter = NSNumberFormatter()
            dollarFormatter.minimumFractionDigits = 2;
            dollarFormatter.maximumFractionDigits = 2;
            return dollarFormatter.stringFromNumber(price)!
                 }
       
        
        self.priceLabel.text = "$" + (priceString as String)
        self.descriptionLabel.text = swag.objectForKey("Description") as! String!
        self.featureLabel.text = swag.objectForKey("Features") as! String!
        
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        applePayButton.hidden = !PKPaymentAuthorizationViewController.canMakePaymentsUsingNetworks(SupportedPaymentNetworks)
        
        self.configureView()
        
        
        //Getting the image
        efmImageView.image = nil
        let queue:dispatch_queue_t = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
        
        dispatch_async(queue, { () -> Void in
            
            var error:NSError?
            let imageFile:PFFile = self.swag.objectForKey("Image") as! PFFile
            
            imageFile.getDataInBackgroundWithBlock({ (data: NSData?, error: NSError?) -> Void in
                
                let imageData:NSData = data!
                
                let image:UIImage = UIImage(data: imageData)!
                dispatch_async(dispatch_get_main_queue(), {
                    
                    self.efmImageView.image = image
                    
                })
                
            })
        })
    }
        
        
 
    @IBAction func applePay(sender: UIButton) {
        let request = PKPaymentRequest()
        
        //
        request.merchantIdentifier = ApplePaySwagMerchantID
        request.supportedNetworks = SupportedPaymentNetworks
        request.merchantCapabilities = PKMerchantCapability.Capability3DS
        request.countryCode = "US"
        request.currencyCode = "USD"
        //
        request.requiredShippingAddressFields = PKAddressField.All
        
        request.paymentSummaryItems = calculateSummaryItemsFromSwag(swag)
        
        let applePayController = PKPaymentAuthorizationViewController(paymentRequest: request)
        
        
        self.presentViewController(applePayController, animated: true, completion: nil)
        applePayController.delegate = self
    }
    
    func calculateSummaryItemsFromSwag(swag: PFObject) -> [PKPaymentSummaryItem] {
        var summaryItems = [PKPaymentSummaryItem]()
        let efmTitle = swag.objectForKey("Title") as! String!
        let price = swag.objectForKey("Price") as! NSNumber
        var priceString: NSString {
            let dollarFormatter: NSNumberFormatter = NSNumberFormatter()
            dollarFormatter.minimumFractionDigits = 2;
            dollarFormatter.maximumFractionDigits = 4;
            return dollarFormatter.stringFromNumber(price)!
        }
        var priceNumber =  NSDecimalNumber( string: priceString as String)
        summaryItems.append(PKPaymentSummaryItem(label: efmTitle, amount: priceNumber))
        switch (deliveryType) {
        case DeliveryType.toDelivered(let method):
            summaryItems.append(PKPaymentSummaryItem(label: "Shipping", amount: method.price))
        case DeliveryType.pickUp:
            break
        }
        summaryItems.append(PKPaymentSummaryItem(label: "EFM Menswear", amount: total()))
        return summaryItems
    }
    
    
    func total() -> NSDecimalNumber {
        let price = swag.objectForKey("Price") as! NSNumber
        var priceString: NSString {
            let dollarFormatter: NSNumberFormatter = NSNumberFormatter()
            dollarFormatter.minimumFractionDigits = 2;
            dollarFormatter.maximumFractionDigits = 4;
            return dollarFormatter.stringFromNumber(price)!
        }
        var priceNumber =  NSDecimalNumber( string: priceString as String)
        switch (deliveryType) {
        case DeliveryType.toDelivered(let deliveryType):
            return priceNumber.decimalNumberByAdding(deliveryType.price)
        case DeliveryType.pickUp:
            return priceNumber
        }
    }
    
    
    func createShippingAddressFromRef(address: ABRecord!) -> Address {
        var shippingAddress: Address = Address()
        shippingAddress.FirstName = ABRecordCopyValue(address, kABPersonFirstNameProperty)?.takeRetainedValue() as? String
        shippingAddress.LastName = ABRecordCopyValue(address, kABPersonLastNameProperty)?.takeRetainedValue() as? String
        let addressProperty : ABMultiValueRef = ABRecordCopyValue(address, kABPersonAddressProperty).takeUnretainedValue() as ABMultiValueRef
        if let dict : NSDictionary = ABMultiValueCopyValueAtIndex(addressProperty, 0).takeUnretainedValue() as? NSDictionary {
            shippingAddress.Street = dict[String(kABPersonAddressStreetKey)] as? String
            shippingAddress.City = dict[String(kABPersonAddressCityKey)] as? String
            shippingAddress.State = dict[String(kABPersonAddressStateKey)] as? String
            shippingAddress.Zip = dict[String(kABPersonAddressZIPKey)] as? String
        }
        return shippingAddress
    }
    
    
    
    @IBAction func swipeBack(sender: UISwipeGestureRecognizer) {
        
        navigationController!.popViewControllerAnimated(true)
        
        
    }
    override func viewWillDisappear(animated: Bool) {
        navigationController!.popViewControllerAnimated(true)
    }
  
}
