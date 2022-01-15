//
//  CityDescriptionView.swift
//  BusTime
//
//  Created by Tuigynbekov Yelzhan on 8/16/20.
//  Copyright © 2020 thousand.com. All rights reserved.
//

import UIKit

class CityDescriptionView: UIView {

    lazy var timeTitle: UILabel = {
        let title = UILabel()
        title.text = "12:58"
        title.textColor = maincolor.blue
        title.font = UIFont.init(name: Font.mullerRegular, size: 16)
        return title
    }()
    lazy var cityTitle: UILabel = {
        let title = UILabel()
        title.text = "Алматы"
        title.textColor = maincolor.blue
        title.font = UIFont.init(name: Font.mullerMedium, size: 18)
        return title
    }()
    lazy var parkTitle: UILabel = {
        let title = UILabel()
        title.text = "Сайран"
        title.textColor = .gray//UIColor(red: 0.741, green: 0.741, blue: 0.741, alpha: 1)
        title.font = UIFont.init(name: Font.mullerRegular, size: 14)
        return title
    }()
    lazy var arrawImage = UIImageView(image: #imageLiteral(resourceName: "Group-7"))
    lazy var dateTitle: UILabel = {
        let title = UILabel()
        title.text = "23 июля 2020"
        title.textColor = .gray//UIColor(red: 0.741, green: 0.741, blue: 0.741, alpha: 1)
        title.font = UIFont.init(name: Font.mullerRegular, size: 14)
        return title
    }()
    
    
    // MARK: - Initialization
    required init?(coder: NSCoder) {fatalError("")}
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .white
        
        addSubviews([cityTitle,parkTitle,arrawImage])
        cityTitle.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.left.equalToSuperview()
        }
        parkTitle.snp.makeConstraints { (make) in
            make.top.equalTo(cityTitle.snp.bottom).offset(4)
            make.left.equalTo(cityTitle.snp.left)
            make.bottom.equalToSuperview()
        }
        arrawImage.snp.makeConstraints { (make) in
            make.centerY.equalTo(cityTitle.snp.centerY)
            make.left.equalTo(cityTitle.snp.right).offset(16)
            make.right.equalToSuperview()
        }
    }
}
