//
//  RegStep3ViewController.swift
//  BusTime
//
//  Created by greetgo on 8/15/20.
//  Copyright © 2020 thousand.com. All rights reserved.
//

import UIKit

class RegStep3ViewController: ScrollViewController {

    // MARK: - Variables
    var code: String?
    
    // MARK: - Helpers
    lazy var imagePicker: ImagePicker = {
        let imagePicker = ImagePicker(presentationController: self, delegate: self)
        return imagePicker
    }()
    lazy var imagePickerBtn: UIButton = {
        let btn = UIButton()
        btn.backgroundColor = .clear
        btn.addTarget(self, action: #selector(openImagePicker), for: .touchUpInside)
        return btn
    }()
    
    // MARK: - Properties
    lazy var stepTitle: UILabel = {
        let label = UILabel()
        label.text = "Шаг 3"
        label.textColor = maincolor.blue
        label.font = UIFont.init(name: Font.mullerRegular, size: 13)
        return label
    }()
    lazy var stepView: StepView = {
        let view = StepView()
        view.view3.backgroundColor = maincolor.blue
        return view
    }()
    lazy var welcomeTitle: UILabel = {
        let label = UILabel()
        label.text = "Подтверждение данных"
        label.textColor = maincolor.blue
        label.font = UIFont.init(name: Font.mullerBold, size: 27)
        return label
    }()
    lazy var justTitle: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.text = "Осталось совсем немного. Вы можете пропустить последний шаг"
        label.textColor = maincolor.lightgray
        label.font = UIFont.init(name: Font.mullerRegular, size: 14)
        label.textAlignment = .center
        return label
    }()
    lazy var imageView: UIImageView = {
        let image = UIImageView()
        image.image = #imageLiteral(resourceName: "Group 10535")
        image.layer.cornerRadius = 52
        image.layer.masksToBounds = true
        return image
    }()
    lazy var nameField: UITextField = {
        let field = DefaultTextField()
        field.rightImage.isHidden = true
        field.attributedPlaceholder = NSAttributedString(string: "Имя", attributes: [.foregroundColor: UIColor.gray,
                                                                                  .font: UIFont.init(name: Font.mullerRegular, size: 14) as Any])
        field.actionButton.isHidden = true
        field.keyboardType = .default
        return field
    }()
    lazy var surnameField: UITextField = {
        let field = DefaultTextField()
        field.rightImage.isHidden = true
        field.attributedPlaceholder = NSAttributedString(string: "Фамилия",
                                                         attributes: [.foregroundColor: UIColor.gray,
                                                                      .font: UIFont.init(name: Font.mullerRegular, size: 14) as Any])
        field.actionButton.isHidden = true
        field.keyboardType = .default
        return field
    }()
    lazy var confirmButton: DefaultButton = {
        let btn = DefaultButton()
        btn.setTitle("Подтвердить", for: .normal)
        btn.addTarget(self, action: #selector(tapConfirm), for: .touchUpInside)
        return btn
    }()
    lazy var loseButton: DefaultButton = {
        let btn = DefaultButton()
        btn.setTitle("Пропустить", for: .normal)
        btn.backgroundColor = UIColor(red: 0.949, green: 0.949, blue: 0.949, alpha: 1)
        btn.setTitleColor(maincolor.blue, for: .normal)
        btn.addTarget(self, action: #selector(tapLose), for: .touchUpInside)
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
    
    // MARK: - Init
    required init?(coder: NSCoder) { fatalError("") }
    init(code: String) {
        super.init(nibName: nil, bundle: nil)
        self.code = code
    }
    
    // MARK: - SetupViews
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
        scrollView.addSubviews([welcomeTitle,justTitle,imageView,nameField,surnameField,confirmButton,loseButton,imagePickerBtn])
        welcomeTitle.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(100)
            make.centerX.equalToSuperview()
        }
        justTitle.snp.makeConstraints { (make) in
            make.top.equalTo(welcomeTitle.snp.bottom).offset(8)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.7)
        }
        imageView.snp.makeConstraints { (make) in
            make.top.equalTo(justTitle.snp.bottom).offset(30)
            make.centerX.equalToSuperview()
            make.width.height.equalTo(100)
        }
        nameField.snp.makeConstraints { (make) in
            make.top.equalTo(imageView.snp.bottom).offset(30)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
            make.height.equalTo(48)
        }
        surnameField.snp.makeConstraints { (make) in
            make.top.equalTo(nameField.snp.bottom).offset(12)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
            make.height.equalTo(48)
        }
        confirmButton.snp.makeConstraints { (make) in
            make.top.equalTo(surnameField.snp.bottom).offset(30)
            make.left.equalToSuperview().offset(43)
            make.right.equalToSuperview().offset(-43)
            make.height.equalTo(48)
        }
        loseButton.snp.makeConstraints { (make) in
            make.top.equalTo(confirmButton.snp.bottom).offset(12)
            make.left.equalToSuperview().offset(43)
            make.right.equalToSuperview().offset(-43)
            make.height.equalTo(48)
            make.bottom.equalToSuperview().offset(-30)
        }
        imagePickerBtn.snp.makeConstraints { (make) in
            make.top.equalTo(justTitle.snp.bottom).offset(30)
            make.centerX.equalToSuperview()
            make.width.height.equalTo(100)
        }
    }
    
    // MARK: - Actions
    @objc func openImagePicker() -> Void {
        imagePicker.present(from: view)
    }
    @objc func tapAddress() {
        let vc = ShowInMapViewController()
        vc.delegate = self
        navigationController?.pushViewController(vc, animated: true)
    }
    @objc func tapConfirm() -> Void {
        confirm()
    }
    @objc func tapLose() -> Void {
        self.showSuccessMessage()
        AppCenter.shared.startCustomer()
    }
}

//  MARK: - ImagePicker Delegate
extension RegStep3ViewController: ImagePickerDelegate {
    func didSelect(image: UIImage?) {
        imageView.image = image
    }
}

//  MARK: - ShowInMapViewController delegate
extension RegStep3ViewController: ShowInMapViewControllerDelegate {
    func sendAddressString(addressString: String, lat: Double, long: Double) {
//        self.locationField.text = addressString
    }
}

// MARK: - Parser
extension RegStep3ViewController {
    private func confirm() -> Void {
        showHUD()
        let imageData = (imageView.image?.jpegData(compressionQuality: 0.1))!
        let parameter = ["avatar": imageData,
                         "name": nameField.text!,
                         "surname": surnameField.text!,
                         "code": code!,
                         "device_type": "ios",
                         "device_token": AppDelegate.deviceToken] as [String : Any]
        ParseManager.shared.multipartFormData(url: api.confirm, parameters: parameter) { (result: UserDetail?, error) in
            self.dismissHUD()
            if let error = error {
                print(error)
                self.showErrorMessage(messageType: .none, "")
                return
            }
            UserManager.shared.setTypeUser(withArray: "passenger")
            self.showSuccessMessage()
            AppCenter.shared.startCustomer()
        }
    }
}
