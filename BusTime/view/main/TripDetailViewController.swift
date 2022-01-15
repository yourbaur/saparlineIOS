//
//  TripDetailViewController.swift
//  BusTime
//
//  Created by Tuigynbekov Yelzhan on 8/19/20.
//  Copyright © 2020 thousand.com. All rights reserved.
//

import UIKit

class TripDetailViewController: ScrollViewController {
    
    // MARK: - Variables
    var travel_id: Int?
    var places = [Int]()
    var placesStr = [String]()
    var timer: Timer?
    var secCounter = 60
    var minCounter = 14
    var phoneNumber = ""
    var kaspiNumber = ""
    var carId: Int = 0
    var userId:Int = 0
    // MARK: - Properties
    lazy var profileView = TripProfileView()
    lazy var tripwayView = TripNewWayView()
    lazy var tripPlaceView = TripNewPlaceView()
    private var typeId: Int = 0
    lazy var line = UIView()
    
    lazy var timerView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 9
        view.layer.borderColor = UIColor.red.cgColor
        view.layer.borderWidth = 2
        return view
    }()
    
  
    lazy var attentionTitle: UILabel = {
        let label = UILabel()
        label.text = " \(minCounter):\(secCounter) "
        label.numberOfLines = 3
        label.textColor = .red//maincolor.blue
        label.font = UIFont.init(name: Font.mullerBold, size: 68)
        return label
    }()
    lazy var topLabelTitle: UILabel = {
        let label = UILabel()
        label.text = "До истечения брони"
        label.numberOfLines = 3
        label.textColor = .red//maincolor.blue
        label.font = UIFont.init(name: Font.mullerBold, size: 25)
        return label
    }()
    lazy var tripPayView = TripNewPayView()
    lazy var price: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textColor = maincolor.blue
        label.textAlignment = .center
        label.font = UIFont.init(name: Font.mullerBold, size: 24)
        return label
    }()
    lazy var reservePlaceBtn: DefaultButton = {
        let btn = DefaultButton()
        btn.backgroundColor = #colorLiteral(red: 0.05386027694, green: 0.6967057586, blue: 0.5264524221, alpha: 1)
        btn.titleLabel?.numberOfLines = 3
        btn.titleLabel?.textAlignment = .center
        btn.layer.cornerRadius = 17
        btn.setTitle("10 000тг \nОплатить", for: .normal)
        btn.addTarget(self, action: #selector(tapReserve), for: .touchUpInside)
        return btn
    }()
    
    var model: UserDetail? {
        didSet {
            if model?.avatar != nil {
                let url = model?.avatar?.serverUrlString.url
                profileView.imageIcon.kf.setImage(with: url)
            }
        }
    }
    var whatsappModel: Whatsapp? {
        didSet {
            if whatsappModel?.whatsapp != nil {
                self.kaspiNumber = "+\(whatsappModel!.whatsapp!)"
                tripPayView.number.text = self.kaspiNumber
                tripPayView.copyIcon.textString = self.kaspiNumber
                self.phoneNumber = "+7\(model?.phone ?? "")"
                
            }
        }
    }

    // MARK: - Lifecycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        title = localized(text: "tripDetail")
        view.backgroundColor = .white
        navigationController?.navigationBar.topItem?.title = ""
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.barTintColor = maincolor.blue
        navigationController!.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont.init(name: Font.mullerBold, size: 18)!,
                                                                   NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarPosition.any, barMetrics: UIBarMetrics.default)
        navigationController?.navigationBar.isTranslucent = false
        
        DispatchQueue.main.async {
            self.getProfile()
            self.getSettings()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        tripPayView.copyIcon.addTarget(self, action: #selector(labelDidGetTapped(sender:)), for: .touchUpInside)
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(processTimer), userInfo: nil, repeats: true)
    }
    @objc
    func labelDidGetTapped(sender: CopyButton) {
       
        let text = sender.textString
        UIPasteboard.general.string = text
        
        showMessage("Cкопировано")
    }
    // MARK: - SetupViews
    private func setupViews() -> Void {
        scrollView.backgroundColor = .white
        line.backgroundColor = .gray
        
        scrollView.addSubviews([profileView,tripwayView,tripPlaceView,line,tripPayView,reservePlaceBtn, timerView])
        profileView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(20)
            make.width.equalToSuperview()
        }
        tripwayView.snp.makeConstraints { (make) in
            make.top.equalTo(profileView.snp.bottom).offset(16)
            make.width.equalToSuperview()
            make.height.equalTo(120)
        }
        tripPlaceView.snp.makeConstraints { (make) in
            make.top.equalTo(tripwayView.snp.bottom).offset(16)
            make.width.equalToSuperview()
            make.height.equalTo(60)
        }
        line.snp.makeConstraints { (make) in
            make.top.equalTo(tripPlaceView.snp.bottom).offset(16)
            make.width.equalToSuperview()
            make.height.equalTo(1)
        }
        timerView.snp.makeConstraints { (make) in
            make.top.equalTo(line).offset(8)
            make.centerX.equalToSuperview()
            make.width.equalTo(335)
            make.height.equalTo(144)
        }
        timerView.addSubviews([topLabelTitle, attentionTitle])
        
        topLabelTitle.snp.makeConstraints { (make) in
            make.bottom.equalTo(attentionTitle.snp.top).offset(-10)
            make.centerX.equalToSuperview()
        }
        
        attentionTitle.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(10)
        }
      
        tripPayView.snp.makeConstraints { (make) in
            make.top.equalTo(timerView.snp.bottom).offset(8)
            make.centerX.equalToSuperview()
        }
//        price.snp.makeConstraints { (make) in
//            make.centerY.equalTo(reservePlaceBtn)
//            make.left.equalToSuperview()
//            make.right.equalTo(reservePlaceBtn.snp.left)
//        }
        reservePlaceBtn.snp.makeConstraints { (make) in
            make.top.equalTo(tripPayView.snp.bottom).offset(30)
            make.width.equalTo(245)
            make.centerX.equalToSuperview()
            make.height.equalTo(73)
            make.bottom.equalToSuperview().offset(-30)
        }
    }
    
    func configure(model: TravelList, travel_id: Int, places: [Int], placesStr: [String], sum: String) -> Void {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:00"
        var date = formatter.date(from: model.departure_time)
        formatter.dateFormat = "dd.MM.yyyy"
        tripwayView.dateTitle.text = formatter.string(from: date ?? Date())
        formatter.dateFormat = "yyyy-MM-dd HH:mm:00"
        date = formatter.date(from: model.destination_time)
        formatter.dateFormat = "dd.MM.yyyy"
        tripwayView.toDateTitle.text = formatter.string(from: date ?? Date())
        tripwayView.timeTitle.text = model.departure_time.onlyTime()
        tripwayView.totimeTitle.text = model.destination_time.onlyTime()
        tripwayView.cityTitle.text = model.from?.city
        tripwayView.parkTitle.text = model.from?.station
        tripwayView.tocityTitle.text = model.to?.city
        tripwayView.toparkTitle.text = model.to?.station
       
        
        formatter.dateFormat = "yyyy-MM-dd HH:mm:00"
        if let fromTime = formatter.date(from: model.departure_time),
           let toTime = formatter.date(from: model.destination_time) {
            let hours = toTime - fromTime
            tripwayView.duration.text = "в пути \(hours.hour ?? 0) час"
        }
        tripPlaceView.stateNumberTitle.text = model.car.state_number
        tripPlaceView.idplaceTitle.text = ""
        self.travel_id = travel_id
        self.places = places
        self.placesStr = placesStr
        if placesStr.count > 0 {
            for item in placesStr {
                if tripPlaceView.idplaceTitle.text == "" {
                    tripPlaceView.idplaceTitle.text = "\(item)"
                } else {
                    tripPlaceView.idplaceTitle.text! += ", \(item)"
                }
            }
        }
        price.text = sum
        self.typeId = model.car.car_type_id
        self.carId = model.car.id
        if model.car.car_type_id == 3 || model.car.car_type_id == 5 || model.car.car_type_id == 6{
            tripPayView.isHidden = true
            reservePlaceBtn.setTitle("\(sum) \nПозвонить", for: .normal)
        }
        else {
            reservePlaceBtn.setTitle("\(sum) \nОплатить", for: .normal)
        }
        
        profileView.nameTitle.text = "№\(model.id)"
        self.userId = model.car.user_id ?? 0
        
    }
    private func updateTextTimer() {
        attentionTitle.text = " \(minCounter):\(secCounter) "
    }
    
    // MARK: - Actions
    @objc func tapReserve() -> Void {
            reserveRequest()
        
    }
    @objc func processTimer() {
        if minCounter != 0 && secCounter != 0 {
            secCounter -= 1
            if secCounter == 0 {
                secCounter = 59
                minCounter -= 1
            }
            updateTextTimer()
        } else {
            timer?.invalidate()
        }
    }
}

extension TripDetailViewController {
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
    private func getSettings() -> Void {
        showHUD()
        let parameter = [:] as Parameters
        ParseManager.shared.getRequest(url: api.settings, parameters: parameter) { (result: Whatsapp?, error) in
            self.dismissHUD()
            if let error = error {
                self.showErrorMessage(messageType: .none, error)
                return
            }
           
            self.whatsappModel = result
        }
    }
    private func reserveRequest() -> Void {
        showHUD()
        // PREPARE parameters
        let parameter: [String: Any] = ["travel_id": travel_id!,
                                        "places": places]
        // REQUEST
        ParseManager.shared.postRequest(url: api.placeReserve, parameters: parameter) { (result: CheckRequest?, error) in
            self.dismissHUD()
//            if let error = error {
//                print(error)
//                self.showErrorMessage(messageType: .none, "К сожелению выбранное место не доступно")
//                return
//            }
            if self.typeId == 3 || self.typeId == 5 || self.typeId == 6 {
                self.phoneNumber.makeCall()
                self.call(orderId: result?.orderId ?? 0)
                
            }
            else{
            self.openWhatsApp()
                AppCenter.shared.startCustomer()}
        }
    }
    private func openWhatsApp() {
        let phoneNumber =  whatsappModel!.whatsapp!
        var placesString = ""
        for item in placesStr {
            placesString += "\(item),"
        }
        let urlString = "Мой номер брони \(placesString) номер автобуса \(tripPlaceView.stateNumberTitle.text ?? "")"
        let urlStringEncoded = urlString.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? ""
        guard let appURL = URL(string: "https://wa.me/\(phoneNumber)?text=\(urlStringEncoded)") else { print("WRONG whatsapp URL"); return; }
        if UIApplication.shared.canOpenURL(appURL) {
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(appURL, options: [:], completionHandler: nil)
            } else {
                UIApplication.shared.openURL(appURL)
            }
        }
    }
    private func call(orderId:Int) {
        showHUD()
        let parameter = ["id":userId , "orderId":orderId]
        ParseManager.shared.getRequest(url: api.call, parameters: parameter as Parameters) { (result: UserDetail?, error) in
            self.dismissHUD()
            if let error = error {
                self.showErrorMessage(messageType: .none, error)
                return
            }
            
        }
    }
}
