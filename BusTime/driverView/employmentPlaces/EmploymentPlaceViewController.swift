//
//  EmploymentPlaceViewController.swift
//  BusTime
//
//  Created by greetgo on 8/27/20.
//  Copyright © 2020 thousand.com. All rights reserved.
//

import UIKit
class EmploymentPlaceViewController: ScrollViewController {

    // MARK: - constant
    var numberOfSits = 40
    var removedNumbersInCollectionView = [2,7,12,17,22,27,32,37]
    
    
    // MARK: - properties
    lazy var descriptionView = DescriptionReserveView()
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
    lazy var publishBtn: DefaultButton = {
        let btn = DefaultButton()
        btn.setTitle(localized(text: "publish"), for: .normal)
        btn.addTarget(self, action: #selector(tapPublish), for: .touchUpInside)
        return btn
    }()
    
    
    // MARK: - lifecycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        title = localized(text: "reservSeat")
        view.backgroundColor = .white
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.barTintColor = maincolor.blue
        navigationController!.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont.init(name: Font.mullerBold, size: 18)!,
                                                                   NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarPosition.any, barMetrics: UIBarMetrics.default)
        navigationController?.navigationBar.isTranslucent = false
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    
    // MARK: - setup
    func setupViews() -> Void {
        view.backgroundColor = .white
        scrollView.addSubviews([descriptionView,rulImage,exitView,collectionView,exitView2,betweenView,placeView,publishBtn])
        
        descriptionView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(20)
            make.width.equalToSuperview()
        }
        rulImage.snp.makeConstraints { (make) in
            make.top.equalTo(descriptionView.snp.bottom).offset(32)
            make.left.equalToSuperview().offset(32)
            make.width.height.equalTo(32)
        }
        exitView.snp.makeConstraints { (make) in
            make.top.equalTo(descriptionView.snp.bottom).offset(26)
            make.width.equalTo(150)
            make.right.equalToSuperview()
        }
        collectionView.snp.makeConstraints { (make) in
            make.top.equalTo(rulImage.snp.bottom).offset(20)
            switch UIDevice.modelName {
            case "iPhone 11", "iPhone 11 Pro", "iPhone X", "iPhone XS", "iPhone XR", "iPhone XS Max", "iPhone 6 Plus", "iPhone 7 Plus", "iPhone 8 Plus":
                make.left.equalToSuperview().offset(48)
                make.right.equalToSuperview().offset(-48)
            default: make.left.equalToSuperview().offset(32)
                     make.right.equalToSuperview().offset(-32)}
        }
        exitView2.snp.makeConstraints { (make) in
            make.centerY.equalTo(collectionView.snp.centerY)
            make.width.equalTo(150)
            make.right.equalToSuperview()
        }
        betweenView.snp.makeConstraints { (make) in
            make.top.equalTo(descriptionView.snp.bottom).offset(32)
            make.centerX.equalToSuperview()
            make.width.equalTo(60)
            make.bottom.equalTo(collectionView.snp.bottom).offset(-55)
        }
        placeView.snp.makeConstraints { (make) in
            make.top.equalTo(collectionView.snp.bottom).offset(28)
            make.width.equalToSuperview()
        }
        publishBtn.snp.makeConstraints { (make) in
            make.top.equalTo(placeView.snp.bottom).offset(32)
            make.left.equalToSuperview().offset(44)
            make.right.equalToSuperview().offset(-44)
            make.height.equalTo(48)
            make.bottom.equalToSuperview().offset(-30)
        }
    }
    
    
    // MARK: - actions
    func shouldBeRemoved(index: Int) -> Bool{
        for i in removedNumbersInCollectionView {
            if i == index {return true}
        }
        return false
    }
    @objc func tapPublish() -> Void {
        
    }
}


// MARK: - collection delegate
extension EmploymentPlaceViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int { numberOfSits}
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier:SitDriverCollectionViewCell.cellIdentifier,for:indexPath)as!SitDriverCollectionViewCell
        if shouldBeRemoved(index: indexPath.item) { cell.isHidden = true }
        
        let column = indexPath.row % 5
        let row = (indexPath.row - column)/5
        
        switch indexPath.row % 5 {
        case 0:
            cell.placeNumber.text = "\(2*row+1)"
            if row == 7 {
                cell.placeNumber.text = "29"
            }
        case 1:
            cell.placeNumber.text = "\((2*row+1)+16)"
            if row == 6 {
                cell.placeNumber.text = "14"
            }else if row == 7 {
                cell.placeNumber.text = "30"
            }
        case 3:
            cell.placeNumber.text = "\(2*(row+1))"
            if row == 6 {
                cell.placeNumber.text = "15"
            }else if row == 7 {
                cell.placeNumber.text = "31"
            }
        case 4:
            cell.placeNumber.text = "\(2*(row+1)+16)"
            if row == 6 {
                cell.placeNumber.text = "16"
            }
        default:
            break
        }
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! SitDriverCollectionViewCell
        print("index:", cell.placeNumber.text!)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: 45, height: 45)
    }
}
