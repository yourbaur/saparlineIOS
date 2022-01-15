//
//  RegStep1ViewController.swift
//  BusTime
//
//  Created by greetgo on 8/15/20.
//  Copyright © 2020 thousand.com. All rights reserved.
//

import UIKit
import BEMCheckBox

class RegStep1ViewController: ScrollViewController {

    // MARK: - Variables
    private var viewModel = RegisterViewModel()
    lazy var pickerView: UIPickerView = {
        let picker = UIPickerView()
        picker.delegate = self
        picker.dataSource = self
        return picker
    }()
    var typeUserArray = ["Пассажир", "Водитель"]
    
    // MARK: - Properties
    lazy var stepTitle: UILabel = {
        let label = UILabel()
        label.text = localized(text: "step1")
        label.textColor = maincolor.blue
        label.font = UIFont.init(name: Font.mullerRegular, size: 13)
        return label
    }()
    lazy var stepView: StepView = {
        let view = StepView()
        view.view1.backgroundColor = maincolor.blue
        return view
    }()
    lazy var welcomeTitle: UILabel = {
        let label = UILabel()
        label.text = localized(text: "welcome") + "!"
        label.textColor = maincolor.blue
        label.font = UIFont.init(name: Font.mullerBold, size: 27)
        return label
    }()
    lazy var justTitle: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.text = localized(text: "createAccText")
        label.textColor = maincolor.lightgray
        label.font = UIFont.init(name: Font.mullerRegular, size: 14)
        label.textAlignment = .center
        return label
    }()
    lazy var typeTextfield: DefaultTextField = {
        let field = DefaultTextField()
        field.text = "Пассажир"
        field.inputView = pickerView
        field.actionButton.isHidden = true
        return field
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
    lazy var passField2: PasswordTextField = {
        let field = PasswordTextField()
        field.attributedPlaceholder = NSAttributedString(string: localized(text: "confirmPass"), attributes: [.foregroundColor: UIColor.gray,
                                                                                                    .font: UIFont.init(name: Font.mullerRegular, size: 14) as Any])
        return field
    }()

    lazy var conditionTitle: UILabel = {
        let privacy = UILabel()
        privacy.textAlignment = .left
        privacy.numberOfLines = 0
        privacy.font = UIFont.systemFont(ofSize: 14.0)

        let attrs1 = [NSAttributedString.Key.font : UIFont.init(name: Font.mullerRegular, size: 12)!,
                      NSAttributedString.Key.foregroundColor :  maincolor.lightgray] as [NSAttributedString.Key : Any]
        
        let attrs2 = [NSAttributedString.Key.font : UIFont.init(name: Font.mullerRegular, size: 12)!,
                      NSAttributedString.Key.foregroundColor :  maincolor.blue] as [NSAttributedString.Key : Any]
        
        let attributedString1 = NSMutableAttributedString(string: "Я согласен с", attributes: attrs1)
        let attributedString2 = NSMutableAttributedString(string: " условиями использования", attributes:attrs2)
        let attributedString3 = NSMutableAttributedString(string: " и", attributes: attrs1)
        let attributedString4 = NSMutableAttributedString(string: " политикой конфиденциальности", attributes: attrs2)
        
        attributedString1.append(attributedString2)
        attributedString1.append(attributedString3)
        attributedString1.append(attributedString4)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(toPolicy))
        privacy.isUserInteractionEnabled = true
        privacy.addGestureRecognizer(tap)
        privacy.attributedText = attributedString1

        return privacy
    }()
    lazy var checkBox: BEMCheckBox = {
        let check = BEMCheckBox()
        check.on = false
        check.boxType = .square
        check.lineWidth = 1
        check.onCheckColor = maincolor.blue
        check.onTintColor = maincolor.blue
        check.onFillColor = .white
        check.onAnimationType = .oneStroke
        check.offAnimationType = .oneStroke
        return check
    }()
    lazy var nextButton: DefaultButton = {
        let btn = DefaultButton()
        btn.setTitle(localized(text: "further"), for: .normal)
        btn.addTarget(self, action: #selector(tapNext), for: .touchUpInside)
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
        scrollView.addSubviews([welcomeTitle,justTitle,typeTextfield,numberField,passField,passField2,conditionTitle,checkBox,nextButton])
        welcomeTitle.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(80)
            make.centerX.equalToSuperview()
        }
        justTitle.snp.makeConstraints { (make) in
            make.top.equalTo(welcomeTitle.snp.bottom).offset(8)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.7)
        }
        typeTextfield.snp.makeConstraints { (make) in
            make.top.equalTo(justTitle.snp.bottom).offset(60)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
            make.height.equalTo(48)
        }
        numberField.snp.makeConstraints { (make) in
            make.top.equalTo(typeTextfield.snp.bottom).offset(12)
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
        passField2.snp.makeConstraints { (make) in
            make.top.equalTo(passField.snp.bottom).offset(12)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
            make.height.equalTo(48)
        }
        conditionTitle.snp.makeConstraints { (make) in
            make.top.equalTo(passField2.snp.bottom).offset(12)
            make.left.equalToSuperview().offset(16)
            make.width.equalToSuperview().multipliedBy(0.8)
        }
        checkBox.snp.makeConstraints { (make) in
            make.centerY.equalTo(conditionTitle.snp.centerY)
            make.right.equalToSuperview().offset(-16)
            make.width.height.equalTo(16)
        }
        nextButton.snp.makeConstraints { (make) in
            make.top.equalTo(conditionTitle.snp.bottom).offset(30)
            make.left.equalToSuperview().offset(43)
            make.right.equalToSuperview().offset(-43)
            make.height.equalTo(48)
            make.bottom.equalToSuperview().offset(-30)
        }
    }
    
    // MARK: - Actions
    @objc func tapNext() -> Void {
        if checkBox.on == false {
            showErrorMessage(messageType: .none, "Подвердите что согласны с политикой конфидициальности")
        } else {
            viewModel.setRole(typeTextfield.text == "Пассажир" ? "passenger" : "driver")
            passField.text == passField2.text ? viewModel.setPassword(passField.text ?? "") : showErrorMessage(messageType: .error, "Пароли не совпадают!")
            register()
        }
    }
    @objc func toPolicy(){
        let controller = EmptyPolicyViewController()
        navigationController?.pushViewController(controller, animated: true)
    }
}

//  MARK: - Picker delegate
extension RegStep1ViewController: UIPickerViewDataSource, UIPickerViewDelegate{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return typeUserArray.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return typeUserArray[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.typeTextfield.text = typeUserArray[row]
    }
}

// MARK: - Textfield delegate
extension RegStep1ViewController: UITextFieldDelegate {
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
    func textFieldDidEndEditing(_ textField: UITextField) {
        viewModel.setPhone(textField.text!)
    }
}

// MARK: - Parser
extension RegStep1ViewController {
    private func register() -> Void {
        let parameter = viewModel.getParameters()
        guard viewModel.isValid() else { self.showErrorMessage(messageType: .none, viewModel.errorMessage); return }
        showHUD()
        ParseManager.shared.postRequest(url: api.register, parameters: parameter) { [self] (result: String?, error) in
            self.dismissHUD()
            if let resultText = (result ?? "") as String? {
                print(result, error)
                if (resultText.contains("занят")) {
                    showErrorMessage(messageType: .none, "Телефон номер уже занят")
                } else {
                    let vc = RegStep2ViewController(isPassenger: self.typeTextfield.text == "Пассажир" ? true :  false, viewModel: self.viewModel)
                    self.navigationController?.pushViewController(vc, animated: true)
                }
            }
        }
    }
}
