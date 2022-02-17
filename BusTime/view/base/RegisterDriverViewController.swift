//
//  RegisterDriverViewController.swift
//  BusTime
//
//  Created by greetgo on 10/17/20.
//  Copyright © 2020 thousand.com. All rights reserved.
//

import UIKit

class RegisterDriverViewController: ScrollViewController {

    // MARK: - Variables
    private var carTypesArray = [CarTypesModel]()
    private var carTypeId = 1
    private var imageTag = Int()
    lazy var pickerView: UIPickerView = {
        let picker = UIPickerView()
        picker.delegate = self
        picker.dataSource = self
        return picker
    }()
    lazy var imagePicker: ImagePicker = {
        let imagePicker = ImagePicker(presentationController: self, delegate: self)
        return imagePicker
    }()
    lazy var imageBtn1: UIButton = {
        let btn = UIButton()
        btn.backgroundColor = .clear
        btn.tag = 1
        btn.addTarget(self, action: #selector(tapImage(button:)), for: .touchUpInside)
        return btn
    }()
    lazy var imageBtn2: UIButton = {
        let btn = UIButton()
        btn.backgroundColor = .clear
        btn.tag = 2
        btn.addTarget(self, action: #selector(tapImage(button:)), for: .touchUpInside)
        return btn
    }()
    lazy var imageBtn3: UIButton = {
        let btn = UIButton()
        btn.backgroundColor = .clear
        btn.tag = 3
        btn.addTarget(self, action: #selector(tapImage(button:)), for: .touchUpInside)
        return btn
    }()
    lazy var imageBtn4: UIButton = {
        let btn = UIButton()
        btn.backgroundColor = .clear
        btn.tag = 4
        btn.addTarget(self, action: #selector(tapImage(button:)), for: .touchUpInside)
        return btn
    }()
    
    // MARK: - Properties
    lazy var welcomeTitle: UILabel = {
        let label = UILabel()
        label.text = "Подтверждение данных"
        label.textColor = maincolor.blue
        label.font = UIFont.init(name: Font.mullerBold, size: 27)
        return label
    }()
    lazy var justTitle: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.text = localized(text: "littleLeft")
        label.textColor = maincolor.lightgray
        label.font = UIFont.init(name: Font.mullerRegular, size: 14)
        label.textAlignment = .center
        return label
    }()
    lazy var typeTransportField: DefaultTextField = {
        let field = DefaultTextField()
        field.actionButton.isHidden = true
        field.imageProfile.image = #imageLiteral(resourceName: "raphael_bus")
        field.rightImage.image = #imageLiteral(resourceName: "Group-19")
        field.attributedPlaceholder = NSAttributedString(string: localized(text: "typeTrans"), attributes: [.foregroundColor: UIColor.gray,
                                                                                     .font: UIFont.init(name: Font.mullerRegular, size: 14) as Any])
        field.inputView = pickerView
        return field
    }()
    lazy var numTransportField: DefaultTextField = {
        let field = DefaultTextField()
        field.actionButton.isHidden = true
        field.imageProfile.image = #imageLiteral(resourceName: "raphael_bus")
        field.rightImage.image = #imageLiteral(resourceName: "Group-19")
        field.attributedPlaceholder = NSAttributedString(string: localized(text: "licensePlate"), attributes: [.foregroundColor: UIColor.gray,
                                                                                     .font: UIFont.init(name: Font.mullerRegular, size: 14) as Any])
        field.actionButton.isHidden = true
        field.keyboardType = .default
        return field
    }()
    lazy var convenienceField: DefaultTextField = {
        let field = DefaultTextField()
        field.imageProfile.image = #imageLiteral(resourceName: "Group-21")
        field.rightImage.image = #imageLiteral(resourceName: "Group-19")
        field.attributedPlaceholder = NSAttributedString(string: localized(text: "facilities"), attributes: [.foregroundColor: UIColor.gray,
                                                                                     .font: UIFont.init(name: Font.mullerRegular, size: 14) as Any])
        field.actionButton.addTarget(self, action: #selector(tapConvenience), for: .touchUpInside)
        return field
    }()
    
    lazy var downloadImage1 = AddImageView(title: localized(text: "downPhotoPass"))
    lazy var downloadImage2 = AddImageView(title: localized(text: "downPhotoUdas"))
    lazy var downloadImage3 = AddBusImageView(title: localized(text: "downPhoto"))
    lazy var downloadImage4 = AddImageView(title: "Загрузите аватар транспорта")
    
    lazy var confirmButton: DefaultButton = {
        let btn = DefaultButton()
        btn.setTitle(localized(text: "confirm"), for: .normal)
        btn.addTarget(self, action: #selector(tapConfirm), for: .touchUpInside)
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
        getCarTypes()
        setupViews()
    }
    
    // MARK: - Initialization
    required init?(coder: NSCoder) { fatalError("") }
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    // MARK: - SetupViews
    func setupViews() -> Void {
        scrollView.addSubviews([welcomeTitle,justTitle,typeTransportField,numTransportField,convenienceField])
        welcomeTitle.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(30)
            make.centerX.equalToSuperview()
        }
        justTitle.snp.makeConstraints { (make) in
            make.top.equalTo(welcomeTitle.snp.bottom).offset(8)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.7)
        }
        typeTransportField.snp.makeConstraints { (make) in
            make.top.equalTo(justTitle.snp.bottom).offset(40)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
            make.height.equalTo(48)
        }
        numTransportField.snp.makeConstraints { (make) in
            make.top.equalTo(typeTransportField.snp.bottom).offset(16)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
            make.height.equalTo(48)
        }
        convenienceField.snp.makeConstraints { (make) in
            make.top.equalTo(numTransportField.snp.bottom).offset(16)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
            make.height.equalTo(48)
        }
        scrollView.addSubviews([downloadImage1,downloadImage2,downloadImage3, downloadImage4, confirmButton])
        downloadImage1.snp.makeConstraints { (make) in
            make.top.equalTo(convenienceField.snp.bottom).offset(23)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
            make.height.equalTo(80)
        }
        downloadImage2.snp.makeConstraints { (make) in
            make.top.equalTo(downloadImage1.snp.bottom).offset(23)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
            make.height.equalTo(80)
        }
        downloadImage3.snp.makeConstraints { (make) in
            make.top.equalTo(downloadImage2.snp.bottom).offset(23)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
            make.height.equalTo(80)
        }
        downloadImage4.snp.makeConstraints { (make) in
            make.top.equalTo(downloadImage3.snp.bottom).offset(23)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
            make.height.equalTo(80)
        }
        confirmButton.snp.makeConstraints { (make) in
            make.top.equalTo(downloadImage4.snp.bottom).offset(30)
            make.left.equalToSuperview().offset(43)
            make.right.equalToSuperview().offset(-43)
            make.height.equalTo(48)
            make.bottom.equalToSuperview().offset(-50)
        }
        // MARK: - ImageButtons
        scrollView.addSubviews([imageBtn1,imageBtn2,imageBtn3, imageBtn4])
        imageBtn1.snp.makeConstraints { (make) in
            make.top.equalTo(convenienceField.snp.bottom).offset(23)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
            make.height.equalTo(80)
        }
        imageBtn2.snp.makeConstraints { (make) in
            make.top.equalTo(downloadImage1.snp.bottom).offset(23)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
            make.height.equalTo(80)
        }
        imageBtn3.snp.makeConstraints { (make) in
            make.top.equalTo(downloadImage2.snp.bottom).offset(23)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
            make.height.equalTo(80)
        }
        imageBtn4.snp.makeConstraints { (make) in
            make.top.equalTo(downloadImage3.snp.bottom).offset(23)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
            make.height.equalTo(80)
        }
    }
    
    // MARK: - Actions
    @objc func tapImage(button: UIButton) -> Void {
        imageTag = button.tag
        imagePicker.present(from: view)
    }
    @objc func tapConvenience() -> Void {
        let vc = ConvenienceViewController()
        vc.delegate = self
        navigationController?.pushViewController(vc, animated: true)
    }
    @objc func tapConfirm() -> Void {
        confirm()
    }
}

//  MARK: - Picker delegate
extension RegisterDriverViewController: UIPickerViewDataSource, UIPickerViewDelegate{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return carTypesArray.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch carTypesArray[row].id {
        case 1:
            return localized(text: "bus50")
        case 2:
            return localized(text: "bus36")
        case 5:
            return localized(text: "bus4")
        case 6:
            return localized(text: "bus7")
        case 7:
            return localized(text: "bus62")
        case 8:
            return localized(text: "bus28")
        case 9:
            return localized(text: "bus29")
        default:
            return localized(text: "bus6")
        }
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        var typeText = ""
        switch carTypesArray[row].id {
        case 1:
            typeText = localized(text: "bus50")
        case 2:
            typeText = localized(text: "bus36")
        case 5:
            typeText = localized(text: "bus4")
        case 6:
            typeText = localized(text: "bus7")
        case 7:
            typeText = localized(text: "bus62")
        case 8:
            typeText = localized(text: "bus28")
        case 9:
            typeText = localized(text: "bus29")
        default:
            typeText = localized(text: "bus6")
        }
        self.typeTransportField.text = typeText
        self.carTypeId = carTypesArray[row].id
    }
}

//MARK: - ImagePicker Delegate
extension RegisterDriverViewController: ImagePickerDelegate {
    func didSelect(image: UIImage?) {
        switch imageTag {
        case 1:
            if downloadImage1.cameraImage1.isHidden{
                downloadImage1.cameraImage.image = image
                downloadImage1.cameraImage1.isHidden = false
            }
            else {
                downloadImage1.cameraImage1.image = image
            }
        case 2:
            if downloadImage2.cameraImage1.isHidden{
                downloadImage2.cameraImage.image = image
                downloadImage2.cameraImage1.isHidden = false
            }
            else {
                downloadImage2.cameraImage1.image = image
            }
        case 3:
            if downloadImage3.cameraImage1.isHidden{
                downloadImage3.cameraImage.image = image
                downloadImage3.cameraImage1.isHidden = false
            }
            else if downloadImage3.cameraImage2.isHidden {
                downloadImage3.cameraImage1.image = image
                downloadImage3.cameraImage2.isHidden = false
            }
            else {
                downloadImage3.cameraImage2.image = image
            }
        case 4:
            break
                downloadImage4.cameraImage.image = image
        default:
            break
        }
    }
}

// MARK: - ConvenienceViewController delegate
extension RegisterDriverViewController: ConvenienceViewControllerDelegate {
    func convenienceTitle(convenienceTitle: String) {
        convenienceField.text = convenienceTitle
    }
}

// MARK: - Parser
extension RegisterDriverViewController {
    private func getCarTypes() -> Void {
        ParseManager.shared.getRequest(url: api.cartypes) { (result: [CarTypesModel]?, error) in
            if let error = error {
                self.showErrorMessage(messageType: .none, error)
                return
            }
            self.carTypesArray = result!
        }
    }
    private func confirm() -> Void {
        showHUD()
        guard let pass: Data = (downloadImage1.cameraImage.image?.jpegData(compressionQuality: 0.1))
        else { showErrorMessage(messageType: .none, "Загрузите фото тех паспорта!"); return; }
        guard let identity: Data = (downloadImage2.cameraImage.image?.jpegData(compressionQuality: 0.1))
        else { showErrorMessage(messageType: .none, "Загрузите фото удостоверения личности!"); return; }
        guard let carImage: Data = (downloadImage3.cameraImage.image?.jpegData(compressionQuality: 0.1))
        else { showErrorMessage(messageType: .none, "Загрузите фото транспорта!"); return; }
        guard let avatarImage: Data = (downloadImage4.cameraImage.image?.jpegData(compressionQuality: 0.1))
        else { showErrorMessage(messageType: .none, "Загрузите фото аватара транспорта!"); return; }
        var pass2:Data? = nil
        if !downloadImage1.cameraImage1.isHidden {
            guard let pass1: Data = (downloadImage1.cameraImage1.image?.jpegData(compressionQuality: 0.1))
            else { showErrorMessage(messageType: .none, "Загрузите вторую сторону тех паспорта!"); return; }
            pass2 = pass1
        }
        var ud2:Data? = nil
        if !downloadImage2.cameraImage1.isHidden {
            guard let ud1: Data = (downloadImage2.cameraImage1.image?.jpegData(compressionQuality: 0.1))
            else { showErrorMessage(messageType: .none, "Загрузите вторую сторону тех паспорта!"); return; }
            ud2 = ud1
        }
        
        var car2:Data? = nil
        if !downloadImage3.cameraImage1.isHidden {
            guard let carImage1: Data = (downloadImage3.cameraImage1.image?.jpegData(compressionQuality: 0.1))
            else { showErrorMessage(messageType: .none, "Загрузите второе фото транспорта"); return; }
            car2 = carImage1
        }
        
        var car3:Data? = nil
        if !downloadImage3.cameraImage2.isHidden {
            guard let carImage1: Data = (downloadImage3.cameraImage1.image?.jpegData(compressionQuality: 0.1))
            else { showErrorMessage(messageType: .none, "Загрузите второе фото транспорта"); return; }
            car3 = carImage1
        }
        let parameter = ["passport_image": pass,
                         "identity_image": identity,
                         "car_image": carImage,
                         "car_image1": car2!,
                         "car_image2":car3!,
                         "car_avatar": avatarImage,
                         "passport_image_back":pass2!,
                         "state_number": numTransportField.text ?? "",
                         "car_type_id": carTypeId,
                         "tv": convenienceField.text?.contains("Телевизор") ?? false ? 1 : 0,
                         "conditioner": convenienceField.text?.contains("Кондиционер") ?? false ? 1 : 0,
                         "baggage": convenienceField.text?.contains("Багаж") ?? false ? 1 : 0] as Parameters
        ParseManager.shared.multipartFormData(url: api.beDriver, parameters: parameter) { (result: CheckRequest?, error) in
            self.dismissHUD()
            self.showErrorMessage(messageType: .none, "Ожидайте, Админ проверяет ваши данные!") {
                AppCenter.shared.startDriver()
            }
        }
    }
}
