//
//  ExitView.swift
//  BusTime
//
//  Created by greetgo on 8/18/20.
//  Copyright © 2020 thousand.com. All rights reserved.
//

import UIKit

class ExitView: UIView {

    lazy var typeTitle: UILabel = {
        let label = UILabel()
        label.text = localized(text: "exit")
        label.textColor = maincolor.blue
        label.font = UIFont.init(name: Font.mullerRegular, size: 16)
        return label
    }()
    lazy var arrowImage = UIImageView(image: #imageLiteral(resourceName: "Group-14"))
    lazy var justImage = UIImageView(image: #imageLiteral(resourceName: "Rectangle 41"))
    
    
    required init?(coder: NSCoder) {fatalError("")}
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
        
        addSubviews([justImage,typeTitle,arrowImage])
        justImage.snp.makeConstraints { (make) in
            make.top.bottom.right.equalToSuperview()
            make.width.equalTo(6)
            make.height.equalTo(48)
        }
        typeTitle.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(5)
            make.right.equalTo(justImage.snp.left).offset(-21.6)
        }
        arrowImage.snp.makeConstraints { (make) in
            make.top.equalTo(typeTitle.snp.bottom).offset(7.5)
            make.right.equalTo(justImage.snp.left).offset(-35.2)
        }
    }
}
