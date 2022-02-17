//
//  ReserveViewController.swift
//  BusTime
//
//  Created by greetgo on 8/17/20.
//  Copyright © 2020 thousand.com. All rights reserved.
//

import UIKit

class ReserveViewController: ScrollViewController {
    
    var removedNumbersInCollectionView4 = [0,1,2,3,5,6,7,8,9,10,11,12,13,17,18,19,20,21,22,23,24]
    var removedNumbersInCollectionView6 = [0,1,2,3,5,6,7,8,9,10,11,12,13,15,17,18,19,20,21,22,23,24,25]
    var removedNumbersInCollectionView7 = [0,1,2,3,5,6,7,8,9,10,11,12,13,17,18,19,20,21,22,23,24,25]
    var removedNumbersInCollectionView28 = [2,3,4,5,8,9,10,11,14,15,20,21,26,27,32,33,36,37,38,39,40,41,42,47,48,53,54,55,56,57,58,59]
    var removedNumbersInCollectionView29 = [2,3,4,5,8,9,10,11,14,15,20,21,26,27,32,33,37,38,39,40,41,42,47,48,53,54,55,56,57,58,59]
    var removedNumbersInCollectionView30 = [2,3,4,5,8,9,10,11,14,15,20,21,26,27,32,33,38,39,40,41,42,47,48,53,54,55,56,57,58,59]
    var removedNumbersInCollectionView31 = [2,3,4,5,8,9,10,11,14,15,20,21,26,27,32,33,38,39,41,42,47,48,53,54,55,56,57,58,59]
    var removedNumbersInCollectionView32 = [2,3,4,5,8,9,10,11,14,15,20,21,26,27,32,33,38,39,42,47,48,53,54,55,56,57,58,59]
    var removedNumbersInCollectionView33 = [2,3,4,5,8,9,10,11,14,15,20,21,26,27,32,33,38,39,42,43,44,45,46,48,53,54,59]
    var removedNumbersInCollectionView34 = [2,3,4,5,8,9,10,11,14,15,20,21,26,27,32,33,38,39,42,43,44,45,48,53,54,59]
    var removedNumbersInCollectionView35 = [2,3,4,5,8,9,10,11,14,15,20,21,26,27,32,33,38,39,44,45,46,48,53,54,59]
    var removedNumbersInCollectionView36 = [2,3,4,5,8,9,10,11,14,15,20,21,26,27,32,33,38,39,44,45,48,53,54,59]
    var removedNumbersInCollectionView50 = [2,3,8,9,10,11,14,15,20,21,26,27,32,33,38,39,44,45,50,51,52,53,56,57,62,63,68,69,74,75]
    var removedNumbersInCollectionView62 = [2,3,8,9,14,15,16,17,20,21,26,27,32,33,38,39,44,45,50,51,56,57,58,59,62,63,64,65,68,69,74,75,80,81,86,87, 92,93,98,99]
    
    private var showHigherSeatsIn36 = [0, 1, 13, 17, 19, 23, 25, 29, 31, 35, 37, 41, 43, 47, 50, 52, 56, 58]
    private var showLowerSeatsIn36 = [6, 7, 12, 16, 18, 22, 24, 28, 30, 34, 36, 40, 42, 46, 49, 51, 55, 57]

    private var passengersInfos = [PassengerInfoModel]()
    var skipCount = 0
    var placesCount = 0
    var kaspiNumber = ""
    var phone = ""
    // MARK: - Variables
    var travel_id: Int?
    var comfortList:[Comfort]?
    var arrayTravelShow: TravelShowModel?
    var places = [Int]()
    var carId:Int?
    var placesStr = [String]()
    var price_place = 0
    var car_type_id: Int?
    var swap1to53 = [7,8,11,12,15,16,19,20,23,24,27,28,33,34,37,38,41,42,45,46]
    var swap2to53 = [9,10,13,14,17,18,21,22,25,26,29,30,35,36,39,40,43,44,47,48]
    var swap1to62 = [39,40,43,44,47,48,51,52,55,56,59,60]
    var swap2to62 = [41,42,45,46,49,50,53,54,57,58,61,62]
    
    // MARK: - Properties
    lazy var descriptionView = DescriptionReserveView()
    lazy var rulImage = UIImageView(image: #imageLiteral(resourceName: "Group-13"))
    lazy var scheme = UIImageView(image: UIImage(named: "scheme1"))
    lazy var scheme53 = UIImageView(image: UIImage(named: "scheme"))
    lazy var exitView = ExitView()
    lazy var exitView2 = ExitView()
    
    lazy var betweenView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 0.949, green: 0.949, blue: 0.949, alpha: 1)
        view.layer.cornerRadius = 7
        return view
    }()
    lazy var layout = UICollectionViewFlowLayout()
    lazy var topLabel: UILabel = {
        let label = UILabel()
        label.text = "Cпальный салон"
        label.textColor = maincolor.blue
        label.font = UIFont.init(name: Font.mullerRegular, size: 16)
        return label
    }()
    
    private lazy var higherSeatsLabel: UILabel = {
        let label = UILabel()
        label.textColor = maincolor.blue
        label.text = "Верхние места"
        label.font = UIFont.init(name: Font.mullerBold, size: 16)
        return label
    }()
    
    private lazy var higherSeatsSwitch: UISwitch = {
        let higherSwitch = UISwitch()
        higherSwitch.isOn = true
        higherSwitch.onTintColor = maincolor.blue
        higherSwitch.addTarget(self, action: #selector(higherSeatsSwitchIsOn), for: .valueChanged)
        return higherSwitch
    }()
    
    private lazy var lowerSeatsLabel: UILabel = {
        let label = UILabel()
        label.textColor = maincolor.blue
        label.text = "Нижние места"
        label.font = UIFont.init(name: Font.mullerBold, size: 16)
        return label
    }()
    
    private lazy var lowerSeatsSwitch: UISwitch = {
        let lower = UISwitch()
        lower.isOn = true
        lower.onTintColor = maincolor.blue
        lower.addTarget(self, action: #selector(lowerSeatsSwitchIsOn), for: .valueChanged)
        return lower
    }()
    
    lazy var collectionView: DynamicHeightCollectionView = {
        let collectionView = DynamicHeightCollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.isScrollEnabled = false
        collectionView.backgroundColor = .clear
        collectionView.register(SitCollectionViewCell.self, forCellWithReuseIdentifier: SitCollectionViewCell.cellIdentifier)
        return collectionView
    }()
    lazy var placeView = PlaceView()
    lazy var bedPlaceView = BedPlaceView()
    lazy var price: UILabel = {
        let label = UILabel()
        label.text = localized(text: "amount")
        label.textColor = UIColor(red: 0.51, green: 0.51, blue: 0.51, alpha: 1)
        label.font = UIFont.init(name: Font.mullerRegular, size: 14)
        return label
    }()
    lazy var priceTitle: UILabel = {
        let label = UILabel()
        label.text = "10 000T"
        label.textColor = maincolor.blue
        label.font = UIFont.init(name: Font.mullerBold, size: 20)
        return label
    }()
    lazy var reservePlaceBtn: DefaultButton = {
        let btn = DefaultButton()
        btn.titleLabel?.textAlignment = .center
        btn.titleLabel?.numberOfLines = 3
        btn.setTitle("0T\n\(localized(text: "reservPlace"))", for: .normal)
        btn.addTarget(self, action: #selector(tapReserve), for: .touchUpInside)
        return btn
    }()
    
    lazy var reviewsButton: DefaultReserveButton = {
        let btn = DefaultReserveButton()
        btn.tag = 2
        btn.setTitle("Отзывы", for: .normal)
        btn.addTarget(self, action: #selector(tapReview), for: .touchUpInside)
        return btn
    }()
    
    lazy var safetyButton: DefaultReserveButton = {
        let btn = DefaultReserveButton()
        btn.setTitle("Удобства", for: .normal)
        btn.tag = 1
        btn.addTarget(self, action: #selector(tapReview), for: .touchUpInside)
        return btn
    }()
    
    lazy var policyButton: DefaultReserveButton = {
        let btn = DefaultReserveButton()
        btn.tag = 3
        btn.setTitle("Политика", for: .normal)
        btn.addTarget(self, action: #selector(tapReview), for: .touchUpInside)
        return btn
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(checkRefresh), userInfo: nil, repeats: true)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        title = localized(text: "reservSeat")
        view.backgroundColor = .white
        navigationController?.navigationBar.topItem?.title = ""
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.barTintColor = maincolor.blue
        navigationController!.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont.init(name: Font.mullerBold, size: 18)!,
                                                                   NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarPosition.any, barMetrics: UIBarMetrics.default)
        navigationController?.navigationBar.isTranslucent = false
        places.removeAll()
        price_place = 0
        placesStr.removeAll()
        passengersInfos.removeAll()
        getTravelShow()
    }
    @objc func checkRefresh() -> Void {
        priceTitle.text = "\(price_place) ₸"
        reservePlaceBtn.setTitle("\(price_place) ₸ \n\(localized(text: "reservPlace"))", for: .normal)
    }
    
    // MARK: - SetupViews
    func setupViews() -> Void {
        view.backgroundColor = .white
        
        view.addSubview(reservePlaceBtn)
        reservePlaceBtn.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(44)
            make.right.equalToSuperview().offset(-44)
            make.height.equalTo(60)
            make.bottom.equalToSuperview().offset(-20)
           
            
        }
        if car_type_id == 1 {
                scrollView.addSubviews([scheme53,exitView,collectionView,exitView2,betweenView,
                                        priceTitle, price, placeView,safetyButton, policyButton, reviewsButton])
            
                scheme53.snp.makeConstraints { (make) in
                    make.centerX.equalTo(collectionView)
                    make.width.equalToSuperview()
                    make.centerY.equalTo(collectionView).offset(-45)
                    make.height.equalTo(collectionView).multipliedBy(1.2)
                
                }
                
                
                descriptionView.isHidden = true
                exitView.snp.makeConstraints { (make) in
                    make.top.equalToSuperview().offset(160)
                    make.width.equalTo(150)
                    make.right.equalToSuperview()
                }
                collectionView.snp.makeConstraints { (make) in
                    make.top.equalToSuperview().offset(120)
                    switch UIDevice.modelName {
                    case "iPhone 12", "iPhone 12 Pro", "iPhone 12 Pro Max", "iPhone 11", "iPhone 11 Pro Max", "iPhone XR", "iPhone XS Max", "iPhone 6 Plus", "iPhone 6s Plus", "iPhone 7 Plus", "iPhone 8 Plus", "iPhone 13", "iPhone 13 Pro Max", "iPhone 13 Pro":
                        make.left.equalToSuperview().offset(44)
                        make.right.equalToSuperview().offset(-44)
                    default: make.left.equalToSuperview().offset(16)
                             make.right.equalToSuperview().offset(-16)
                        
                    }
                }
                exitView2.snp.makeConstraints { (make) in
                    make.width.equalTo(170)
                    make.right.equalToSuperview()
                    make.centerY.equalTo(collectionView.snp.centerY).offset(70)
                }
                betweenView.snp.makeConstraints { (make) in
                    make.top.equalToSuperview().offset(120)
                    make.centerX.equalToSuperview()
                    make.width.equalTo(80)
                    make.bottom.equalTo(collectionView.snp.bottom).offset(-55)
                }
            
        }
        else if car_type_id == 3 {
            descriptionView.isHidden = true
            scrollView.addSubviews([scheme,rulImage, exitView,collectionView,exitView2,betweenView,
                                    priceTitle, price, placeView,safetyButton, policyButton, reviewsButton])
            
            scheme.snp.makeConstraints { (make) in
                make.centerX.equalTo(collectionView).offset(20)
                make.centerY.equalTo(collectionView).offset(-20)
                make.width.equalTo(260)
                make.height.equalTo(350)
            }
            rulImage.snp.makeConstraints { (make) in
                make.top.equalToSuperview().offset(84)
                make.left.equalToSuperview().offset(145)
                make.width.height.equalTo(42)
            }
            exitView.snp.makeConstraints { (make) in
                exitView.isHidden = true
                make.top.equalTo(rulImage.snp.bottom).offset(22.5)
                make.width.equalTo(150)
                make.right.equalToSuperview()
            }
            collectionView.snp.makeConstraints { (make) in
                make.top.equalToSuperview().offset(80)
                switch UIDevice.modelName {
                case "iPhone 12", "iPhone 12 Pro", "iPhone 12 Pro Max", "iPhone 11", "iPhone 11 Pro Max", "iPhone XR", "iPhone XS Max", "iPhone 6 Plus", "iPhone 6s Plus", "iPhone 7 Plus", "iPhone 8 Plus","iPhone 13", "iPhone 13 Pro Max", "iPhone 13 Pro":
                    make.left.equalToSuperview().offset(44)
                    make.right.equalToSuperview().offset(-44)
                default: make.left.equalToSuperview().offset(16)
                         make.right.equalToSuperview().offset(-16)
                    
                }
            }
            exitView2.snp.makeConstraints { (make) in
                exitView2.isHidden = true
                make.width.equalTo(150)
                make.right.equalToSuperview()
                make.centerY.equalTo(collectionView.snp.centerY).offset(70)
            }
            betweenView.snp.makeConstraints { (make) in
                betweenView.isHidden = true
                make.top.equalToSuperview().offset(64)
                make.centerX.equalTo(-50)
                make.width.equalTo(50)
                make.bottom.equalTo(collectionView.snp.bottom).offset(-170)
            }
        }
        
        else if car_type_id == 5 {
            descriptionView.isHidden = true
            scrollView.addSubviews([scheme,rulImage, exitView,collectionView,exitView2,betweenView,
                                    priceTitle, price, placeView,safetyButton, policyButton, reviewsButton])
            
            scheme.snp.makeConstraints { (make) in
                make.centerX.equalTo(collectionView).offset(20)
                make.centerY.equalTo(collectionView).offset(-40)
                make.width.equalTo(260)
                make.height.equalTo(310)
            }
            rulImage.snp.makeConstraints { (make) in
                make.top.equalToSuperview().offset(84)
                make.left.equalToSuperview().offset(145)
                make.width.height.equalTo(42)
            }
            exitView.snp.makeConstraints { (make) in
                exitView.isHidden = true
                make.top.equalTo(rulImage.snp.bottom).offset(22.5)
                make.width.equalTo(150)
                make.right.equalToSuperview()
            }
            collectionView.snp.makeConstraints { (make) in
                make.top.equalToSuperview().offset(80)
                switch UIDevice.modelName {
                case "iPhone 12", "iPhone 12 Pro", "iPhone 12 Pro Max", "iPhone 11", "iPhone 11 Pro Max", "iPhone XR", "iPhone XS Max", "iPhone 6 Plus", "iPhone 6s Plus", "iPhone 7 Plus", "iPhone 8 Plus", "iPhone 13", "iPhone 13 Pro Max", "iPhone 13 Pro":
                    make.left.equalToSuperview().offset(44)
                    make.right.equalToSuperview().offset(-44)
                default: make.left.equalToSuperview().offset(16)
                         make.right.equalToSuperview().offset(-16)
                }
            }
            exitView2.snp.makeConstraints { (make) in
                exitView2.isHidden = true
                make.width.equalTo(150)
                make.right.equalToSuperview()
                make.centerY.equalTo(collectionView.snp.centerY).offset(70)
            }
            betweenView.snp.makeConstraints { (make) in
                betweenView.isHidden = true
                make.top.equalToSuperview().offset(64)
                make.centerX.equalTo(-50)
                make.width.equalTo(50)
                make.bottom.equalTo(collectionView.snp.bottom).offset(-170)
            }
        }
        else if car_type_id == 6 {
            descriptionView.isHidden = true
            scrollView.addSubviews([scheme,rulImage, exitView,collectionView,exitView2,betweenView,
                                    priceTitle, price, placeView,safetyButton, policyButton, reviewsButton])
            
            scheme.snp.makeConstraints { (make) in
                make.centerX.equalTo(collectionView).offset(20)
                make.centerY.equalTo(collectionView).offset(-20)
                make.width.equalTo(260)
                make.height.equalTo(350)
            }
            rulImage.snp.makeConstraints { (make) in
                make.top.equalToSuperview().offset(84)
                make.left.equalToSuperview().offset(145)
                make.width.height.equalTo(42)
            }
            exitView.snp.makeConstraints { (make) in
                exitView.isHidden = true
                make.top.equalTo(rulImage.snp.bottom).offset(22.5)
                make.width.equalTo(150)
                make.right.equalToSuperview()
            }
            collectionView.snp.makeConstraints { (make) in
                make.top.equalToSuperview().offset(80)
                switch UIDevice.modelName {
                case "iPhone 12", "iPhone 12 Pro", "iPhone 12 Pro Max", "iPhone 11", "iPhone 11 Pro Max", "iPhone XR", "iPhone XS Max", "iPhone 6 Plus", "iPhone 6s Plus", "iPhone 7 Plus", "iPhone 8 Plus", "iPhone 13", "iPhone 13 Pro Max", "iPhone 13 Pro":
                    make.left.equalToSuperview().offset(44)
                    make.right.equalToSuperview().offset(-44)
                default: make.left.equalToSuperview().offset(16)
                         make.right.equalToSuperview().offset(-16)
                }
            }
            exitView2.snp.makeConstraints { (make) in
                exitView2.isHidden = true
                make.width.equalTo(150)
                make.right.equalToSuperview()
                make.centerY.equalTo(collectionView.snp.centerY).offset(70)
            }
            betweenView.snp.makeConstraints { (make) in
                betweenView.isHidden = true
                make.top.equalToSuperview().offset(64)
                make.centerX.equalTo(-50)
                make.width.equalTo(50)
                make.bottom.equalTo(collectionView.snp.bottom).offset(-170)
            }
        }
        else if car_type_id == 7 {
            scrollView.addSubviews([scheme53,exitView,collectionView,exitView2,betweenView,
                                    priceTitle, price, placeView,safetyButton, policyButton, reviewsButton])
            scheme53.snp.makeConstraints { (make) in
                make.centerX.equalTo(collectionView)
                make.width.equalToSuperview()
                make.centerY.equalTo(collectionView).offset(-55)
                make.height.equalTo(collectionView).multipliedBy(1.2)
            }
            descriptionView.isHidden = true
            exitView.snp.makeConstraints { (make) in
                make.top.equalToSuperview().offset(245)
                make.width.equalTo(150)
                make.right.equalToSuperview()
            }
            collectionView.snp.makeConstraints { (make) in
                make.top.equalToSuperview().offset(145)
                switch UIDevice.modelName {
                case "iPhone 12", "iPhone 12 Pro", "iPhone 12 Pro Max", "iPhone 11", "iPhone 11 Pro Max", "iPhone XR", "iPhone XS Max", "iPhone 6 Plus", "iPhone 6s Plus", "iPhone 7 Plus", "iPhone 8 Plus","iPhone 13", "iPhone 13 Pro Max", "iPhone 13 Pro":
                    make.left.equalToSuperview().offset(44)
                    make.right.equalToSuperview().offset(-44)
                default: make.left.equalToSuperview().offset(16)
                         make.right.equalToSuperview().offset(-16)
                }
            }
            exitView2.snp.makeConstraints { (make) in
                make.width.equalTo(170)
                make.right.equalToSuperview()
                make.centerY.equalTo(collectionView.snp.centerY).offset(70)
            }
            betweenView.snp.makeConstraints { (make) in
                make.top.equalToSuperview().offset(140)
                make.centerX.equalToSuperview()
                make.width.equalTo(80)
                make.bottom.equalTo(collectionView.snp.bottom).offset(-55)
            }
        }
        else {
            scrollView.addSubviews([topLabel,
                                    higherSeatsLabel, higherSeatsSwitch,
                                    lowerSeatsLabel, lowerSeatsSwitch,
                                    scheme53,exitView,collectionView,exitView2, betweenView,
                                    priceTitle, price, bedPlaceView, safetyButton, policyButton, reviewsButton])
        
            topLabel.snp.makeConstraints { make in
                make.top.equalToSuperview().offset(16)
                make.left.equalToSuperview().offset(16)
            }
            
            higherSeatsLabel.snp.makeConstraints {
                $0.top.equalTo(topLabel.snp.bottom).offset(16)
                $0.left.equalTo(16)
            }
            
            higherSeatsSwitch.snp.makeConstraints {
                $0.centerY.equalTo(higherSeatsLabel.snp.centerY)
                $0.right.equalTo(-24)
            }
            
            lowerSeatsLabel.snp.makeConstraints {
                $0.centerY.equalTo(lowerSeatsSwitch.snp.centerY)
                $0.left.equalTo(16)
            }
            
            lowerSeatsSwitch.snp.makeConstraints {
                $0.top.equalTo(higherSeatsSwitch.snp.bottom).offset(8)
                $0.right.equalTo(-24)
            }
            
            scheme53.snp.makeConstraints { (make) in
                make.centerX.equalTo(collectionView)
                make.width.equalToSuperview()
                make.centerY.equalTo(collectionView).offset(-50)
                make.height.equalTo(collectionView).multipliedBy(1.1)
            }
            descriptionView.isHidden = true
            exitView.snp.makeConstraints { (make) in
                make.top.equalToSuperview().offset(230)
                make.width.equalTo(150)
                make.right.equalToSuperview()
            }
            collectionView.snp.makeConstraints { (make) in
                make.top.equalToSuperview().offset(220)
                switch UIDevice.modelName {
                case "iPhone 12", "iPhone 12 Pro", "iPhone 12 Pro Max", "iPhone 11", "iPhone 11 Pro Max", "iPhone XR", "iPhone XS Max", "iPhone 6 Plus", "iPhone 6s Plus", "iPhone 7 Plus", "iPhone 8 Plus","iPhone 13", "iPhone 13 Pro Max", "iPhone 13 Pro":
                    make.left.equalToSuperview().offset(44)
                    make.right.equalToSuperview().offset(-44)
                default: make.left.equalToSuperview().offset(16)
                         make.right.equalToSuperview().offset(-16)
                    
                }
            }
            exitView2.snp.makeConstraints { (make) in
                exitView2.isHidden = true
                make.width.equalTo(170)
                make.right.equalToSuperview()
                make.centerY.equalTo(collectionView.snp.centerY).offset(70)
            }
            betweenView.snp.makeConstraints { (make) in
                make.top.equalToSuperview().offset(220)
                make.centerX.equalToSuperview()
                make.width.equalTo(80)
                make.bottom.equalTo(collectionView.snp.bottom).offset(-250)
            }
            betweenView.isHidden = true
        }
        
        if car_type_id == 2 {
            bedPlaceView.snp.makeConstraints { (make) in
                make.top.equalTo(safetyButton.snp.bottom).offset(16)
                make.width.equalToSuperview()
            }
            
            price.snp.makeConstraints { (make) in
                make.top.equalTo(bedPlaceView.snp.bottom).offset(40)
                make.left.equalToSuperview().offset(16)
            }
        } else {
            placeView.snp.makeConstraints { (make) in
                make.top.equalTo(safetyButton.snp.bottom).offset(16)
                make.width.equalToSuperview()
            }
            
            price.snp.makeConstraints { (make) in
                make.top.equalTo(placeView.snp.bottom).offset(40)
                make.left.equalToSuperview().offset(16)
            }
        }
        priceTitle.snp.makeConstraints { (make) in
            make.centerY.equalTo(price.snp.centerY)
            make.right.equalToSuperview().offset(-16)
            make.bottom.equalToSuperview().offset(-120)
        }
        
        safetyButton.snp.makeConstraints { (make) in
            make.top.equalTo(collectionView.snp.bottom).offset(40)
            make.left.equalToSuperview().offset(16)
            make.height.equalTo(32)
            make.width.equalTo(100)
        }
        reviewsButton.snp.makeConstraints { (make) in
            make.top.equalTo(collectionView.snp.bottom).offset(40)
            make.left.equalTo(safetyButton.snp.right).offset(8)
            make.height.equalTo(32)
            make.width.equalTo(100)
        }
        policyButton.snp.makeConstraints { (make) in
            make.top.equalTo(collectionView.snp.bottom).offset(40)
            make.left.equalTo(reviewsButton.snp.right).offset(8)
            make.height.equalTo(32)
            make.width.equalTo(100)
        }
    }
    
    // MARK: - Initialization
    required init?(coder: NSCoder) {fatalError("")}
    init(travel_id: Int, price: Int, car_type_id: Int, carId:Int, comfortList:[Comfort]) {
        super.init(nibName: nil, bundle: nil)
        self.travel_id = travel_id
//        self.price_place = price
        self.car_type_id = car_type_id
        self.comfortList = comfortList
        self.carId = carId
    }
    
    // MARK: - Simple functions
    func shouldBeRemoved(index: Int) -> Bool {
        if placesCount == 4 {
            if removedNumbersInCollectionView4.contains(index) {
                skipCount += 1
                return true
            } else {
                return false
            }
        } else if placesCount == 7 {
            if removedNumbersInCollectionView7.contains(index) {
                skipCount += 1
                return true
            } else {
                return false
            }

        } else if placesCount == 28 {
            if removedNumbersInCollectionView28.contains(index) {
                skipCount += 1
                return true
            } else {
                return false
            }
        } else if placesCount == 29 {
            if removedNumbersInCollectionView29.contains(index) {
                skipCount += 1
                return true
            } else {
                return false
            }
        } else if placesCount == 30 {
            if removedNumbersInCollectionView30.contains(index) {
                skipCount += 1
                return true
            } else {
                return false
            }
        } else if placesCount == 31 {
            if removedNumbersInCollectionView31.contains(index) {
                skipCount += 1
                return true
            } else {
                return false
            }
        } else if placesCount == 32 {
            if removedNumbersInCollectionView32.contains(index) {
                skipCount += 1
                return true
            } else {
                return false
            }
        } else if placesCount == 33 {
            if removedNumbersInCollectionView33.contains(index) {
                skipCount += 1
                return true
            } else {
                return false
            }
        } else if placesCount == 34 {
            if removedNumbersInCollectionView34.contains(index) {
                skipCount += 1
                return true
            } else {
                return false
            }
        } else if placesCount == 35 {
            if removedNumbersInCollectionView35.contains(index) {
                skipCount += 1
                return true
            } else {
                return false
            }
        } else if placesCount == 36 {
            if removedNumbersInCollectionView36.contains(index) {
                skipCount += 1
                return true
            } else {
                return false
            }
        } else if placesCount == 53 {
            if removedNumbersInCollectionView50.contains(index) {
                skipCount += 1
                return true
            } else {
                return false
            }
        }
        else if placesCount == 62 {
            if removedNumbersInCollectionView62.contains(index) {
                skipCount += 1
                return true
            } else {
                return false
            }
        }  else {
            if removedNumbersInCollectionView6.contains(index) {
                skipCount += 1
                return true
            } else {
                return false
            }
        }
    }
    private func setupDescriptionView() {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:00"
        let date = formatter.date(from: arrayTravelShow?.travel?.departure_time ?? "")
        formatter.dateFormat = "HH:mm / dd.MM.yyyy"
        descriptionView.dateTitle.text = formatter.string(from: date ?? Date())
        descriptionView.typeTitle.text = arrayTravelShow?.travel?.car.name
        descriptionView.placeTitle.text = ""
    }
    
    // MARK: - Actions
    @objc func tapReserve() -> Void {
        if placesStr.count > 0 && placesStr.count < 5 {
            var allPlaces = ""
            for item in placesStr {
                allPlaces += " \(item),"
            }
            allPlaces = String(allPlaces.dropLast())
            showSubmitMessage(messageType: .none, "Вы выбрали места:\(allPlaces)") {
                self.reserve()
            }
        } else {
            if places.count > 4 {
                showErrorMessage(messageType: .none, "Вы не можете выбрать не больше 4 мест")
            }
            else {
                showErrorMessage(messageType: .none, "Выберите места!")
            }
        }
    }
    
    @objc func tapReview(button:UIButton) -> Void {
        let vc = ReviewListViewController(carId: self.carId!, comfortList: self.comfortList!, type:button.tag, carNumber: arrayTravelShow?.travel?.car.state_number ?? "")
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc private func higherSeatsSwitchIsOn(_ higherSwitch: UISwitch) {
        if higherSwitch.isOn {
            lowerSeatsSwitch.isOn = false
            NotificationCenter.default.post(name: NSNotification.Name("higherOn"),
                                            object: nil,
                                            userInfo: nil)
        } else {
            lowerSeatsSwitch.isOn = true
            NotificationCenter.default.post(name: NSNotification.Name("higherOff"),
                                            object: nil,
                                            userInfo: nil)
        }
    }
    
    @objc private func lowerSeatsSwitchIsOn(_ lowerSwitch: UISwitch) {
        if lowerSwitch.isOn {
            higherSeatsSwitch.isOn = false
            NotificationCenter.default.post(name: NSNotification.Name("lowerOn"),
                                            object: nil,
                                            userInfo: nil)
        } else {
            higherSeatsSwitch.isOn = true
            NotificationCenter.default.post(name: NSNotification.Name("lowerOff"),
                                            object: nil,
                                            userInfo: nil)
        }
    }
    
    private func checkBookedPlaces(cell: SitCollectionViewCell) {
        if self.arrayTravelShow != nil {
            for i in self.arrayTravelShow!.places! {
                if i.number == cell.placeNumBack {
                    if i.status == "free" {
                        cell.sitImageView.image = #imageLiteral(resourceName: "bed-16")
                    } else if i.status == "take" {
                        cell.sitImageView.image = #imageLiteral(resourceName: "bed-12")
                    } else if i.status == "in_process" {
                        cell.sitImageView.image = #imageLiteral(resourceName: "bed-15")
                    }
                }
            }
        }
    }
}

// MARK: - CollectionView delegate
extension ReserveViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if placesCount == 4 {
            return placesCount + removedNumbersInCollectionView4.count
        } else if placesCount == 6 {
            return placesCount + removedNumbersInCollectionView6.count
        } else if placesCount == 7 {
            return placesCount + removedNumbersInCollectionView7.count
        } else if placesCount == 28 {
            return placesCount + removedNumbersInCollectionView28.count
        } else if placesCount == 29 {
            return placesCount + removedNumbersInCollectionView29.count
        } else if placesCount == 30 {
            return placesCount + removedNumbersInCollectionView30.count
        } else if placesCount == 31 {
            return placesCount + removedNumbersInCollectionView31.count
        } else if placesCount == 32 {
            return placesCount + removedNumbersInCollectionView32.count
        } else if placesCount == 33 {
            return placesCount + removedNumbersInCollectionView33.count
        } else if placesCount == 34 {
            return placesCount + removedNumbersInCollectionView34.count
        } else if placesCount == 35 {
            return placesCount + removedNumbersInCollectionView35.count
        } else if placesCount == 36 {
            return placesCount + removedNumbersInCollectionView36.count
        } else if placesCount == 53 {
            return placesCount + removedNumbersInCollectionView50.count
        } else if placesCount == 62 {
            return placesCount + removedNumbersInCollectionView62.count
        }
        else {
            return 0
        }
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SitCollectionViewCell.cellIdentifier, for: indexPath) as! SitCollectionViewCell
        // place
        if car_type_id == 2 {
            cell.sitImageView.image = #imageLiteral(resourceName: "bed-16")
        } else {
            cell.sitImageView.image = #imageLiteral(resourceName: "Group-16")
        }
        cell.placeNumber.text = "\(indexPath.row)"
        if shouldBeRemoved(index: indexPath.item) {
            cell.isHidden = true
        }
        let placeNum: Int = indexPath.item + 1 - skipCount
        cell.placeNumBack = placeNum
        cell.placeNumber.text = "\(placeNum)"
        
        if car_type_id == 2 {
            NotificationCenter.default.addObserver(forName: NSNotification.Name("higherOn"), object: nil, queue: nil) { res in
                if self.showLowerSeatsIn36.contains(indexPath.row) {
                    cell.sitImageView.image = #imageLiteral(resourceName: "bed-12")
                } else {
                    cell.sitImageView.image = #imageLiteral(resourceName: "bed-16")
                    self.checkBookedPlaces(cell: cell)
                }
            }

            NotificationCenter.default.addObserver(forName: NSNotification.Name("lowerOn"), object: nil, queue: nil) { res in
                if self.showHigherSeatsIn36.contains(indexPath.row) {
                    cell.sitImageView.image = #imageLiteral(resourceName: "bed-12")
                } else {
                    cell.sitImageView.image = #imageLiteral(resourceName: "bed-16")
                    self.checkBookedPlaces(cell: cell)
                }
            }

            NotificationCenter.default.addObserver(forName: NSNotification.Name("higherOff"), object: nil, queue: nil) { res in
                if self.showHigherSeatsIn36.contains(indexPath.row) {
                    cell.sitImageView.image = #imageLiteral(resourceName: "bed-12")
                } else {
                    cell.sitImageView.image = #imageLiteral(resourceName: "bed-16")
                    self.checkBookedPlaces(cell: cell)
                }
            }

            NotificationCenter.default.addObserver(forName: NSNotification.Name("lowerOff"), object: nil, queue: nil) { res in

                if self.showLowerSeatsIn36.contains(indexPath.row) {
                    cell.sitImageView.image = #imageLiteral(resourceName: "bed-12")
                } else {
                    cell.sitImageView.image = #imageLiteral(resourceName: "bed-16")
                    self.checkBookedPlaces(cell: cell)
                }
            }
        }
        
        if car_type_id == 1 {
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
        // free, take, in_process
        if car_type_id == 2 {
            if arrayTravelShow != nil {
                for i in arrayTravelShow!.places! {
                    if i.number == cell.placeNumBack {
                        if i.status == "free" {
                            cell.sitImageView.image = #imageLiteral(resourceName: "bed-16")
                        } else if i.status == "take" {
                            cell.sitImageView.image = #imageLiteral(resourceName: "bed-12")
                        } else if i.status == "in_process" {
                            cell.sitImageView.image = #imageLiteral(resourceName: "bed-15")
                        }
                    }
                }
            }
            if places.count != 0 {
                for place in places {
                    if place == cell.placeNumBack {
                        cell.sitImageView.image = #imageLiteral(resourceName: "bed-17")
                    }
                }
            }
        } else {
            if arrayTravelShow != nil {
                for i in arrayTravelShow!.places! {
                    if i.number == cell.placeNumBack {
                        if i.status == "free" {
                            cell.sitImageView.image = #imageLiteral(resourceName: "Group-16")
                        } else if i.status == "take" {
                            cell.sitImageView.image = #imageLiteral(resourceName: "Group-12")
                        } else if i.status == "in_process" {
                            cell.sitImageView.image = #imageLiteral(resourceName: "Group-15")
                        }
                    }
                }
            }
            if places.count != 0 {
                for place in places {
                    if place == cell.placeNumBack {
                        cell.sitImageView.image = #imageLiteral(resourceName: "Group-17")
                    }
                }
            }
        }
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! SitCollectionViewCell
        
        /// for buses with 36 seats
        if car_type_id == 2 {
            if cell.sitImageView.image != #imageLiteral(resourceName: "bed-15") && cell.sitImageView.image != #imageLiteral(resourceName: "bed-12") {
                cell.sitImageView.image == #imageLiteral(resourceName: "bed-16") ? (cell.sitImageView.image = #imageLiteral(resourceName: "bed-17")) : (cell.sitImageView.image = #imageLiteral(resourceName: "bed-16"))
                
                if places.contains(cell.placeNumBack) {
                    for i in 0...(arrayTravelShow?.places!.count)!-1 {
                        if cell.placeNumBack == arrayTravelShow?.places![i].number {
                            price_place -= (arrayTravelShow?.places![i].price)!
                            break
                        }
                    }
                    let newArray = places.filter { $0 != cell.placeNumBack }
                    places.removeAll()
                    places = newArray
                    let newArrayStr = placesStr.filter { $0 != cell.placeNumber.text }
                    placesStr.removeAll()
                    placesStr = newArrayStr
                } else if !places.contains(cell.placeNumBack) && places.count<4{
                    for i in 0...(arrayTravelShow?.places!.count)!-1 {
                        if cell.placeNumBack == arrayTravelShow?.places![i].number {
                            
                            price_place += (arrayTravelShow?.places![i].price)!
                            break
                        }
                    }
                    places.append(cell.placeNumBack)
                    placesStr.append(cell.placeNumber.text ?? "")
                }
                else {
                    if cell.sitImageView.image != #imageLiteral(resourceName: "bed-15") && cell.sitImageView.image != #imageLiteral(resourceName: "bed-12") {
                        cell.sitImageView.image == #imageLiteral(resourceName: "bed-16") ? (cell.sitImageView.image = #imageLiteral(resourceName: "bed-17")) : (cell.sitImageView.image = #imageLiteral(resourceName: "bed-16"))

                    }
                    showErrorMessage(messageType: .none, "Вы не можете выбрать не больше 4 мест")
                }
            }
        } else {
            if cell.sitImageView.image != #imageLiteral(resourceName: "Group-15") && cell.sitImageView.image != #imageLiteral(resourceName: "Group-12") {
                cell.sitImageView.image == #imageLiteral(resourceName: "Group-16") ? (cell.sitImageView.image = #imageLiteral(resourceName: "Group-17")) : (cell.sitImageView.image = #imageLiteral(resourceName: "Group-16"))
                
                if places.contains(cell.placeNumBack) {
                    for i in 0...(arrayTravelShow?.places!.count)!-1 {
                        if cell.placeNumBack == arrayTravelShow?.places![i].number {
                            price_place -= (arrayTravelShow?.places![i].price)!
                            break
                        }
                    }
                    let newArray = places.filter { $0 != cell.placeNumBack }
                    places.removeAll()
                    places = newArray
                    let newArrayStr = placesStr.filter { $0 != cell.placeNumber.text }
                    placesStr.removeAll()
                    placesStr = newArrayStr
                } else if !places.contains(cell.placeNumBack) && places.count<4{
                    for i in 0...(arrayTravelShow?.places!.count)!-1 {
                        if cell.placeNumBack == arrayTravelShow?.places![i].number {
                            
                            price_place += (arrayTravelShow?.places![i].price)!
                            break
                        }
                    }
                    places.append(cell.placeNumBack)
                    placesStr.append(cell.placeNumber.text ?? "")
                }
                else {
                    if cell.sitImageView.image != #imageLiteral(resourceName: "Group-15") && cell.sitImageView.image != #imageLiteral(resourceName: "Group-12") {
                        cell.sitImageView.image == #imageLiteral(resourceName: "Group-16") ? (cell.sitImageView.image = #imageLiteral(resourceName: "Group-17")) : (cell.sitImageView.image = #imageLiteral(resourceName: "Group-16"))

                    }
                    showErrorMessage(messageType: .none, "Вы не можете выбрать не больше 4 мест")
                }
            }
        }
        if car_type_id == 2 {
            if cell.sitImageView.image != #imageLiteral(resourceName: "bed-12") &&
                cell.sitImageView.image != #imageLiteral(resourceName: "bed-15") {
                
                let vc = EnterPassengerInformationViewController(travelId: travel_id ?? 0,
                                                                 placeString: placesStr,
                                                                 completion: {
                    if self.car_type_id == 2 {
                        cell.sitImageView.image = #imageLiteral(resourceName: "bed-16")
                    } else {
                        cell.sitImageView.image = #imageLiteral(resourceName: "Group-16")
                    }
                    if !self.places.isEmpty && !self.placesStr.isEmpty {
                        self.places.removeLast()
                        self.placesStr.removeLast()
                    }
                    for i in 0...(self.arrayTravelShow?.places!.count)!-1 {
                        if cell.placeNumBack == self.arrayTravelShow?.places![i].number {
                            self.price_place -= (self.arrayTravelShow?.places![i].price)!
                            break
                        }
                    }
                })
                vc.modalPresentationStyle = .overCurrentContext
                vc.modalTransitionStyle = .crossDissolve
                vc.delegate = self
                present(vc, animated: true, completion: nil)
            }
        } else {
            if cell.sitImageView.image != #imageLiteral(resourceName: "Group-12") &&
                cell.sitImageView.image != #imageLiteral(resourceName: "Group-15") {
                
                let vc = EnterPassengerInformationViewController(travelId: travel_id ?? 0,
                                                                 placeString: placesStr,
                                                                 completion: {
                    if self.car_type_id == 2 {
                        cell.sitImageView.image = #imageLiteral(resourceName: "bed-16")
                    } else {
                        cell.sitImageView.image = #imageLiteral(resourceName: "Group-16")
                    }
                    if !self.places.isEmpty && !self.placesStr.isEmpty {
                        self.places.removeLast()
                        self.placesStr.removeLast()
                    }
                    for i in 0...(self.arrayTravelShow?.places!.count)!-1 {
                        if cell.placeNumBack == self.arrayTravelShow?.places![i].number {
                            self.price_place -= (self.arrayTravelShow?.places![i].price)!
                            break
                        }
                    }
                })
                vc.modalPresentationStyle = .overCurrentContext
                vc.modalTransitionStyle = .crossDissolve
                vc.delegate = self
                present(vc, animated: true, completion: nil)
            }
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath)
    -> CGSize {
        if car_type_id == 2 {
            return CGSize(width: 42, height: 64)
        } else {
            return CGSize(width: 42, height: 42)
        }
        
    }
}

// MARK: - Parser
extension ReserveViewController {
    private func getTravelShow() -> Void {
        showHUD()
        let parameter = ["travel_id": travel_id!]
        ParseManager.shared.getRequest(url: api.travelShowPassenger, parameters: parameter as Parameters) { (result: TravelShowModel?, error) in
            self.dismissHUD()
            if let error = error {
                self.showErrorMessage(messageType: .none, error)
                return
            }
            self.phone = "+7" + (result?.travel?.car.phone ?? "")
            self.kaspiNumber = "+7" + (result?.travel?.car.bank_card ?? "")

            self.arrayTravelShow = result!
            self.skipCount = 0
            self.placesCount = self.arrayTravelShow?.places?.count ?? 0
            self.setupDescriptionView()
            self.collectionView.reloadData()
        }
    }
    private func reserve() {
        let vc = TripDetailViewController()
        vc.configure(model: (self.arrayTravelShow?.travel)!,
                     travel_id: self.travel_id!,
                     places: self.places,
                     placesStr: self.placesStr,
                     sum: self.priceTitle.text!,
                     passengerInfos: self.passengersInfos)
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension ReserveViewController: PassengerInformationDelegate {
    func didEnterInformation(info: PassengerInfoModel) {
        self.passengersInfos.append(info)
    }
}
