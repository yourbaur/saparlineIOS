//
//  MyPassengersViewController.swift
//  BusTime
//
//  Created by greetgo on 8/27/20.
//  Copyright © 2020 thousand.com. All rights reserved.
//

import UIKit

class MyPassengersViewController: BaseDriverViewController {

    var model: [PassengerModel]?
    var carsModel: [CarsListModel]? {
        didSet {
            
        }
    }
    var carId:Int?
    
    required init?(coder: NSCoder) {fatalError("")}
    init(carId:Int?) {
        self.carId = carId
        super.init(nibName: nil, bundle: nil)
        
    }
    lazy var passengerHeaderView =
        
        PassengersHeaderView("Место", "Пассажир")
    // MARK: - Properties
    lazy var tableView: UITableView = {
        let table = UITableView()
        table.register(MyPassengersTableViewCell.self, forCellReuseIdentifier: MyPassengersTableViewCell.cellIdentifier())
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
        
        title = localized(text: "myPass")
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
    func setupViews() -> Void {
        passengerHeaderView.isHidden = true
        view.addSubview(passengerHeaderView)
        passengerHeaderView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(15)
            make.height.equalTo(50)
            make.width.equalToSuperview()
            
        }
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.left.right.bottom.equalToSuperview()
            make.top.equalTo(passengerHeaderView.snp.bottom).offset(2)
        }
        view.addSubview(emptyLabel)
        emptyLabel.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
    }
    func isEmptyData() {
        if model?.count == 0 {
            passengerHeaderView.isHidden = true
            emptyLabel.isHidden = false
        } else {
            passengerHeaderView.isHidden = false
            emptyLabel.isHidden = true
        }
    }

    // MARK: - Actions
    @objc func tapFilter() -> Void {
        navigationController?.pushViewController(FilterCalendarViewController(), animated: true)
    }
}

// MARK: - TableView delegate
extension MyPassengersViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model?.count ?? 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MyPassengersTableViewCell.cellIdentifier(), for: indexPath) as! MyPassengersTableViewCell
        cell.selectionStyle = .none

        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let date = formatter.date(from: model![indexPath.row].booking_time ?? "")
        formatter.dateFormat = "HH:mm / dd.MM.yyyy"
        var count = 0
        
        for number in model![indexPath.row].number {

            var value = "\(number)"
            
            if model![indexPath.row].car.car_type_id == 2 {
                
                switch number{
                case 1...16:
                    value = "\(number)↓"
                case 17...32:
                    value = "\(number - 16)↑"
                case 33,34:
                    value = "0↑"
                case 35,36:
                    value = "0↓"
                default:
                    value = "\(number)"
                }
                
            }
            if count == 1 {
                cell.leftTitle1.isHidden = false
                cell.leftTitle1.text = value
            }
            else if count == 2 {
                cell.leftTitle2.isHidden = false
                cell.leftTitle2.text = value
            }
            else if count == 3 {
                cell.leftTitle3.isHidden = false
                cell.leftTitle3.text = value
            }
            else {
                cell.leftTitle.text = value
            }
            count+=1
            
        }
        cell.rightTitle.text = "8" + model![indexPath.row].passenger!.phone
        cell.callButton.phone = "8" + model![indexPath.row].passenger!.phone
        cell.callButton.addTarget(self, action: #selector(makeCall(sender:)), for: .touchUpInside)

        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    @objc func makeCall(sender:PhoneButton) {
        sender.phone.makeCall()
    }
}


// MARK: - Parser
extension MyPassengersViewController {
    private func getMyPassengers() -> Void {
        showHUD()
        
        var parameters: Parameters? = nil
        if self.carId != nil {
            parameters = ["carId":(self.carId)!]
        }
        ParseManager.shared.getRequest(url: api.myPassengersGroup,
                                       parameters: parameters) { (result: [PassengerModel]?, error) in
            self.dismissHUD()
            if let error = error {
                self.showErrorMessage(messageType: .error, error)
                return
            }
            self.model = result
            self.isEmptyData()
            self.tableView.reloadData()
        }
    }
}
// MARK: - Parser
extension MyPassengersViewController {
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
                self.getMyPassengers()
            }
            else {
                self.navigationController?.pushViewController(CardViewController(cardType: 3), animated: true)
            }
            
        }
    }
  
}

class PhoneButton:UIButton {
    var phone = String()
}
