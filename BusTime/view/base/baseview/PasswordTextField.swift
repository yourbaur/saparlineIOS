//
//  PasswordTextField.swift
//  Helper
//
//  Created by Tuigynbekov Yelzhan on 10/26/19.
//  Copyright © 2019 Yelzhan Tuigynbekov. All rights reserved.
//

import UIKit

class PasswordTextField: UITextField, UITextFieldDelegate {

    // MARK: - Properties
    lazy var imageKey: UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "Group"), for: .normal)
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: -16, bottom: 0, right: 0)
        return button
    }()
    lazy var btnEye: UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "Vector"), for: .normal)
        button.addTarget(self, action: #selector(actionButton(button:)), for: .touchUpInside)
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
    
    // MARK: - SetupViews
    func setupViews() -> Void {
        
        layer.cornerRadius = 5
        textColor = maincolor.blue
        font = UIFont.init(name: Font.mullerBold, size: 16)
        isSecureTextEntry = true
        
        let space = UIView(frame: CGRect(x: 0, y: 0, width: 60, height: 0))
        leftView = space
        leftViewMode = .always
        rightView = space
        rightViewMode = .always
        attributedPlaceholder = NSAttributedString(string: "Пароль", attributes: [.foregroundColor: UIColor.gray,
                                                                                  .font: UIFont.init(name: Font.mullerRegular, size: 14) as Any])
        
        addSubview(imageKey)
        imageKey.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(36)
            make.width.height.equalTo(20)
        }
        addSubview(btnEye)
        btnEye.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().offset(-16)
            make.width.height.equalTo(20)
        }
        
        layer.shadowColor = UIColor.gray.cgColor
        layer.shadowOpacity = 0.3
        layer.shadowOffset = CGSize.zero
        layer.shadowRadius = 6
    }
    
    // MARK: - Actions
    @objc func actionButton(button: UIButton) {
        isSecureTextEntry = !isSecureTextEntry
        isSecureTextEntry ? btnEye.setImage(#imageLiteral(resourceName: "Vector"), for: .normal) : btnEye.setImage(#imageLiteral(resourceName: "eye2"), for: .normal)
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        btnEye.isEnabled = true
        btnEye.isUserInteractionEnabled = true
    }
    
}
