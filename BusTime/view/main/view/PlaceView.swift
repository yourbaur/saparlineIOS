//
//  PlaceView.swift
//  BusTime
//
//  Created by greetgo on 8/18/20.
//  Copyright © 2020 thousand.com. All rights reserved.
//

import UIKit
class PlaceView: UIView {

    lazy var yourPlaceImage = UIImageView(image: #imageLiteral(resourceName: "Group-17"))
    lazy var freePlaceImage = UIImageView(image: #imageLiteral(resourceName: "Group-16"))
    lazy var reservePlaceImage = UIImageView(image: #imageLiteral(resourceName: "Group-12"))
    lazy var processPlaceImage = UIImageView(image: #imageLiteral(resourceName: "Group-15"))
    
    lazy var yourTitle: UILabel = {
        let label = UILabel()
        label.text = localized(text: "yourPlace")
        label.textColor = UIColor(red: 0.094, green: 0.157, blue: 0.282, alpha: 1)
        label.font = UIFont.init(name: Font.mullerRegular, size: 14)
        return label
    }()
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
    lazy var processTitle: UILabel = {
        let label = UILabel()
        label.text = localized(text: "inProcess")
        label.textColor = UIColor(red: 0.094, green: 0.157, blue: 0.282, alpha: 1)
        label.font = UIFont.init(name: Font.mullerRegular, size: 14)
        return label
    }()
    
    
    required init?(coder: NSCoder) {fatalError("")}
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews([yourPlaceImage,freePlaceImage,reservePlaceImage,processPlaceImage])
        addSubviews([yourTitle,freeTitle,reserveTitle,processTitle])
        
        yourPlaceImage.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.left.equalToSuperview().offset(30)
            make.width.height.equalTo(40)
        }
        freePlaceImage.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.left.equalTo(yourPlaceImage.snp.right).offset(55)
            make.width.height.equalTo(40)
        }
        reservePlaceImage.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.right.equalToSuperview().offset(-30)
            make.width.height.equalTo(40)
        }
        processPlaceImage.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.right.equalTo(reservePlaceImage.snp.left).offset(-55)
            make.width.height.equalTo(40)
        }
        
        yourTitle.snp.makeConstraints { (make) in
            make.top.equalTo(yourPlaceImage.snp.bottom).offset(4)
            make.centerX.equalTo(yourPlaceImage.snp.centerX)
            make.bottom.equalToSuperview()
        }
        freeTitle.snp.makeConstraints { (make) in
            make.top.equalTo(freePlaceImage.snp.bottom).offset(4)
            make.centerX.equalTo(freePlaceImage.snp.centerX)
            make.bottom.equalToSuperview()
        }
        reserveTitle.snp.makeConstraints { (make) in
            make.top.equalTo(reservePlaceImage.snp.bottom).offset(4)
            make.centerX.equalTo(reservePlaceImage.snp.centerX)
            make.bottom.equalToSuperview()
        }
        processTitle.snp.makeConstraints { (make) in
            make.top.equalTo(processPlaceImage.snp.bottom).offset(4)
            make.centerX.equalTo(processPlaceImage.snp.centerX)
            make.bottom.equalToSuperview()
        }
    }
}
