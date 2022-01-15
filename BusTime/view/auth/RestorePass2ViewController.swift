//
//  RestorePass2ViewController.swift
//  SaparLine
//
//  Created by Rustem Madigassymov on 11/30/20.
//  Copyright © 2020 thousand.com. All rights reserved.
//

import UIKit

class RestorePass2ViewController: UIViewController, UITextFieldDelegate {
    
    // MARK: - Variables
    var phone: String = ""
    
    // MARK: - Properties
    lazy var restoreTitle: UILabel = {
        let label = UILabel()
        label.text = localized(text: "restoreTitle")
        label.textAlignment = .center
        label.textColor = maincolor.blue
        label.font = UIFont.init(name: Font.mullerBold, size: 27)
        return label
    }()
    lazy var smsField: PasswordTextField = {
        let field = PasswordTextField()
        field.attributedPlaceholder = NSAttributedString(string: "СМС код", attributes: [.foregroundColor: UIColor.gray,
                                                                                              .font: UIFont.init(name: Font.mullerRegular, size: 14) as Any])
        field.isSecureTextEntry = false
        field.keyboardType = .numberPad
        return field
    }()
    lazy var passField: PasswordTextField = {
        let field = PasswordTextField()
        field.placeholder = "Пароль"
        return field
    }()
    lazy var confirmField: PasswordTextField = {
        let field = PasswordTextField()
        field.attributedPlaceholder = NSAttributedString(string: "Подтвердите пароль", attributes: [.foregroundColor: UIColor.gray,
                                                                                              .font: UIFont.init(name: Font.mullerRegular, size: 14) as Any])
        return field
    }()
    lazy var restoreButton: DefaultButton = {
        let btn = DefaultButton()
        btn.setTitle(localized(text: "restore"), for: .normal)
        btn.addTarget(self, action: #selector(tapRestore), for: .touchUpInside)
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
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarPosition.any, barMetrics: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.tintColor = maincolor.blue
        navigationController?.navigationBar.topItem?.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        showToast(message: "На ваш номер отправлен код подтверждения", font: .systemFont(ofSize: 14))
    }
    // MARK: - SetupViews
    func setupViews() -> Void  {
        view.addSubviews([restoreTitle,smsField,passField,confirmField,restoreButton])
        restoreTitle.snp.makeConstraints { (make) in
            make.width.equalToSuperview()
            make.bottom.equalTo(smsField.snp.top).offset(-30)
        }
        smsField.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
            make.bottom.equalTo(passField.snp.top).offset(-12)
            make.height.equalTo(48)
        }
        passField.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
            make.height.equalTo(48)
        }
        confirmField.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
            make.top.equalTo(passField.snp.bottom).offset(12)
            make.height.equalTo(48)
        }
        restoreButton.snp.makeConstraints { (make) in
            make.top.equalTo(confirmField.snp.bottom).offset(30)
            make.left.equalToSuperview().offset(44)
            make.right.equalToSuperview().offset(-44)
            make.height.equalTo(48)
        }
    }
    
    // MARK: - Actions
    @objc func tapRestore() -> Void {
        if passField.text != confirmField.text {
            showErrorMessage(messageType: .error, "Пароли не совпадают!")
            return
        }
        let parameter: [String: Any] = ["phone": phone,
                                        "password": passField.text ?? "",
                                        "code": smsField.text ?? ""]
        showHUD()
        ParseManager.shared.postRequest(url: api.restoreNewPass, parameters: parameter) { (result: CheckRequest?, error) in
            self.dismissHUD()
//            if let error = error {
//                print(error)
//                self.showErrorMessage(messageType: .none, self.localized(text: "wrongData"))
//                return
//            }
            self.showToast(message: "Пароль успешно изменен!", font: .systemFont(ofSize: 14))
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                AppCenter.shared.startAuth()
            }
        }
    }
}

