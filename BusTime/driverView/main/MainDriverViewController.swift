//
//  MainDriverViewController.swift
//  BusTime
//
//  Created by greetgo on 8/25/20.
//  Copyright © 2020 thousand.com. All rights reserved.
//

import UIKit

class MainDriverViewController: BaseDriverViewController {
    
    // MARK: - helpers
    var pickerTextCities: [CitiesModel]?
    var stationsArray: [Int]?
    var selectedFirst: Bool = false
    var tag = 0
    var carsModel: [CarsListModel]? {
        didSet {
            
        }
    }
    var fromCityID: Int?
    var toCityID: Int?
    var from_station_id: Int?
    var to_station_id: Int?
    var times = [Times]()
    var placesPrices = [PlacePrice]()
    var totalPlacesPrices = 0
    var allPlaces = 0
    var carTypeId = 0
    var carId:Int?
    
    
    var model: UserDetail? {
        didSet {
            if self.carId == nil{
                carTypeId = model?.car?.car_type_id ?? 0
                allPlaces = model?.car?.count_places ?? 0
            }
        }
    }
    
    lazy var datePicker: UIDatePicker = {
        let picker = UIDatePicker()
        picker.tag = 0
        let calendar = Calendar.current
        let addOneWeekToCurrentDate = calendar.date(byAdding: .weekOfYear, value: 1, to: Date())
        if #available(iOS 13.4, *) { picker.preferredDatePickerStyle = .wheels }
        picker.minimumDate = Date()
        picker.maximumDate = addOneWeekToCurrentDate
        picker.datePickerMode = .dateAndTime
        picker.addTarget(self, action: #selector(tapDate(sender:)), for: .valueChanged)
        return picker
    }()
    
    lazy var datePicker2: UIDatePicker = {
        let picker = UIDatePicker()
        let calendar = Calendar.current
        let addOneWeekToCurrentDate = calendar.date(byAdding: .day, value: 8, to: Date())
        picker.tag = 1
        if #available(iOS 13.4, *) { picker.preferredDatePickerStyle = .wheels }
        picker.minimumDate = Date()
        picker.maximumDate = addOneWeekToCurrentDate
        picker.datePickerMode = .dateAndTime
        picker.addTarget(self, action: #selector(tapDate(sender:)), for: .valueChanged)
        return picker
    }()
    // MARK: - properties
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
    //lazy var betweenImage = UIImageView(image: #imageLiteral(resourceName: "Group 10486"))
    lazy var swapButton: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(#imageLiteral(resourceName: "Group 10486"), for: .normal)
        button.backgroundColor = .clear
        button.addTarget(self, action: #selector(tapSwap), for: .touchUpInside)
        return button
    }()
    lazy var parkView: CustomDriverView = {
        let view = CustomDriverView(leftIcon: #imageLiteral(resourceName: "fa-solid_map-pin"), title: localized(text: "park"), rightIcon: #imageLiteral(resourceName: "feather_chevron-right"))
        view.button.addTarget(self, action: #selector(tapPark), for: .touchUpInside)
        view.isHidden = true
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
        view.inputView = datePicker
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
        view.inputView = datePicker2
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
    lazy var seatDescLabel: UILabel = {
        let label = UILabel()
        label.text = localized(text: "seatDesc")
        label.numberOfLines = 2
        label.textColor = .lightGray //UIColor(red: 0.094, green: 0.157, blue: 0.282, alpha: 1)
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
        field.delegate = self
        field.keyboardType = .numberPad
        field.deleteBackward()
        return field
    }()
    lazy var firstLabel: UILabel = {
        let label = UILabel()
        label.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        label.layer.cornerRadius = 8
        label.text = "1"
        label.layer.masksToBounds = true
        label.textAlignment = .center
        label.font = UIFont.init(name: Font.mullerBold, size: 14)
        label.backgroundColor = maincolor.blue
        return label
    }()
    lazy var firstField: UITextField = {
        let field = UITextField()
        field.layer.shadowColor = UIColor.gray.cgColor
        field.layer.shadowOpacity = 0.3
        field.layer.shadowOffset = CGSize.zero
        field.layer.shadowRadius = 6
        field.layer.cornerRadius = 5
        field.backgroundColor = .white
        field.placeholder = "Цена"
        field.textAlignment = NSTextAlignment.center
        field.delegate = self
        field.keyboardType = .numberPad
        field.deleteBackward()
        return field
    }()
    lazy var done1Button: DefaultButton = {
        let btn = DefaultButton()
        btn.setTitle(localized(text: "done"), for: .normal)
        btn.addTarget(self, action: #selector(tapDone1), for: .touchUpInside)
        return btn
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
        field.delegate = self
        field.keyboardType = .numberPad
        return field
    }()
    lazy var doneButton: DefaultButton = {
        let btn = DefaultButton()
        btn.setTitle(localized(text: "done"), for: .normal)
        btn.addTarget(self, action: #selector(tapDone), for: .touchUpInside)
        return btn
    }()
    lazy var stack: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        return stackView
    }()
    lazy var stack1: UIStackView = {
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
        btn.addTarget(self, action: #selector(tapFewDays), for: .touchUpInside)
        return btn
    }()
    lazy var nextButton: DefaultButton = {
        let btn = DefaultButton()
        btn.setTitle(localized(text: "further"), for: .normal)
        btn.addTarget(self, action: #selector(tapNext), for: .touchUpInside)
        return btn
    }()
    
    // MARK: - lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        getCards()
       
        
        
    }
    
    // MARK: - Init
    required init?(coder: NSCoder) {fatalError("")}
    init(carId:Int?, countPlaces:Int?, carTypeId:Int?) {
        self.carId = carId
        self.allPlaces = countPlaces ?? 0
        self.carTypeId = carTypeId ?? 0
        super.init(nibName: nil, bundle: nil)
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        title = localized(text: "main")
        navigationController?.navigationBar.tintColor = maincolor.blue
        navigationController!.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont.init(name: Font.mullerBold, size: 18)!,
                                                                   NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationController?.navigationBar.topItem?.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarPosition.any, barMetrics: UIBarMetrics.default)
        navigationController?.navigationBar.barTintColor = UIColor(red: 0.094, green: 0.157, blue: 0.282, alpha: 1)
        view.backgroundColor = .white
    }
    
    // MARK: - setup
    func setupViews() -> Void {
        definesPresentationContext = true
        
        scrollView.addSubviews([worldImage])
        worldImage.snp.makeConstraints { (make) in
            make.width.equalToSuperview()
            make.centerX.equalToSuperview()
            make.top.equalToSuperview()
            make.height.equalTo(220)
        }
        scrollView.addSubviews([firstField,done1Button,firstLabel, warningImage,warningTitle,fromField,toField,swapButton])
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
            make.top.equalTo(warningImage.snp.bottom).offset(14)
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
        scrollView.addSubviews([parkView, fromDateView, toDateView, stackDates, otDoLabel, seatDescLabel, otField, doField, doneButton, stack])
        parkView.snp.makeConstraints { (make) in
            make.top.equalTo(worldImage.snp.bottom).offset(0)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
            make.height.equalTo(0)
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
        seatDescLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
            switch carTypeId {
            case 2:
                make.top.equalTo(otDoLabel.snp.bottom).offset(8)
            default:
                make.top.equalTo(otDoLabel.snp.bottom)
                make.height.equalTo(0)
            }
        }
        firstLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(16)
            make.height.equalTo(40)
            make.width.equalTo(50)
            switch carTypeId {
            case 3:
                make.top.equalTo(seatDescLabel.snp.bottom).offset(8)
            case 5:
                make.top.equalTo(seatDescLabel.snp.bottom).offset(8)
            case 6:
                make.top.equalTo(seatDescLabel.snp.bottom).offset(8)
            default:
                make.top.equalTo(seatDescLabel.snp.bottom)
                make.height.equalTo(0)
            }
        }
        firstField.snp.makeConstraints { (make) in
            make.left.equalTo(firstLabel.snp.right).offset(20)
            make.height.equalTo(40)
            make.width.equalTo(100)
            switch carTypeId {
            case 3:
                make.top.equalTo(seatDescLabel.snp.bottom).offset(8)
            case 5:
                make.top.equalTo(seatDescLabel.snp.bottom).offset(8)
            case 6:
                make.top.equalTo(seatDescLabel.snp.bottom).offset(8)
            default:
                make.top.equalTo(seatDescLabel.snp.bottom)
                make.height.equalTo(0)
            }
        }
        done1Button.snp.makeConstraints { (make) in
            make.left.equalTo(firstField.snp.right).offset(20)
            make.height.equalTo(40)
            make.width.equalTo(doneButton)
            switch carTypeId {
            case 3:
                make.top.equalTo(seatDescLabel.snp.bottom).offset(8)
            case 5:
                make.top.equalTo(seatDescLabel.snp.bottom).offset(8)
            case 6:
                make.top.equalTo(seatDescLabel.snp.bottom).offset(8)
            default:
                make.top.equalTo(seatDescLabel.snp.bottom)
                make.height.equalTo(0)
            }
        }
        
        stack.snp.makeConstraints { (make) in
            make.top.equalTo(otField.snp.bottom).offset(16)
            make.left.right.equalToSuperview()
        }
        otField.snp.makeConstraints { (make) in
            make.top.equalTo(firstLabel.snp.bottom).offset(16)
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
    private func checkConfirmation() {
        if model?.confirmation == "waiting" {
            let vc = UnconfirmedProfileDriverViewController()
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    // MARK: - Parser
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
            self.setupViews()
            self.checkConfirmation()
        }
    }
    private func setConfirm() -> Void {
        showHUD()
        let parameter: Parameters = [:] as Parameters
        ParseManager.shared.postRequest(url: "order/take/\(UserManager.shared.getOrderId() ?? "")", parameters: parameter) { (result: UserDetail?, error) in
            self.dismissHUD()
//            if let error = error {
//                self.showErrorMessage(messageType: .none, error)
//                return
//            }
            self.getCards()
            
        }
    }
    private func reformatDateForBack(dateString: String) -> String {
        var result = ""
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy HH:mm"
        if let date = formatter.date(from: dateString) {
            formatter.dateFormat = "yyyy-MM-dd HH:mm:00"
            result = formatter.string(from: date)
        }
        return result
    }
    private func publishRequest() -> Void {
        showHUD()
        // PREPARE additional dates & times
        var timesFromTo = [Any]()
        for item in times {
            let temp = [ "departure_time": reformatDateForBack(dateString: item.departure_time),
                         "destination_time": reformatDateForBack(dateString: item.destination_time) ]
            timesFromTo.append(temp as Any)
        }
        // PREPARE places & prices
        var places_prices = [Any]()
        for item in placesPrices {
            let temp = [ "from": item.from ?? 0,
                         "to": item.to ?? 0,
                         "price": item.price ?? 0]
            places_prices.append(temp as Any)
        }
        
        // PREPARE parameters
        let parameter: [String : Any] = [ "from_station_id": from_station_id!,
                                          "to_station_id": to_station_id!,
                                          "from_city_id":fromCityID!,
                                          "to_city_id":toCityID!,
                                          "carId":self.carId,
                                          "departure_time": reformatDateForBack(dateString: fromDateView.text!),
                                          "destination_time": reformatDateForBack(dateString: toDateView.text!),
                                          "stations": stationsArray ?? [],
                                          "times": timesFromTo,
                                          "place_price": places_prices ] as Parameters
        print(parameter)
        // REQUEST
        ParseManager.shared.postRequest(url: api.travelAdd, parameters: parameter) { (result: CheckRequest?, error) in
            self.dismissHUD()
//            if let error = error {
//                if !error.contains("success") {
//                    print(error)
//                    self.showErrorMessage(messageType: .none, error)
//                    return
//                }
//            }
            self.showSuccessMessage {
                //AppCenter.shared.startDriver()
                let vc = ComingTripsViewController(carId: self.carId!)
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
    }
    
    // MARK: - actions
    @objc func tapCity(sender: UIButton) -> Void {
        tag = sender.tag
        let vc = FilterViewController(tapType: "driver")
        vc.delegate = self
        vc.modalPresentationStyle = .overCurrentContext
        vc.modalTransitionStyle = .crossDissolve
        present(vc, animated: true, completion: nil)
    }
    @objc func tapPark() -> Void {
        if fromCityID != nil && toCityID != nil {
            let vc = IntermediateFilterViewController(fromID: fromCityID!, toID: toCityID!)
            vc.delegate = self
            vc.modalPresentationStyle = .overCurrentContext
            vc.modalTransitionStyle = .crossDissolve
            present(vc, animated: true, completion: nil)
        } else {
            self.showErrorMessage(messageType: .none, "Укажите город!")
        }
    }
    @objc func tapSwap() {
        if from_station_id != nil && to_station_id != nil {
            let tempStr = fromField.text
            fromField.text = toField.text
            toField.text = tempStr
            var tempId = fromCityID
            fromCityID = toCityID
            toCityID = tempId
            tempId = from_station_id
            from_station_id = to_station_id
            to_station_id = tempId
        }
    }
    @objc func tapDate(sender: UIDatePicker) {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy HH:mm"
        if sender.tag == 0 {
            fromDateView.text = formatter.string(from: datePicker.date)
            datePicker2.minimumDate = datePicker.date
        } else {
            toDateView.text = formatter.string(from: datePicker2.date)
        }
    }
    @objc func tapDone() {
        view.endEditing(true)
        if let ot = Int(otField.text!), let doo = Int(doField.text!) {
            if ot >= doo {
                showErrorMessage(messageType: .none, "Значение От не может быть больше/равно До!")
            } else if stack.arrangedSubviews.count == 0 {
                let otdo = OtDoPriceView(ot: String(ot), doo: String(doo), price: 500)
                stack.addArrangedSubview(otdo)
                otField.text = ""
                doField.text = ""
            } else {
                var flag = false
                for index in 0 ... stack.arrangedSubviews.count - 1 {
                    if let subView = stack.arrangedSubviews[index] as? OtDoPriceView {
                        if (ot >= subView.ot && ot <= subView.doo) || (doo >= subView.ot && doo <= subView.doo) { flag = false; break; }
                        else { flag = true }
                    }
                }
                if flag {
                    let otdo = OtDoPriceView(ot: String(ot), doo: String(doo), price: 500)
                    stack.addArrangedSubview(otdo)
                    otField.text = ""
                    doField.text = ""
                } else { showErrorMessage(messageType: .none, "Повторяющиеся значения!") }
            }
        }
    }
    
    @objc func tapDone1() {
        view.endEditing(true)
        if let ot = Int(firstField.text!) {
            if !self.selectedFirst{
           
                let otdo = OtDoPriceView(ot: "1", doo: "1", price: ot)
                otdo.otDoLabel.text = "1 место"
                otdo.delegate = self
                otdo.first = true
                self.selectedFirst = true
                stack.addArrangedSubview(otdo)}
        }
            
        
}
    @objc func tapFewDays() {
        let newDates = AdditionalDatesView()
        stackDates.addArrangedSubview(newDates)
    }
    @objc func tapNext() -> Void {
        if stack.arrangedSubviews.count > 0 {
            totalPlacesPrices = 0
            placesPrices.removeAll()
            for index in 0 ... stack.arrangedSubviews.count - 1 {
                let subView = stack.arrangedSubviews[index] as? OtDoPriceView
                if !(subView?.first ?? false){
                placesPrices.append(PlacePrice(from: subView?.ot, to: subView?.doo, price: subView?.price))
                    totalPlacesPrices += (subView!.doo - subView!.ot + 1)
                }
                else {
                    placesPrices.append(PlacePrice(from: 1, to: 1, price: subView?.price))
                        totalPlacesPrices += 1
                }
                
            }
            if allPlaces != totalPlacesPrices {
                self.showErrorMessage(messageType: .none, "Неверные данные, введите цен всех мест")
                return
            }
            if stackDates.arrangedSubviews.count > 0 {
                times.removeAll()
                for index in 0 ... stackDates.arrangedSubviews.count - 1 {
                    let subView = stackDates.arrangedSubviews[index] as? AdditionalDatesView
                    times.append(Times(departure_time: subView?.fromDateView.text ?? "", destination_time: subView?.toDateView.text ?? ""))
                }
            }
            if from_station_id != nil && to_station_id != nil && fromDateView.text! != localized(text: "chooseDepartureDate") && toDateView.text! != localized(text: "chooseArrivalDate") && placesPrices.count != 0 {
                publishRequest()
            } else {
                self.showErrorMessage(messageType: .none, "Заполните поле!")
            }
        } else {
            self.showErrorMessage(messageType: .none, "Заполните количество и цену за место!")
        }
    }
}

// MARK: - filter from to delegate
extension MainDriverViewController: FilterDelegate {
    func send(cityStr: String, cityID: Int, stationsStr: String, stationsID: Int) {
        if tag == 0 {
            fromField.text = cityStr + " - " + stationsStr
            fromCityID = cityID
            from_station_id = stationsID
        } else {
            toField.text = cityStr + " - " + stationsStr
            toCityID = cityID
            to_station_id = stationsID
        }
    }
}

// MARK: - filter intermediate delegate
extension MainDriverViewController: InterFilterDelegate {
    func send(stationsID: [Int], stationsStr: String) {
        stationsArray = stationsID
        if stationsStr == "" {
            parkView.title.text = localized(text: "park")
        } else {
            parkView.title.text = stationsStr
        }
    }
}

// MARK: - Textfield delegate
extension MainDriverViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let char = string.cString(using: String.Encoding.utf8)!
        let isBackSpace = strcmp(char, "\\b")
        if (isBackSpace == -92) {
            print("Backspace was pressed")
            return true
        } else if string.rangeOfCharacter(from: NSCharacterSet.decimalDigits) != nil {
            let currentText = textField.text ?? ""
            guard let stringRange = Range(range, in: currentText) else { return false }
            let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
            return updatedText.count <= 5
        } else {
            return false
        }
    }
}

// MARK: - Parser
extension MainDriverViewController {
    private func getCards() -> Void {
        showHUD()
        ParseManager.shared.getRequest(url: api.carsList) { (result: [CarsListModel]?, error) in
            self.dismissHUD()
            if let error = error {
                self.showErrorMessage(messageType: .none, error)
                return
            }
            self.carsModel = result!
            if self.carsModel?.count == 1 || self.carId != nil{
                if self.carsModel?.count == 1 {
                    
                    switch self.carsModel?[0].car_type_id ?? 0 {
                    case 1:
                        self.allPlaces = 53
                    case 2:
                        self.allPlaces = 36
                    case 6:
                        self.allPlaces = 7
                    case 5:
                        self.allPlaces = 4
                    case 7:
                        self.allPlaces = 62
                    case 8:
                        self.allPlaces = 28
                    case 9:
                        self.allPlaces = 29
                    default:
                        self.allPlaces = 6
                    }
                    
                    self.carId = self.carsModel?[0].id
                    
                }
                self.getProfile()
                if (UserManager.shared.getConfirm() ?? false) {
                    self.showSubmitMessage(messageType: .confirm, UserManager.shared.getText() ?? "") {
                        UserManager.shared.setConfirm(to: false)
                        self.setConfirm()
                    }
                }
            }
            else {
                self.navigationController?.pushViewController(CardViewController(cardType: 1), animated: true)
            }
            
        }
    }
  
}

extension MainDriverViewController: DeleteDelegate {
    func delete() {
        self.selectedFirst = false
    }
    
    
}
