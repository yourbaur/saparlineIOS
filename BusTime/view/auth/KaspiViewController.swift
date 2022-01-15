//
//  KaspiViewController.swift
//  SaparLine
//
//  Created by Admin on 1/23/21.
//  Copyright © 2021 thousand.com. All rights reserved.
//

import Foundation
import UIKit

protocol KaspiViewControllerDelegate: class {
    func kaspiTitle(kaspiTitle: String, fullName:String, kaspiNumber:String)
}

class KaspiViewControlller: UIViewController {

    weak var delegate: KaspiViewControllerDelegate?
    
    // MARK: - Properties
    lazy var quesTitle: UILabel = {
        let label = UILabel()
        label.numberOfLines = 3
        label.text = localized(text: "kaspiText")
        label.textColor = maincolor.blue
        label.font = UIFont.init(name: Font.mullerBold, size: 27)
        label.textAlignment = .center
        return label
    }()
    lazy var kaspiField: NumberTextField = {
        let field = NumberTextField()
        field.delegate = self
        field.attributedPlaceholder = NSAttributedString(string: localized(text: "kaspi"), attributes: [.foregroundColor: UIColor.gray,
                                                                                     .font: UIFont.init(name: Font.mullerRegular, size: 14) as Any])
        return field
    }()
 
    lazy var fullNameField: DefaultTextField = {
        let field = DefaultTextField()
        field.keyboardType = .default
        field.rightImage.isHidden = true
        field.actionButton.isHidden = true
        field.attributedPlaceholder = NSAttributedString(string: localized(text: "fullName"), attributes: [.foregroundColor: UIColor.gray,
                                                                                     .font: UIFont.init(name: Font.mullerRegular, size: 14) as Any])
        return field
    }()
 
    lazy var addButton: DefaultButton = {
        let btn = DefaultButton()
        btn.setTitle(localized(text: "addButton"), for: .normal)
        btn.addTarget(self, action: #selector(tapAdd), for: .touchUpInside)
        return btn
    }()
    
    // MARK: - Lifecycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        view.backgroundColor = .white
        navigationController?.navigationBar.tintColor = maincolor.blue
        navigationController?.navigationBar.topItem?.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    // MARK: - Setup
    func setupViews() -> Void {
        view.addSubviews([quesTitle, kaspiField, fullNameField, addButton])
        quesTitle.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(80)
            make.centerX.equalToSuperview()
            make.left.equalToSuperview().offset(42)
            make.right.equalToSuperview().offset(-42)
        }
        kaspiField.snp.makeConstraints { (make) in
            make.top.equalTo(quesTitle.snp.bottom).offset(20)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
            make.height.equalTo(48)
        }
        fullNameField.snp.makeConstraints { (make) in
            make.top.equalTo(kaspiField.snp.bottom).offset(20)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
            make.height.equalTo(48)
        }
      
        addButton.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(43)
            make.right.equalToSuperview().offset(-43)
            make.height.equalTo(48)
            make.top.equalTo(fullNameField.snp.bottom).offset(20)
        }
       
    }
    
    // MARK: - Actions
    @objc func tapAdd() -> Void {
        
        
        let fullText = "\(kaspiField.text ?? "" ), \(fullNameField.text ?? "")"
        delegate?.kaspiTitle(kaspiTitle: fullText, fullName: fullNameField.text ?? "", kaspiNumber: kaspiField.text ?? "")
        navigationController?.popViewController(animated: true)
    }
}


extension KaspiViewControlller: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let text = textField.text!
        let spaceIndex = [2, 6, 10, 13]
        if text == "+7" && string == "" {
            return false
        }
        if text.count == 16 && string != "" {
            return false
        }
        if spaceIndex.contains(textField.text!.count) && string != "" {
            textField.text!.append(" ")
        }
        return true
    }
   
}
