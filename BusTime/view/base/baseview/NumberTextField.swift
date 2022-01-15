//
//  NumberTextField.swift
//  Helper
//
//  Created by Tuigynbekov Yelzhan on 10/26/19.
//  Copyright © 2019 Yelzhan Tuigynbekov. All rights reserved.
//

import UIKit

class NumberTextField: UITextField {

    // MARK: - Properties
    lazy var imageProfile: UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "asd"), for: .normal)
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: -16, bottom: 0, right: 0)
        return button
    }()

    
    // MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .white
        setupViews()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Setup
    func setupViews() -> Void {
        text = "+7"
        textColor = maincolor.blue
        tintColor = maincolor.blue
        font = UIFont.init(name: Font.mullerBold, size: 16)
        keyboardType = .numberPad
        layer.cornerRadius = 5
        
        let space = UIView(frame: CGRect(x: 0, y: 0, width: 65, height: 0))
        leftView = space
        leftViewMode = .always
        
        addSubview(imageProfile)
        imageProfile.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(36)
            make.width.height.equalTo(20)
        }
        
        layer.shadowColor = UIColor.gray.cgColor
        layer.shadowOpacity = 0.3
        layer.shadowOffset = CGSize.zero
        layer.shadowRadius = 6
    }
}

