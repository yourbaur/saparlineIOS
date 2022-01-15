//
//  GliderViewController.swift
//  BusTime
//
//  Created by greetgo on 8/24/20.
//  Copyright © 2020 thousand.com. All rights reserved.
//

import UIKit
//import GoogleMaps
import RDGliderViewController

class GliderViewController: RDGliderContentViewController {

//    // MARK: - Variables
//    private var toogleOpen = true
//    private var arrayTravelShow: TravelShowModel? {
//        didSet {
//            descripTitle.typeTransportTitle.text = "Тип транспорта: \(arrayTravelShow?.travel?.car.name ?? "-")"
//            descripTitle.timeTitle.text = arrayTravelShow?.travel?.departure_time.onlyTime()
//            descripTitle.dateTitle.text = formatOnlyDateFromBack(dateString: arrayTravelShow?.travel?.departure_time.onlyDate() ?? "")
//            
//            wayView.fromcityTitle.text = arrayTravelShow?.travel?.from?.city
//            let formatter = DateFormatter()
//            formatter.dateFormat = "yyyy-MM-dd HH:mm:00"
//            if let fromTime = formatter.date(from: (arrayTravelShow?.travel!.departure_time)!),
//               let toTime = formatter.date(from: (arrayTravelShow?.travel!.destination_time)!) {
//                let interval = toTime - fromTime
//                wayView.waytimeTitle.text = "\(interval.hour ?? 0) ч. \(interval.minute! - (interval.hour! * 60)) мин"
//            }
//            for item in wayView.stack.arrangedSubviews {
//                item.removeFromSuperview()
//            }
//            if let stations = arrayTravelShow?.travel?.stations {
//                if stations.count != 0 {
//                    for item in stations {
//                        let station = CityGliderView(city: item.stations ?? "")
//                        wayView.stack.addArrangedSubview(station)
//                    }
//                }
//            }
////            wayView.parkFrom.timeTitle.text = "0ч. 0мин"
////            wayView.parkFrom.cityTitle.text = "-"
////            wayView.parkFrom.priceTitle.text = "0тг"
////            wayView.parkTo.timeTitle.text = "0ч. 0мин"
////            wayView.parkTo.cityTitle.text = "-"
////            wayView.parkTo.priceTitle.text = "0тг"
////            
//            wayView.toCityView.timeTitle.text =  arrayTravelShow?.travel?.destination_time.onlyTime()
//            wayView.toCityView.dateTitle.text = formatOnlyDateFromBack(dateString: arrayTravelShow?.travel?.destination_time.onlyDate() ?? "")
//            wayView.toCityView.priceTitle.text = "\(arrayTravelShow?.travel?.max_price ?? 0) ₸"
//            wayView.toCityView.cityTitle.text = arrayTravelShow?.travel?.to?.city
//            
//            let lat = Double(arrayTravelShow?.travel?.from?.lat ?? "0.0") ?? 0.0
//            let lng = Double(arrayTravelShow?.travel?.from?.lng ?? "0.0") ?? 0.0
////            let location = GMSCameraPosition.camera(
////                withLatitude: lat,
////                longitude: lng,
////                zoom: 15.0)
////            mapView.googleMap.camera = location
////            mapView.googleMap.animate(to: location)
////            let point = CLLocationCoordinate2DMake(lat, lng)
////            let marker = GMSMarker(position: point)
////            marker.title = arrayTravelShow?.travel?.from?.station
////            marker.map = mapView.googleMap
//            
////            arrayTravelShow?.travel?.car.tv == 1 ?
////                detailView.stack.addArrangedSubview(detailView.firstCellView) : detailView.firstCellView.removeFromSuperview()
////            arrayTravelShow?.travel?.car.conditioner == 1 ?
////                detailView.stack.addArrangedSubview(detailView.secondCellView) : detailView.secondCellView.removeFromSuperview()
////            arrayTravelShow?.travel?.car.baggage == 1 ?
////                detailView.stack.addArrangedSubview(detailView.thirdCellView) : detailView.thirdCellView.removeFromSuperview()
//////            if arrayTravelShow?.travel?.car.conditioner == 1 { detailView.stack.addArrangedSubview(detailView.secondCellView) }
//////            if arrayTravelShow?.travel?.car.baggage == 1 { detailView.stack.addArrangedSubview(detailView.thirdCellView) }
////            toogleOpen = true
////            tapWay()
//        }
//    }
//    
//    // MARK: - Helpers
//    lazy var scrollView = UIScrollView()
//    lazy var contentView: UIView = {
//        let view = UIView()
//        view.backgroundColor = .white
//        return view
//    }()
//    
//    // MARK: - Properties
//    lazy var descripTitle = DescriptionGliderView()
//    lazy var wayView: WayGliderView = {
//        let way = WayGliderView()
//        way.wayButton.addTarget(self, action: #selector(tapWay), for: .touchUpInside)
//        return way
//    }()
//    lazy var mapView = MapView()
//    lazy var detailView = DetailGliderView(icon1: #imageLiteral(resourceName: "television"), title1: localized(text: "tv"),
//                                           icon2: #imageLiteral(resourceName: "air-conditioner"), title2: localized(text: "conditioner"),
//                                           icon3: #imageLiteral(resourceName: "luggage"), title3: localized(text: "baggage"))
//    
//    // MARK: - Lifecycle
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        setupScrollView()
//        setupViews()
//    }
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(true)
//        
//    }
//    
//    // MARK: - SetupViews
//    func setupScrollView() {
//        view.backgroundColor = .white
//        scrollView.alwaysBounceVertical = true
//        scrollView.showsVerticalScrollIndicator = false
//        scrollView.keyboardDismissMode = .onDrag
//        view.addSubview(scrollView)
//        scrollView.addSubview(contentView)
//        
//        scrollView.snp.makeConstraints { (make) in
//            make.edges.equalToSuperview()
//            make.width.equalTo(UIScreen.main.bounds.width)
//        }
//        contentView.snp.makeConstraints { (make) in
//            make.edges.equalToSuperview()
//            make.width.equalTo(view)
//        }
//    }
//    func setupViews() -> Void {
//        view.layer.cornerRadius = 15
//        view.backgroundColor = .white
//        
//        scrollView.layer.cornerRadius = 15
//        contentView.layer.cornerRadius = 15
//        
//        scrollView.addSubviews([descripTitle, wayView, mapView, detailView])
//        descripTitle.snp.makeConstraints { (make) in
//            make.top.width.equalToSuperview()
//        }
//        wayView.snp.makeConstraints { (make) in
//            make.top.equalTo(descripTitle.snp.bottom).offset(8)
//            make.width.equalToSuperview()
//        }
//        mapView.snp.makeConstraints { (make) in
//            make.top.equalTo(wayView.snp.bottom).offset(25)
//            make.width.equalToSuperview()
//        }
//        detailView.snp.makeConstraints { (make) in
//            make.top.equalTo(mapView.snp.bottom).offset(15)
//            make.width.equalToSuperview()
//            make.bottom.equalToSuperview().offset(-150)
//        }
//    }
//    
//    // MARK: - Actions
//    @objc func tapWay() -> Void {
//        
//        if toogleOpen {
//            UIView.animate(withDuration: 0.3, animations: {
//                let counter = self.wayView.stack.arrangedSubviews.count
//                self.wayView.toCityView.transform = CGAffineTransform(translationX: 0, y: -(CGFloat(counter * 45) + 30))
//                self.mapView.transform = CGAffineTransform(translationX: 0, y: -(CGFloat(counter * 45) + 30))
//                self.detailView.transform = CGAffineTransform(translationX: 0, y: -(CGFloat(counter * 45) + 30))
//                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
//                    self.wayView.stack.isHidden = true
////                    self.wayView.circleIcon2.isHidden = true
//                    self.wayView.circleIcon3.isHidden = true
////                    self.wayView.parkFrom.isHidden = true
////                    self.wayView.parkTo.isHidden = true
//                }
//            })
//        } else {
//            UIView.animate(withDuration: 0.5, animations: {
//                self.wayView.toCityView.transform = .identity
//                self.mapView.transform = .identity
//                self.detailView.transform = .identity
//                DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
//                    self.wayView.stack.isHidden = false
////                    self.wayView.circleIcon2.isHidden = false
//                    self.wayView.circleIcon3.isHidden = false
////                    self.wayView.parkFrom.isHidden = false
////                    self.wayView.parkTo.isHidden = false
//                }
//            })
//        }
//        toogleOpen.toggle()
//    }
//    
//    // MARK: - Configure
//    func configure(travel_id: Int) -> Void {
//        getTravelShow(travel_id: travel_id)
//    }
//}
//
//// MARK: - Parser
//extension GliderViewController {
//    private func getTravelShow(travel_id: Int) -> Void {
//        showHUD()
//        let parameter = ["travel_id": travel_id]
//        ParseManager.shared.getRequest(url: api.travelShowPassenger, parameters: parameter as Parameters) { (result: TravelShowModel?, error) in
//            self.dismissHUD()
//            if let error = error {
//                self.showErrorMessage(messageType: .none, error)
//                return
//            }
//            self.arrayTravelShow = result!
//        }
//    }
//    private func formatOnlyDateFromBack(dateString: String) -> String {
//        var result = ""
//        let formatter = DateFormatter()
//        formatter.dateFormat = "yyyy-MM-dd"
//        if let date = formatter.date(from: dateString) {
//            formatter.dateFormat = "dd.MM.yyyy"
//            result = formatter.string(from: date)
//        }
//        return result
//    }
}
