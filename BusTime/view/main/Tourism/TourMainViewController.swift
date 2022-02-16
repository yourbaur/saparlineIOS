//
//  TourMainViewController.swift
//  SaparLine
//
//  Created by Cheburek on 12.02.2022.
//  Copyright © 2022 thousand.com. All rights reserved.
//

import UIKit

final class TourMainViewController: BaseViewController {
    var tag = 0
    var fromCity: String?
    var fromCityID: Int?
    var from_station: String?
    var from_station_id: Int?
    var toCity: String?
    var toCityID: Int?
    var to_station: String?
    var to_station_id: Int?
    var onlyDate: String!
    
    // MARK: - Properties
    var datePicker: UIDatePicker = {
        let picker = UIDatePicker()
        picker.tag = 0
        let calendar = Calendar.current
        let addOneWeekToCurrentDate = calendar.date(byAdding: .weekOfYear, value: 1, to: Date())
        if #available(iOS 13.4, *) { picker.preferredDatePickerStyle = .wheels }
        picker.minimumDate = Date()
        picker.maximumDate = addOneWeekToCurrentDate
        picker.datePickerMode = .date
        picker.addTarget(self, action: #selector(tapDate(sender:)), for: .valueChanged)
        return picker
    }()
    lazy var worldImage: UIImageView = {
        let image = UIImageView()
        image.image = #imageLiteral(resourceName: "Group 10505")
        return image
    }()
    lazy var warningImage: UIImageView = {
        let image = UIImageView()
        image.image = #imageLiteral(resourceName: "Group-4")
        return image
    }()
    lazy var warningTitle: UILabel = {
        let label = UILabel()
        label.text = localized(text: "warning")
        label.numberOfLines = 2
        label.textColor = .white
        label.font = UIFont.init(name: Font.mullerRegular, size: 12)
        return label
    }()
    
    lazy var fromField: DefaultTextField = {
        let field = DefaultTextField()
        field.backgroundColor = maincolor.blue
        field.imageProfile.image = #imageLiteral(resourceName: "Group-5")
        //field.rightImage.image = #imageLiteral(resourceName: "map_location-arrow-1")
        field.text = localized(text: "from")
        field.textColor = .white
        field.keyboardType = .default
        field.actionButton.tag = 0
        field.actionButton.addTarget(self, action: #selector(tapCity(sender:)), for: .touchUpInside)
        return field
    }()
    
    lazy var toField: DefaultTextField = {
        let field = DefaultTextField()
        field.backgroundColor = maincolor.blue
        field.imageProfile.image = #imageLiteral(resourceName: "Group-6")
        field.rightImage.isHidden = true
        field.text = localized(text: "to")
        field.textColor = .white
        field.keyboardType = .default
        field.actionButton.tag = 1
        field.actionButton.addTarget(self, action: #selector(tapCity(sender:)), for: .touchUpInside)
        return field
    }()
    
    lazy var swapButton: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(#imageLiteral(resourceName: "Group 10486"), for: .normal)
        button.backgroundColor = .clear
        button.addTarget(self, action: #selector(tapSwap), for: .touchUpInside)
        return button
    }()
    
    lazy var dateField: DefaultTextField = {
        let field = DefaultTextField()
        field.actionButton.tag = 0
        field.rightImage.isHidden = true
        field.imageProfile.image = #imageLiteral(resourceName: "calendar2")
        field.attributedPlaceholder = NSAttributedString(string: localized(text: "shipDate"), attributes: [.foregroundColor: UIColor.gray,
             .font: UIFont.init(name: Font.mullerRegular, size: 14) as Any])
        field.actionButton.isHidden = false
        field.actionButton.addTarget(self, action: #selector(tapDateField), for: .touchUpInside)
        field.inputView = datePicker
        return field
    }()
    
    lazy var convenienceField: DefaultTextField = {
        let field = DefaultTextField()
        field.imageProfile.image = #imageLiteral(resourceName: "Group-21")
        field.rightImage.isHidden = true
        field.attributedPlaceholder = NSAttributedString(string: localized(text: "facilities"), attributes: [.foregroundColor: UIColor.gray,
                                                                                     .font: UIFont.init(name: Font.mullerRegular, size: 14) as Any])
        field.actionButton.addTarget(self, action: #selector(tapConvenience), for: .touchUpInside)
        field.isHidden = true
        return field
    }()
    lazy var todayButton: DefaultReserveButton = {
        let btn = DefaultReserveButton()
        btn.tag = 1
        btn.setTitle("Сегодня", for: .normal)
        btn.addTarget(self, action: #selector(tapToday(sender:)), for: .touchUpInside)
        return btn
    }()
    lazy var tomorrowButton: DefaultReserveButton = {
        let btn = DefaultReserveButton()
        btn.tag = 2
        btn.setTitle("Завтра", for: .normal)
        btn.addTarget(self, action: #selector(tapTomorrow(sender:)), for: .touchUpInside)
        return btn
    }()
    

    

    
    lazy var countPlaceView = CountPlaceView()
    
    lazy var findButton: DefaultButton = {
        let button = DefaultButton()
        button.setTitle("Найти тур", for: .normal)
        button.addTarget(self, action: #selector(tapFind), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Lifecycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        title = localized(text: "main")
        
        navigationController?.navigationBar.tintColor = maincolor.blue
        navigationController!.navigationBar.titleTextAttributes = [
            NSAttributedString.Key.font: UIFont.init(name: Font.mullerBold, size: 18)!,
            NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationController?.navigationBar.topItem?.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarPosition.any, barMetrics: UIBarMetrics.default)
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.barTintColor = UIColor(red: 0.094, green: 0.157, blue: 0.282, alpha: 1)
        //view.backgroundColor = UIColor(red: 0.094, green: 0.157, blue: 0.282, alpha: 1)
        view.backgroundColor = .white
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        print("/// width", UIScreen.main.bounds.size.width)
        print("/// height", UIScreen.main.bounds.size.height)
    }
    
    // MARK: - SetupViews
    func setupViews() -> Void {
        scrollView.addSubviews([worldImage])
        worldImage.snp.makeConstraints { (make) in
            make.top.width.equalToSuperview()
            make.height.equalTo(220)
        }
        scrollView.addSubviews([warningImage,warningTitle,fromField,toField,swapButton])
        warningImage.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(70)
            make.left.equalToSuperview().offset(16)
            make.width.height.equalTo(20)
        }
        warningTitle.snp.makeConstraints { (make) in
            make.top.equalTo(warningImage.snp.top)
            make.left.equalTo(warningImage.snp.right).offset(8)
            make.right.equalToSuperview().offset(-16)
        }
        fromField.snp.makeConstraints { (make) in
            make.top.equalTo(warningImage.snp.bottom).offset(16)
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
            make.right.equalToSuperview().offset(-32)
            make.width.height.equalTo(34)
            make.top.equalTo(fromField.snp.top).offset(37)
        }
        scrollView.addSubviews([dateField,convenienceField,countPlaceView,findButton,
                                todayButton, tomorrowButton
        ])
        dateField.snp.makeConstraints { (make) in
            make.top.equalTo(worldImage.snp.bottom).offset(8)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
            make.height.equalTo(48)
        }
        convenienceField.snp.makeConstraints { (make) in
            make.top.equalTo(dateField.snp.bottom).offset(12)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
            make.height.equalTo(48)
        }
        todayButton.snp.makeConstraints { (make) in
            make.top.equalTo(dateField.snp.bottom).offset(12)
            make.centerX.equalToSuperview().offset(-60)
            make.height.equalTo(32)
            make.width.equalTo(100)
        }
        tomorrowButton.snp.makeConstraints { (make) in
            make.top.equalTo(dateField.snp.bottom).offset(12)
            
            make.left.equalTo(todayButton.snp.right).offset(8)
            make.height.equalTo(32)
            make.width.equalTo(100)
        }

        countPlaceView.snp.makeConstraints { (make) in
            make.top.equalTo(convenienceField.snp.bottom).offset(26)
            make.width.equalToSuperview()
            make.height.equalTo(40)
            countPlaceView.isHidden = true
        }
        findButton.snp.makeConstraints { (make) in
            make.top.equalTo(countPlaceView.snp.bottom).offset(30)
            make.left.equalToSuperview().offset(44)
            make.right.equalToSuperview().offset(-44)
            make.height.equalTo(48)
        }
    }
    
    // MARK: - Actions
    @objc func tapCity(sender: UIButton) -> Void {
        tag = sender.tag
        let vc = FilterViewController(tapType:"passenger")
        vc.delegate = self
        vc.modalPresentationStyle = .overCurrentContext
        vc.modalTransitionStyle = .crossDissolve
        present(vc, animated: true, completion: nil)
    }
    @objc func tapToday(sender:UIButton) -> Void {
        let formatter = DateFormatter()
        let formatter2 = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        formatter2.dateFormat = "yyyy-MM-dd"
        
        tomorrowButton.backgroundColor = .white
        tomorrowButton.setTitleColor(.lightGray, for: .normal)
        todayButton.backgroundColor = maincolor.blue
        todayButton.setTitleColor(.white, for: .normal)
        
        dateField.text = formatter.string(from: Date())
        onlyDate = formatter2.string(from: Date())
    }
    @objc func tapTomorrow(sender:UIButton) -> Void {
        let calendar = Calendar.current
        let addOneDayToCurrentDate = calendar.date(byAdding: .day, value: 1, to: Date())

        let formatter = DateFormatter()
        let formatter2 = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        formatter2.dateFormat = "yyyy-MM-dd"
        
        todayButton.backgroundColor = .white
        todayButton.setTitleColor(.lightGray, for: .normal)
        tomorrowButton.backgroundColor = maincolor.blue
        tomorrowButton.setTitleColor(.white, for: .normal)
        
        
        dateField.text = formatter.string(from: addOneDayToCurrentDate!)
        onlyDate = formatter2.string(from: addOneDayToCurrentDate!)
    }
    
    
    @objc func tapSwap() {
        if fromCityID != nil && toCityID != nil && from_station_id != nil && to_station_id != nil {
            swap(&fromField.text, &toField.text)
            swap(&fromCity, &toCity)
            swap(&from_station, &to_station)
            swap(&fromCityID, &toCityID)
            swap(&from_station_id, &to_station_id)
        }
    }
     @objc func tapDate(sender: UIDatePicker) {
        let formatter = DateFormatter()
        let formatter2 = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        formatter2.dateFormat = "yyyy-MM-dd"
        dateField.text = formatter.string(from: datePicker.date)
        onlyDate = formatter2.string(from: datePicker.date)
    }
    @objc func tapDateField() {
        tapDate(sender: datePicker)
        dateField.actionButton.isHidden = true
        dateField.becomeFirstResponder()
    }
    @objc func tapConvenience() -> Void {
        let vc = ConvenienceSimpleViewController()
        vc.delegate = self
        vc.modalPresentationStyle = .overCurrentContext
        vc.modalTransitionStyle = .crossDissolve
        present(vc, animated: true, completion: nil)
    }
    @objc func tapFind() -> Void {
        // validation
        guard fromCityID != nil else { self.showErrorMessage(messageType: .error, "Выберите откуда"); return }
        guard toCityID != nil else { self.showErrorMessage(messageType: .error, "Выберите куда"); return }
        guard onlyDate != nil else { self.showErrorMessage(messageType: .error, "Выберите дату"); return }
        // vc set
        let vc = TourSearchResultViewController(from_city_id: fromCityID!,
                                            to_city_id: toCityID!,
                                            date: onlyDate!)
        vc.personCountTitle.text = "  \(countPlaceView.countTitle.text!) " + localized(text: "persons") + "  "
        //vc.dateTitle.text = dateField.text!
        vc.fromto.fromTitle.text = fromCity!
        vc.fromto.parkfromTitle.text = from_station!
        vc.fromto.toTitle.text = toCity!
        vc.fromto.parktoTitle.text = to_station!
        // push
        navigationController?.pushViewController(vc, animated: true)
    }
}

// MARK: - filter from to delegate
extension TourMainViewController: FilterDelegate {
    func send(cityStr: String, cityID: Int, stationsStr: String, stationsID: Int) {
        if tag == 0 {
            fromField.text = cityStr
            fromCityID = cityID
            from_station_id = stationsID
            fromCity = cityStr
            from_station = stationsStr
        } else {
            toField.text = cityStr
            toCityID = cityID
            to_station_id = stationsID
            toCity = cityStr
            to_station = stationsStr
        }
    }
}

// MARK: - ConvenienceViewController delegate
extension TourMainViewController: ConvenienceSimpleViewControllerDelegate {
    func convenienceTitle(convenienceTitle: String) {
        convenienceField.text = convenienceTitle
    }
}
