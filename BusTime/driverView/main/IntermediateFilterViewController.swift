//
//  IntermediateFilterViewController.swift
//  BusTime
//
//  Created by greetgo on 10/23/20.
//  Copyright © 2020 thousand.com. All rights reserved.
//

import UIKit

protocol InterFilterDelegate {
    func send(stationsID: [Int], stationsStr: String)
}

class IntermediateFilterViewController: UIViewController {

    var stationsArray: [StationsModel2]?
    var stationIDs = [Int]()
    var stationsStr = [String]()
    var allStations = ""
    var delegate: InterFilterDelegate? = nil
    
    // MARK: - Properties
    lazy var mainView: UIButton = {
        let btn = UIButton()
        btn.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        btn.addTarget(self, action: #selector(tapAdd), for: .touchUpInside)
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
        setupViews()
    }
    
    // MARK: - Init
    required init?(coder: NSCoder) {fatalError("")}
    init(fromID: Int, toID: Int) {
        super.init(nibName: nil, bundle: nil)
        
        getTravelStations(fromID: fromID, toID: toID)
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
    @objc func tapAdd() -> Void {
        if stationIDs.count != 0 && stationsStr.count != 0 {
            for item in stationsStr {
                allStations += "\(item),"
            }
            allStations = String(allStations.dropLast())
        }
        delegate?.send(stationsID: stationIDs, stationsStr: allStations)
        dismiss(animated: true, completion: nil)
    }
}

// MARK: - Tableview delegate
extension IntermediateFilterViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stationsArray?.count ?? 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FilterUniverTableViewCell.cellIdentifier(), for: indexPath) as! FilterUniverTableViewCell
        cell.label.text = stationsArray![indexPath.row].stations
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! FilterUniverTableViewCell
        cell.itemSelected = !cell.itemSelected
        cell.itemSelected == true ? (cell.iconImage.image = #imageLiteral(resourceName: "Frame 36")) : (cell.iconImage.image = #imageLiteral(resourceName: "Frame 36-1"))
        tableView.deselectRow(at: indexPath, animated: true)
        guard let currentID = stationsArray?[indexPath.row].station_id else { return }
        guard let currentStr = stationsArray?[indexPath.row].stations else { return }
        if stationIDs.contains(currentID) {
            let newArray = stationIDs.filter { $0 != currentID }
            stationIDs.removeAll()
            stationIDs = newArray
            let newArrayStr = stationsStr.filter { $0 != currentStr }
            stationsStr.removeAll()
            stationsStr = newArrayStr
        } else {
            stationIDs.append(currentID)
            stationsStr.append(currentStr)
        }
    }
}

// MARK: - Parser
extension IntermediateFilterViewController {
    private func getTravelStations(fromID: Int, toID: Int) -> Void {
        self.showHUD()
        let parameter = ["from_city_id": fromID,
                         "to_city_id": toID]
        ParseManager.shared.getRequest(url: api.travelStations, parameters: parameter) { (result: [StationsModel2]?, error) in
            self.dismissHUD()
            if let error = error {
                self.showErrorMessage(messageType: .error, error); return
            }
            self.stationsArray = result!
            self.tableView.reloadData()
        }
    }
}
