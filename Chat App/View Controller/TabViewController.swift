//
//  TabViewController.swift
//  Chat App
//
//  Created by Bhautik Rajodiya on 26/07/23.
//

import UIKit

class TabViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.backBarButtonItem?.isHidden = true
    }

}
