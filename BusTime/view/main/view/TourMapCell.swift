//
//  TourMapCell.swift
//  SaparLine
//
//  Created by Cheburek on 18.02.2022.
//  Copyright © 2022 thousand.com. All rights reserved.
//

import GoogleMaps
import UIKit
import CoreLocation

class TourMapCell: UITableViewCell {
    
    static let identifier = "TourMapCell"
    
    var delegate: ShowInMapViewControllerDelegate? = nil
    let locationManager = CLLocationManager()
    var latitude: Double?
    var longitude: Double?

    // MARK: - Properties
    lazy var googleMap: GMSMapView = {
        let map = GMSMapView()
        map.delegate = self
        map.isMyLocationEnabled = true
        map.settings.myLocationButton = true
        map.settings.compassButton = true
        map.layer.cornerRadius = 10
        return map
    }()
    
    
    // MARK: - Initialization
    required init?(coder: NSCoder) {fatalError("")}
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = .white
        contentView.isUserInteractionEnabled = false
        isUserInteractionEnabled = true
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: 50.1645977, longitude: 69.0313204)
        marker.map = googleMap
        addSubview(googleMap)
        
        
        googleMap.snp.makeConstraints {
//            $0.edges.equalToSuperview()
            $0.top.left.equalTo(8)
            $0.right.bottom.equalTo(-8)
            $0.height.equalTo(200)
        }
    }
}

extension TourMapCell: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let userLocation = locations.last
        let camera = GMSCameraPosition.camera(withLatitude: (userLocation?.coordinate.latitude)!,
                                              longitude: (userLocation?.coordinate.longitude)!,
                                              zoom: 16.0)
        googleMap.camera = camera
        locationManager.stopUpdatingLocation()
    }
}

extension TourMapCell: GMSMapViewDelegate {
    func mapView(_ mapView: GMSMapView, idleAt position: GMSCameraPosition) {
        self.latitude = position.target.latitude
        self.longitude = position.target.longitude
        
        let geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(CLLocation(latitude: position.target.latitude,
                                                   longitude: position.target.longitude),
                                        completionHandler: {(placemarks, error) in
            
            if (error != nil) {print("Error in reverseGeocode")}

            let placemark = placemarks! as [CLPlacemark]
            if placemark.count > 0 {
                let placemark = placemarks![0]
//                self.addressLabel.text = "\(placemark.thoroughfare ?? "") \(placemark.subThoroughfare ?? "")"
            }
        })
    }
}

