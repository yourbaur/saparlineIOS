//
//  SearchResultViewController.swift
//  BusTime
//
//  Created by Tuigynbekov Yelzhan on 8/16/20.
//  Copyright © 2020 thousand.com. All rights reserved.
//

import UIKit
import RDGliderViewController

class SearchResultViewController: UIViewController {

    var arrayTravelList: TravelListModel?
    var isBus = 0
    var from_city_id: Int?
    var to_city_id: Int?
    var date: String?
    lazy var sortButton: SortButtonView = {
        let button = SortButtonView()
        button.sortButton.addTarget(self, action: #selector(tapSort), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Variables
    let gliderViewController: GliderViewController = GliderViewController.init()
    var glider: RDGliderViewController?
    lazy var shadowView: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        button.isHidden = true
        button.addTarget(self, action: #selector(gliderClose), for: .touchUpInside)
        return button
    }()
    private var switcher = SwitcherView(firstTitle: "Автобус (0)",
                                        secondTitle: "Минивэн (0)",
                                        thirdTitle: "Такси (0)")
    
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
    lazy var tableView: UITableView = {
        let table = UITableView()
        table.register(SearchResultTableViewCell.self, forCellReuseIdentifier: SearchResultTableViewCell.cellIdentifier())
        table.delegate = self
        table.dataSource = self
        
        table.separatorStyle = .none
        return table
    }()
    lazy var emptyLabel: UILabel = {
        let label = UILabel()
        label.text = localized(text: "emptyList")
        label.textColor = .gray
        label.backgroundColor = .clear
        label.font = UIFont.init(name: Font.mullerRegular, size: 16)
        return label
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupSwitcher()
        setupViews()
        initGliderView()
    }
    
    func setupSwitcher() {
        getCount()
        getTaxiCount()
        switcher.firstAction = {
            if self.isBus == 0 || self.isBus == 2{
                self.isBus = 1
                self.travelList()
            }
            
        }
        
        switcher.secondAction = {
            if self.isBus == 1 || self.isBus == 2{
                self.isBus = 0
                self.travelList()
            }
        }
        
        switcher.thirdAction = {
            if self.isBus == 0 || self.isBus == 1{
                self.isBus = 2
                self.travelList()
            }

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
        
        travelList()
    }
    
    // MARK: - SetupViews
    func setupViews() -> Void {
        view.addSubviews([worldImage, switcher, tableView, emptyLabel])
        worldImage.snp.makeConstraints { (make) in
            make.top.width.equalToSuperview()
            make.height.equalTo(200)
        }
        switcher.snp.makeConstraints { (make) in
            make.top.equalTo(worldImage.snp.bottom).offset(5)
            make.width.equalToSuperview()
        }
        tableView.snp.makeConstraints { (make) in
            make.top.equalTo(switcher.snp.bottom).offset(5)
            make.width.bottom.equalToSuperview()
        }
        emptyLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(tableView)
            make.centerX.equalTo(tableView)
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
        view.addSubview(sortButton)
        sortButton.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.height.equalTo(80)
            make.bottom.equalToSuperview().offset(-30)
        }

        //shadow
        view.addSubview(shadowView)
        shadowView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
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
    
    // MARK: - Actions
    private func initGliderView() {
        self.glider = RDGliderViewController.init(on: self, withContent: gliderViewController, type: .bottomToTop, andOffsets: [0.0, 0.8])
        self.glider?.delegate = self
    }
    
    func showGlider(id: Int) -> Void {
//        gliderViewController.configure(travel_id: id)
//        glider?.expand()
    }
    
    @objc func gliderClose() -> Void {
        shadowView.isHidden = true
        glider?.close()
    }
    
    @objc func tapFilter() -> Void {
        navigationController?.pushViewController(FilterCalendarViewController(), animated: true)
    }
    
    @objc
    func tapSort() {
        let vc = SortViewController(tapType:"passenger")
        vc.modalPresentationStyle = .overCurrentContext
        vc.modalTransitionStyle = .crossDissolve
        vc.delegate = self
        present(vc, animated: true, completion: nil)
    }
    
    @objc
    func tapReview(){
        let vc = ReviewViewController(carId: 0)
        navigationController?.pushViewController(vc, animated: true)
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
                                       car_type_id: (arrayTravelList?.data![index].car.car_type_id)!, carId:(arrayTravelList?.data![index].car.id )!,
                                       comfortList: comfortList)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func tapSlider(button: MyButton) -> Void {
        let listOfNews = [SliderPhoto(image:button.photo1), SliderPhoto(image: button.photo2), SliderPhoto(image:button.photo3), SliderPhoto(image: button.avatar)]
        let vc = SliderViewController(tapType:"passenger", listOfNews: listOfNews)
        vc.modalPresentationStyle = .overCurrentContext
        vc.modalTransitionStyle = .crossDissolve
        present(vc, animated: true, completion: nil)
    }
    
    private func isEmptyData() {
        if arrayTravelList?.data?.count == 0 {
            emptyLabel.isHidden = false
        } else {
            emptyLabel.isHidden = true
        }
    }
}

//  MARK: - Glider delegate
extension SearchResultViewController: RDGliderViewControllerDelegate {
    func glideViewController(_ glideViewController: RDGliderViewController, hasChangedOffsetOfContent offset: CGPoint) {
        offset != CGPoint(x: 0, y: 0) ? (shadowView.isHidden = false) : (shadowView.isHidden = true)
    }
}

// MARK: - TableView delegate
extension SearchResultViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayTravelList?.data?.count ?? 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SearchResultTableViewCell.cellIdentifier(), for: indexPath) as! SearchResultTableViewCell
        cell.sliderBtn.tag = indexPath.row
        let model = (arrayTravelList?.data![indexPath.row])!
        cell.sliderBtn.photo1 = model.car.image!
        cell.sliderBtn.photo2 = model.car.image1 ?? ""
        cell.sliderBtn.photo3 = model.car.image2 ?? ""
        cell.sliderBtn.avatar = model.car.avatar ?? ""
        //cell.reservButton.addTarget(self, action: #selector(tapReserv(button:)), for: .touchUpInside)
        
        cell.configure(model: (arrayTravelList?.data![indexPath.row])!)
        cell.sliderBtn.addTarget(self, action: #selector(tapSlider(button:)), for: .touchUpInside)
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tapReserv(index: indexPath.row)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
}

// MARK: - Parser
extension SearchResultViewController {
    private func travelList() -> Void {
        showHUD()
        let parameter = ["page": 1,
                         "limit": 10,
                         "from_city_id": from_city_id!,
                         "to_city_id": to_city_id!,
                         "date": date!,
                         "isBus":self.isBus
        ] as Parameters
        ParseManager.shared.getRequest(url: api.travelListPassenger, parameters: parameter) { (result: TravelListModel?, error) in
            self.dismissHUD()
            if self.isBus == 0 {
                self.switcher.secondButton.setTitle("Минивэн (\((result?.count ?? 0)))", for: .normal)
            }
            else if self.isBus == 1{
                self.switcher.firstButton.setTitle("Автобус (\((result?.count ?? 0)))", for: .normal)
            }
            else{
                self.switcher.thirdButton.setTitle("Такси (\((result?.count)!))", for: .normal)

            }
            
            if let error = error {
                self.showErrorMessage(messageType: .error, error)
                return
            }
            self.arrayTravelList = result!
            self.isEmptyData()
            self.tableView.reloadData()
        }
    }
    
    private func travelSortList() -> Void {
        showHUD()
        let parameter = ["page": 1,
                         "limit": 10,
                         "from_city_id": from_city_id!,
                         "to_city_id": to_city_id!,
                         "date": date!,
                         "isBus":self.isBus,
                         "filter":"rating"
        ] as Parameters
        ParseManager.shared.getRequest(url: api.travelListPassenger, parameters: parameter) { (result: TravelListModel?, error) in
            self.dismissHUD()
            if self.isBus == 0 {
                self.switcher.secondButton.setTitle("Минивэн (\((result?.count ?? 0)))", for: .normal)
            }
            else if self.isBus == 1{
                self.switcher.firstButton.setTitle("Автобус (\((result?.count ?? 0)))", for: .normal)
            }
            else{
                self.switcher.thirdButton.setTitle("Такси (\((result?.count)!))", for: .normal)
            }
            
            if let error = error {
                self.showErrorMessage(messageType: .error, error)
                return
            }
            self.arrayTravelList = result!
            self.isEmptyData()
            self.tableView.reloadData()
        }
    }

    
    private func getCount() -> Void {
        showHUD()
        let parameter = ["page": 1,
                         "limit": 10,
                         "from_city_id": from_city_id!,
                         "to_city_id": to_city_id!,
                         "date": date!,
                         "isBus":0
        ] as Parameters
        ParseManager.shared.getRequest(url: api.travelListPassenger, parameters: parameter) { (result: TravelListModel?, error) in
            self.dismissHUD()
            self.switcher.secondButton.setTitle("Минивэн (\((result?.count)!))", for: .normal)
           
            if let error = error {
                self.showErrorMessage(messageType: .error, error)
                return
            }
           
        }
    }
    
    private func getTaxiCount() -> Void {
        showHUD()
        let parameter = ["page": 1,
                         "limit": 10,
                         "from_city_id": from_city_id!,
                         "to_city_id": to_city_id!,
                         "date": date!,
                         "isBus":2
        ] as Parameters
        ParseManager.shared.getRequest(url: api.travelListPassenger, parameters: parameter) { (result: TravelListModel?, error) in
            self.dismissHUD()
           
                self.switcher.thirdButton.setTitle("Такси (\((result?.count)!))", for: .normal)
           
              
            if let error = error {
                self.showErrorMessage(messageType: .error, error)
                return
            }
           
        }
    }

    
}
class MyButton:UIButton {
    var photo1 = String()
    var photo2 = String()
    var photo3 = String()
    var avatar = String()
}

extension SearchResultViewController: SortDelegate {
    func send(sortType: String) {
        sortButton.sortButton.setTitle(sortType, for: .normal)
        sortButton.sortButton.backgroundColor = .white
        sortButton.sortButton.setTitleColor(maincolor.blue, for: .normal)
        sortButton.sortButton.setImage(UIImage(named:"sortRed")?.withRenderingMode(.alwaysTemplate), for: .normal)
        sortButton.sortButton.imageView?.tintColor = maincolor.blue
        
        travelSortList()
    }
    
    
}
