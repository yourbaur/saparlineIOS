//
//  AboutAppViewController.swift
//  BusTime
//
//  Created by greetgo on 8/20/20.
//  Copyright © 2020 thousand.com. All rights reserved.
//

import UIKit

class AboutAppViewController: UIViewController {

    lazy var titleText: UILabel = {
        let label = UILabel()
        label.text = localized(text: "aboutAppText")
        label.numberOfLines = 0
        label.textColor = maincolor.blue
        label.font = UIFont.init(name: Font.mullerMedium, size: 16)
        label.textAlignment = .justified
        return label
    }()
    
    // MARK: - Lifecycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        title = localized(text: "about app")
        view.backgroundColor = .white
        navigationController?.navigationBar.topItem?.title = ""
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.barTintColor = maincolor.blue
        navigationController!.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont.init(name: Font.mullerBold, size: 18)!,
                                                                   NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarPosition.any, barMetrics: UIBarMetrics.default)
        navigationController?.navigationBar.isTranslucent = false
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(titleText)
        titleText.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(20)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
        }
    }
}
