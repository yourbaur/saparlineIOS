//
//  ComingTripsViewController.swift
//  BusTime
//
//  Created by greetgo on 8/27/20.
//  Copyright © 2020 thousand.com. All rights reserved.
//

import UIKit

class ComingTripsViewController: BaseDriverViewController {

    // MARK: - Variables
    var carId:Int?
    var placesCount = 0
    var carsModel: [CarsListModel]? {
        didSet {
            
        }
    }
    var tripsModel: [ComingTripsModel]? {
        didSet {
            
        }
    }
    required init?(coder: NSCoder) {fatalError("")}
    init(carId:Int?) {
        self.carId = carId
        super.init(nibName: nil, bundle: nil)
        
    }
    // MARK: - Properties
    lazy var tableView: UITableView = {
        let table = UITableView()
        table.register(ComingTripsTableViewCell.self, forCellReuseIdentifier: ComingTripsTableViewCell.cellIdentifier())
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
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        title = localized(text: "comingRides")
        navigationController?.navigationBar.tintColor = maincolor.blue
        navigationController?.navigationBar.barTintColor = maincolor.blue
        navigationController!.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont.init(name: Font.mullerBold,size: 18)!,
                                                                   NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarPosition.any, barMetrics: UIBarMetrics.default)
//        let filterButton = UIBarButtonItem(image:  #imageLiteral(resourceName: "Group-9").withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(tapFilter))
//        navigationItem.rightBarButtonItem = filterButton
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getCards()
        
        setupViews()
    }
    
    // MARK: - SetupViews
    private func setupViews() -> Void {
        view.addSubviews([tableView, emptyLabel])
        tableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        emptyLabel.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
    }
    private func isEmptyData() {
        if tripsModel?.count == 0 {
            emptyLabel.isHidden = false
        } else {
            emptyLabel.isHidden = true
        }
    }

    // MARK: - Actions
    @objc func tapFilter() -> Void {
        navigationController?.pushViewController(FilterCalendarViewController(), animated: true)
    }
    @objc func tapDelete(button: UIButton) -> Void {
        deleteTrip(id: tripsModel![button.tag].id, index: button.tag)
    }
    @objc func tapWatch(button: UIButton) -> Void {
        
        let vc = ReserveDriverViewController(travel_id: tripsModel![button.tag].id,
                                             car_type_id: tripsModel![button.tag].car.car_type_id)
        navigationController?.pushViewController(vc, animated: true)
    }
}

// MARK: - TableView delegate
extension ComingTripsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tripsModel?.count ?? 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ComingTripsTableViewCell.cellIdentifier(), for: indexPath) as! ComingTripsTableViewCell
        cell.priceView.freePlaceCountTitle.text = tripsModel![indexPath.row].count_free_places == 0 ?
            localized(text: "fullSeats") : localized(text: "freeSeats")
        cell.deleteButton.tag = indexPath.row
        cell.watchButton.tag = indexPath.row
    
        cell.deleteButton.addTarget(self, action: #selector(tapDelete(button:)), for: .touchUpInside)
        cell.watchButton.addTarget(self, action: #selector(tapWatch(button:)), for: .touchUpInside)
        cell.configure(model: tripsModel![indexPath.row])
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let vc = ReserveDriverViewController(travel_id: tripsModel![indexPath.row].id,
                                             car_type_id: tripsModel![indexPath.row].car.car_type_id)
        navigationController?.pushViewController(vc, animated: true)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

// MARK: - Parser
extension ComingTripsViewController {
    private func getUpComing() -> Void {
        showHUD()
        let parameter: [String : Any] = ["id":self.carId!] as Parameters
        ParseManager.shared.getRequest(url: api.travelUpComingId, parameters: parameter) { (result: [ComingTripsModel]?, error) in
            
            self.dismissHUD()
            if let error = error {
                self.showErrorMessage(messageType: .none, error)
                return
            }
            self.tripsModel = result!
            self.isEmptyData()
            self.tableView.reloadData()
        }
    }
    private func deleteTrip(id: Int, index:Int) -> Void {
        var busyCount = 0
        let freeCount = tripsModel?[index].count_free_places ?? 0
        switch tripsModel?[index].car.car_type_id {
        case 1:
            busyCount = 53 - freeCount
        case 3:
            busyCount = 6 - freeCount
        case 5:
            busyCount = 4 - freeCount
        case 6:
            busyCount = 7 - freeCount
        case 7:
            busyCount = 62 - freeCount
        case 8:
            busyCount = 28 - freeCount
        case 9:
            busyCount = 29 - freeCount
        default:
            busyCount = 36 - freeCount
        }
        if busyCount == 0 {
            showSubmitMessage(messageType: .none, "Вы действительно хотите удалить поездку?") {
                self.showHUD()
                let parameter: [String : Any] = [ "travel_id": id ] as Parameters
                ParseManager.shared.postRequest(url: api.travelDelete, parameters: parameter) { (result: CheckRequest?, error) in
                    self.dismissHUD()
    //                if let error = error {
    //                    print(error)
    //                    return
    //                }
                    self.showSuccessMessage {
                        self.getUpComing()
                    }
                }
            }
        }
        else {
            showErrorMessage(messageType: .error,  "Вы не можете удалить эту поездку")
        }
    }
}
// MARK: - Parser
extension ComingTripsViewController {
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
                    self.carId = self.carsModel?[0].id
                }
                self.getUpComing()
            }
            else {
                self.navigationController?.pushViewController(CardViewController(cardType: 2), animated: true)
            }
            
        }
    }
  
}
