//
//  TourSearchResultViewController.swift
//  SaparLine
//
//  Created by Cheburek on 12.02.2022.
//  Copyright © 2022 thousand.com. All rights reserved.
//

import UIKit
import RDGliderViewController

final class TourSearchResultViewController: UIViewController {

    var arrayTravelList: TravelListModel?
    var isBus = 0
    var from_city_id: Int?
    var to_city_id: Int?
    var date: String?
    private var tourInfo: [TourInfoModel]?
    
    // MARK: - Variables
    private var switcher = TourSwitcherView(firstTitle: "Инфо о туре",
                                        secondTitle: "Транспорт",
                                        thirdTitle: "Карта")
    
    // MARK: - Properties
    lazy var worldImage = UIImageView(image: #imageLiteral(resourceName: "Group 10505"))
    lazy var personCountTitle: UILabel = {
        let label = UILabel()
        label.text = "  1 человек  "
        label.textColor = .white
        label.backgroundColor = maincolor.blue
        label.font = UIFont.init(name: Font.mullerRegular, size: 14)
        label.layer.cornerRadius = 5
        return label
    }()
    lazy var fromto = WayCityView()
    
    lazy var busesTableView: UITableView = {
        let table = UITableView()
        table.register(SearchResultTableViewCell.self, forCellReuseIdentifier: SearchResultTableViewCell.cellIdentifier())
        table.delegate = self
        table.dataSource = self
        table.separatorStyle = .none
        return table
    }()
    //TourMapCell
    
    private lazy var imagesInfoTableView: UITableView = {
        let table = UITableView()
        table.register(TourCell.self, forCellReuseIdentifier: TourCell.identifier)
        table.register(UITableViewCell.self, forCellReuseIdentifier: "description")
        table.delegate = self
        table.dataSource = self
        table.separatorStyle = .none
        return table
    }()
    
    private lazy var mapTableView: UITableView = {
        let table = UITableView()
        table.register(TourMapCell.self, forCellReuseIdentifier: TourMapCell.identifier)
        table.delegate = self
        table.dataSource = self
        table.separatorStyle = .none
        return table
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSwitcher()
        setupViews()
        getTours()
    }
    
    func setupSwitcher() {
        switcher.firstAction = {
            self.imagesInfoTableView.isHidden = false
            self.busesTableView.isHidden = true
            self.mapTableView.isHidden = true
        }
        
        switcher.secondAction = {
            self.imagesInfoTableView.isHidden = true
            self.busesTableView.isHidden = false
            self.mapTableView.isHidden = true
            self.travelList()
        }
        
        switcher.thirdAction = {
            self.imagesInfoTableView.isHidden = true
            self.busesTableView.isHidden = true
            self.mapTableView.isHidden = false
        }
        
        switcher.firstButtonSelected()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        title = localized(text: "result")
        
        navigationController?.navigationBar.tintColor = .white
        navigationController!.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont.init(name: Font.mullerBold, size: 18)!,
                                                                   NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationController?.navigationBar.topItem?.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarPosition.any, barMetrics: UIBarMetrics.default)
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.barTintColor = UIColor(red: 0.094, green: 0.157, blue: 0.282, alpha: 1)
        view.backgroundColor = .white
        
//        travelList()
    }
    
    // MARK: - SetupViews
    func setupViews() -> Void {
        view.addSubviews([worldImage, switcher, busesTableView, imagesInfoTableView, mapTableView])
        worldImage.snp.makeConstraints { (make) in
            make.top.width.equalToSuperview()
            make.height.equalTo(200)
        }
        switcher.snp.makeConstraints { (make) in
            make.top.equalTo(worldImage.snp.bottom).offset(5)
            make.width.equalToSuperview()
        }
        busesTableView.snp.makeConstraints { (make) in
            make.top.equalTo(switcher.snp.bottom).offset(5)
            make.width.bottom.equalToSuperview()
        }
        
        imagesInfoTableView.snp.makeConstraints { (make) in
            make.top.equalTo(switcher.snp.bottom).offset(5)
            make.width.bottom.equalToSuperview()
        }
        
        mapTableView.snp.makeConstraints { (make) in
            make.top.equalTo(switcher.snp.bottom).offset(5)
            make.width.bottom.equalToSuperview()
        }
        
        worldImage.addSubviews([fromto,personCountTitle])
        fromto.snp.makeConstraints { (make) in
            make.bottom.equalTo(worldImage.snp.bottom).offset(-16)
            make.width.equalToSuperview()
        }
        personCountTitle.snp.makeConstraints { (make) in
            make.bottom.equalTo(fromto.snp.top).offset(-16)
            make.left.equalToSuperview().offset(16)
            make.height.equalTo(24)
        }
    }
    
    // MARK: - Init
    required init?(coder: NSCoder) {fatalError("")}
    init(from_city_id: Int, to_city_id: Int, date: String) {
        super.init(nibName: nil, bundle: nil)
        
        self.from_city_id = from_city_id
        self.to_city_id = to_city_id
        self.date = date
    }
    
    @objc func tapReserv(index:Int) -> Void {
        var comfortList: [Comfort] = []
        let item = (arrayTravelList?.data![index].car)!
        if item.tv == 1 {
            comfortList.append(Comfort(title: "Телевизор", image: "television"))
        }
        if item.baggage == 1 {
            comfortList.append(Comfort(title: "Багаж", image: "luggage"))
        }
        if item.conditioner == 1 {
            comfortList.append(Comfort(title: "Кондиционер", image: "air-conditioner"))
        }
        
        let vc = ReserveViewController(travel_id: (arrayTravelList?.data![index].id)!,
                                       price: (arrayTravelList?.data![index].max_price)!,
                                       car_type_id: (arrayTravelList?.data![index].car.car_type_id)!,
                                       carId:(arrayTravelList?.data![index].car.id )!,
                                       comfortList: comfortList,
                                       tourAgent: true)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func tapSlider(button: MyButton) -> Void {
        let listOfNews = [SliderPhoto(image:button.photo1), SliderPhoto(image: button.photo2), SliderPhoto(image:button.photo3), SliderPhoto(image: button.avatar)]
        let vc = SliderViewController(tapType:"passenger", listOfNews: listOfNews)
        vc.modalPresentationStyle = .overCurrentContext
        vc.modalTransitionStyle = .crossDissolve
        present(vc, animated: true, completion: nil)
    }
}

// MARK: - TableView delegate/datasource
extension TourSearchResultViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch tableView {
        case imagesInfoTableView:
            return 2
        case busesTableView:
            return arrayTravelList?.count ?? 0
        case mapTableView:
            return 1
        default:
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch tableView {
        case imagesInfoTableView:
            switch indexPath.row {
            case 0:
                let cell = tableView.dequeueReusableCell(withIdentifier: TourCell.identifier, for: indexPath) as! TourCell
                cell.model = tourInfo
                return cell
            case 1:
                let cell = tableView.dequeueReusableCell(withIdentifier: "description", for: indexPath)
                cell.textLabel?.text = tourInfo?.first?.description
                cell.textLabel?.font = UIFont.systemFont(ofSize: 12, weight: .regular)
                cell.textLabel?.numberOfLines = 0
                cell.selectionStyle = .none
                return cell
            default:
                return UITableViewCell()
            }
        case busesTableView:
            let cell = tableView.dequeueReusableCell(withIdentifier: SearchResultTableViewCell.cellIdentifier(),
                                                     for: indexPath) as! SearchResultTableViewCell
            cell.sliderBtn.tag = indexPath.row
            let model = (arrayTravelList?.data![indexPath.row])!
            cell.sliderBtn.photo1 = model.car.image!
            cell.sliderBtn.photo2 = model.car.image1 ?? ""
            cell.sliderBtn.photo3 = model.car.image2 ?? ""
            cell.sliderBtn.avatar = model.car.avatar ?? ""
//            cell.reservButton.addTarget(self, action: #selector(tapReserv(button:)), for: .touchUpInside)
    
            cell.configure(model: (arrayTravelList?.data![indexPath.row])!)
            cell.sliderBtn.addTarget(self, action: #selector(tapSlider(button:)), for: .touchUpInside)
    
            return cell
            
        case mapTableView:
            let cell = tableView.dequeueReusableCell(withIdentifier: TourMapCell.identifier, for: indexPath) as! TourMapCell
            return cell
        default:
            return UITableViewCell()
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch tableView {
        case imagesInfoTableView, mapTableView:
            tableView.deselectRow(at: indexPath, animated: true)
        case busesTableView:
            busesTableView.deselectRow(at: indexPath, animated: true)
            tapReserv(index: indexPath.row)
        default:
            return
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch tableView {
        case imagesInfoTableView:
            if indexPath.row == 0 {
                return UIScreen.main.bounds.size.height / 4.5
            } else {
                return 250
            }
        case busesTableView:
            return 200
        case mapTableView:
            return 300
        default:
            return 100
        }
    }
}

// MARK: - Parser
extension TourSearchResultViewController {
    private func travelList() -> Void {
        showHUD()
        let parameter = ["page": 1,
                         "limit": 10,
                         "from_city_id": from_city_id!,
                         "to_city_id": to_city_id!,
                         "date": date!,
                         "isBus": 1
        ] as Parameters
        ParseManager.shared.getRequest(url: api.travelListPassenger,
                                       parameters: parameter) { (result: TravelListModel?, error) in
            self.dismissHUD()
            
            self.switcher.secondButton.setTitle("Транспорт (\((result?.count ?? 0)))", for: .normal)
            
            if let error = error {
                self.showErrorMessage(messageType: .error, error)
                return
            }
            self.arrayTravelList = result
            self.busesTableView.reloadData()
        }
    }
    
    private func getTours() {
        ParseManager.shared.getRequest(url: api.getTours) { (result: [TourInfoModel]?, error) in
            self.dismissHUD()
           
            self.tourInfo = result
              
            DispatchQueue.main.async {
                self.imagesInfoTableView.reloadData()
            }
            if let error = error {
                self.showErrorMessage(messageType: .error, error.description)
                return
            }
        }
    }
}
