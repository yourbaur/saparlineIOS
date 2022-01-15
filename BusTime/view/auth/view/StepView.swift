//
//  StepView.swift
//  BusTime
//
//  Created by greetgo on 8/15/20.
//  Copyright © 2020 thousand.com. All rights reserved.
//

import UIKit
class StepView: UIView {

    lazy var view1 = UIView()
    lazy var view2 = UIView()
    lazy var view3 = UIView()

    required init?(coder: NSCoder) {fatalError("")}
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        view1.backgroundColor = UIColor(red: 0.949, green: 0.949, blue: 0.949, alpha: 1)
        view2.backgroundColor = UIColor(red: 0.949, green: 0.949, blue: 0.949, alpha: 1)
        view3.backgroundColor = UIColor(red: 0.949, green: 0.949, blue: 0.949, alpha: 1)
        
        addSubviews([view2, view1, view3])
        view1.snp.makeConstraints { (make) in
            view2.snp.makeConstraints { (make) in
                make.center.equalToSuperview()
                make.height.equalTo(1)
                make.width.equalTo(40)
            }
            view1.snp.makeConstraints { (make) in
                make.centerY.equalToSuperview()
                make.right.equalTo(view2.snp.left).offset(-12)
                make.height.equalTo(1)
                make.width.equalTo(40)
            }
            view3.snp.makeConstraints { (make) in
                make.centerY.equalToSuperview()
                make.left.equalTo(view2.snp.right).offset(12)
                make.height.equalTo(1)
                make.width.equalTo(40)
            }
        }
    }
}
