//
//  MenuTableViewCell.swift
//  BusTime
//
//  Created by Tuigynbekov Yelzhan on 8/15/20.
//  Copyright © 2020 thousand.com. All rights reserved.
//

import UIKit
class MenuTableViewCell: UITableViewCell {

    // MARK: - Properties
    lazy var iconImageView: UIImageView = {
        let image = UIImageView()
        image.image = #imageLiteral(resourceName: "home")
        return image
    }()
    lazy var title: UILabel = {
        let label = UILabel()
        label.text = "Главная"
        label.textColor = .white
        label.font = UIFont.init(name: Font.mullerMedium, size: 18)
        return label
    }()
    
    
    // MARK: - Init
    required init?(coder: NSCoder) { fatalError("") }
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupViews()
    }
    
    
    // MARK: - Setup
    func setupViews() -> Void {
        backgroundColor = .clear
        
        addSubviews([iconImageView, title])
        iconImageView.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(16)
            make.width.height.equalTo(20)
        }
        title.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.left.equalTo(iconImageView.snp.right).offset(15)
        }
    }
}
