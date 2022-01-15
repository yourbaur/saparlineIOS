//
//  ReserveDriverViewController.swift
//  BusTime
//
//  Created by greetgo on 8/26/20.
//  Copyright © 2020 thousand.com. All rights reserved.
//

import UIKit

class ReserveDriverViewController: ScrollViewController {
    
    var travel_id: Int?
    var travelShow: TravelShowModel?
    var car_type_id: Int?
    var fromStationId: Int?
    var passengerId: Int?
    var toStationId: Int?
    var departureTime: String?
    var destinationTime: String?
    var swap1to53 = [7,8,11,12,15,16,19,20,23,24,27,28,33,34,37,38,41,42,45,46]
    var swap2to53 = [9,10,13,14,17,18,21,22,25,26,29,30,35,36,39,40,43,44,47,48]
    
    var stations: [Int]?
    var timesFromTo: [Times]?
    var placesPrices: [PlacePrice]?
    // MARK: - constant
    var removedNumbersInCollectionView36 = [2,3,4,5,8,9,10,11,14,15,20,21,26,27,32,33,38,39,44,45,48,53,54,59]
    var removedNumbersInCollectionView50 = [2,3,8,9,10,11,14,15,20,21,26,27,32,33,38,39,44,45,50,51,52,53,56,57,62,63,68,69,74,75]
    var removedNumbersInCollectionView6 = [0,1,2,3,5,6,7,8,9,10,11,12,13,15,17,18,19,20,21,22,23,24,25]
    var removedNumbersInCollectionView7 = [0,1,2,3,5,6,7,8,9,10,11,12,13,17,18,19,20,21,22,23,24,25]
    var removedNumbersInCollectionView4 = [0,1,2,3,5,6,7,8,9,10,11,12,13,17,18,19,20,21,22,23,24]
    var removedNumbersInCollectionView62 = [2,3,8,9,14,15,16,17,20,21,26,27,32,33,38,39,44,45,50,51,56,57,58,59,62,63,64,65,68,69,74,75,80,81,86,87, 92,93,98,99]
    var swap1to62 = [39,40,43,44,47,48,51,52,55,56,59,60]
    var swap2to62 = [41,42,45,46,49,50,53,54,57,58,61,62]

    
    lazy var scheme = UIImageView(image: UIImage(named: "scheme1"))
    lazy var scheme53 = UIImageView(image: UIImage(named: "scheme"))
    
    var skipCount = 0
    var placesCount = 0
    var place_id = 0
    
    // MARK: - properties
    //lazy var descriptionView = DescriptionReserveView()
    lazy var rulImage = UIImageView(image: #imageLiteral(resourceName: "Group-13"))
    lazy var exitView = ExitView()
    lazy var exitView2 = ExitView()
    lazy var betweenView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 0.949, green: 0.949, blue: 0.949, alpha: 1)
        view.layer.cornerRadius = 7
        return view
    }()
    lazy var layout = UICollectionViewFlowLayout()
    lazy var collectionView: DynamicHeightCollectionView = {
        let collectionView = DynamicHeightCollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.isScrollEnabled = false
        collectionView.backgroundColor = .clear
        collectionView.register(SitDriverCollectionViewCell.self, forCellWithReuseIdentifier: SitDriverCollectionViewCell.cellIdentifier)
        return collectionView
    }()
    lazy var placeView = PlaceDriverView()
//    lazy var publishBtn: DefaultButton = {
//        let btn = DefaultButton()
//        btn.setTitle(localized(text: "publish"), for: .normal)
//        btn.addTarget(self, action: #selector(tapPublish), for: .touchUpInside)
//        return btn
//    }()
    
    // MARK: - lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        title = localized(text: "reservSeat")
        view.backgroundColor = .white
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.barTintColor = maincolor.blue
        navigationController?.navigationBar.topItem?.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationController!.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont.init(name: Font.mullerBold, size: 18)!,
                                                                   NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarPosition.any, barMetrics: UIBarMetrics.default)
        navigationController?.navigationBar.isTranslucent = false
        
        getTravelShow()
    }
    
    // MARK: - setup
    func setupViews() -> Void {
        view.backgroundColor = .white
        if car_type_id == 1{
            scrollView.addSubviews([exitView,collectionView,exitView2,betweenView, scheme53])
            
            
            scheme53.snp.makeConstraints { (make) in
                make.centerX.equalTo(collectionView)
                make.width.equalToSuperview()
                make.centerY.equalTo(collectionView).offset(-45)
                make.height.equalTo(collectionView).multipliedBy(1.2)
            
            }
           
            exitView.snp.makeConstraints { (make) in
                make.top.equalToSuperview().offset(170)
                make.width.equalTo(150)
                make.right.equalToSuperview()
            }
            collectionView.snp.makeConstraints { (make) in
                make.top.equalToSuperview().offset(120)
                make.bottom.equalToSuperview().offset(-32)
                switch UIDevice.modelName {
                case "iPhone 12", "iPhone 12 Pro", "iPhone 12 Pro Max", "iPhone 11", "iPhone 11 Pro Max", "iPhone XR", "iPhone XS Max", "iPhone 6 Plus", "iPhone 6s Plus", "iPhone 7 Plus", "iPhone 8 Plus", "iPhone 13", "iPhone 13 Pro Max", "iPhone 13 Pro":
                    make.left.equalToSuperview().offset(44)
                    make.right.equalToSuperview().offset(-44)
                default: make.left.equalToSuperview().offset(16)
                         make.right.equalToSuperview().offset(-16)}
            }
            exitView2.snp.makeConstraints { (make) in
                make.width.equalTo(150)
                make.right.equalToSuperview()
                make.centerY.equalTo(collectionView.snp.centerY).offset(70)
            }
            betweenView.snp.makeConstraints { (make) in
                make.top.equalToSuperview().offset(100)
                make.centerX.equalToSuperview()
                make.width.equalTo(80)
                make.bottom.equalTo(collectionView.snp.bottom).offset(-55)
            }
        }
        else if car_type_id == 7{
            scrollView.addSubviews([exitView,collectionView,exitView2,betweenView, scheme53])
           
            
            scheme53.snp.makeConstraints { (make) in
                make.centerX.equalTo(collectionView)
                make.width.equalToSuperview()
                make.centerY.equalTo(collectionView).offset(-55)
                make.height.equalTo(collectionView).multipliedBy(1.2)
            
            }
            exitView.snp.makeConstraints { (make) in
                make.top.equalToSuperview().offset(250)
                make.width.equalTo(150)
                make.right.equalToSuperview()
            }
            collectionView.snp.makeConstraints { (make) in
                make.top.equalToSuperview().offset(150)
                make.bottom.equalToSuperview().offset(-32)
                switch UIDevice.modelName {
                case "iPhone 12", "iPhone 12 Pro", "iPhone 12 Pro Max", "iPhone 11", "iPhone 11 Pro Max", "iPhone XR", "iPhone XS Max", "iPhone 6 Plus", "iPhone 6s Plus", "iPhone 7 Plus", "iPhone 8 Plus", "iPhone 13", "iPhone 13 Pro Max", "iPhone 13 Pro":
                    make.left.equalToSuperview().offset(44)
                    make.right.equalToSuperview().offset(-44)
                default: make.left.equalToSuperview().offset(16)
                         make.right.equalToSuperview().offset(-16)}
            }
            exitView2.snp.makeConstraints { (make) in
                make.width.equalTo(160)
                make.right.equalToSuperview()
                make.centerY.equalTo(collectionView.snp.centerY).offset(70)
            }
            betweenView.snp.makeConstraints { (make) in
                make.top.equalToSuperview().offset(130)
                make.centerX.equalToSuperview()
                make.width.equalTo(80)
                make.bottom.equalTo(collectionView.snp.bottom).offset(-55)
            }
        }
        else if car_type_id == 3{
            scrollView.addSubviews([rulImage,exitView,collectionView,exitView2,betweenView, scheme])
            scheme.snp.makeConstraints { (make) in
                make.centerX.equalTo(collectionView).offset(20)
                make.centerY.equalTo(collectionView).offset(-20)
                make.width.equalTo(260)
                make.height.equalTo(350)
            }
            rulImage.snp.makeConstraints { (make) in
                make.top.equalToSuperview().offset(100)
                make.left.equalToSuperview().offset(135)
                make.width.height.equalTo(32)
            }
            exitView.snp.makeConstraints { (make) in
                exitView.isHidden = true
                make.top.equalToSuperview().offset(32)
                make.width.equalTo(150)
                make.right.equalToSuperview()
            }
            collectionView.snp.makeConstraints { (make) in
                make.top.equalTo(rulImage.snp.bottom).offset(-20)
                make.bottom.equalToSuperview().offset(-32)
                switch UIDevice.modelName {
                case "iPhone 12", "iPhone 12 Pro", "iPhone 12 Pro Max", "iPhone 11", "iPhone 11 Pro Max", "iPhone XR", "iPhone XS Max", "iPhone 6 Plus", "iPhone 6s Plus", "iPhone 7 Plus", "iPhone 8 Plus", "iPhone 13", "iPhone 13 Pro Max", "iPhone 13 Pro":
                    make.left.equalToSuperview().offset(32)
                    make.right.equalToSuperview().offset(-48)
                default: make.left.equalToSuperview().offset(16)
                         make.right.equalToSuperview().offset(-16)}
            }
            
            exitView2.snp.makeConstraints { (make) in
                exitView2.isHidden = true
                make.width.equalTo(70)
                make.right.equalToSuperview()
                make.centerY.equalTo(collectionView.snp.centerY).offset(-5)
            }
            betweenView.snp.makeConstraints { (make) in
                make.top.equalTo(rulImage)
                make.centerX.equalToSuperview().offset(25)
                make.width.equalTo(50)
                make.bottom.equalTo(collectionView.snp.bottom).offset(-55)
            }
        }
        else if car_type_id == 6{
            scrollView.addSubviews([rulImage,exitView,collectionView,exitView2,betweenView, scheme])
            scheme.snp.makeConstraints { (make) in
                make.centerX.equalTo(collectionView).offset(20)
                make.centerY.equalTo(collectionView).offset(-20)
                make.width.equalTo(260)
                make.height.equalTo(350)
            }
            rulImage.snp.makeConstraints { (make) in
                make.top.equalToSuperview().offset(120)
                make.left.equalToSuperview().offset(145)
                make.width.height.equalTo(32)
            }
            exitView.snp.makeConstraints { (make) in
                exitView.isHidden = true
                make.top.equalToSuperview().offset(32)
                make.width.equalTo(150)
                make.right.equalToSuperview().offset(-25)
            }
            collectionView.snp.makeConstraints { (make) in
                make.top.equalTo(rulImage.snp.bottom).offset(-20)
                make.bottom.equalToSuperview().offset(-32)
                switch UIDevice.modelName {
                case "iPhone 12", "iPhone 12 Pro", "iPhone 12 Pro Max", "iPhone 11", "iPhone 11 Pro Max", "iPhone XR", "iPhone XS Max", "iPhone 6 Plus", "iPhone 6s Plus", "iPhone 7 Plus", "iPhone 8 Plus", "iPhone 13", "iPhone 13 Pro Max", "iPhone 13 Pro":
                    make.left.equalToSuperview().offset(44)
                    make.right.equalToSuperview().offset(-44)
                default: make.left.equalToSuperview().offset(16)
                         make.right.equalToSuperview().offset(-16)}
            }
            exitView2.snp.makeConstraints { (make) in
                exitView2.isHidden = true
                make.width.equalTo(70)
                make.right.equalToSuperview().offset(-25)
                make.centerY.equalTo(collectionView.snp.centerY).offset(-5)
            }
            betweenView.snp.makeConstraints { (make) in
                make.top.equalTo(rulImage)
                betweenView.isHidden = true
                make.centerX.equalTo(-50)
                make.width.equalTo(50)
                make.bottom.equalTo(collectionView.snp.bottom).offset(-190)
            }
        }

        else if car_type_id == 5{
            scrollView.addSubviews([rulImage,exitView,collectionView,exitView2,betweenView, scheme])
            
            scheme.snp.makeConstraints { (make) in
                make.centerX.equalTo(collectionView).offset(20)
                make.centerY.equalTo(collectionView).offset(-40)
                make.width.equalTo(260)
                make.height.equalTo(310)
            }
            rulImage.snp.makeConstraints { (make) in
                make.top.equalToSuperview().offset(100)
                make.left.equalToSuperview().offset(145)
                make.width.height.equalTo(32)
            }
            exitView.snp.makeConstraints { (make) in
                exitView.isHidden = true
                make.top.equalToSuperview().offset(32)
                make.width.equalTo(150)
                make.right.equalToSuperview().offset(-25)
            }
            collectionView.snp.makeConstraints { (make) in
                make.top.equalTo(rulImage.snp.bottom).offset(-20)
                make.bottom.equalToSuperview().offset(-32)
                switch UIDevice.modelName {
                case "iPhone 12", "iPhone 12 Pro", "iPhone 12 Pro Max", "iPhone 11", "iPhone 11 Pro Max", "iPhone XR", "iPhone XS Max", "iPhone 6 Plus", "iPhone 6s Plus", "iPhone 7 Plus", "iPhone 8 Plus", "iPhone 13", "iPhone 13 Pro Max", "iPhone 13 Pro":
                    make.left.equalToSuperview().offset(32)
                    make.right.equalToSuperview().offset(-44)
                default: make.left.equalToSuperview().offset(16)
                         make.right.equalToSuperview().offset(-16)}
            }
            exitView2.snp.makeConstraints { (make) in
                exitView2.isHidden = true
                make.width.equalTo(70)
                make.right.equalToSuperview().offset(-25)
                make.centerY.equalTo(collectionView.snp.centerY).offset(-5)
            }
            betweenView.snp.makeConstraints { (make) in
                betweenView.isHidden = true
                make.top.equalTo(rulImage)
                make.centerX.equalToSuperview().offset(-20)
                make.width.equalTo(50)
                make.bottom.equalTo(collectionView.snp.bottom).offset(-190)
            }
        }
        else {
            scrollView.addSubviews([exitView,collectionView,betweenView, scheme53])
            scheme53.snp.makeConstraints { (make) in
                make.centerX.equalTo(collectionView)
                make.width.equalToSuperview()
                make.centerY.equalTo(collectionView).offset(-50)
                make.height.equalTo(collectionView).multipliedBy(1.1)
            
            }
            exitView.snp.makeConstraints { (make) in
                make.top.equalToSuperview().offset(120)
                make.width.equalTo(150)
                make.right.equalToSuperview()
            }
            collectionView.snp.makeConstraints { (make) in
                make.top.equalToSuperview().offset(120)
                make.bottom.equalToSuperview().offset(-32)
                switch UIDevice.modelName {
                case "iPhone 12", "iPhone 12 Pro", "iPhone 12 Pro Max", "iPhone 11", "iPhone 11 Pro Max", "iPhone XR", "iPhone XS Max", "iPhone 6 Plus", "iPhone 6s Plus", "iPhone 7 Plus", "iPhone 8 Plus", "iPhone 13", "iPhone 13 Pro Max", "iPhone 13 Pro":
                    make.left.equalToSuperview().offset(44)
                    make.right.equalToSuperview().offset(-44)
                default: make.left.equalToSuperview().offset(16)
                         make.right.equalToSuperview().offset(-16)}
            }
            betweenView.snp.makeConstraints { (make) in
                make.top.equalToSuperview().offset(120)
                make.centerX.equalToSuperview()
                make.width.equalTo(80)
                make.bottom.equalTo(collectionView.snp.bottom).offset(-250)
            }
        }
    }
    
    // MARK: - Init
    required init?(coder: NSCoder) {fatalError("")}
    init(travel_id: Int, car_type_id: Int) {
        super.init(nibName: nil, bundle: nil)
        
        self.travel_id = travel_id
        self.car_type_id = car_type_id
    }
//    private func reformatDate(dateString: String) {
//        let formatter = DateFormatter()
//        formatter.dateFormat = "yyyy-MM-dd HH:mm:00"
//        if let date = formatter.date(from: dateString) {
//            formatter.dateFormat = "HH:mm / dd.MM.yyyy"
//            descriptionView.dateTitle.text = formatter.string(from: date)
//        }
//    }
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
//    private func showPlacesPrices(sender: [PlacePrice]) {
//        var placesPricesString = ""
//        for item in sender {
//            placesPricesString += "места №\(item.from ?? 0)-\(item.to ?? 0): \(item.price ?? 0) ₸\n"
//        }
//        descriptionView.placeTitle.text = placesPricesString
//    }
    
    // MARK: - actions
    func shouldBeRemoved(index: Int) -> Bool {
        if placesCount == 36 {
            if removedNumbersInCollectionView36.contains(index) {
                skipCount += 1
                return true
            } else {
                return false
            }
        } else if placesCount == 53{
            if removedNumbersInCollectionView50.contains(index) {
                skipCount += 1
                return true
            } else {
                return false
            }
        }
        else if placesCount == 62{
            if removedNumbersInCollectionView62.contains(index) {
                skipCount += 1
                return true
            } else {
                return false
            }
        }
        else if placesCount == 7 {
            if removedNumbersInCollectionView7.contains(index) {
                skipCount += 1
                return true
            } else {
                return false
            }

        }
        else if placesCount == 4 {
            if removedNumbersInCollectionView4.contains(index) {
                skipCount += 1
                return true
            } else {
                return false
            }

        }
        else {
            if removedNumbersInCollectionView6.contains(index) {
                skipCount += 1
                return true
            } else {
                return false
            }
        }
        
    }
}

// MARK: - collection delegate
extension ReserveDriverViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if placesCount == 36 {
            return placesCount + removedNumbersInCollectionView36.count
        } else if placesCount == 53 {
            return placesCount + removedNumbersInCollectionView50.count
        }
        else if placesCount == 6 {
           return placesCount + removedNumbersInCollectionView6.count
       }
        else if placesCount == 7 {
            return placesCount + removedNumbersInCollectionView7.count
        }
        else if placesCount == 4 {
            return placesCount + removedNumbersInCollectionView4.count
        }
        else if placesCount == 62 {
            return placesCount + removedNumbersInCollectionView62.count
        }
        else {
            return 0
        }
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SitDriverCollectionViewCell.cellIdentifier, for: indexPath) as! SitDriverCollectionViewCell
        
        if shouldBeRemoved(index: indexPath.item) {
            cell.isHidden = true
        }
        let placeNum: Int = indexPath.item + 1 - skipCount
        cell.placeNumBack = placeNum
        cell.placeNumber.text = "\(placeNum)"
        if car_type_id == 1 {
//
            if let index = swap1to53.firstIndex(of: placeNum) {
                cell.placeNumBack = swap2to53[index]
                cell.placeNumber.text = "\(swap2to53[index])"
            }
            else if let index = swap2to53.firstIndex(of: placeNum) {
                cell.placeNumBack = swap1to53[index]
                cell.placeNumber.text = "\(swap1to53[index])"
            }
        }
        
        if car_type_id == 7 {
            if let index = swap1to62.firstIndex(of: placeNum) {
                cell.placeNumBack = swap2to62[index]
                cell.placeNumber.text = "\(swap2to62[index])"
            }
            else if let index = swap2to62.firstIndex(of: placeNum) {
                cell.placeNumBack = swap1to62[index]
                cell.placeNumber.text = "\(swap1to62[index])"
            }
        }
        if car_type_id == 2 {
            if placeNum < 5 {
                cell.placeNumBack = placeNum + 32
                switch cell.placeNumBack {
                case 33,34:
                    cell.placeNumber.text = "0↑"
                default:
                    cell.placeNumber.text = "0↓"
                }
            } else {
                let newNum = Int(round(Double((placeNum - 3) / 2)))
                if placeNum % 2 == 0 {
                    cell.placeNumber.text = "\(newNum)↑"
                    cell.placeNumBack = newNum + 16
                } else {
                    cell.placeNumber.text = "\(newNum)↓"
                    cell.placeNumBack = newNum
                }
            }
        }
        if travelShow != nil {
            for i in travelShow!.places! {
                if i.number == cell.placeNumBack {
                    if i.status == "free" {
                        cell.sitImageView.image = #imageLiteral(resourceName: "Group-16")
                        cell.status = 0
                    } else if i.status == "take" {
                        
                        cell.sitImageView.image = #imageLiteral(resourceName: "Group-12")
                        cell.status = 1
                    } else if i.status == "in_process" {
                        cell.sitImageView.image = #imageLiteral(resourceName: "Group-15")
                    }
                }
            }
        }
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! SitDriverCollectionViewCell
        showSubmitMessage(messageType: .none, "Вы действительно хотите забронировать место?") {
            if cell.sitImageView.image != #imageLiteral(resourceName: "Group-15") && self.travelShow != nil{
                for place in self.travelShow!.places! {
                    if place.number == cell.placeNumBack {
                        self.place_id = place.id
                        self.passengerId = place.passenger?.id
                        break
                    }
                }
                if cell.status == 0 {
                    if self.passengerId == nil{
                        cell.sitImageView.image = #imageLiteral(resourceName: "Group-12")
                        cell.status = 1
                        self.reserveRequest(id: self.place_id, status: "take")
                    }
                    else {
                        self.showErrorMessage(messageType: .error, "Вы не можете забронировать это место")
                    }
                } else {
                    if self.passengerId == nil{
                        cell.sitImageView.image = #imageLiteral(resourceName: "Group-16")
                        cell.status = 0
                        self.reserveRequest(id: self.place_id, status: "free")
                    }
                    else {
                        self.showErrorMessage(messageType: .error, "Вы не можете забронировать это место")
                    }
                }
            }
            else {
                self.showErrorMessage(messageType: .error, "Вы не можете забронировать это место")
            }
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: 42, height: 42)
    }
}

extension ReserveDriverViewController {
    private func getTravelShow() -> Void {
        showHUD()
        print("travel_id: \(travel_id!)")
        let parameter = ["travel_id": travel_id!]
        ParseManager.shared.getRequest(url: api.travelShowPassenger, parameters: parameter as Parameters) { (result: TravelShowModel?, error) in
            self.dismissHUD()
            if let error = error {
                print(error)
                self.showErrorMessage(messageType: .none, error)
                return
            }
            self.travelShow = result!
            self.skipCount = 0
            self.placesCount = self.travelShow?.places?.count ?? 0
            self.collectionView.reloadData()
            print("places: \(self.placesCount)")
        }
    }
    private func reserveRequest(id: Int, status: String) -> Void {
        showHUD()
        let parameter: [String: Any] = [ "travel_place_id": id,
                                         "status": status]
        ParseManager.shared.postRequest(url: api.reserveEdit, parameters: parameter) { (result: CheckRequest?, error) in
            self.dismissHUD()
            print("PLACES", self.travelShow?.places)
//            if let error = error {
//                print(error)
//                self.showErrorMessage(messageType: .none, "К сожелению выбранное место не доступно")
//                return
//            }
            self.showSuccessMessage {
                print("Fine!")
                DispatchQueue.main.async {
                    self.getTravelShow()
                }
            }
        }
    }
}
