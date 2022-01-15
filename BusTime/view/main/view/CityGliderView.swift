//
//  CityGliderView.swift
//  BusTime
//
//  Created by greetgo on 8/24/20.
//  Copyright © 2020 thousand.com. All rights reserved.
//

import UIKit

class CityGliderView: UIView {

    lazy var circleIcon = UIImageView(image: #imageLiteral(resourceName: "Group 10517"))
    lazy var timeTitle: UILabel = {
        let label = UILabel()
        label.text = "20:47"
        label.textColor = UIColor(red: 0.51, green: 0.51, blue: 0.51, alpha: 1)
        label.font = UIFont.init(name: Font.mullerRegular, size: 13)
        return label
    }()
    lazy var cityTitle: UILabel = {
        let label = UILabel()
        label.text = "р-н Кордай"
        label.textColor = UIColor(red: 0.094, green: 0.157, blue: 0.282, alpha: 1)
        label.font = UIFont.init(name: Font.mullerRegular, size: 14)
        return label
    }()
    lazy var priceTitle: UILabel = {
        let label = UILabel()
        label.text = "4 500 тг"
        label.textColor = UIColor(red: 0.184, green: 0.502, blue: 0.929, alpha: 1)
        label.font = UIFont.init(name: Font.mullerBold, size: 16)
        return label
    }()
    
    //  MARK: - init
    required init?(coder: NSCoder) {fatalError("")}
    init(city: String) {
        super.init(frame: .zero)
        
        cityTitle.text = city
        
        addSubviews([circleIcon,cityTitle])
        circleIcon.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(4)
            make.left.equalToSuperview().offset(44)
            make.width.equalTo(6)
            make.height.equalTo(30)
        }
        cityTitle.snp.makeConstraints { (make) in
            make.top.equalTo(circleIcon.snp.bottom).offset(8)
            make.left.equalToSuperview().offset(40)
            make.bottom.equalToSuperview()
        }
    }
}
