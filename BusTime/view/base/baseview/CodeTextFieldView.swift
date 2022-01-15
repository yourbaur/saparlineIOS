
//  LTGas
//  Created by Tuigynbekov Yelzhan on 1/29/20.
//  Copyright © 2020 Tuigynbekov Yelzhan. All rights reserved.

import UIKit
class CodeTextFieldView: UIView {

    var setClosureCode: ((String) -> ())?

    // MARK: - Properties
    lazy var firstInputTextField: UITextField = {
        let text = UITextField()
        text.layer.cornerRadius = 5
        text.keyboardType = UIKeyboardType.numberPad
        text.textAlignment = .center
        text.isSecureTextEntry = false
        text.backgroundColor = .white
        text.textColor = maincolor.blue
        text.tintColor = maincolor.blue
        text.font = UIFont.init(name: Font.mullerBold, size: 20)
        
        text.layer.shadowColor = UIColor.gray.cgColor
        text.layer.shadowOpacity = 0.3
        text.layer.shadowOffset = CGSize.zero
        text.layer.shadowRadius = 6
        
        text.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: .editingChanged)
        return text
    }()
    lazy var secondInputTextField: UITextField = {
        let text = UITextField()
        text.layer.cornerRadius = 5
        text.keyboardType = UIKeyboardType.numberPad
        text.textAlignment = .center
        text.isSecureTextEntry = false
        text.backgroundColor = .white
        text.textColor = maincolor.blue
        text.tintColor = maincolor.blue
        text.font = UIFont.init(name: Font.mullerBold, size: 20)
        
        text.layer.shadowColor = UIColor.gray.cgColor
        text.layer.shadowOpacity = 0.3
        text.layer.shadowOffset = CGSize.zero
        text.layer.shadowRadius = 6
        
        text.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: .editingChanged)
        return text
    }()
    lazy var thirdInputTextField: UITextField = {
        let text = UITextField()
        text.layer.cornerRadius = 5
        text.keyboardType = UIKeyboardType.numberPad
        text.textAlignment = .center
        text.isSecureTextEntry = false
        text.backgroundColor = .white
        text.textColor = maincolor.blue
        text.tintColor = maincolor.blue
        text.font = UIFont.init(name: Font.mullerBold, size: 20)
        
        text.layer.shadowColor = UIColor.gray.cgColor
        text.layer.shadowOpacity = 0.3
        text.layer.shadowOffset = CGSize.zero
        text.layer.shadowRadius = 6
        
        text.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: .editingChanged)
        return text
    }()
    lazy var fourthInputTextField: UITextField = {
        let text = UITextField()
        text.layer.cornerRadius = 5
        text.keyboardType = UIKeyboardType.numberPad
        text.textAlignment = .center
        text.isSecureTextEntry = false
        text.backgroundColor = .white
        text.textColor = maincolor.blue
        text.tintColor = maincolor.blue
        text.font = UIFont.init(name: Font.mullerBold, size: 20)
        
        text.layer.shadowColor = UIColor.gray.cgColor
        text.layer.shadowOpacity = 0.3
        text.layer.shadowOffset = CGSize.zero
        text.layer.shadowRadius = 6
        
        text.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: .editingChanged)
        return text
    }()
    
    
    // MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK:- Setup
    func setupViews() -> Void {
        addSubview(firstInputTextField)
        addSubview(secondInputTextField)
        addSubview(thirdInputTextField)
        addSubview(fourthInputTextField)

        secondInputTextField.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview().offset(-40)
            make.height.width.equalTo(56)
            make.centerY.equalToSuperview()
        }
        thirdInputTextField.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview().offset(40)
            make.height.width.equalTo(56)
            make.centerY.equalToSuperview()
        }
        firstInputTextField.snp.makeConstraints { (make) in
            make.right.equalTo(secondInputTextField.snp.left).offset(-15)
            make.height.width.equalTo(56)
            make.centerY.equalToSuperview()
        }
        fourthInputTextField.snp.makeConstraints { (make) in
            make.left.equalTo(thirdInputTextField.snp.right).offset(15)
            make.height.width.equalTo(56)
            make.centerY.equalToSuperview()
        }
    }
    
    
    // MARK: - Actions
    @objc func textFieldDidChange(textField: UITextField) {
        let text = textField.text
        if text?.count == 1 {
            switch textField {
            case firstInputTextField:
                secondInputTextField.becomeFirstResponder()
            case secondInputTextField:
                thirdInputTextField.becomeFirstResponder()
            case thirdInputTextField:
                fourthInputTextField.becomeFirstResponder()
            case fourthInputTextField:
                fourthInputTextField.resignFirstResponder()
                getCode(firstInputTextField.text!, secondInputTextField.text!, thirdInputTextField.text!, fourthInputTextField.text!)
            default:
                break
            }
        }
        if text?.count == 0 {
            switch textField {
            case secondInputTextField:
                firstInputTextField.becomeFirstResponder()
            case thirdInputTextField:
                secondInputTextField.becomeFirstResponder()
            case fourthInputTextField:
                thirdInputTextField.becomeFirstResponder()
            default:
                break
            }
        }
    }
    
    
    // MARK: - Simple Function
    func getCode(_ one:String, _ two:String, _ three:String, _ four:String) -> Void {
        let codes = one + two + three + four
        setClosureCode?(codes)
    }
}
