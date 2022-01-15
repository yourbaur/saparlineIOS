//
//  ReviewListViewController.swift
//  SaparLine
//
//  Created by Bauyrzhan on 11.03.2021.
//  Copyright © 2021 thousand.com. All rights reserved.
//

import Foundation
import UIKit
import Charts
import Cosmos


class ReviewListViewController: ScrollViewController {

    // MARK: - Variables
    var reviews: [Feedback] = []
    var comfortList:[Comfort] = []
    var carId:Int?
    var carNumber = ""
    var shouldFetch = true
    var type = 2
    var currentPage = 1
    
    private var switcher: SwitcherReviewView = {
       let sw = SwitcherReviewView(firstTitle: "Удобства",
                    secondTitle: "Отзывы",
                    thirdTitle: "Политика")
        
        return sw
    }()
    
    lazy var cityView = ComingCityView()
    
    lazy var cleanChartView: PieChartView = {
        let view = PieChartView()
        return view
    }()
    
    lazy var behaChartView: PieChartView = {
        let view = PieChartView()
        return view
    }()
    
    lazy var speedChartView: PieChartView = {
        let view = PieChartView()
        return view
    }()
    
    lazy var mainView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.shadowColor = UIColor.black.cgColor//UIColor.gray.cgColor
        view.layer.shadowOpacity = 0.3
        view.layer.shadowOffset = CGSize.zero
        view.layer.shadowRadius = 20
        view.layer.cornerRadius = 20
        return view
    }()
    lazy var reviewLabel: UILabel = {
        let review = UILabel()
        review.text = "15 отзывов"
        review.textColor = maincolor.blue
        return review
    }()
    
    lazy var policyText:UILabel = {
        let policy = UILabel()
        policy.text = "В случае возврата билета будет удержана 50% от суммы"
        policy.textColor =  maincolor.blue
        policy.numberOfLines = 0
        return policy
    }()
    
    lazy var avgRatingLabel: UILabel = {
        let rating = UILabel()
        rating.text = "0.0☆"
        rating.backgroundColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
        rating.layer.cornerRadius = 8
        rating.font = UIFont.init(name: Font.mullerRegular, size: 15)
        rating.textAlignment = .center

        rating.textColor = .white
        rating.layer.masksToBounds = true
        return rating
    }()
    lazy var carNumberLabel: UILabel = {
        let car = UILabel()
        car.text = "00 Ff 34"
        car.layer.borderColor = maincolor.blue.cgColor
    
        car.layer.cornerRadius = 8
        car.font = UIFont.init(name: Font.mullerRegular, size: 15)
        car.textAlignment = .center
        car.layer.borderWidth = 1
        car.textColor = maincolor.blue
        car.layer.masksToBounds = true
        return car
    }()
    
        
    lazy var tableView: UITableView = {
        let table = UITableView()
        table.register(ReviewTableViewCell.self, forCellReuseIdentifier: ReviewTableViewCell.cellIdentifier())
        table.register(ComfortTableViewCell.self, forCellReuseIdentifier: ComfortTableViewCell.cellIdentifier())
        table.delegate = self
        table.dataSource = self
        table.separatorStyle = .none
        return table
    }()
    
    // MARK: - Lifecycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.title = "Список отзывов"
        view.backgroundColor = .white
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupActions()
        setupSwitcher()
        setupPieChart()
        
    }
    
    private func setupPieChart(){}
    private func setupActions(){}
    
    // MARK: - Init
    required init?(coder: NSCoder) {fatalError("")}
    init(carId:Int, comfortList:[Comfort], type:Int, carNumber:String) {
        super.init(nibName: nil, bundle: nil)
        self.carId = carId
        self.comfortList = comfortList
        self.type = type
        self.carNumber = carNumber
    }
    
    private func bind(review:Review) {
        let rating1 = Double(review.ratingInfo?[0].criterion1 ?? 0.0)
        let rating2 = Double(review.ratingInfo?[0].criterion2 ?? 0.0)
        let rating3 = Double(review.ratingInfo?[0].criterion3 ?? 0.0)
        
        setCenter(rating: rating1, type: 1)
        setCenter(rating: rating2, type: 2)
        setCenter(rating: rating3, type: 3)
        
        setChart(dataPoints: ["", ""], values: Array([rating1, 5-rating1]), type: 1)
        setChart(dataPoints: ["", ""], values: Array([rating2, 5-rating2]), type: 2)
        setChart(dataPoints: ["", ""], values: Array([rating3, 5-rating3]), type: 3)

    }
    
    func setupSwitcher() {
        getList()
        switcher.firstAction  = {
            self.type = 1
            self.mainView.isHidden = true
            self.policyText.isHidden = true
            self.tableView.isHidden = false
            self.tableView.snp.remakeConstraints { make in
                make.top.equalTo(self.switcher.snp.bottom).offset(8)
                make.bottom.equalTo(self.view.safeAreaLayoutGuide)
                make.left.equalToSuperview().offset(16)
                make.right.equalToSuperview().offset(-16)
                
            }
            self.tableView.reloadData()
        }
        switcher.secondAction = {
            self.type = 2
            UIView.animate(withDuration: 0.6, animations: {
                self.mainView.isHidden = false
                self.policyText.isHidden = true
                self.reviewLabel.isHidden = false
            }, completion: {_ in
                
                self.tableView.snp.remakeConstraints { make in
                    make.top.equalTo(self.mainView.snp.bottom).offset(8)
                    make.bottom.equalTo(self.view.safeAreaLayoutGuide)
                    make.left.equalToSuperview().offset(16)
                    make.right.equalToSuperview().offset(-16)
                }
                self.tableView.reloadData()
            })
            
        }
        switcher.thirdAction = {
            self.type = 3
            UIView.animate(withDuration: 0.6, animations: {
                self.mainView.isHidden = true
                self.tableView.isHidden = false
                self.reviewLabel.isHidden = true
            }, completion: {_ in
                self.policyText.isHidden = false
                self.tableView.snp.remakeConstraints { make in
                    make.top.equalTo(self.mainView.snp.bottom).offset(8)
                    make.bottom.equalTo(self.view.safeAreaLayoutGuide)
                    make.left.equalToSuperview().offset(16)
                    make.right.equalToSuperview().offset(-16)
                }
                self.tableView.reloadData()
            })
        }
        
        if self.type == 1 {
            switcher.firstButtonSelected()
        }
        else if self.type == 2{
            switcher.secondButtonSelected()
        }
        else if self.type == 3 {
            switcher.thirdButtonSelected()
        }
        
        
    }
    
    private func setupViews() {
        carNumberLabel.text = carNumber
        scrollView.addSubviews([switcher, mainView, reviewLabel, tableView, policyText])
        switcher.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.width.equalToSuperview()
        }
        
        mainView.snp.makeConstraints { make in
            make.top.equalTo(switcher.snp.bottom).offset(8)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
            make.height.equalTo(200)
        }
        
        policyText.snp.makeConstraints { make in
            make.top.equalTo(switcher.snp.bottom).offset(8)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
            
        }
        
        mainView.addSubviews([cleanChartView, behaChartView, speedChartView,
                              avgRatingLabel, carNumberLabel
        ])
        cleanChartView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(8)
            make.left.equalToSuperview().offset(16)
            make.height.equalTo(150)
            make.width.equalTo(100)
            
        }
        behaChartView.snp.makeConstraints { make in
            make.top.equalTo(cleanChartView)
            make.left.equalTo(cleanChartView.snp.right).offset(8)
            make.height.equalTo(150)
            make.width.equalTo(100)
            
        }
        speedChartView.snp.makeConstraints { make in
            make.top.equalTo(cleanChartView)
            make.left.equalTo(behaChartView.snp.right).offset(8)
            make.height.equalTo(150)
            make.width.equalTo(100)
            
        }
        
        avgRatingLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(4)
            make.right.equalToSuperview().offset(-16)
            make.width.equalTo(55)
            make.height.equalTo(20)
            
        }
        carNumberLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(4)
            make.left.equalToSuperview().offset(16)
            make.height.equalTo(20)
            
        }
        
      
        reviewLabel.snp.makeConstraints { make in
            make.top.equalTo(mainView.snp.bottom).offset(4)
            make.left.equalToSuperview().offset(16)
            
        }
        tableView.snp.makeConstraints { make in
            make.top.equalTo(reviewLabel.snp.bottom).offset(4)
            make.bottom.equalTo(view.safeAreaLayoutGuide)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
            
        }

        
    }
    func setChart(dataPoints: [String], values: [Double], type:Int) {
        var dataEntries: [ChartDataEntry] = []
        for i in 0..<dataPoints.count {
          let dataEntry1 = ChartDataEntry(x: Double(i), y: values[i], data: dataPoints[i] as AnyObject)
          dataEntries.append(dataEntry1)
        }
        print(dataEntries[0].data)
        var label = ""
        if type == 1 {
            label = "Чистота"
        }
        else if type == 2{
            label = "Поведение"
        }
        else {
            label = "Скорость"
        }
        let pieChartDataSet = PieChartDataSet(entries: dataEntries, label: label)
        let pieChartData = PieChartData(dataSet: pieChartDataSet)
        var colors: [UIColor] = []
        if type == 1 {
            cleanChartView.data = pieChartData
            cleanChartView.holeRadiusPercent = 0.5
            cleanChartView.transparentCircleRadiusPercent = 0.0
            cleanChartView.centerTextRadiusPercent = 1.0
            cleanChartView.holeColor = UIColor.white
        }
        else if type == 2{
            behaChartView.data = pieChartData
            behaChartView.holeRadiusPercent = 0.5
            behaChartView.transparentCircleRadiusPercent = 0.0
            behaChartView.centerTextRadiusPercent = 1.0
            behaChartView.holeColor = UIColor.white
        }
        else if type == 3{
            speedChartView.data = pieChartData
            speedChartView.holeRadiusPercent = 0.5
            speedChartView.transparentCircleRadiusPercent = 0.0
            speedChartView.centerTextRadiusPercent = 1.0
            speedChartView.holeColor = UIColor.white
        }
        colors.append(#colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1))
        colors.append(.lightGray)
        pieChartDataSet.colors = colors
        pieChartDataSet.drawValuesEnabled = false
        
        
      }
    
    func setCenter(rating: Double, type:Int){
        let textColor = UIColor.black

        
        let dayString = String(describing: rating)
        let centerText = NSMutableAttributedString()
        let numberText = NSMutableAttributedString(string: " " + dayString, attributes: [NSAttributedString.Key.foregroundColor:textColor,NSAttributedString.Key.font: UIFont.init(name: Font.mullerBold, size: 14)!])
        let descriptionText = NSMutableAttributedString(string: "", attributes: [NSAttributedString.Key.foregroundColor:textColor,NSAttributedString.Key.font: UIFont.init(name: Font.mullerBold, size: 14)!])
        centerText.append(numberText)
        centerText.append(descriptionText)
        
        if type == 1 {
            cleanChartView.centerAttributedText = centerText
        }
        else if type == 2 {
            behaChartView.centerAttributedText = centerText
        }
        else if type == 3{
            speedChartView.centerAttributedText = centerText
        }
        
    }
    
 }

extension ReviewListViewController {
    @objc
    func getList() -> Void {
        showHUD()
      
        let parameter = [
            "carId":self.carId!,
            "page":currentPage
        ] as Parameters
        
        ParseManager.shared.getRequest(url: api.listReviews, parameters: parameter) { (result: Review?, error) in
            self.dismissHUD()
            if let error = error {
                print(error)
                self.showErrorMessage(messageType: .none, "Заполните все поля!")
                return
            }
            if result?.feedbackList?.data?.count != 0{
                self.reviews.append(contentsOf:result?.feedbackList?.data ?? [Feedback]())
            }
            self.avgRatingLabel.text = "\(result?.ratingInfo?[0].rating ?? 0.0)".prefix(4) + "☆"
            self.tableView.reloadData()
            if result != nil{
                self.bind(review: result!)
            }
            //            self.showSuccessMessage()
            
            
        }
    }
}
// MARK: - TableView delegate
extension ReviewListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if type == 2 {
            return self.reviews.count
        }
        else if type == 1 {
            return self.comfortList.count
        }
        else {
            return 0
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if type == 3 {
            let cell = tableView.dequeueReusableCell(withIdentifier: ReviewTableViewCell.cellIdentifier(), for: indexPath) as! ReviewTableViewCell
                cell.configure(model: self.reviews[indexPath.row])
                return cell
        }
        
        if type == 2{
            let cell = tableView.dequeueReusableCell(withIdentifier: ReviewTableViewCell.cellIdentifier(), for: indexPath) as! ReviewTableViewCell
                cell.configure(model: self.reviews[indexPath.row])
                return cell
        }
        
        else {
            let cell = tableView.dequeueReusableCell(withIdentifier: ComfortTableViewCell.cellIdentifier(), for: indexPath) as! ComfortTableViewCell
            cell.configure(model: self.comfortList[indexPath.row])
            return cell
        }
       
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //tapReserv(index: indexPath.row)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return type == 2 ? 150 : 100
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row + 1 == reviews.count && shouldFetch && self.type == 2{
            shouldFetch = false
            currentPage += 1
            getList()
     }

    }
}
