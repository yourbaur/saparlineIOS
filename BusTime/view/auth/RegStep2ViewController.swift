//
//  RegStep2ViewController.swift
//  BusTime
//
//  Created by greetgo on 8/15/20.
//  Copyright © 2020 thousand.com. All rights reserved.
//

import UIKit

class RegStep2ViewController: ScrollViewController {

    var code: String = ""
    var phone: String = ""
    lazy var codeTarget: (String) -> () = {[weak self] code in
        guard let strongself = self else {return}
        strongself.code = code
    }
    var isPassenger = Bool()
    var timer: Timer?
    var secCounter = 60

    // MARK: - Properties
    private var viewModel = RegisterViewModel()
    lazy var stepTitle: UILabel = {
        let label = UILabel()
        label.text = localized(text: "step2")
        label.textColor = maincolor.blue
        label.font = UIFont.init(name: Font.mullerRegular, size: 13)
        return label
    }()
    lazy var stepView: StepView = {
        let view = StepView()
        view.view2.backgroundColor = maincolor.blue
        return view
    }()
    lazy var welcomeTitle: UILabel = {
        let label = UILabel()
        label.text = "Подтверждение номера"
        label.textColor = maincolor.blue
        label.font = UIFont.init(name: Font.mullerBold, size: 27)
        return label
    }()
    lazy var justTitle: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.text = "Введите код из 4 цифры, который мы вам отправили на номер +7\(phone)"
        label.textColor = maincolor.lightgray
        label.font = UIFont.init(name: Font.mullerRegular, size: 14)
        label.textAlignment = .center
        return label
    }()
    lazy var codeView: CodeTextFieldView = {
        let view = CodeTextFieldView()
        view.setClosureCode = codeTarget
        return view
    }()
    lazy var againTitle: UILabel = {
        let privacy = UILabel()
        privacy.textAlignment = .left
        privacy.numberOfLines = 0
        privacy.font = UIFont.systemFont(ofSize: 14.0)

        let attrs1 = [NSAttributedString.Key.font : UIFont.init(name: Font.mullerRegular, size: 12)!,
                      NSAttributedString.Key.foregroundColor :  maincolor.lightgray] as [NSAttributedString.Key : Any]
        let attrs2 = [NSAttributedString.Key.font : UIFont.init(name: Font.mullerRegular, size: 12)!,
                      NSAttributedString.Key.foregroundColor :  maincolor.blue] as [NSAttributedString.Key : Any]
        let attributedString1 = NSMutableAttributedString(string: "Отправить код повторно", attributes: attrs1)
        let attributedString2 = NSMutableAttributedString(string: " через \(secCounter) секунд", attributes:attrs2)
        attributedString1.append(attributedString2)
        privacy.attributedText = attributedString1

        return privacy
    }()
    lazy var confirmButton: DefaultButton = {
        let btn = DefaultButton()
        btn.setTitle("Подтвердить", for: .normal)
        btn.addTarget(self, action: #selector(tapConfirm), for: .touchUpInside)
        return btn
    }()
    
    // MARK: - Lifecycle
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        if self.isMovingFromParent {
            UserManager.shared.deleteCurrentSession()
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        view.backgroundColor = .white
        navigationController?.navigationBar.tintColor = maincolor.blue
        navigationController?.navigationBar.topItem?.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(processTimer), userInfo: nil, repeats: true)
    }
    
    // MARK: - init
    required init?(coder: NSCoder) { fatalError("") }
    init(isPassenger: Bool, viewModel: RegisterViewModel) {
        super.init(nibName: nil, bundle: nil)
        self.isPassenger = isPassenger
        self.viewModel = viewModel
        self.phone = viewModel.phone
    }
    
    // MARK: - Setup
    func setupViews() -> Void {
        view.addSubviews([stepTitle,stepView])
        stepTitle.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(50)
            make.centerX.equalToSuperview()
        }
        stepView.snp.makeConstraints { (make) in
            make.top.equalTo(stepTitle.snp.bottom).offset(12)
            make.height.equalTo(1)
            make.width.equalToSuperview()
        }
        scrollView.addSubviews([welcomeTitle,justTitle,codeView,againTitle,confirmButton])
        welcomeTitle.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(100)
            make.centerX.equalToSuperview()
        }
        justTitle.snp.makeConstraints { (make) in
            make.top.equalTo(welcomeTitle.snp.bottom).offset(8)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.8)
        }
        codeView.snp.makeConstraints { (make) in
            make.top.equalTo(justTitle.snp.bottom).offset(80)
            make.width.equalToSuperview()
            make.height.equalTo(65)
        }
        againTitle.snp.makeConstraints { (make) in
            make.top.equalTo(codeView.snp.bottom).offset(8)
            make.centerX.equalToSuperview()
        }
        confirmButton.snp.makeConstraints { (make) in
            make.top.equalTo(againTitle.snp.bottom).offset(30)
            make.left.equalToSuperview().offset(43)
            make.right.equalToSuperview().offset(-43)
            make.height.equalTo(48)
            make.bottom.equalToSuperview().offset(-30)
        }
    }
    
    // MARK: - Actions
    @objc func tapConfirm() -> Void {
        guard code.count == 4 else { self.showErrorMessage(messageType: .none, "Введите код!"); return }
        confirmCode()
    }
    @objc func processTimer() {
        if secCounter != 0 {
            secCounter -= 1
            updateLabel(firstColor: maincolor.lightgray, secondColor: maincolor.blue)
            againTitle.isUserInteractionEnabled = false
        } else {
            timer?.invalidate()
            updateLabel(firstColor: maincolor.blue, secondColor: maincolor.lightgray)
            againTitle.isUserInteractionEnabled = true
        }
    }
    private func updateLabel(firstColor: UIColor, secondColor: UIColor) {
        let attrs1 = [NSAttributedString.Key.font : UIFont.init(name: Font.mullerRegular, size: 12)!,
                      NSAttributedString.Key.foregroundColor: firstColor] as [NSAttributedString.Key : Any]
        let attrs2 = [NSAttributedString.Key.font : UIFont.init(name: Font.mullerRegular, size: 12)!,
                      NSAttributedString.Key.foregroundColor: secondColor] as [NSAttributedString.Key : Any]
        let attributedString1 = NSMutableAttributedString(string: "Отправить код повторно", attributes: attrs1)
        let attributedString2 = NSMutableAttributedString(string: " через \(secCounter) секунд", attributes:attrs2)
        attributedString1.append(attributedString2)
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapAgain))
        againTitle.addGestureRecognizer(tap)
        againTitle.attributedText = attributedString1
    }
    @objc func tapAgain() {
        requestCodeAgain()
    }
}

// MARK: - Parser
extension RegStep2ViewController {
    private func confirmCode() -> Void {
        showHUD()
        let parameter = ["phone": phone,
                         "code": code,
                         "device_type": "ios",
                         "device_token": AppDelegate.deviceToken]
        ParseManager.shared.postRequest(url: api.phoneConfirm, parameters: parameter) { (result: User?, error) in
            self.dismissHUD()
//            if let error = error {
//                self.showErrorMessage(messageType: .error, error)
//                return
//            }
            UserManager.shared.createSession(withUser: result!)
            UserManager.shared.setTypeUser(withArray: (result!.user!.role))
            self.showSuccessMessage { [self] in
                let vc = self.isPassenger ? RegStep3ViewController(code: self.code) : RegStep3DriverViewController(code: self.code)
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
    }
    private func requestCodeAgain() -> Void {
        let parameter = viewModel.getParameters()
        guard viewModel.isValid() else { self.showErrorMessage(messageType: .none, viewModel.errorMessage); return }
        showHUD()
        ParseManager.shared.postRequest(url: api.register, parameters: parameter) { [self] (result: String?, error) in
            self.dismissHUD()
//            if let error = error {
//                self.showErrorMessage(messageType: .error, error)
//                return
//            }
            self.showSuccessMessage {
                secCounter = 60
                codeView.firstInputTextField.text = ""
                codeView.secondInputTextField.text = ""
                codeView.thirdInputTextField.text = ""
                codeView.fourthInputTextField.text = ""
                timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(processTimer), userInfo: nil, repeats: true)
            }
        }
    }
}
