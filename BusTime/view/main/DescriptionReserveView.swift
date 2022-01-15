//
//  DescriptionReserveView.swift
//  BusTime
//
//  Created by greetgo on 8/18/20.
//  Copyright © 2020 thousand.com. All rights reserved.
//

import UIKit
class DescriptionReserveView: UIView {

    lazy var typeTitle: UILabel = {
        let label = UILabel()
        label.text = localized(text: "typeTrans")
        label.textColor = maincolor.blue
        label.font = UIFont.init(name: Font.mullerMedium, size: 18)
        return label
    }()
    lazy var dateTitle: UILabel = {
        let label = UILabel()
        label.text = "-:- / -.-.-"
        label.textColor = .gray//UIColor(red: 0.741, green: 0.741, blue: 0.741, alpha: 1)
        label.font = UIFont.init(name: Font.mullerRegular, size: 14)
        return label
    }()
    lazy var placeTitle: UILabel = {
        let label = UILabel()
        label.text = "места №-: 0 тг"
        label.textColor = maincolor.blue
        label.font = UIFont.init(name: Font.mullerRegular, size: 14)
        label.numberOfLines = 0
        label.textAlignment = .right
        return label
    }()
    
    required init?(coder: NSCoder) {fatalError("")}
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
        addSubviews([typeTitle, dateTitle, placeTitle])
        typeTitle.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.left.equalToSuperview().offset(16)
        }
        dateTitle.snp.makeConstraints { (make) in
            make.top.equalTo(typeTitle.snp.bottom).offset(8)
            make.left.equalToSuperview().offset(16)
        }
        placeTitle.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.right.equalToSuperview().offset(-16)
            make.bottom.equalToSuperview()
        }
    }
}
