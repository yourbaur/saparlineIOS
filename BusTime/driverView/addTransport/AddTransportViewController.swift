//
//  AddTransportViewController.swift
//  SaparLine
//
//  Created by Admin on 1/3/21.
//  Copyright © 2021 thousand.com. All rights reserved.
//

import Foundation
import UIKit


class AddTransportViewController: BaseDriverViewController {

    // MARK: - Variables
 

    private var carTypesArray = [CarTypesModel]()
    private var carTypeId = 1
    private var imageTag = Int()
    
    // MARK: - Helpers
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
    lazy private var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 8

        return stackView
    }()
 
    
    // MARK: - Properties
   
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
    lazy var downloadImage3 = AddImageView(title: "Загрузите аватар транспорта(1 фото)")
    lazy var downloadImage4 = AddImageView(title: localized(text: "downPhotoUdas"))
    lazy var downloadImage2 = AddBusImageView(title: localized(text: "downPhoto"))
    
    lazy var confirmButton: DefaultButton = {
        let btn = DefaultButton()
        btn.setTitle(localized(text: "confirm"), for: .normal)
        btn.addTarget(self, action: #selector(tapConfirm), for: .touchUpInside)
        return btn
    }()
    
    
    // MARK: - Lifecycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.title = localized(text: "addBus")
        
        navigationController?.navigationBar.tintColor = maincolor.blue
        navigationController?.navigationBar.barTintColor = maincolor.blue
        navigationController!.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont.init(name: Font.mullerBold,size: 18)!,
                                                                   NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarPosition.any, barMetrics: UIBarMetrics.default)
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        getCarTypes()
        setupViews()
    }
    
 

    
    // MARK: - Init
  
    
    // MARK: - SetupViews
    func setupViews() -> Void {
        scrollView.addSubviews([typeTransportField,numTransportField,convenienceField])
        typeTransportField.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(30)
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
        scrollView.addSubviews([downloadImage1,downloadImage2,downloadImage3,
                                downloadImage4,
                                confirmButton, stackView])
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
        stackView.snp.makeConstraints { (make) in
            make.top.equalTo(convenienceField.snp.bottom).offset(23)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
            make.height.equalTo(80)
        }
        
  
        confirmButton.snp.makeConstraints { (make) in
            make.top.equalTo(downloadImage4.snp.bottom).offset(30)
            make.left.equalToSuperview().offset(43)
            make.right.equalToSuperview().offset(-43)
            make.height.equalTo(48)
            make.bottom.equalToSuperview().offset(-30)
        }
        // MARK: - ImageButtons
        scrollView.addSubviews([imageBtn1,imageBtn2, imageBtn3, imageBtn4])
      
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
        //if nameField.text == "" { showErrorMessage(messageType: .none, "Загрузите фото тех паспорта!") }
        if downloadImage1.cameraImage.image == #imageLiteral(resourceName: "Group-20") { showErrorMessage(messageType: .none, "Загрузите фото тех паспорта!") }
        else if downloadImage2.cameraImage.image == #imageLiteral(resourceName: "Group-20") { showErrorMessage(messageType: .none, "Загрузите три фото транспорта!") }
        else if downloadImage1.cameraImage1.image == #imageLiteral(resourceName: "Group 10484"){ showErrorMessage(messageType: .none, "Загрузите второе фото тех паспорта") }
        else if downloadImage2.cameraImage1.image == #imageLiteral(resourceName: "Group 10484") { showErrorMessage(messageType: .none, "Загрузите три фото транспорта!") }
        else if downloadImage2.cameraImage2.image == #imageLiteral(resourceName: "Group 10484") { showErrorMessage(messageType: .none, "Загрузите три фото транспорта!") }
        else if downloadImage3.cameraImage.image == #imageLiteral(resourceName: "Group-20") { showErrorMessage(messageType: .none, "Загрузите аватар транспорта!") }
        else if downloadImage4.cameraImage.image == #imageLiteral(resourceName: "Group-20") { showErrorMessage(messageType: .none, "Загрузите фото прав!") }
        else if downloadImage4.cameraImage1.image == #imageLiteral(resourceName: "Group 10484"){ showErrorMessage(messageType: .none, "Загрузите второе фото прав") }
        else { confirm() }
    }
}

//  MARK: - Picker delegate
extension AddTransportViewController: UIPickerViewDataSource, UIPickerViewDelegate{
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
            default:
                typeText = localized(text: "bus6")
        }

        self.typeTransportField.text = typeText
        self.carTypeId = carTypesArray[row].id
    }
}

//MARK: - ImagePicker Delegate
extension AddTransportViewController: ImagePickerDelegate {
    
    func didSelect(image: UIImage?) -> Void{
        if image == nil {
            return
        }
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
            else if downloadImage2.cameraImage2.isHidden {
                downloadImage2.cameraImage1.image = image
                downloadImage2.cameraImage2.isHidden = false
                
            }
            else {
                downloadImage2.cameraImage2.image = image
            }
        case 3:
            downloadImage3.cameraImage.image = image
        case 4:
            if downloadImage4.cameraImage1.isHidden{
                downloadImage4.cameraImage.image = image
                downloadImage4.cameraImage1.isHidden = false
            }
            else {
                downloadImage4.cameraImage1.image = image
            }
        default:
            break
        }
    }
}

// MARK: - ConvenienceViewController delegate
extension AddTransportViewController: ConvenienceViewControllerDelegate {
    func convenienceTitle(convenienceTitle: String) {
        convenienceField.text = convenienceTitle
    }
}

// MARK: - Parser
extension AddTransportViewController {
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
        
        var pass2:Data? = nil
        if !downloadImage1.cameraImage1.isHidden {
            guard let pass1: Data = (downloadImage1.cameraImage1.image?.jpegData(compressionQuality: 0.1))
            else { showErrorMessage(messageType: .none, "Загрузите вторую сторону тех паспорта!"); return; }
            pass2 = pass1
        }
        
        guard let carImage: Data = (downloadImage2.cameraImage.image?.jpegData(compressionQuality: 0.1))
        else { showErrorMessage(messageType: .none, "Загрузите фото транспорта!"); return; }
        
        var car2:Data? = nil
        if !downloadImage2.cameraImage1.isHidden {
            guard let carImage1: Data = (downloadImage2.cameraImage1.image?.jpegData(compressionQuality: 0.1))
            else { showErrorMessage(messageType: .none, "Загрузите второе фото транспорта"); return; }
            car2 = carImage1
        }
        
        var car3:Data? = nil
        if !downloadImage2.cameraImage2.isHidden {
            guard let carImage1: Data = (downloadImage2.cameraImage1.image?.jpegData(compressionQuality: 0.1))
            else { showErrorMessage(messageType: .none, "Загрузите второе фото транспорта"); return; }
            car3 = carImage1
        }
        
        var car4:Data? = nil
        if !downloadImage3.cameraImage.isHidden {
            guard let carImage1: Data = (downloadImage3.cameraImage.image?.jpegData(compressionQuality: 0.1))
            else { showErrorMessage(messageType: .none, "Загрузите второе фото транспорта"); return; }
            car4 = carImage1
        }
        guard let identity: Data = (downloadImage4.cameraImage.image?.jpegData(compressionQuality: 0.1))
        else { showErrorMessage(messageType: .none, "Загрузите фото удостоверения личности!"); return; }
        
        var ud2:Data? = nil
        if !downloadImage4.cameraImage1.isHidden {
            guard let ud1: Data = (downloadImage4.cameraImage1.image?.jpegData(compressionQuality: 0.1))
            else { showErrorMessage(messageType: .none, "Загрузите вторую сторону тех паспорта!"); return; }
            ud2 = ud1
        }
        
        let parameter = [
                         "passport_image": pass,
                         "car_image": carImage,
                         "car_image1": car2!,
                         "car_image2":car3!,
                        "car_avatar":car4!,
                         "passport_image_back": pass2!,
                        "identity_image": identity,
                        "identity_image_back":ud2!,
                         "state_number": numTransportField.text ?? "",
                         "car_type_id": carTypeId,
                         "tv": convenienceField.text?.contains("Телевизор") ?? false ? 1 : 0,
                         "conditioner": convenienceField.text?.contains("Кондиционер") ?? false ? 1 : 0,
                         "baggage": convenienceField.text?.contains("Багаж") ?? false ? 1 : 0] as Parameters
        ParseManager.shared.multipartFormData(url: api.addBus, parameters: parameter) { (result: UserDetail?, error) in
            self.dismissHUD()
            if let error = error {
                print(error)
                self.showErrorMessage(messageType: .none, "Заполните все поля!")
                return
            }
            self.navigationController?.pushViewController(MainDriverViewController(carId: nil, countPlaces: nil, carTypeId: nil), animated: true)
//            self.showSuccessMessage()
            
            
        }
    }
}

