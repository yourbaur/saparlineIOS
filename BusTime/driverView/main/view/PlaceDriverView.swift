//
//  PlaceDriverView.swift
//  BusTime
//
//  Created by greetgo on 8/26/20.
//  Copyright © 2020 thousand.com. All rights reserved.
//

import UIKit
class PlaceDriverView: UIView {
    // MARK: - Properties
    lazy var freePlaceImage = UIImageView(image: #imageLiteral(resourceName: "Group-16"))
    lazy var reservePlaceImage = UIImageView(image: #imageLiteral(resourceName: "Group-12"))
    lazy var freeTitle: UILabel = {
        let label = UILabel()
        label.text = localized(text: "free")
        label.textColor = UIColor(red: 0.094, green: 0.157, blue: 0.282, alpha: 1)
        label.font = UIFont.init(name: Font.mullerRegular, size: 14)
        return label
    }()
    lazy var reserveTitle: UILabel = {
        let label = UILabel()
        label.text = localized(text: "private")
        label.textColor = UIColor(red: 0.094, green: 0.157, blue: 0.282, alpha: 1)
        label.font = UIFont.init(name: Font.mullerRegular, size: 14)
        return label
    }()
    
    // MARK: - lifecycle
    required init?(coder: NSCoder) {fatalError("")}
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        addSubviews([freePlaceImage,reservePlaceImage])
        addSubviews([freeTitle,reserveTitle])

        freePlaceImage.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.right.equalTo(-((UIScreen.main.bounds.width/2)+15))
            make.width.height.equalTo(40)
        }
        reservePlaceImage.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.left.equalTo((UIScreen.main.bounds.width/2)+15)
            make.width.height.equalTo(40)
        }

        freeTitle.snp.makeConstraints { (make) in
            make.top.equalTo(freePlaceImage.snp.bottom).offset(4)
            make.centerX.equalTo(freePlaceImage.snp.centerX)
        }
        reserveTitle.snp.makeConstraints { (make) in
            make.top.equalTo(reservePlaceImage.snp.bottom).offset(4)
            make.centerX.equalTo(reservePlaceImage.snp.centerX)
            make.bottom.equalToSuperview()
        }
    }
}
