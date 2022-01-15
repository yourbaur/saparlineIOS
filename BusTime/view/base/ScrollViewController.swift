//
//  ScrollViewController.swift
//  BusTime
//
//  Created by greetgo on 8/15/20.
//  Copyright © 2020 thousand.com. All rights reserved.
//

import UIKit
class ScrollViewController: UIViewController {
  
    // MARK: - Properties
    lazy var scrollView = UIScrollView()
    lazy var contentView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupScrollView()
    }
    
    // MARK: - Setup
    func setupScrollView() {
        view.backgroundColor = .white
        scrollView.alwaysBounceVertical = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.keyboardDismissMode = .onDrag
        
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        scrollView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
            make.width.equalTo(UIScreen.main.bounds.width)
        }
        contentView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
            make.width.equalTo(view)
        }
    }
}
