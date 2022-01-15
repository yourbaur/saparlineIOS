//
//  FilterUniverTableViewCell.swift
//  KASE mobile
//
//  Created by greetgo on 10/21/20.
//  Copyright © 2020 greetgo. All rights reserved.
//

import UIKit

class FilterUniverTableViewCell: UITableViewCell {

    lazy var itemSelected = false
    lazy var iconImage = UIImageView(image: #imageLiteral(resourceName: "Frame 36-1"))
    lazy var label: UILabel = {
        let label = UILabel()
        label.text = "-"
        label.textColor = .black
        label.font = UIFont.init(name: Font.mullerRegular, size: 16)
        label.numberOfLines = .zero
        label.textAlignment = .left
        return label
    }()
    
    required init?(coder: NSCoder) {fatalError("")}
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(label)
        label.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(16)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
            make.bottom.equalToSuperview().offset(-16)
        }
        addSubview(iconImage)
        iconImage.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-16)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(26)
        }
    }
}
