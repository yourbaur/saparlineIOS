//
//  EditProfileDriverViewController.swift
//  BusTime
//
//  Created by greetgo on 8/27/20.
//  Copyright © 2020 thousand.com. All rights reserved.
//

import UIKit

class EditProfileDriverViewController: ScrollViewController {

    var model: UserDetail? {
        didSet {
            if model?.avatar != nil {
                let url = model?.avatar?.serverUrlString.url
                userImage.kf.setImage(with: url)
            }
            nameField.text = model?.name ?? ""
            surnameField.text = model?.surname ?? ""
        }
    }
    
    // MARK: - Variables
    private var imageTag = Int()
    private var carTypeId = 1
    private var carTypesArray = [CarTypesModel]()
    lazy var imagePicker: ImagePicker = {
        let imagePicker = ImagePicker(presentationController: self, delegate: self)
        return imagePicker
    }()
    lazy var imageBtn: UIButton = {
        let btn = UIButton()
        btn.backgroundColor = .clear
        btn.tag = 0
        btn.addTarget(self, action: #selector(tapImage), for: .touchUpInside)
        return btn
    }()
    
    // MARK: - Properties
    lazy var userImage: UIImageView = {
        let image = UIImageView(image: #imageLiteral(resourceName: "Group 10534"))
        image.layer.cornerRadius = 52
        image.layer.masksToBounds = true
        return image
    }()
    lazy var uploadBackImg = UIImageView(image: #imageLiteral(resourceName: "upload_back"))
    lazy var uploadTextImg = UIImageView(image: #imageLiteral(resourceName: "upload_text"))
    lazy var nameField: DefaultTextField = {
        let field = DefaultTextField()
        field.actionButton.isHidden = true
        field.imageProfile.image = #imageLiteral(resourceName: "asd")
        field.rightImage.isHidden = true
        field.attributedPlaceholder = NSAttributedString(string: localized(text: "name"), attributes: [.foregroundColor: UIColor.gray,
                                                                                     .font: UIFont.init(name: Font.mullerRegular, size: 14) as Any])
        field.keyboardType = .default
        return field
    }()
    lazy var surnameField: DefaultTextField = {
        let field = DefaultTextField()
        field.actionButton.isHidden = true
        field.imageProfile.image = #imageLiteral(resourceName: "asd")
        field.rightImage.isHidden = true
        field.attributedPlaceholder = NSAttributedString(string: localized(text: "surname"), attributes: [.foregroundColor: UIColor.gray,
                                                                                     .font: UIFont.init(name: Font.mullerRegular, size: 14) as Any])
        field.keyboardType = .default
        return field
    }()
    lazy var saveButton: DefaultButton = {
        let btn = DefaultButton()
        btn.setTitle(localized(text: "save"), for: .normal)
        btn.backgroundColor = maincolor.blue//UIColor(red: 0.949, green: 0.949, blue: 0.949, alpha: 1)
        btn.setTitleColor(.white, for: .normal)
        btn.addTarget(self, action: #selector(tapSave), for: .touchUpInside)
        return btn
    }()
    
    // MARK: - lifecycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        title = localized(text: "edit")
        view.backgroundColor = .white
        navigationController?.navigationBar.topItem?.title = ""
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.barTintColor = maincolor.blue
        navigationController!.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont.init(name: Font.mullerBold, size: 18)!,
                                                                   NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarPosition.any, barMetrics: UIBarMetrics.default)
        navigationController?.navigationBar.isTranslucent = false
        
        getProfile()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
//        getCarTypes()
        setupViews()
    }
    
    // MARK: - Setup
    func setupViews() -> Void {
        scrollView.addSubviews([userImage,uploadBackImg,uploadTextImg,nameField,surnameField,saveButton])
        userImage.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(20)
            make.centerX.equalToSuperview()
            make.width.height.equalTo(104)
        }
        uploadBackImg.snp.makeConstraints { (make) in
            make.centerX.equalTo(userImage)
            make.width.equalTo(90.09)
            make.height.equalTo(26)
            make.bottom.equalTo(userImage)
        }
        uploadTextImg.snp.makeConstraints { (make) in
            make.top.equalTo(uploadBackImg).offset(6)
            make.centerX.equalTo(uploadBackImg)
            make.width.equalTo(47)
            make.height.equalTo(10)
        }
        nameField.snp.makeConstraints { (make) in
            make.top.equalTo(userImage.snp.bottom).offset(40)
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
        saveButton.snp.makeConstraints { (make) in
            make.top.equalTo(surnameField.snp.bottom).offset(30)
            make.left.equalToSuperview().offset(44)
            make.right.equalToSuperview().offset(-44)
            make.height.equalTo(48)
            make.bottom.equalToSuperview().offset(-32)
        }
        scrollView.addSubviews([imageBtn])
        imageBtn.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(20)
            make.centerX.equalToSuperview()
            make.width.height.equalTo(104)
        }
    }
    
    // MARK: - Actions
    @objc func tapImage() -> Void {
        imagePicker.present(from: view)
    } 
    @objc func tapConvenience() -> Void {
        let vc = ConvenienceSimpleViewController()
        vc.delegate = self
        vc.modalPresentationStyle = .overCurrentContext
        vc.modalTransitionStyle = .crossDissolve
        present(vc, animated: true, completion: nil)
    }
    @objc func tapSave() -> Void {
        edit()
    }
}

// MARK: - ImagePicker Delegate
extension EditProfileDriverViewController: ImagePickerDelegate {
    func didSelect(image: UIImage?) {
        userImage.image = image
    }
}

extension EditProfileDriverViewController: ConvenienceSimpleViewControllerDelegate {
    func convenienceTitle(convenienceTitle: String) {
//        convenienceField.text = convenienceTitle
    }
}

// MARK: - Parser
extension EditProfileDriverViewController {
    private func getProfile() -> Void {
        showHUD()
        let parameter = ["id": UserManager.shared.getCurrentUser()!.user!.id] as Parameters
        ParseManager.shared.getRequest(url: api.getById, parameters: parameter) { (result: UserDetail?, error) in
            self.dismissHUD()
            if let error = error {
                self.showErrorMessage(messageType: .none, error)
                return
            }
            self.model = result!
        }
    }
    private func getCarTypes() -> Void {
        ParseManager.shared.getRequest(url: api.cartypes) { (result: [CarTypesModel]?, error) in
            if let error = error {
                self.showErrorMessage(messageType: .none, error)
                return
            }
            self.carTypesArray = result!
        }
    }
    private func edit() -> Void {
        showHUD()
        guard let imageData: Data = (userImage.image?.jpegData(compressionQuality: 0.1)) else { return }
        let parameter = ["avatar": imageData,
                         "name": nameField.text!,
                         "surname": surnameField.text!] as Parameters
        ParseManager.shared.multipartFormData(url: api.edit, parameters: parameter) { (result: CheckRequest?, error) in
            self.dismissHUD()
            if let error = error {
                self.showErrorMessage(messageType: .none, error)
                return
            } else {
                self.showSuccessMessage {
                    self.navigationController?.popViewController(animated: true)
                }
            }
        }
    }
}
