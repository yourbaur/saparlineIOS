//
//  SliderViewController.swift
//  SaparLine
//
//  Created by Admin on 1/16/21.
//  Copyright © 2021 thousand.com. All rights reserved.
//

import Foundation
import UIKit
import Kingfisher

class SliderViewController: UIViewController {
    var tapType:String?
    var pickerTextCities: [CitiesModel]?
    var stationsArray: [StationsModel]?
    var listOfNews:[SliderPhoto]?
    
    var type = "city"
    var cityString: String?
    var cityID: Int?
    var stationString: String?
    var stationsID: Int?
    
    lazy var newsCollectionView = PhotosCollectionView()
    
    // MARK: - Properties
    lazy var mainView: UIButton = {
        let btn = UIButton()
        btn.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        btn.addTarget(self, action: #selector(tapMain), for: .touchUpInside)
        return btn
    }()
  
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
       
        newsCollectionView.setNews(newsList: listOfNews!)
        getCities()
        setupViews()
    }
    
    // MARK: - Init
    required init?(coder: NSCoder) { fatalError("") }
    init(tapType:String, listOfNews:[SliderPhoto]) {
        self.tapType = tapType
        self.listOfNews = listOfNews
        super.init(nibName: nil, bundle: nil)
        
    }
    
    // MARK: - Setup
    func setupViews() -> Void {
        view.backgroundColor = .clear
        
        view.addSubviews([mainView, newsCollectionView])
        mainView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        newsCollectionView.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalTo(500)
            make.centerX.equalToSuperview()
        }
    }
    
    // MARK: - Actions
    @objc func tapMain() -> Void {
        dismiss(animated: true, completion: nil)
    }
}



// MARK: - Parser
extension SliderViewController {
    private func getCities() -> Void {
        showHUD()
        ParseManager.shared.getRequest(url: api.cities) { (result: [CitiesModel]?, error) in
            self.dismissHUD()
            if let error = error {
                self.showErrorMessage(messageType: .none, error)
                return
            }
            self.pickerTextCities = result!
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
        }
    }
}
