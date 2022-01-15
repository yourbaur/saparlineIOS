//
//  ComingPriceView.swift
//  BusTime
//
//  Created by greetgo on 8/27/20.
//  Copyright © 2020 thousand.com. All rights reserved.
//

import UIKit

class ComingPriceView: UIView {

    // MARK: - properties
    lazy var freePlaceCountTitle: UILabel = {
        let label = UILabel()
        label.text = "Есть свободные места"
        label.textColor = UIColor(red: 0.51, green: 0.51, blue: 0.51, alpha: 1)
        label.font = UIFont.init(name: Font.mullerRegular, size: 16)
        return label
    }()
    lazy var dateTitle: UILabel = {
        let label = UILabel()
        label.text = "14: 30 / 24 июля 2020г"
        label.textColor = UIColor(red: 0.741, green: 0.741, blue: 0.741, alpha: 1)
        label.font = UIFont.init(name: Font.mullerRegular, size: 14)
        return label
    }()
    lazy var onePlaceTitle: UILabel = {
        let label = UILabel()
        label.text = localized(text: "priceSeat")
        label.textColor = UIColor(red: 0.51, green: 0.51, blue: 0.51, alpha: 1)
        label.font = UIFont.init(name: Font.mullerRegular, size: 14)
        return label
    }()
    lazy var priceTitle: UILabel = {
        let label = UILabel()
        label.text = "4 500-5 000 тг"
        label.textColor = UIColor(red: 0.184, green: 0.502, blue: 0.929, alpha: 1)
        label.font = UIFont.init(name: Font.mullerBold, size: 18)
        return label
    }()
    
    // MARK: - init
    required init?(coder: NSCoder) {fatalError("")}
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .white
        addSubviews([freePlaceCountTitle,dateTitle,onePlaceTitle,priceTitle])
        freePlaceCountTitle.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.left.equalToSuperview().offset(16)
        }
        dateTitle.snp.makeConstraints { (make) in
            make.top.equalTo(freePlaceCountTitle.snp.bottom).offset(8)
            make.left.equalToSuperview().offset(16)
        }
        onePlaceTitle.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.right.equalToSuperview().offset(-16)
        }
        priceTitle.snp.makeConstraints { (make) in
            make.top.equalTo(onePlaceTitle.snp.bottom).offset(4)
            make.right.equalToSuperview().offset(-16)
            make.bottom.equalToSuperview()
        }
    }
}
