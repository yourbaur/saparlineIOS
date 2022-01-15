//
//  LoginViewController.swift
//  BusTime
//
//  Created by Tuigynbekov Yelzhan on 8/14/20.
//  Copyright © 2020 thousand.com. All rights reserved.
//

import UIKit

class LoginViewController: ScrollViewController {

    // MARK: - Variables
    private var viewModel = LoginViewModel()

    // MARK: - Properties
    lazy var comebackTitle: UILabel = {
        let label = UILabel()
        label.text = localized(text: "welcomeBack")
        label.textColor = maincolor.blue
        label.font = UIFont.init(name: Font.mullerBold, size: 27)
        return label
    }()
    lazy var ifTitle: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.text = localized(text: "haveAccount")
        label.textColor = maincolor.lightgray
        label.font = UIFont.init(name: Font.mullerRegular, size: 14)
        label.textAlignment = .center
        return label
    }()
    lazy var numberField: NumberTextField = {
        let field = NumberTextField()
        field.delegate = self
        return field
    }()
    lazy var passField: PasswordTextField = {
        let field = PasswordTextField()
        return field
    }()
    lazy var losePassButton: UIButton = {
        let btn = UIButton()
        btn.setTitle(localized(text: "restore"), for: .normal)
        btn.titleLabel?.font = UIFont.init(name: Font.mullerRegular, size: 12)
        btn.setTitleColor(maincolor.blue, for: .normal)
        btn.addTarget(self, action: #selector(tapRestore), for: .touchUpInside)
        return btn
    }()
    lazy var losePassTitle: UILabel = {
        let btn = UILabel()
        btn.text = localized(text: "forgotPass")
        btn.font = UIFont.init(name: Font.mullerRegular, size: 12)
        btn.textColor = maincolor.lightgray
        return btn
    }()
    lazy var loginButton: DefaultButton = {
        let btn = DefaultButton()
        btn.setTitle(localized(text: "login"), for: .normal)
        btn.addTarget(self, action: #selector(tapLogin), for: .touchUpInside)
        return btn
    }()
    lazy var createAccButton: DefaultButton = {
        let btn = DefaultButton()
        btn.setTitle(localized(text: "createAcc"), for: .normal)
        btn.backgroundColor = UIColor(red: 0.949, green: 0.949, blue: 0.949, alpha: 1)
        btn.setTitleColor(maincolor.blue, for: .normal)
        btn.addTarget(self, action: #selector(tapCreateAcc), for: .touchUpInside)
        return btn
    }()
    
    // MARK: - Lifecycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        view.backgroundColor = .white
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarPosition.any, barMetrics: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        
        //showToast(message: "Test Test Test Test Test Test Test Test Test", font: .systemFont(ofSize: 14))
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }

    // MARK: - SetupViews
    func setupViews() -> Void {
        scrollView.addSubviews([comebackTitle,ifTitle,numberField,passField,losePassButton,losePassTitle,loginButton,createAccButton])
        comebackTitle.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(100)
            make.centerX.equalToSuperview()
        }
        ifTitle.snp.makeConstraints { (make) in
            make.top.equalTo(comebackTitle.snp.bottom).offset(8)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.7)
        }
        numberField.snp.makeConstraints { (make) in
            make.top.equalTo(ifTitle.snp.bottom).offset(48)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
            make.height.equalTo(48)
        }
        passField.snp.makeConstraints { (make) in
            make.top.equalTo(numberField.snp.bottom).offset(12)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
            make.height.equalTo(48)
        }
        losePassButton.snp.makeConstraints { (make) in
            make.top.equalTo(passField.snp.bottom).offset(13)
            make.right.equalToSuperview().offset(-16)
        }
        losePassTitle.snp.makeConstraints { (make) in
            make.centerY.equalTo(losePassButton.snp.centerY)
            make.right.equalTo(losePassButton.snp.left).offset(-2)
        }
        loginButton.snp.makeConstraints { (make) in
            make.top.equalTo(losePassTitle.snp.bottom).offset(50)
            make.left.equalToSuperview().offset(44)
            make.right.equalToSuperview().offset(-44)
            make.height.equalTo(48)
        }
        createAccButton.snp.makeConstraints { (make) in
            make.top.equalTo(loginButton.snp.bottom).offset(8)
            make.left.equalToSuperview().offset(44)
            make.right.equalToSuperview().offset(-44)
            make.height.equalTo(48)
        }
    }
    
    // MARK: - Actions
    @objc
    func tapLogin() -> Void {
        //tapTest()
        login()
    }
    @objc
    func tapTest() -> Void {
        navigationController?.pushViewController(RegStep3DriverViewController(code: ""), animated: true)
    }
    @objc
    func tapCreateAcc() -> Void {
        navigationController?.pushViewController(RegStep1ViewController(), animated: true)
    }
    @objc
    func tapRestore() {
        let vc = RestorePassViewController(phone: viewModel.phone)
        navigationController?.pushViewController(vc, animated: true)
    }
}

// MARK: - Textfield delegate
extension LoginViewController: UITextFieldDelegate {
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
        //viewModel.setPhone(text.appending(string))
        return true
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        viewModel.setPhone(textField.text!)
    }
}

// MARK: - Parser
extension LoginViewController {
    private func login() -> Void {
        viewModel.password = passField.text ?? ""
        let parameters = viewModel.getParameters()
        guard viewModel.isValid() else {self.showErrorMessage(messageType: .none, viewModel.errorMessage); return}
        showHUD()
        ParseManager.shared.postRequest(url: api.auth, parameters: parameters) { (result: User?, error) in
            self.dismissHUD()
            if let error = error {
                print(error)
                self.showErrorMessage(messageType: .none,  self.localized(text: "wrongData"))
                return
            }
            
            if result != nil {
                self.showSuccessMessage()
                result?.user?.role == "passenger" ? UserManager.shared.setTypeUser(withArray: "passenger") : UserManager.shared.setTypeUser(withArray: "driver")
            UserManager.shared.createSession(withUser: result!)
                result?.user?.role == "passenger" ? AppCenter.shared.startCustomer() : AppCenter.shared.startDriver()}
          
        }
    }
}

// MARK: - Toast
extension UIViewController {

func showToast(message : String, font: UIFont) {

    let toastLabel = UILabel(frame: CGRect(x: self.view.frame.size.width/2 - 100, y: self.view.frame.size.height/2, width: 200, height: 44))
    toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
    toastLabel.textColor = UIColor.white
    toastLabel.font = font
    toastLabel.textAlignment = .center;
    toastLabel.text = message
    toastLabel.numberOfLines = 2
    toastLabel.alpha = 1.0
    toastLabel.layer.cornerRadius = 10;
    toastLabel.clipsToBounds  =  true
    self.view.addSubview(toastLabel)
    UIView.animate(withDuration: 4.0, delay: 1.0, options: .curveEaseOut, animations: {
         toastLabel.alpha = 0.0
    }, completion: {(isCompleted) in
        toastLabel.removeFromSuperview()
    })
} }
