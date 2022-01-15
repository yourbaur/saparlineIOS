//
//  UnconfirmedProfileDriverViewController.swift
//  BusTime
//
//  Created by Aldiyar Massimkhanov on 11/9/20.
//  Copyright © 2020 thousand.com. All rights reserved.
//

import UIKit
import Kingfisher

class UnconfirmedProfileDriverViewController: BaseDriverViewController {

    // MARK: - Variables
    var model: UserDetail?
    
    // MARK: - Properties
    lazy var warningView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 210/255, green: 86/255, blue: 76/255, alpha: 1)
        return view
    }()
    lazy var warningImage: UIImageView = {
        let image = UIImageView()
        image.image = #imageLiteral(resourceName: "bi_info-circle-fill")
        return image
    }()
    lazy var warningTitle: UILabel = {
        let label = UILabel()
        label.text = "Ваш аккаунт в процессе подтверждения, подождите пока администрация подтвердит ваши данные"
        label.numberOfLines = 3
        label.textColor = maincolor.blue
        label.font = UIFont.init(name: Font.mullerRegular, size: 14)
        return label
    }()
    lazy var worldImage: UIImageView = {
        let image = UIImageView()
        image.image = #imageLiteral(resourceName: "Group 10505")
        return image
    }()
    lazy var fromField: DefaultTextField = {
        let field = DefaultTextField()
        field.backgroundColor = maincolor.blue
        field.imageProfile.image = #imageLiteral(resourceName: "Group-5")
        field.rightImage.image = #imageLiteral(resourceName: "map_location-arrow-1")
        field.text = localized(text: "from")
        field.textColor = .white
        field.isUserInteractionEnabled = false
        return field
    }()
    lazy var toField: DefaultTextField = {
        let field = DefaultTextField()
        field.backgroundColor = maincolor.blue
        field.imageProfile.image = #imageLiteral(resourceName: "Group-6")
        field.rightImage.isHidden = true
        field.text = localized(text: "to")
        field.textColor = .white
        field.isUserInteractionEnabled = false
        return field
    }()
    lazy var swapButton: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(#imageLiteral(resourceName: "Group 10486"), for: .normal)
        button.backgroundColor = .clear
        button.isUserInteractionEnabled = false
        return button
    }()
    lazy var parkView: CustomDriverView = {
        let view = CustomDriverView(leftIcon: #imageLiteral(resourceName: "fa-solid_map-pin"), title: localized(text: "park"), rightIcon: #imageLiteral(resourceName: "feather_chevron-right"))
        view.isUserInteractionEnabled = false
        return view
    }()
    lazy var fromDateView: DefaultTextField = {
        let view = DefaultTextField()
        view.text = localized(text: "chooseDepartureDate")
        view.imageProfile.image = #imageLiteral(resourceName: "calendar 1")
        view.rightImage.image = #imageLiteral(resourceName: "feather_chevron-right")
        view.actionButton.isHidden = true
        view.layer.shadowColor = UIColor.gray.cgColor
        view.layer.shadowOpacity = 0.3
        view.layer.shadowOffset = CGSize.zero
        view.layer.shadowRadius = 6
        view.layer.cornerRadius = 5
        view.backgroundColor = .white
        view.isUserInteractionEnabled = false
        return view
    }()
    lazy var toDateView: DefaultTextField = {
        let view = DefaultTextField()
        view.text = localized(text: "chooseArrivalDate")
        view.imageProfile.image = #imageLiteral(resourceName: "calendar 1")
        view.rightImage.image = #imageLiteral(resourceName: "feather_chevron-right")
        view.actionButton.isHidden = true
        view.layer.shadowColor = UIColor.gray.cgColor
        view.layer.shadowOpacity = 0.3
        view.layer.shadowOffset = CGSize.zero
        view.layer.shadowRadius = 6
        view.layer.cornerRadius = 5
        view.backgroundColor = .white
        view.isUserInteractionEnabled = false
        return view
    }()
    lazy var stackDates: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        return stackView
    }()
    lazy var otDoLabel: UILabel = {
        let label = UILabel()
        label.text = localized(text: "priceSeat")
        label.textColor = UIColor(red: 0.094, green: 0.157, blue: 0.282, alpha: 1)
        label.font = UIFont.init(name: Font.mullerRegular, size: 14)
        return label
    }()
    lazy var otField: UITextField = {
        let field = UITextField()
        field.layer.shadowColor = UIColor.gray.cgColor
        field.layer.shadowOpacity = 0.3
        field.layer.shadowOffset = CGSize.zero
        field.layer.shadowRadius = 6
        field.layer.cornerRadius = 5
        field.backgroundColor = .white
        field.placeholder = localized(text: "seatFrom")
        field.textAlignment = NSTextAlignment.center
        field.isUserInteractionEnabled = false
        return field
    }()
    lazy var doField: UITextField = {
        let field = UITextField()
        field.layer.shadowColor = UIColor.gray.cgColor
        field.layer.shadowOpacity = 0.3
        field.layer.shadowOffset = CGSize.zero
        field.layer.shadowRadius = 6
        field.layer.cornerRadius = 5
        field.backgroundColor = .white
        field.placeholder = localized(text: "seatTo")
        field.textAlignment = NSTextAlignment.center
        field.isUserInteractionEnabled = false
        return field
    }()
    lazy var doneButton: DefaultButton = {
        let btn = DefaultButton()
        btn.setTitle(localized(text: "done"), for: .normal)
        btn.isUserInteractionEnabled = false
        return btn
    }()
    lazy var stack: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        return stackView
    }()
    lazy var addDatesButton: DefaultButton = {
        let btn = DefaultButton()
        btn.backgroundColor = UIColor(red: 0.95, green: 0.95, blue: 0.95, alpha: 1)
        btn.setTitleColor(maincolor.blue, for: .normal)
        btn.setTitle(localized(text: "fewDays"), for: .normal)
        btn.isUserInteractionEnabled = false
        return btn
    }()
    lazy var nextButton: DefaultButton = {
        let btn = DefaultButton()
        btn.setTitle(localized(text: "further"), for: .normal)
        btn.isUserInteractionEnabled = false
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
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        getProfile()
    }
    
    // MARK: - SetupViews
    func setupViews() -> Void {
        scrollView.addSubviews([worldImage])
        worldImage.snp.makeConstraints { (make) in
            make.width.equalToSuperview()
            make.centerX.equalToSuperview()
            make.top.equalToSuperview()
            make.height.equalTo(220)
        }
        scrollView.addSubviews([fromField,toField,swapButton])
        fromField.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(100)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
            make.height.equalTo(48)
        }
        toField.snp.makeConstraints { (make) in
            make.top.equalTo(fromField.snp.bottom).offset(12)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
            make.height.equalTo(48)
        }
        swapButton.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(3)
            make.width.height.equalTo(34)
            make.top.equalTo(fromField.snp.top).offset(37)
        }
        scrollView.addSubviews([warningView,warningImage,warningTitle])
        warningView.snp.makeConstraints { (make) in
            make.top.equalTo(worldImage.snp.bottom).offset(16)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.height.equalTo(72)
        }
        warningImage.snp.makeConstraints { (make) in
            make.centerY.equalTo(warningView)
            make.left.equalToSuperview().offset(16)
            make.width.height.equalTo(20)
        }
        warningTitle.snp.makeConstraints { (make) in
            make.centerY.equalTo(warningView)
            make.left.equalTo(warningImage.snp.right).offset(16)
            make.right.equalToSuperview().offset(-16)
        }
        scrollView.addSubviews([parkView, fromDateView, toDateView, stackDates, otDoLabel, otField, doField, doneButton])
        parkView.snp.makeConstraints { (make) in
            make.top.equalTo(warningView.snp.bottom).offset(16)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
            make.height.equalTo(48)
        }
        fromDateView.snp.makeConstraints { (make) in
            make.top.equalTo(parkView.snp.bottom).offset(12)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
            make.height.equalTo(48)
        }
        toDateView.snp.makeConstraints { (make) in
            make.top.equalTo(fromDateView.snp.bottom).offset(12)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
            make.height.equalTo(48)
        }
        stackDates.snp.makeConstraints { (make) in
            make.top.equalTo(toDateView.snp.bottom).offset(8)
            make.left.right.equalToSuperview()
        }
        otDoLabel.snp.makeConstraints { (make) in
            make.top.equalTo(stackDates.snp.bottom).offset(16)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
        }
        otField.snp.makeConstraints { (make) in
            make.top.equalTo(otDoLabel.snp.bottom).offset(5)
            make.height.equalTo(40)
            make.width.equalToSuperview().multipliedBy(0.25)
            make.left.equalToSuperview().offset(16)
        }
        doField.snp.makeConstraints { (make) in
            make.centerY.equalTo(otField.snp.centerY)
            make.height.equalTo(40)
            make.left.equalTo(otField.snp.right).offset(20)
            make.width.equalToSuperview().multipliedBy(0.25)
        }
        doneButton.snp.makeConstraints { (make) in
            make.centerY.equalTo(otField.snp.centerY)
            make.height.equalTo(40)
            make.left.equalTo(doField.snp.right).offset(20)
            make.right.equalToSuperview().offset(-16)
        }
        scrollView.addSubviews([stack, addDatesButton, nextButton])
        stack.snp.makeConstraints { (make) in
            make.top.equalTo(otField.snp.bottom).offset(16)
            make.left.right.equalToSuperview()
        }
        addDatesButton.snp.makeConstraints { (make) in
            make.top.equalTo(stack.snp.bottom).offset(30)
            make.right.equalTo(worldImage.snp.centerX).offset(-8)
            make.left.equalToSuperview().offset(16)
            make.height.equalTo(48)
        }
        nextButton.snp.makeConstraints { (make) in
            make.top.equalTo(stack.snp.bottom).offset(30)
            make.right.equalToSuperview().offset(-16)
            make.left.equalTo(worldImage.snp.centerX).offset(8)
            make.height.equalTo(48)
            make.bottom.equalToSuperview().offset(-30)
        }
    }
}

// MARK: - Parser
extension UnconfirmedProfileDriverViewController {
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
