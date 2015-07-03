//
//  EFMDetailsViewController.swift
//  EFMMenswear
//
//  Created by KEEVIN MITCHELL on 2/19/15.
//  Copyright (c) 2015 Parse. All rights reserved.
//

import UIKit
import Parse
import PassKit







extension EFMDetailsViewController: PKPaymentAuthorizationViewControllerDelegate {
//    func paymentAuthorizationViewController(controller: PKPaymentAuthorizationViewController!, didAuthorizePayment payment: PKPayment!, completion: ((PKPaymentAuthorizationStatus) -> Void)!) {
//        completion(PKPaymentAuthorizationStatus.Success)
//    }
    
    @available(iOS 8.0, *)
    func paymentAuthorizationViewController(controller: PKPaymentAuthorizationViewController, didAuthorizePayment payment: PKPayment, completion: ((PKPaymentAuthorizationStatus) -> Void)) {
        //completion(PKPaymentAuthorizationStatus.Success)
        
        // 1
        let shippingAddress = self.createShippingAddressFromRef(payment.shippingAddress)
        
        // 2
        Stripe.setDefaultPublishableKey("pk_test_10iie7Xp98twCbxCC0njHt8L")  // Replace With Your Own Key!
        
        STPAPIClient.sharedClient().createTokenWithPayment(payment, completion: { (token: STPToken!, error: NSError!) -> Void in
            
            
         //   })
            if (error != nil) {
                                print(error)
                                completion(PKPaymentAuthorizationStatus.Failure)
                                return
                            }
            
            
            
       // })
                    // 4
            let shippingAddress = self.createShippingAddressFromRef(payment.shippingAddress)
            
            // 5
            let url = NSURL(string: "http://10.0.0.132:5000/pay")  // Replace with computers local IP Address!
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
            do {
                request.HTTPBody = try NSJSONSerialization.dataWithJSONObject(body, options: NSJSONWritingOptions())
            } catch let error1 as NSError {
                error = error1
                request.HTTPBody = nil
            } catch {
                fatalError()
            }
            
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
    
    
    
    
//    func paymentAuthorizationViewControllerDidFinish(controller: PKPaymentAuthorizationViewController) {
//        controller.dismissViewControllerAnimated(true, completion: nil)
//    }
//    @available(iOS 8.0, *)
//    func paymentAuthorizationViewController(controller: PKPaymentAuthorizationViewController, didSelectShippingAddress address: ABRecord, completion: (PKPaymentAuthorizationStatus, [PKShippingMethod], [PKPaymentSummaryItem]) -> Void) {
//        completion(PKPaymentAuthorizationStatus.Success, nil, calculateSummaryItemsFromSwag(swag))
//        let shippingAddress = createShippingAddressFromRef(address)
//        switch (shippingAddress.State, shippingAddress.City, shippingAddress.Zip) {
//        case (.Some(let state), .Some(let city), .Some(let zip)):
//            completion(PKPaymentAuthorizationStatus.Success, nil, nil)
//        default:
//            completion(PKPaymentAuthorizationStatus.InvalidShippingPostalAddress, nil, nil)
//        }
//        
//    }
//}


    func paymentAuthorizationViewControllerDidFinish(controller: PKPaymentAuthorizationViewController) {
        controller.dismissViewControllerAnimated(true, completion: nil)
    }
    @available(iOS 8.0, *)
    func paymentAuthorizationViewController(controller: PKPaymentAuthorizationViewController, didSelectShippingAddress address: ABRecord, completion: (PKPaymentAuthorizationStatus, [PKShippingMethod], [PKPaymentSummaryItem]) -> Void) {
        
        let shipping = PKShippingMethod(label: "Standard Shipping", amount: NSDecimalNumber.zero())
        shipping.detail = "Delivers within two working days"

        
        completion(.Success, [shipping], calculateSummaryItemsFromSwag(swag))
        
        
    }
}

    
    
    


@available(iOS 8.0, *)
class EFMDetailsViewController: UIViewController{
    
    let SupportedPaymentNetworks = [PKPaymentNetworkVisa, PKPaymentNetworkMasterCard, PKPaymentNetworkAmex]
    let ApplePaySwagMerchantID = "merchant.com.EFM" // Fill in your merchant ID here!
    
    var canvasView:UIView!
    var scrollView:UIScrollView!
    var drawerView:UIVisualEffectView!
    
    var descriptionString : String!
    var featureString : String!
    var priceString : String!
    
    let exampleTransitionDelegate = ExampleTransitioningDelegate() //Presentation
    
    
    
    
   // var galleryView: UIView!
    
    @IBOutlet weak var applePayButton: UIButton!
    
    
    @IBOutlet weak var priceLabel: UILabel!
    
    
    let shippingPrice: NSDecimalNumber = NSDecimalNumber(string: "20.0")
    
    var deliveryType: DeliveryType = DeliveryType.toDelivered(method: ShippingMethod.ShippingMethodOptions.first!)
    
    
    var swag: PFObject! {
        didSet {
          
            print("The swag is set")
                       self.configureView()
        }
    }
    
    func configureView() {
        if (!self.isViewLoaded()) {
            return
        }
        
      getPhotoArray()
        
        self.title = swag.objectForKey("Title") as! String!
       let price = swag.objectForKey("Price") as! NSNumber
        
        
        var priceString: NSString {
            let dollarFormatter: NSNumberFormatter = NSNumberFormatter()
            dollarFormatter.minimumFractionDigits = 2;
            dollarFormatter.maximumFractionDigits = 2;
            return dollarFormatter.stringFromNumber(price)!
               }
        
        
        self.priceString = "$" + (priceString as String)
        self.descriptionString = swag.objectForKey("Description") as! String!
       self.featureString = swag.objectForKey("Features") as! String!
       }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        
        
    }
    
    override init(nibName nibNameOrNil: String!, bundle nibBundleOrNil: NSBundle!) {
        canvasView = UIView()
        scrollView = UIScrollView()
        drawerView = UIVisualEffectView()
       // drawerView = UIView(frame: CGRect(x: 0, y: 0, width: 400, height: 900))
        
        super.init(nibName: nil, bundle: nil)
    }
    
    convenience  init() {
        self.init(nibName: nil, bundle: nil)
    }
    
    
    
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       self .configureView()
        getPhotoArray()
        
        let bounds:CGRect = self.view.bounds
        canvasView = UIView(frame: bounds)
        canvasView.backgroundColor = UIColor.darkGrayColor()
    
        let gBounds: CGRect =  CGRect(x: 0, y: 100, width: bounds.width - 80, height: bounds.height - 120)
       let galleryView = UIView(frame: gBounds)
      
        galleryView.backgroundColor = UIColor.blueColor()
        canvasView.addSubview(galleryView)

        
        galleryView.center = canvasView.center
                self.view .addSubview(canvasView)
        
        
        
        let touchDelay = TouchDelayGestureRecognizer(target: self, action: nil)//stops
        canvasView.addGestureRecognizer(touchDelay)
//        addDotts(25, toView: canvasView)
//        DotView.arrangeDotsRandomlyInView(canvasView)
        
        let scrollViewBounds = self.view.bounds
        scrollView = OverlayScrollView(frame: scrollViewBounds)
        self.view .addSubview(scrollView)
        
        let drawerViewBounds = self.view.bounds
        drawerView = UIVisualEffectView(frame: drawerViewBounds)
        
        
        drawerView = UIVisualEffectView(effect: UIBlurEffect(style: .Dark)) as UIVisualEffectView
        drawerView.frame = CGRectMake(0, 0, bounds.size.width, 650.0)
        scrollView.addSubview(drawerView)// Touches are broken here
        
        
        var shapeView = MainView(applePayButton: UIButton(),  descriptionString : descriptionString, featureString : featureString, priceString : priceString)
        
        
       drawerView.contentView.addSubview(shapeView)
        
        
        
        scrollView.contentSize = CGSizeMake(bounds.size.width, bounds.size.height + drawerView.frame.size.height)
        
       
        scrollView.contentOffset = CGPointMake(0, drawerView.frame.size.height)
                //
        self.view.addGestureRecognizer(scrollView.panGestureRecognizer)
        
        
                    }
    
    
    
    override func viewWillAppear(animated: Bool) {
//        //   mainScrollView.contentSize = mainView.frame.size
//        let baseView = MainView()
//        
//        // mainScrollView.addSubview(baseView)
//        
//       // self.view.addSubview(baseView)
//        
//        let containerView = UIView(frame: CGRect(x: 0, y: 0, width: 400, height: 900))
//        
//        containerView.addSubview(baseView)
//        
//        let scrollView = UIScrollView()
//        //        scrollView . contentSize = baseView.frame.size
//        scrollView . contentSize = CGSizeMake(400, 1200)
//        scrollView.scrollEnabled = true
//        
//        
//       scrollView.addSubview(containerView)
//       // containerView.addSubview( scrollView)
//        
//        self.view.addSubview(scrollView)
//        
//        
        
            }
    
    func getPhotoArray(){
        
        let imageFile:PFFile = swag.objectForKey("Image") as! PFFile
        
        
        if    let viewImageFiles = swag.relationForKey("AlternativeViews") as PFRelation! {
            
//            let query = viewImageFiles.query()
//            query.whereKey("KnitImages", equalTo: "Image1")
//            
//           // println("Image1 :\(query)")
//            query.whereKey("KnitImages", equalTo: "Image2")
//           // println("Image2 :\(query)")
            
             print("viewImageFiles :\(viewImageFiles)")
            
            // To acess the data from the relation object
            
//            PFRelation *relationObj = [getImageObject relationForKey:@"locationImages"];
//            PFQuery *query1 = [relationObj query];
//            [query1 findObjectsInBackgroundWithBlock:^(NSArray *results, NSError *error) {
//            
//            [locationImagesArray addObjectsFromArray:results];
//            for (int imgCount = 0; imgCount < [locationImagesArray count]; imgCount ++) {
//            
//            PFFile *getImage1 = [[locationImagesArray valueForKey:@"Image"] objectAtIndex:imgCount];
//            [getImage1 getDataInBackgroundWithBlock:^(NSData *imageData, NSError *error)
//            {
//            
//            if (imageData!=nil) {
//            UIImage *image = [UIImage imageWithData:imageData];
//            activityImage.image = image;
//            
//            NSLog(@"location image output");
//            
//            NSLog(@"location image output : %@", activityImage.image);
//            
//            }
//            }];
//            
//            }
            
            
//Bit
            
            
           let query1 = viewImageFiles.query()
            query1!.findObjectsInBackgroundWithBlock({ (results, error: NSError?) -> Void in
                if (error ==  nil)
                    
                {
                    
                    print(query1)
                    
                }
                    
                else
                    
                {
                    
                    print("ERROR LOAD")
                    
                }
                
 
                
                
                
            })
            
            
            
        } else {
            
            print("The relation is nil")
        }

        
        
        let queue:dispatch_queue_t = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
        
        dispatch_async(queue, { () -> Void in
            
            var error:NSError?
            
            let imageObject:PFRelation = self.swag.relationForKey("AlternativeViews") as PFRelation
            
         //   let imageFile:PFFile = imageObject.rel("Image") as PFFile
            
            
            imageFile.getDataInBackgroundWithBlock({ (data: NSData?, error: NSError?) -> Void in
                
                let imageData:NSData = data!
                
                //let image:UIImage = UIImage(data: imageData)!
           //     self.EFMImage = UIImage(data: imageData)!
                
                
                dispatch_async(dispatch_get_main_queue(), {
                    
                    // cell.image = image
             //       cell.image = self.EFMImage
                    
                    
              //      let yOffset:CGFloat = ((collectionView.contentOffset.y - cell.frame.origin.y) / 200) * 5
                    
               //     cell.imageOffset = CGPointMake(0, yOffset)
                    
                    
                })
                
            })
        })
    }
    
    
    
    
        
    override func viewWillDisappear(animated: Bool) {
        navigationController!.popViewControllerAnimated(true)
    }
  
    
    @IBAction func purchase(sender: UIButton) {
        
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
    
    @available(iOS 8.0, *)
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
        let priceNumber =  NSDecimalNumber( string: priceString as String)
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
        let priceNumber =  NSDecimalNumber( string: priceString as String)
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
    
    
    //MARK:
    
    
    
   }


