//
//  ToCityGliderView.swift
//  BusTime
//
//  Created by greetgo on 8/24/20.
//  Copyright © 2020 thousand.com. All rights reserved.
//

import UIKit

class ToCityGliderView: UIView {

    // MARK: - Properties
    lazy var timeTitle: UILabel = {
        let label = UILabel()
        label.text = "17:54"
        label.textColor = maincolor.blue
        label.font = UIFont.init(name: Font.mullerMedium, size: 20)
        return label
    }()
    lazy var dateTitle: UILabel = {
        let label = UILabel()
        label.text = "24 июля 2020"
        label.textColor = UIColor(red: 0.741, green: 0.741, blue: 0.741, alpha: 1)
        label.font = UIFont.init(name: Font.mullerRegular, size: 12)
        return label
    }()
    lazy var cityTitle: UILabel = {
        let label = UILabel()
        label.text = "Кызылорда"
        label.textColor = UIColor(red: 0.741, green: 0.741, blue: 0.741, alpha: 1)
        label.font = UIFont.init(name: Font.mullerRegular, size: 14)
        return label
    }()
    lazy var priceTitle: UILabel = {
        let label = UILabel()
        label.text = "4 500 тг"
        label.textColor = UIColor(red: 0.184, green: 0.502, blue: 0.929, alpha: 1)
        label.font = UIFont.init(name: Font.mullerBold, size: 18)
        return label
    }()
    
    
    // MARK: - init
    required init?(coder: NSCoder) {fatalError("")}
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .white
        
        addSubviews([timeTitle,dateTitle,cityTitle,priceTitle])
        timeTitle.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.left.equalToSuperview().offset(16)
        }
        dateTitle.snp.makeConstraints { (make) in
            make.centerY.equalTo(timeTitle.snp.centerY)
            make.left.equalTo(timeTitle.snp.right).offset(8)
        }
        cityTitle.snp.makeConstraints { (make) in
            make.top.equalTo(timeTitle.snp.bottom).offset(4)
            make.left.equalToSuperview().offset(16)
            make.bottom.equalToSuperview()
        }
        priceTitle.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-25)
            make.centerY.equalTo(dateTitle.snp.centerY)
        }
    }
}
