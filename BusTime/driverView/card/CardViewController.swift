//
//  CardViewController.swift
//  SaparLine
//
//  Created by Admin on 1/5/21.
//  Copyright © 2021 thousand.com. All rights reserved.
//

import Foundation
import UIKit

class CardViewController: BaseDriverViewController {

    // MARK: - Variables
    var placesCount = 0
    var cardType = 0
    var carsModel: [CarsListModel]? {
        didSet {
            
        }
    }
    
    required init?(coder: NSCoder) {fatalError("")}
    init(cardType:Int) {
        self.cardType = cardType
        super.init(nibName: nil, bundle: nil)
        
    }
    // MARK: - Properties
    lazy var tableView: UITableView = {
        let table = UITableView()
        table.register(CarsViewCell.self, forCellReuseIdentifier: CarsViewCell.cellIdentifier())
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
        
        if cardType == 1{
            title = localized(text: "carsList")
        }
        else if cardType == 3{
            title = localized(text: "myPass")
        }
        else {
            title = localized(text: "comingRides")
        }
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
        if carsModel?.count == 0 {
            emptyLabel.isHidden = false
        } else {
            emptyLabel.isHidden = true
        }
    }

    // MARK: - Actions
    @objc func tapFilter() -> Void {
        navigationController?.pushViewController(FilterCalendarViewController(), animated: true)
    }
   
}

// MARK: - TableView delegate
extension CardViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return carsModel?.count ?? 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CarsViewCell.cellIdentifier(), for: indexPath) as! CarsViewCell
       
        
     
        cell.configure(model: carsModel![indexPath.row])
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch carsModel?[indexPath.row].car_type_id ?? 0 {
        case 1:
            self.placesCount = 53
        case 2:
            self.placesCount = 36
        case 6:
            self.placesCount = 7
        case 5:
            self.placesCount = 4
        case 7:
            self.placesCount = 62
        default:
            self.placesCount = 6
        }
        if carsModel?[indexPath.row].is_confirmed == 1 {
            var vc:UIViewController?
            // if it is Main View, go to add travel view, this type of card is a 1
            if cardType == 1 {
                vc = MainDriverViewController(carId: carsModel?[indexPath.row].id, countPlaces: self.placesCount, carTypeId: carsModel?[indexPath.row].car_type_id ?? 0)
            }
            // else card type is a 2, that's mean is coming trips
            else if cardType == 2 {
                print((carsModel?[indexPath.row].id)!)
                vc = ComingTripsViewController(carId: (carsModel?[indexPath.row].id)!)
            }
            else {
                vc = MyPassengersViewController(carId: (carsModel?[indexPath.row].id)!)
            }
        
            self.navigationController?.pushViewController(vc!, animated: true)
            
        }
     
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

// MARK: - Parser
extension CardViewController {
    private func getCards() -> Void {
        showHUD()
        ParseManager.shared.getRequest(url: api.carsList) { (result: [CarsListModel]?, error) in
            self.dismissHUD()
            if let error = error {
                self.showErrorMessage(messageType: .none, error)
                return
            }
            
            self.carsModel = result!
            self.isEmptyData()
            self.tableView.reloadData()
            if (UserManager.shared.getConfirm() ?? false) {
                self.showSubmitMessage(messageType: .confirm, UserManager.shared.getText() ?? "") {
                    UserManager.shared.setConfirm(to: false)
                    self.setConfirm()
                }
            }
        }
    }
    private func setConfirm() -> Void {
        showHUD()
        let parameter: Parameters = [:] as Parameters
        ParseManager.shared.getRequest(url: "order/take/\(UserManager.shared.getOrderId() ?? "")", parameters: parameter) { (result: UserDetail?, error) in
            self.dismissHUD()
//            if let error = error {
//                self.showErrorMessage(messageType: .none, error)
//                return
//            }
            
            
        }
    }
  
}
