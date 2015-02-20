//
//  EFMDetailsViewController.swift
//  EFMMenswear
//
//  Created by KEEVIN MITCHELL on 2/19/15.
//  Copyright (c) 2015 Parse. All rights reserved.
//

import UIKit

class EFMDetailsViewController: UIViewController {
    @IBOutlet weak var navBar: UINavigationBar!

    @IBOutlet weak var doneButton: UIBarButtonItem!
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBAction func DoneAction(sender: AnyObject) {
    }
    
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var priceLabel: UILabel!
    
    @IBOutlet weak var efmImageView: UIImageView!
    
    @IBOutlet weak var applePayButtonLabel: UIButton!
    
    @IBOutlet weak var applePayButtonAction: UIButton!
    
    @IBOutlet weak var featureLabel: UILabel!
    
    
    var swag: EFMPhoto! {
        didSet {
            // Update the view.
            self.configureView()
        }
    }
    
    func configureView() {
        
        if (!self.isViewLoaded()) {
            return
        }
        
        self.title = swag.efmTitle
        self.priceLabel.text = "$" + swag.priceString
        //self.efmImageView.image = swag.image
        self.descriptionLabel.text = swag.efmDescription
        self.featureLabel.text = swag.efmFeatures
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureView()
    }
    
    
    
}
