//
//  FilterViewController.swift
//  BusTime
//
//  Created by greetgo on 10/23/20.
//  Copyright © 2020 thousand.com. All rights reserved.
//

import UIKit

protocol FilterDelegate {
    func send(cityStr: String, cityID: Int, stationsStr: String, stationsID: Int)
}

class FilterViewController: UIViewController {
    var tapType:String?
    var pickerTextCities: [CitiesModel]?
    var stationsArray: [StationsModel]?
    var delegate: FilterDelegate? = nil
    
    var type = "city"
    var cityString: String?
    var cityID: Int?
    var stationString: String?
    var stationsID: Int?
    
    // MARK: - Properties
    lazy var mainView: UIButton = {
        let btn = UIButton()
        btn.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        btn.addTarget(self, action: #selector(tapMain), for: .touchUpInside)
        return btn
    }()
    lazy var tableView: UITableView = {
        let table = UITableView()
        table.register(FilterUniverTableViewCell.self, forCellReuseIdentifier: FilterUniverTableViewCell.cellIdentifier())
        table.delegate = self
        table.dataSource = self
        table.layer.cornerRadius = 9
        return table
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        getCities()
        setupViews()
    }
    
    // MARK: - Init
    required init?(coder: NSCoder) { fatalError("") }
    init(tapType:String) {
        self.tapType = tapType
        super.init(nibName: nil, bundle: nil)
        
    }
    
    // MARK: - Setup
    func setupViews() -> Void {
        view.backgroundColor = .clear
        
        view.addSubviews([mainView, tableView])
        mainView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        tableView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(200)
            make.width.equalToSuperview().multipliedBy(0.8)
            make.bottom.equalToSuperview().offset(-150)
            make.centerX.equalToSuperview()
        }
    }
    
    // MARK: - Actions
    @objc func tapMain() -> Void {
        dismiss(animated: true, completion: nil)
    }
}

// MARK: - Tableview delegate
extension FilterViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return type == "city" ? (pickerTextCities?.count ?? 0) : (stationsArray?.count ?? 0)
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FilterUniverTableViewCell.cellIdentifier(), for: indexPath) as! FilterUniverTableViewCell
        cell.iconImage.isHidden = true
        cell.label.text = type == "city" ? (pickerTextCities![indexPath.row].name) : (stationsArray?[indexPath.row].name)
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if type == "city" {
            
            cityString = pickerTextCities![indexPath.row].name
            cityID = pickerTextCities![indexPath.row].id
            if self.tapType == "passenger" {
                self.delegate?.send(cityStr: cityString!, cityID: cityID!, stationsStr: "", stationsID: 0)
                self.dismiss(animated: true, completion: nil)
            }
            else {
                type = "stations"
                getStations(city_id: pickerTextCities![indexPath.row].id)}
        } else {
            stationString = stationsArray?[indexPath.row].name
            stationsID = stationsArray?[indexPath.row].id
            delegate?.send(cityStr: cityString!, cityID: cityID!, stationsStr: stationString!, stationsID: stationsID!)
            dismiss(animated: true, completion: nil)
        }
    }
}

// MARK: - Parser
extension FilterViewController {
    private func getCities() -> Void {
        showHUD()
        ParseManager.shared.getRequest(url: api.cities) { (result: [CitiesModel]?, error) in
            self.dismissHUD()
            if let error = error {
                self.showErrorMessage(messageType: .none, error)
                return
            }
            self.pickerTextCities = result!
            self.tableView.reloadData()
        }
    }
    private func getStations(city_id: Int) -> Void {
        showHUD()
        let parameter = ["city_id": city_id]
        ParseManager.shared.getRequest(url: api.stations, parameters: parameter) { (result: [StationsModel]?, error) in
            self.dismissHUD()
            if let error = error {
                self.showErrorMessage(messageType: .none, error)
                return
            }
            self.stationsArray = result!
            self.tableView.reloadData()
        }
    }
}
