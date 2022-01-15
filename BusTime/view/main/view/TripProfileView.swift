//
//  TripProfileView.swift
//  BusTime
//
//  Created by Tuigynbekov Yelzhan on 8/19/20.
//  Copyright © 2020 thousand.com. All rights reserved.
//

import UIKit

class TripProfileView: UIView {

    lazy var imageIcon: UIImageView = {
        let image = UIImageView(image: #imageLiteral(resourceName: "Group 10558"))
        image.layer.cornerRadius = 25
        image.clipsToBounds = true
        return image
    }()
    lazy var nameTitle: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textColor = maincolor.blue
        label.font = UIFont.init(name: Font.mullerMedium, size: 18)
        return label
    }()
    
    required init?(coder: NSCoder) {fatalError("")}
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        addSubviews([imageIcon,nameTitle])
        imageIcon.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.left.equalToSuperview().offset(16)
            make.width.height.equalTo(50)
            make.bottom.equalToSuperview()
        }
        nameTitle.snp.makeConstraints { (make) in
            make.centerY.equalTo(imageIcon.snp.centerY)
            make.left.equalTo(imageIcon.snp.right).offset(16)
        }
    }
}
