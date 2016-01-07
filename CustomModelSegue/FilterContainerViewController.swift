//
//  FilterContainerViewController.swift
//  CustomModelSegue
//
//  Created by luojie on 15/12/21.
//  Copyright © 2015年 LuoJie. All rights reserved.
//  Demo Url:https://github.com/beeth0ven/CustomModelSegue

import UIKit

// This VC is required, and controls the animation
class FilterContainerViewController: UIViewController {
    
    @IBOutlet weak var widthConstraint: NSLayoutConstraint! { didSet { tableViewWidth = widthConstraint.constant } }
    private var tableViewWidth: CGFloat!

    override func viewDidLoad() {
        super.viewDidLoad()
        widthConstraint.constant = 0
    }
    
    private var isSizeUpdated = false
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        guard !isSizeUpdated else { return }
        isSizeUpdated = true
        Queue.Main.execute { // Fix a bug 
            self.widthConstraint.constant = self.tableViewWidth
            UIView.animateWithDuration(0.3) { self.view.layoutIfNeeded() }
        }
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillAppear(animated)
        widthConstraint.constant = 0
        UIView.animateWithDuration(0.3) { self.view.layoutIfNeeded() }
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
