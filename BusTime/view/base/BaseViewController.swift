//
//  BaseViewController.swift
//  BusTime
//
//  Created by greetgo on 8/15/20.
//  Copyright © 2020 thousand.com. All rights reserved.
//

import UIKit
import LGSideMenuController
class BaseViewController: ScrollViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "menu").withRenderingMode(.alwaysOriginal),style: .plain,target: self, action:#selector(tapMenu))
        navigationItem.leftBarButtonItem = leftBarButtonItem
        navigationController?.navigationBar.isTranslucent = false
        
        view.backgroundColor = .white
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.layoutIfNeeded()
    }

    @objc private func tapMenu(button: UIButton) -> Void {
        self.sideMenuController?.showLeftViewAnimated()
    }
}
