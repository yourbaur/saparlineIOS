//
//  EnterPassengerInformationViewController.swift
//  SaparLine
//
//  Created by Cheburek on 15.01.2022.
//  Copyright © 2022 thousand.com. All rights reserved.
//

import UIKit

protocol PassengerInformationDelegate: AnyObject {
    func didEnterInformation(info: PassengerInfoModel)
}

final class EnterPassengerInformationViewController: UIViewController {
    
    private var onCancelClicked: (() -> Void)?
    private var tourAgent: Bool?
    
    private var travelId: Int?
    private var placeString: [String]?
    weak var delegate: PassengerInformationDelegate?
    private lazy var mainView: UIButton = {
        let btn = UIButton()
        btn.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        btn.addTarget(self, action: #selector(tapMain), for: .touchUpInside)
        return btn
    }()
    
    private lazy var backgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 10
        return view
    }()
    
    private lazy var iinImage: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 5
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        if #available(iOS 13.0, *) {
            imageView.image = UIImage(named: "calendar 1")?.withTintColor(maincolor.blue)
        } else {
            // Fallback on earlier versions
        }
        return imageView
    }()
    
    private lazy var iinTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "ИИН"
        textField.keyboardType = .numberPad
        textField.delegate = self
        return textField
    }()
    
    private lazy var nameImage: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 5
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        if #available(iOS 13.0, *) {
            imageView.image = UIImage(named: "asd")?.withTintColor(maincolor.blue)
        } else {
            // Fallback on earlier versions
        }
        return imageView
    }()
    
    private lazy var nameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "ФИО"
        textField.keyboardType = .default
        return textField
    }()
    
    private lazy var phoneImage: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 5
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        if #available(iOS 13.0, *) {
            imageView.image = UIImage(named: "callb")?.withTintColor(maincolor.blue)
        } else {
            // Fallback on earlier versions
        }
        return imageView
    }()
    
    private lazy var phoneTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Номер телефона"
        textField.keyboardType = .phonePad
        textField.delegate = self
        textField.text = "+7"
        return textField
    }()
    
    private lazy var agentImage: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 5
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        if #available(iOS 13.0, *) {
            imageView.image = UIImage(named: "zondicons_travel-case")?.withTintColor(maincolor.blue)
        } else {
            // Fallback on earlier versions
        }
        return imageView
    }()
    
    private lazy var agentPhoneTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Номер агента"
        textField.keyboardType = .phonePad
        textField.delegate = self
        textField.text = "+7"
        return textField
    }()
    
    private lazy var buttonsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        return stackView
    }()
    
    private lazy var okButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("OK", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        button.titleLabel?.tintColor = .white
        button.backgroundColor = maincolor.blue
        button.layer.cornerRadius = 5
        button.addTarget(self, action: #selector(onOKButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var cancelButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Отмена", for: .normal)
        button.backgroundColor = maincolor.lightgray
        button.titleLabel?.tintColor = maincolor.blue
        button.layer.cornerRadius = 5
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        button.addTarget(self, action: #selector(onCancelButtonTapped), for: .touchUpInside)
        return button
    }()
    
    init(travelId: Int, placeString: [String], tourAgent: Bool, completion: (() -> Void)?) {
        self.travelId = travelId
        self.placeString = placeString
        self.onCancelClicked = completion
        self.tourAgent = tourAgent
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setConstraints()
    }
    
    private func setupViews() {
        view.addSubview(mainView)
        mainView.addSubview(backgroundView)
        [iinImage, iinTextField,
        nameImage, nameTextField,
        phoneImage, phoneTextField,
        buttonsStackView].forEach {
            backgroundView.addSubview($0)
        }
        
        if tourAgent == true {
            [agentImage, agentPhoneTextField].forEach { backgroundView.addSubview($0)}
        } else {
            agentImage.isHidden = true
            agentPhoneTextField.isHidden = true
        }
        
        [cancelButton, okButton].forEach {
            buttonsStackView.addArrangedSubview($0)
        }
    }
    
    private func setConstraints() {
        
        mainView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        backgroundView.snp.makeConstraints {
            if tourAgent == true {
                $0.height.equalTo(270)
            } else {
                $0.height.equalTo(230)
            }
            $0.left.equalToSuperview().offset(16)
            $0.right.equalToSuperview().offset(-16)
            $0.centerY.equalToSuperview()
        }
        
        iinImage.snp.makeConstraints {
            $0.height.width.equalTo(20)
            $0.top.equalTo(backgroundView.snp.top).offset(24)
            $0.left.equalTo(backgroundView.snp.left).offset(16)
        }
        
        iinTextField.snp.makeConstraints {
            $0.left.equalTo(iinImage.snp.right).offset(12)
            $0.right.equalToSuperview().offset(-16)
            $0.centerY.equalTo(iinImage.snp.centerY)
        }
        
        nameImage.snp.makeConstraints {
            $0.height.width.equalTo(20)
            $0.top.equalTo(iinImage.snp.bottom).offset(24)
            $0.left.equalTo(backgroundView.snp.left).offset(16)
        }
        
        nameTextField.snp.makeConstraints {
            $0.left.equalTo(nameImage.snp.right).offset(12)
            $0.right.equalToSuperview().offset(-16)
            $0.centerY.equalTo(nameImage.snp.centerY)
        }
        
        phoneImage.snp.makeConstraints {
            $0.height.width.equalTo(20)
            $0.top.equalTo(nameImage.snp.bottom).offset(24)
            $0.left.equalTo(backgroundView.snp.left).offset(16)
        }
        
        phoneTextField.snp.makeConstraints {
            $0.left.equalTo(phoneImage.snp.right).offset(12)
            $0.right.equalToSuperview().offset(-16)
            $0.centerY.equalTo(phoneImage.snp.centerY)
        }
        
        if tourAgent == true {
            agentImage.snp.makeConstraints {
                $0.height.width.equalTo(20)
                $0.top.equalTo(phoneImage.snp.bottom).offset(24)
                $0.left.equalTo(backgroundView.snp.left).offset(16)
            }
            
            agentPhoneTextField.snp.makeConstraints {
                $0.left.equalTo(agentImage.snp.right).offset(12)
                $0.right.equalToSuperview().offset(-16)
                $0.centerY.equalTo(agentImage.snp.centerY)
            }
        }
        
        buttonsStackView.snp.makeConstraints {
            if tourAgent == true {
                $0.top.equalTo(agentPhoneTextField.snp.bottom).offset(24)
            } else {
                $0.top.equalTo(phoneTextField.snp.bottom).offset(24)
            }
            $0.height.equalTo(48)
            $0.left.equalToSuperview().offset(16)
            $0.right.equalToSuperview().offset(-16)
        }
    }
    
    @objc private func onCancelButtonTapped() {
        if let onCancelClicked = onCancelClicked {
            onCancelClicked()
            dismiss(animated: true)
        }
    }
    
    @objc func tapMain() -> Void {
        if let onCancelClicked = onCancelClicked {
            onCancelClicked()
            dismiss(animated: true)
        }
    }
    
    @objc private func onOKButtonTapped() {
        guard !(iinTextField.text?.isEmpty ?? false) && iinTextField.text?.count == 12 else {
            showMessage("Заполни ИИН")
            return
        }
        
        guard !(nameTextField.text?.isEmpty ?? false) else {
            showMessage("Заполни ФИО")
            return
        }
        
        guard !(phoneTextField.text?.isEmpty ?? false) && phoneTextField.text?.count == 16 else {
            showMessage("Заполни номер телефона")
            return
        }
        
        self.delegate?.didEnterInformation(info: PassengerInfoModel(seat: self.placeString,
                                                                    iin: self.iinTextField.text ?? "",
                                                                    name: self.nameTextField.text ?? "",
                                                                    phone: self.phoneTextField.text ?? ""))
        self.dismiss(animated: true)
    }
}

extension EnterPassengerInformationViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField,
                   shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool {
        switch textField {
        case iinTextField:
            return range.location < 12
        case phoneTextField:
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
        default:
            return true
        }
    }
}
