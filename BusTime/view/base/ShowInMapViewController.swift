
//  Copyright © 2020 Tuigynbekov Yelzhan. All rights reserved.

import UIKit
import GoogleMaps
import CoreLocation


//MARK: - send address protocol
protocol ShowInMapViewControllerDelegate {
    func sendAddressString(addressString: String, lat: Double, long: Double)
}


class ShowInMapViewController: UIViewController {

    var delegate: ShowInMapViewControllerDelegate? = nil
    let locationManager = CLLocationManager()
    var latitude: Double?
    var longitude: Double?
    
    //  MARK: - properties
    lazy var googleMap: GMSMapView = {
        let map = GMSMapView()
        map.delegate = self
        map.isMyLocationEnabled = true
        map.settings.myLocationButton = true
        map.settings.compassButton = true
        return map
    }()
    let trackerView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.image = #imageLiteral(resourceName: "location")
        return image
    }()
    
    lazy var borderView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    lazy var addressLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "Выберите адрес"
        lbl.textColor = .black
        lbl.font = UIFont.init(name: Font.mullerBold, size: 15)
        return lbl
    }()
    lazy var chooseBtn: DefaultButton = {
        let btn = DefaultButton()
        btn.setTitle("Выбрать", for: .normal)
        btn.addTarget(self, action: #selector(tapChoose), for: .touchUpInside)
        return btn
    }()
    lazy var backBtn: UIButton = {
        let btn = UIButton()
        btn.setImage(#imageLiteral(resourceName: "Group-23"), for: .normal)
        btn.addTarget(self, action: #selector(tapBack), for: .touchUpInside)
        return btn
    }()
    
    
    //  MARK: - lifecycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        setupNav()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupLocationManager()
    }
    
    
    //  MARK: - setup
    func setupNav() -> Void {
        navigationController?.navigationBar.isHidden = true
        tabBarController?.tabBar.isHidden = true
    }
    func setupViews() -> Void {
        view.addSubviews([borderView,
                          googleMap,
                          backBtn])
        borderView.snp.makeConstraints { (make) in
            make.bottom.width.equalToSuperview()
            make.height.equalTo(170)
        }
        googleMap.snp.makeConstraints { (make) in
            make.bottom.equalTo(borderView.snp.top)
            make.width.top.equalToSuperview()
        }
        backBtn.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(32)
            make.left.equalToSuperview().offset(16)
            make.height.width.equalTo(45)
        }
        
        borderView.addSubviews([addressLabel,
                                chooseBtn])
        addressLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(24)
            make.left.equalToSuperview().offset(16)
        }
        chooseBtn.snp.makeConstraints { (make) in
            make.top.equalTo(addressLabel.snp.bottom).offset(33)
            make.height.equalTo(56)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
        }
        
        googleMap.addSubview(trackerView)
        trackerView.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(-15)
            make.width.height.equalTo(50)
        }
    }
    func setupLocationManager() {
        self.locationManager.requestWhenInUseAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
    }
    
    
    //  MARK: - actions
    @objc func tapBack() -> Void {
        navigationController?.popViewController(animated: true)
    }
    @objc func tapChoose() -> Void {
        delegate?.sendAddressString(addressString: addressLabel.text!, lat: latitude!, long: longitude!)
        navigationController?.popViewController(animated: true)
    }
}


//MARK: - location delegate
extension ShowInMapViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let userLocation = locations.last
        let camera = GMSCameraPosition.camera(withLatitude: (userLocation?.coordinate.latitude)!,
                                              longitude: (userLocation?.coordinate.longitude)!,
                                              zoom: 16.0)
        googleMap.camera = camera
        locationManager.stopUpdatingLocation()
    }
}


//MARK: - googleMap delegate
extension ShowInMapViewController: GMSMapViewDelegate {
    func mapView(_ mapView: GMSMapView, idleAt position: GMSCameraPosition) {
        self.latitude = position.target.latitude
        self.longitude = position.target.longitude
        
        let geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(CLLocation(latitude: position.target.latitude, longitude: position.target.longitude), completionHandler: {(placemarks, error) in
            
            if (error != nil) {print("Error in reverseGeocode")}

            let placemark = placemarks! as [CLPlacemark]
            if placemark.count > 0 {
                let placemark = placemarks![0]
                self.addressLabel.text = "\(placemark.thoroughfare ?? "") \(placemark.subThoroughfare ?? "")"
            }
        })
    }
}

