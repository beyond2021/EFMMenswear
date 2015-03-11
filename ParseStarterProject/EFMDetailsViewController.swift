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
    func paymentAuthorizationViewController(controller: PKPaymentAuthorizationViewController!, didAuthorizePayment payment: PKPayment!, completion: ((PKPaymentAuthorizationStatus) -> Void)!) {
        completion(PKPaymentAuthorizationStatus.Success)
    }
    
    func paymentAuthorizationViewControllerDidFinish(controller: PKPaymentAuthorizationViewController!) {
        controller.dismissViewControllerAnimated(true, completion: nil)
    }
    func paymentAuthorizationViewController(controller: PKPaymentAuthorizationViewController!, didSelectShippingAddress address: ABRecord!, completion: ((status: PKPaymentAuthorizationStatus, shippingMethods: [AnyObject]!, summaryItems: [AnyObject]!) -> Void)!) {
        completion(status:PKPaymentAuthorizationStatus.Success, shippingMethods: nil, summaryItems:calculateSummaryItemsFromSwag(swag))
        let shippingAddress = createShippingAddressFromRef(address)
        switch (shippingAddress.State, shippingAddress.City, shippingAddress.Zip) {
        case (.Some(let state), .Some(let city), .Some(let zip)):
            completion(status: PKPaymentAuthorizationStatus.Success, shippingMethods: nil, summaryItems: nil)
        default:
            completion(status: PKPaymentAuthorizationStatus.InvalidShippingPostalAddress, shippingMethods: nil, summaryItems: nil)
        }
    }
}





class EFMDetailsViewController: UIViewController, UIScrollViewDelegate, UIGestureRecognizerDelegate {
    
    let SupportedPaymentNetworks = [PKPaymentNetworkVisa, PKPaymentNetworkMasterCard, PKPaymentNetworkAmex]
    let ApplePaySwagMerchantID = "merchant.com.EFMMerchantID" // Fill in your merchant ID here!
    
    var canvasView:UIView!
    var scrollView:UIScrollView!
    var drawerView:UIVisualEffectView!
    
    var descriptionString : String!
    var featureString : String!
    var priceString : String!
 
    
    
   // var galleryView: UIView!
    
    @IBOutlet weak var applePayButton: UIButton!
    
    
    @IBOutlet weak var priceLabel: UILabel!
    
    
    let shippingPrice: NSDecimalNumber = NSDecimalNumber(string: "20.0")
    
    var deliveryType: DeliveryType = DeliveryType.toDelivered(method: ShippingMethod.ShippingMethodOptions.first!)
    
    
    var swag: PFObject! {
        didSet {
          
            println("The swag is set")
                       self.configureView()
        }
    }
    
    func configureView() {
        if (!self.isViewLoaded()) {
            return
        }
        
      getPhotoArray()
        
        self.title = swag.objectForKey("Title") as String!
       let price = swag.objectForKey("Price") as NSNumber
        
        
        var priceString: NSString {
            let dollarFormatter: NSNumberFormatter = NSNumberFormatter()
            dollarFormatter.minimumFractionDigits = 2;
            dollarFormatter.maximumFractionDigits = 2;
            return dollarFormatter.stringFromNumber(price)!
               }
        
        
        self.priceString = "$" + priceString
        self.descriptionString = swag.objectForKey("Description") as String!
       self.featureString = swag.objectForKey("Features") as String!
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
    
    convenience override init() {
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
        
        let imageFile:PFFile = swag.objectForKey("Image") as PFFile
        
        
        if    let viewImageFiles = swag.relationForKey("AlternativeViews") as PFRelation! {
            
//            let query = viewImageFiles.query()
//            query.whereKey("KnitImages", equalTo: "Image1")
//            
//           // println("Image1 :\(query)")
//            query.whereKey("KnitImages", equalTo: "Image2")
//           // println("Image2 :\(query)")
            
             println("viewImageFiles :\(viewImageFiles)")
            
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
            query1.findObjectsInBackgroundWithBlock({ (results, error: NSError?) -> Void in
                if (error ==  nil)
                    
                {
                    
                    println(query1)
                    
                }
                    
                else
                    
                {
                    
                    println("ERROR LOAD")
                    
                }
                
 
                
                
                
            })
            
            
            
        } else {
            
            println("The relation is nil")
        }

        
        
        let queue:dispatch_queue_t = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
        
        dispatch_async(queue, { () -> Void in
            
            var error:NSError?
            
            let imageObject:PFRelation = self.swag.relationForKey("AlternativeViews") as PFRelation
            
         //   let imageFile:PFFile = imageObject.rel("Image") as PFFile
            
            
            imageFile.getDataInBackgroundWithBlock({ (data: NSData!, error: NSError!) -> Void in
                
                let imageData:NSData = data
                
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
    
    func calculateSummaryItemsFromSwag(swag: PFObject) -> [PKPaymentSummaryItem] {
        var summaryItems = [PKPaymentSummaryItem]()
        let efmTitle = swag.objectForKey("Title") as String!
        let price = swag.objectForKey("Price") as NSNumber
        var priceString: NSString {
            let dollarFormatter: NSNumberFormatter = NSNumberFormatter()
            dollarFormatter.minimumFractionDigits = 2;
            dollarFormatter.maximumFractionDigits = 4;
            return dollarFormatter.stringFromNumber(price)!
        }
        var priceNumber =  NSDecimalNumber( string: priceString)
        summaryItems.append(PKPaymentSummaryItem(label: efmTitle, amount: priceNumber))
        switch (deliveryType) {
        case DeliveryType.toDelivered(let method):
            summaryItems.append(PKPaymentSummaryItem(label: "Shipping", amount: method.method.price))
        case DeliveryType.pickUp:
            break
        }
        summaryItems.append(PKPaymentSummaryItem(label: "EFM Menswear", amount: total()))
        return summaryItems
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
        switch (deliveryType) {
        case DeliveryType.toDelivered(let deliveryType):
            return priceNumber.decimalNumberByAdding(deliveryType.method.price)
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
    
    
   /*
   //Scrollview
    func loadPage(page: Int) {
        if page < 0 || page >= pageImages.count {
                        return
        }
        
     
        
        if let pageView = pageViews[page] {
            
        } else {
           
            
            var frame = scrollView.bounds
            frame.origin.x = frame.size.width * CGFloat(page)
            frame.origin.y = 0.0
            
            let newPageView = UIImageView(image: pageImages[page])
            newPageView.contentMode = .ScaleAspectFit
            newPageView.frame = frame
            scrollView.addSubview(newPageView)
            
            
            pageViews[page] = newPageView
        }
    }
    
    
    func purgePage(page: Int) {
        if page < 0 || page >= pageImages.count {
            // If it's outside the range of what you have to display, then do nothing
            return
        }
        
        // Remove a page from the scroll view and reset the container array
        if let pageView = pageViews[page] {
            pageView.removeFromSuperview()
            pageViews[page] = nil
        }
    }
    
    
     func loadVisiblePages() {
       
        let pageWidth = scrollView.frame.size.width
        let page = Int(floor((scrollView.contentOffset.x * 2.0 + pageWidth) / (pageWidth * 2.0)))
        
       
        pageControl.currentPage = page
        
       
        let firstPage = page - 1
        let lastPage = page + 1
        
        
        for var index = 0; index < firstPage; ++index {
            purgePage(index)
        }
        
       
        for index in firstPage...lastPage {
            loadPage(index)
        }
        
       
        for var index = lastPage+1; index < pageImages.count; ++index {
            purgePage(index)
        }
    }
    
    //MARK - Scrollview Delegate Methods
    
    func scrollViewDidScroll(scrollView: UIScrollView!) {
       
        loadVisiblePages()
    }
    
    
    
    */
    
    
    
   }


