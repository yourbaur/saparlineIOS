//
//  RestorePassViewController.swift
//  SaparLine
//
//  Created by Rustem Madigassymov on 11/30/20.
//  Copyright © 2020 thousand.com. All rights reserved.
//

import UIKit

class RestorePassViewController: UIViewController {
    
    // MARK: - Variables
    var phone: String = ""
    
    // MARK: - Properties
    lazy var restoreTitle: UILabel = {
        let label = UILabel()
        label.text = localized(text: "restoreTitle")
        label.textAlignment = .center
        label.textColor = maincolor.blue
        label.font = UIFont.init(name: Font.mullerBold, size: 22)
        return label
    }()
    lazy var numberField: NumberTextField = {
        let field = NumberTextField()
        field.delegate = self
        return field
    }()
    lazy var nextButton: DefaultButton = {
        let btn = DefaultButton()
        btn.setTitle(localized(text: "further"), for: .normal)
        btn.addTarget(self, action: #selector(tapNext), for: .touchUpInside)
        return btn
    }()
    
    // MARK: - Lifecycle
    required init?(coder: NSCoder) { fatalError("") }
    init(phone: String) {
        super.init(nibName: nil, bundle: nil)
        self.phone = phone
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        view.backgroundColor = .white
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarPosition.any, barMetrics: UIBarMetrics.default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.tintColor = maincolor.blue
        navigationController?.navigationBar.topItem?.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
    // MARK: - SetupViews
    func setupViews() -> Void  {
        view.addSubviews([restoreTitle,numberField,nextButton])
        restoreTitle.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.width.equalToSuperview()
            make.bottom.equalTo(numberField.snp.top).offset(-30)
        }
        numberField.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
            make.height.equalTo(48)
        }
        nextButton.snp.makeConstraints { (make) in
            make.top.equalTo(numberField.snp.bottom).offset(30)
            make.left.equalToSuperview().offset(44)
            make.right.equalToSuperview().offset(-44)
            make.height.equalTo(48)
        }
    }
    
    // MARK: - Actions
    @objc func tapNext() -> Void {
        phone = String((numberField.text?.suffix(numberField.text!.count-2))!).replacingOccurrences(of: " ", with: "")
        let parameter = ["phone": phone]
        showHUD()
        ParseManager.shared.postRequest(url: api.restoreSMS, parameters: parameter) { [self] (result: String?, error) in
            self.dismissHUD()
//            if let error = error {
//                print(error)
//                self.showErrorMessage(messageType: .none, self.localized(text: "wrongData"))
//                return
//            }
            let vc = RestorePass2ViewController(phone: phone)
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}

// MARK: - Textfield delegate
extension RestorePassViewController: UITextFieldDelegate {
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
