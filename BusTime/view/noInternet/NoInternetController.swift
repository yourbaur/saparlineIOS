//
//  NoInternetController.swift
//  SaparLine
//
//  Created by Bauyrzhan on 04.10.2021.
//  Copyright © 2021 thousand.com. All rights reserved.
//

import Foundation
import UIKit
import Charts
import Cosmos


class NoInternetViewController: ScrollViewController {

    // MARK: - Variables
    lazy var noInternetImage: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "noInternet")
        return view
    }()
    lazy var noInternetLabel:UILabel = {
        let label = UILabel()
        label.text = "Похоже, вы не подключены к интернету"
        label.textColor = maincolor.blue
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = UIFont.init(name: Font.mullerRegular, size: 21)
        return label
    }()
    lazy var noInternetDescription:UILabel = {
        let label = UILabel()
        label.text = "Проверьте ваше интернет-соединение и перезайдите в приложение"
        label.textColor = maincolor.blue
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = UIFont.init(name: Font.mullerRegular, size: 16)
        return label
    }()
    lazy var updateButton: DefaultButton = {
        let button = DefaultButton()
        button.setTitle("Обновить", for: .normal)
        button.isHidden = true
        
        button.addTarget(self, action: #selector(update), for: .touchUpInside)
        return button
    }()

    // MARK: - Lifecycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    
    // MARK: - Init
    required init?(coder: NSCoder) {fatalError("")}
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    
    private func setupViews() {
        scrollView.addSubviews([noInternetImage, noInternetLabel,
                                noInternetDescription, updateButton])
        noInternetImage.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(50)
            make.centerX.equalToSuperview()
            make.width.equalTo(100)
            make.height.equalTo(100)
        }
        noInternetLabel.snp.makeConstraints { make in
            make.top.equalTo(noInternetImage.snp.bottom).offset(16)
            make.left.equalToSuperview().offset(16)
            make.centerX.equalToSuperview()
            make.right.lessThanOrEqualToSuperview().offset(-16)
        }
        noInternetDescription.snp.makeConstraints { make in
            make.top.equalTo(noInternetLabel.snp.bottom).offset(16)
            make.centerX.equalToSuperview()
            make.left.equalToSuperview().offset(16)
            make.right.lessThanOrEqualToSuperview().offset(-16)
        }
        updateButton.snp.makeConstraints { make in
            make.top.equalTo(noInternetDescription.snp.bottom).offset(16)
            make.centerX.equalToSuperview()
            make.left.equalToSuperview().offset(44)
            make.right.equalToSuperview().offset(-44)
            make.height.equalTo(48)
        }
        
    }
   
    @objc
    func update() {
        if (UserManager.shared.getTypeUser() ?? "") == "driver" {
            AppCenter.shared.startDriver()
        }
        else if (UserManager.shared.getTypeUser() ?? "") == "passenger" {
            AppCenter.shared.startCustomer()
        }
        else {
            AppCenter.shared.startAuth()
        }
    }
    
}
