//
//  ReviewViewController.swift
//  SaparLine
//
//  Created by Bauyrzhan on 28.02.2021.
//  Copyright © 2021 thousand.com. All rights reserved.
//

import Foundation
import UIKit
import Cosmos


class ReviewViewController: BaseDriverViewController {
    private var average = 0
    private var cleanCount = 0
    private var behaCount = 0
    private var speedCount = 0
    private var carId = 0

    // MARK: - Variables
 
    lazy private var ratingView: CosmosView = {
        let ratingView = CosmosView()
        ratingView.rating = 0
        ratingView.settings.starSize = 40
        return ratingView
    }()
    

    
    lazy private var cleanView: CosmosView = {
        let ratingView = CosmosView()
        ratingView.rating = 0
        ratingView.text = "Чистота"
        ratingView.isHidden = true
        ratingView.settings.starSize = 25

        return ratingView
    }()
    
    lazy private var behaView: CosmosView = {
       let ratingView = CosmosView()
        ratingView.rating = 0
        ratingView.text = "Поведение"
        ratingView.isHidden = true
        ratingView.settings.starSize = 25
        return ratingView
    }()
    
    lazy private var speedView: CosmosView = {
        let ratingView = CosmosView()
        ratingView.rating = 0
        ratingView.text = "Скорость"
        ratingView.isHidden = true
        ratingView.settings.starSize = 25
        return ratingView
    }()
    
    // MARK: - Properties
   
    lazy var reviewField: DefaultTextField = {
        let field = DefaultTextField()
        field.actionButton.isHidden = true
        field.rightImage.isHidden = true
        field.keyboardType = .default
        field.attributedPlaceholder = NSAttributedString(string: "Напишите..", attributes: [.foregroundColor: UIColor.gray,
                                                                                     .font: UIFont.init(name: Font.mullerRegular, size: 14) as Any])
        return field
    }()
    lazy var confirmButton: DefaultButton = {
        let btn = DefaultButton()
        btn.setTitle("Отправить", for: .normal)
        return btn
    }()
    // MARK: - Init
    required init?(coder: NSCoder) {fatalError("")}
    init(carId:Int?) {
        self.carId = carId ?? 0
        super.init(nibName: nil, bundle: nil)
        
    }
    
    // MARK: - Lifecycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.title = localized(text: "reviews")
        
        navigationController?.navigationBar.tintColor = maincolor.blue
        navigationController?.navigationBar.barTintColor = maincolor.blue
        navigationController!.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont.init(name: Font.mullerBold,size: 18)!,
                                                                   NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarPosition.any, barMetrics: UIBarMetrics.default)
        
    }
    
    private func showVisible(bool:Bool) {
        if !bool{
            behaView.isHidden = true
            speedView.isHidden = true
            cleanView.isHidden = true
        }
        else {
            behaView.isHidden = false
            speedView.isHidden = false
            cleanView.isHidden = false
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupActions()
    }
    private func setupActions() {
        ratingView.didTouchCosmos = { rating in
            self.showVisible(bool: true)
            self.cleanView.rating = Double(rating)
            self.behaView.rating = Double(rating)
            self.speedView.rating = Double(rating)

        }
        
        cleanView.didTouchCosmos = { rating in
            self.cleanCount = Int(rating)
            self.average = self.cleanCount + self.behaCount + self.speedCount
            self.ratingView.rating = Double(self.average/3)
        }
        
        behaView.didTouchCosmos = { rating in
            self.behaCount = Int(rating)
            
            self.average = self.cleanCount + self.behaCount + self.speedCount
            self.ratingView.rating = Double(self.average/3)
        }
        speedView.didTouchCosmos = { rating in
            self.speedCount = Int(rating)
            self.average = self.cleanCount + self.behaCount + self.speedCount
            self.ratingView.rating = Double(self.average/3)
        }
        
        confirmButton.addTarget(self, action: #selector(confirm), for: .touchUpInside)
    }
    
    private func setupViews() {
        scrollView.addSubviews([ratingView, cleanView, behaView, speedView,
                                reviewField, confirmButton])
        ratingView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(30)
            make.centerX.equalToSuperview()
            make.height.equalTo(60)
        }

        cleanView.snp.makeConstraints { (make) in
            make.top.equalTo(ratingView.snp.bottom).offset(30)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
            make.height.equalTo(48)
        }
        behaView.snp.makeConstraints { (make) in
            make.top.equalTo(cleanView.snp.bottom).offset(30)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
            make.height.equalTo(48)
        }
        speedView.snp.makeConstraints { (make) in
            make.top.equalTo(behaView.snp.bottom).offset(30)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
            make.height.equalTo(48)
        }
        reviewField.snp.makeConstraints { (make) in
            make.top.equalTo(speedView.snp.bottom).offset(30)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
            make.height.equalTo(100)
            
        }
        
        confirmButton.snp.makeConstraints { (make) in
            make.top.equalTo(reviewField.snp.bottom).offset(30)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
            make.height.equalTo(48)
            
        }

        

        
    }
    
 }

extension ReviewViewController {
    @objc
    func confirm() -> Void {
        showHUD()
      
        let parameter = [
                         "text": reviewField.text!,
                         "criterion1": cleanCount,
                         "criterion2": behaCount,
                         "criterion3":speedCount,
                          "carId":self.carId
        ] as Parameters
        ParseManager.shared.postRequest(url: api.addReview, parameters: parameter) { (result: UserDetail?, error) in
            self.dismissHUD()
//            if let error = error {
//                print(error)
//                self.showErrorMessage(messageType: .none, "Заполните все поля!")
//                return
//            }
            self.showSuccessMessage()
            AppCenter.shared.startCustomer()
            //            self.showSuccessMessage()
            
            
        }
    }
}
