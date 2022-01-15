//
//  ExitButtonView.swift
//  BusTime
//
//  Created by greetgo on 8/20/20.
//  Copyright © 2020 thousand.com. All rights reserved.
//

import UIKit
class ExitButtonView: UIView {

    lazy var icon = UIImageView(image: #imageLiteral(resourceName: "logout 1").withRenderingMode(.alwaysTemplate))
    lazy var title: UILabel = {
        let label = UILabel()
        label.text = localized(text: "exit")
        label.textColor = UIColor(red: 0.922, green: 0.341, blue: 0.341, alpha: 1)
        label.font = UIFont.init(name: Font.mullerMedium, size: 14)
        return label
    }()
    lazy var mainButton = UIButton()
    
    // MARK: - Init
    required init?(coder: NSCoder) {fatalError("")}
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        layer.shadowColor = UIColor.red.cgColor
        layer.shadowOpacity = 0.3
        layer.shadowOffset = CGSize.zero
        layer.shadowRadius = 6
        layer.cornerRadius = 5
        backgroundColor = .white
    
        addSubviews([icon,title,mainButton])
        icon.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(20)
            make.width.height.equalTo(20)
        }
        title.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
        }
        mainButton.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
}
