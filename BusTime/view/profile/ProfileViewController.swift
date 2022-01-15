//
//  ProfileViewController.swift
//  BusTime
//
//  Created by Tuigynbekov Yelzhan on 8/19/20.
//  Copyright © 2020 thousand.com. All rights reserved.
//

import UIKit

class ProfileViewController: BaseViewController {

    // MARK: - Variables
    var lang = ""
    var model: UserDetail? {
        didSet {
            if model?.avatar != nil {
                let url = model?.avatar?.serverUrlString.url
                userImage.kf.setImage(with: url)
            }
            nameTitle.text = (model!.name ?? "Введите") + " " + (model!.surname ?? "")
            typeTitle.text = localized(text: "passenger")
            songView.switcher.isOn = model?.sound == 1 ? true : false
            pushView.switcher.isOn = model?.push == 1 ? true : false
            lang = model?.lang == "ru" ? "Русский" : "Қазақша"
            languageView.rightTitle.text = lang
            if let itemRowIndex = languages.firstIndex(of: lang) {
                pickerLanguage.selectRow(itemRowIndex, inComponent: 0, animated: false)
            }
        }
    }
    
    // MARK: - Helpes
    var languages = ["Русский","Қазақша"]
    lazy var pickerLanguage: UIPickerView = {
        let picker = UIPickerView()
        picker.delegate = self
        picker.dataSource = self
        return picker
    }()
    
    // MARK: - Properties
    lazy var userImage: UIImageView = {
        let image = UIImageView(image: #imageLiteral(resourceName: "Group 10533"))
        image.layer.cornerRadius = 52
        image.layer.masksToBounds = true
        return image
    }()
    lazy var nameTitle: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textColor = maincolor.blue
        label.font = UIFont.init(name: Font.mullerMedium, size: 16)
        return label
    }()
    lazy var typeTitle: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textColor = UIColor(red: 0.741, green: 0.741, blue: 0.741, alpha: 1)
        label.font = UIFont.init(name: Font.mullerRegular, size: 12)
        return label
    }()
    lazy var editView: ProfileDetailView = {
        let view = ProfileDetailView(iconImage: #imageLiteral(resourceName: "pencil"), title: localized(text: "edit"), type: "arrow")
        view.button.addTarget(self, action: #selector(tapEdit), for: .touchUpInside)
        return view
    }()
    lazy var pushView: ProfileDetailView = {
        let view = ProfileDetailView(iconImage: #imageLiteral(resourceName: "notification"), title: localized(text: "push"), type: "switcher")
        view.button.isHidden = true
        return view
    }()
    lazy var songView: ProfileDetailView = {
        let view = ProfileDetailView(iconImage: #imageLiteral(resourceName: "volume"), title: localized(text: "song"), type: "switcher")
        view.button.isHidden = true
        return view
    }()
    lazy var languageView: ProfileDetailView = {
        let view = ProfileDetailView(iconImage: #imageLiteral(resourceName: "translate"), title: localized(text: "lang"), type: "title")
        view.field.isHidden = false
        view.field.inputView = pickerLanguage
        return view
    }()
    lazy var aboutView: ProfileDetailView = {
        let view = ProfileDetailView(iconImage: #imageLiteral(resourceName: "Group-4"), title: localized(text: "about app"), type: "arrow")
        view.button.addTarget(self, action: #selector(tapAbout), for: .touchUpInside)
        return view
    }()
    lazy var shareView: ProfileDetailView = {
        let view = ProfileDetailView(iconImage: #imageLiteral(resourceName: "pencil"), title: localized(text: "share"), type: "arrow")
        view.button.addTarget(self, action: #selector(tapShare), for: .touchUpInside)
        return view
    }()
    lazy var makeBtn: ExitButtonView = {
        let btn = ExitButtonView()
        btn.title.text = localized(text: "apply")
        btn.title.textColor = maincolor.blue
        btn.icon.image = #imageLiteral(resourceName: "Group-8")
        btn.icon.tintColor = maincolor.blue
        btn.layer.shadowColor = maincolor.blue.cgColor
        btn.mainButton.addTarget(self, action: #selector(tapMake), for: .touchUpInside)
        return btn
    }()
    lazy var exitView: ExitButtonView = {
        let btn = ExitButtonView()
        btn.icon.tintColor = .red
        btn.mainButton.addTarget(self, action: #selector(tapExit), for: .touchUpInside)
        return btn
    }()
    
    // MARK: - Lifecycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        title = localized(text: "profile")
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
        setupViews()
    }
    
    // MARK: - SetupViews
    func setupViews() -> Void {
        scrollView.addSubviews([userImage,nameTitle,typeTitle,pushView])
        userImage.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(20)
            make.width.height.equalTo(104)
            make.centerX.equalToSuperview()
        }
        nameTitle.snp.makeConstraints { (make) in
            make.top.equalTo(userImage.snp.bottom).offset(12)
            make.centerX.equalToSuperview()
        }
        typeTitle.snp.makeConstraints { (make) in
            make.top.equalTo(nameTitle.snp.bottom).offset(4)
            make.centerX.equalToSuperview()
        }
        scrollView.addSubviews([editView,pushView,songView,languageView,
                                aboutView, shareView, makeBtn, exitView])
        editView.snp.makeConstraints { (make) in
            make.top.equalTo(typeTitle.snp.bottom).offset(40)
            make.height.equalTo(48)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
        }
        pushView.snp.makeConstraints { (make) in
            make.top.equalTo(editView.snp.bottom).offset(12)
            make.height.equalTo(48)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
        }
        songView.snp.makeConstraints { (make) in
            make.top.equalTo(pushView.snp.bottom).offset(12)
            make.height.equalTo(48)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
        }
        languageView.snp.makeConstraints { (make) in
            make.top.equalTo(songView.snp.bottom).offset(12)
            make.height.equalTo(48)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
        }
        aboutView.snp.makeConstraints { (make) in
            make.top.equalTo(languageView.snp.bottom).offset(12)
            make.height.equalTo(48)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
        }
        shareView.snp.makeConstraints { (make) in
            make.top.equalTo(aboutView.snp.bottom).offset(12)
            make.height.equalTo(48)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
        }
        makeBtn.snp.makeConstraints { (make) in
            make.top.equalTo(shareView.snp.bottom).offset(60)
            make.height.equalTo(40)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
        }
        exitView.snp.makeConstraints { (make) in
            make.top.equalTo(makeBtn.snp.bottom).offset(22)
            make.height.equalTo(40)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
            make.bottom.equalToSuperview().offset(-100)
        }
    }
    
    // MARK: - Actions
    @objc func tapEdit() -> Void {
        navigationController?.pushViewController(EditProfileViewController(), animated: true)
    }
    @objc func tapAbout() -> Void {
        navigationController?.pushViewController(EmptyPolicyViewController(), animated: true)
        //navigationController?.pushViewController(AboutAppViewController(), animated: true)
    }
    @objc func tapShare() -> Void {
        let items = [URL(string:"http://onelink.to/y3898n")]
        self.present(UIActivityViewController(activityItems: items, applicationActivities: nil),animated: true)
        //navigationController?.pushViewController(AboutAppViewController(), animated: true)
    }
    @objc func tapMake() -> Void {
        showHUD()
        let parameter = ["sound": songView.switcher.isOn ? 1 : 0,
                         "push": pushView.switcher.isOn ? 1 : 0,
                         "lang": languageView.rightTitle.text == "Русский" ? "ru" : "kz"] as Parameters
        ParseManager.shared.multipartFormData(url: api.edit, parameters: parameter) { (result: CheckRequest?, error) in
            self.dismissHUD()
            if let error = error {
                self.showErrorMessage(messageType: .none, error)
                return
            }
            self.showSuccessMessage {
                LanguageCenter.standard.setLanguageCustomer(language: self.languageView.rightTitle.text == "Русский" ? "ru" : "kk-KZ")
            }
        }
    }
    @objc func tapExit() -> Void {
        self.showSubmitMessage(messageType: .none, "Вы уверены что хотите выйти?") {
            UserManager.shared.deleteCurrentSession()
            AppCenter.shared.startAuth()
        }
    }
}

//  MARK: - Picker delegate
extension ProfileViewController: UIPickerViewDataSource, UIPickerViewDelegate{
    func numberOfComponents(in pickerView: UIPickerView) -> Int { 1 }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int { return languages.count }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? { return languages[row] }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        languageView.rightTitle.text = languages[row]
    }
}

// MARK: - Parser
extension ProfileViewController {
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
}
