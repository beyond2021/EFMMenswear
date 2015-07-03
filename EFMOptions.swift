//
//  EFMOptions.swift
//  EFMMenswear
//
//  Created by KEEVIN MITCHELL on 3/3/15.
//  Copyright (c) 2015 Parse. All rights reserved.
//

import UIKit

class EFMOptions: UITableViewController {
    
    var descriptionCell: UITableViewCell = UITableViewCell()
    var featuresCell: UITableViewCell = UITableViewCell()
    var shareCell: UITableViewCell = UITableViewCell()
    
    
    init(descriptionCell: UITableViewCell, featuresCell: UITableViewCell, shareCell: UITableViewCell) {
        
        self.descriptionCell = descriptionCell
        self.featuresCell = featuresCell
        self.shareCell = shareCell
        // Overriding this method prevents other initializers from being inherited.
        // The super implementation calls init:nibName:bundle:
        // so we need to redeclare that initializer to prevent a runtime crash.
        super.init(style: UITableViewStyle.Plain)
    }
    
    // This needs to be implemented (enforced by compiler).
    required init(coder aDecoder: NSCoder) {
        // Or call super implementation
        fatalError("NSCoding not supported")
    }
    
    // Need this to prevent runtime error:
    // fatal error: use of unimplemented initializer 'init(nibName:bundle:)'
    // for class 'TestViewController'
    // I made this private since users should use the no-argument constructor.
    private override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    
    override func loadView() {
        super.loadView()
        descriptionCell.backgroundColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.5)
        descriptionCell.textLabel?.text = "Description"
        
        
        // construct last name cell, section 0, row 1
        featuresCell.backgroundColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.5)
        featuresCell.textLabel?.text = "Features And Benefits"
        
        
        // construct share cell, section 1, row 0
        shareCell.textLabel?.text = "Share with Friends"
        shareCell.backgroundColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.5)
        shareCell.accessoryType = UITableViewCellAccessoryType.Checkmark
        
//        int num = indexPath.row;
//        UITableViewCell *cell;
//        switch (num) {
//        case 0:
//            cell = self.myFirstCell;
//            break;
//        case 1:
//            cell = self.mySecondCell;
//            break;
//        }
//        return cell;
        
//        let num = NSIndexPath()
//        var cell = UITableViewCell()
//        switch num{
//        case 0 :
//            return descriptionCell.textLabel.text = "Description"
//        case 1:
//            return featuresCell.textLabel.text = "Features And Benefits"
//        default:
//            return descriptionCell.textLabel.text = "Description"
//            
//        }
        
        
        
    }
    
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        var cell = UITableViewCell()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch(section) {
        case 0: return 2    // section 0 has 2 rows
        case 1: return 1    // section 1 has 1 row
        default: fatalError("Unknown number of sections")
        }
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        switch(indexPath.section) {
        case 0:
            switch(indexPath.row) {
            case 0: return self.descriptionCell   // section 0, row 0 is the first name
            case 1: return self.featuresCell    // section 0, row 1 is the last name
            default: fatalError("Unknown row in section 0")
            }
        case 1:
            switch(indexPath.row) {
            case 0: return self.shareCell       // section 1, row 0 is the share option
            default: fatalError("Unknown row in section 1")
            }
        default: fatalError("Unknown section")
        }
    }
    
    // Customize the section headings for each section
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch(section) {
        case 0: return "Product"
        case 1: return "Social"
        default: fatalError("Unknown section")
        }
    }
    
   
}
