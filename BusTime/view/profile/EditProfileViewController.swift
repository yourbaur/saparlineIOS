//
//  EditProfileViewController.swift
//  BusTime
//
//  Created by greetgo on 8/20/20.
//  Copyright © 2020 thousand.com. All rights reserved.
//

import UIKit

class EditProfileViewController: ScrollViewController {

    var model: UserDetail? {
        didSet {
            if model?.avatar != nil {
                let url = model?.avatar?.serverUrlString.url
                userImage.kf.setImage(with: url)
            }
            if model?.name != nil {
                nameField.text = model?.name
            }
            if model?.surname != nil {
                surnameField.text = model?.surname
            }
        }
    }
    
    // MARK: - Variables
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
    lazy var userImage: UIImageView = {
        let image = UIImageView(image: #imageLiteral(resourceName: "Group 10535"))
        image.contentMode = .scaleToFill
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
        field.imageProfile.image = #imageLiteral(resourceName: "asd")
        field.actionButton.isHidden = true
        field.rightImage.isHidden = true
        field.attributedPlaceholder = NSAttributedString(string: localized(text: "surname"), attributes: [.foregroundColor: UIColor.gray,
                                                                                         .font: UIFont.init(name: Font.mullerRegular, size: 14) as Any])
        field.keyboardType = .default
        return field
    }()
    lazy var locationField: DefaultTextField = {
        let field = DefaultTextField()
        field.imageProfile.image = #imageLiteral(resourceName: "Group-1")
        field.rightImage.image = #imageLiteral(resourceName: "map_location-arrow")
        field.attributedPlaceholder = NSAttributedString(string: localized(text: "address"), attributes: [.foregroundColor: UIColor.gray,
                                                                                     .font: UIFont.init(name: Font.mullerRegular, size: 14) as Any])
        field.actionButton.addTarget(self, action: #selector(tapLocation), for: .touchUpInside)
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
    
    // MARK: - Lifecycle
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
    
        scrollView.addSubviews([userImage,uploadBackImg,uploadTextImg,nameField,surnameField,saveButton,imagePickerBtn])
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
            make.top.equalTo(nameField.snp.bottom).offset(16)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
            make.height.equalTo(48)
        }
//        locationField.snp.makeConstraints { (make) in
//            make.top.equalTo(surnameField.snp.bottom).offset(12)
//            make.left.equalToSuperview().offset(16)
//            make.right.equalToSuperview().offset(-16)
//            make.height.equalTo(48)
//        }
        saveButton.snp.makeConstraints { (make) in
            make.top.equalTo(surnameField.snp.bottom).offset(30)
            make.left.equalToSuperview().offset(44)
            make.right.equalToSuperview().offset(-44)
            make.height.equalTo(48)
            make.bottom.equalToSuperview().offset(-30)
        }
        imagePickerBtn.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(20)
            make.centerX.equalToSuperview()
            make.width.height.equalTo(104)
        }
    }
    
    // MARK: - Actions
    @objc func openImagePicker() -> Void {
        imagePicker.present(from: view)
    }
    @objc func tapLocation() -> Void {
        let vc = ShowInMapViewController()
        vc.delegate = self
        navigationController?.pushViewController(vc, animated: true)
    }
    @objc func tapSave() -> Void {
        edit()
    }
}

// MARK: - ImagePicker Delegate
extension EditProfileViewController: ImagePickerDelegate {
    func didSelect(image: UIImage?) {
        userImage.image = image
    }
}

// MARK: - Location delegate
extension EditProfileViewController: ShowInMapViewControllerDelegate {
    func sendAddressString(addressString: String, lat: Double, long: Double) {
        locationField.text = addressString
    }
}

// MARK: - Parser
extension EditProfileViewController {
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
            }
            self.showSuccessMessage {
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
}
