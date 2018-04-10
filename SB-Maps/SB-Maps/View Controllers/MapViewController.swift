//
//  MapViewController.swift
//  SB-Maps
//
//  Created by Kerry Knight on 4/10/18.
//  Copyright © 2018 Kerry Knight. All rights reserved.
//

import UIKit
import SnapKit
import MapKit

class MapViewController: UIViewController {
    let viewModel: MapViewModel
    lazy var mapView: MKMapView = MKMapView(frame: .zero)
    
    init(location: LocationSelection) {
        self.viewModel = MapViewModel(location: location)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = viewModel.titleText()
        
        configureMap()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        mapView.showsUserLocation = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        checkLocationAuthorizationStatus()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        mapView.showsUserLocation = false
        super.viewDidDisappear(animated)
    }
    
    deinit {
        mapView.delegate = nil
        LocationService.shared.delegate = nil
        LocationService.shared.stopUpdatingLocation()
    }
}

fileprivate extension MapViewController {
    func configureMap() {
        view.addSubview(mapView)
        
        mapView.snp.makeConstraints { make in
            make.leading.trailing.top.bottom.equalTo(self.view)
        }
        
        mapView.delegate = self
    }
    
    func checkLocationAuthorizationStatus() {
        LocationService.shared.delegate = self
        
        if LocationService.shared.isAuthorized() {
            mapView.showsUserLocation = true
            LocationService.shared.startUpdatingLocation()
        }
        else {
            LocationService.shared.locationManager?.requestWhenInUseAuthorization()
        }
    }
    
    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate,
                                                                  viewModel.regionRadius, viewModel.regionRadius)
        mapView.setRegion(coordinateRegion, animated: true)
    }
}

// MARK: - LocationServiceDelegate
extension MapViewController: LocationServiceDelegate {
    func didFindLocation(currentLocation: CLLocation) {
        centerMapOnLocation(location: currentLocation)
    }
    
    func didFailFindingLocation(error: Error) {
        let alert = UIAlertController(title: "Error Finding Location", message: "\(error)", preferredStyle: .alert)
        alert.show(self, sender: nil)
    }
}

// MARK: - MKMapViewDelegate
extension MapViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
    }
    
    func mapView(_ mapView: MKMapView, didDeselect view: MKAnnotationView) {
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        return nil
    }
    
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
    }
}
