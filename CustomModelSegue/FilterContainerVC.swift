//
//  FilterContainerVC.swift
//  CustomModelSegue
//
//  Created by luojie on 15/12/21.
//  Copyright © 2015年 LuoJie. All rights reserved.
//  Demo Url: https://github.com/beeth0ven/CustomModelSegue

import UIKit

// This VC is required, and controls the animation
class FilterContainerVC: UIViewController {
    
    @IBOutlet weak var containerTrailingConstraint: NSLayoutConstraint!
    @IBOutlet weak var containerLeadingConstraint: NSLayoutConstraint!

    private var isContainerShowed: Bool! {
        didSet {
            containerTrailingConstraint.active = isContainerShowed
            containerLeadingConstraint.active = !isContainerShowed
        }
    }

    // Appear
    private var isSizeUpdated = false
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        guard !isSizeUpdated else { return }
        isSizeUpdated = true
        // Fix a bug: story board will override the constraint's active state which is setted by code before viewDidLayoutSubviews.
        // So after viewDidLayoutSubviews we change the active state.
        
        // Set default constraint state below:
        isContainerShowed = false
        view.layoutIfNeeded()
        
        // Do the animation and show container
        Queue.Main.execute { // Fix a bug
            self.isContainerShowed = true
            UIView.animateWithDuration(0.3) { self.view.layoutIfNeeded() }
        }
    }
    
    // Disappear
    override func viewWillDisappear(animated: Bool) {
        super.viewWillAppear(animated)
        isContainerShowed = false
        UIView.animateWithDuration(0.3) { self.view.layoutIfNeeded() }
    }
    
    @IBAction func doClose() {
        presentingViewController?.dismissViewControllerAnimated(true, completion: nil)
    }
}

// This VC is just a demo, and it is presenting FilterVC, it use unwindSegue to hanlde FilterVC's call back
class PresentFilterVC: UIViewController {
    @IBAction func presentFilterVCAndDoCancel(segue: UIStoryboardSegue) {}
    @IBAction func presentFilterVCAndDoFilter(segue: UIStoryboardSegue) {
        let filterTableViewController = segue.sourceViewController as! FilterTableViewController
        print(filterTableViewController.filterText) // get model from FilterTableViewController
    }
}

// This VC is just a demo, and it is use for filter
class FilterTableViewController: UITableViewController {
    var filterText = "hallo" // model
}
