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

// MARK: - Life Cycle
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
        
        checkLocationAuthorizationStatus()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        mapView.showsUserLocation = false
        super.viewDidDisappear(animated)
    }
    
    deinit {
        mapView.delegate = nil
        LocationService.shared.stopUpdatingLocation()
    }
}

// MARK: - Private Methods
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
    
    func showRoute(fromLocation location: CLLocation) {
        // adapted from https://www.ioscreator.com/tutorials/draw-route-mapkit-tutorial
        let sourceLocation = location.coordinate
        let destinationLocation = viewModel.getDestinationCoordinates()
        
        log.debug("source location: \(sourceLocation)")
        
        let sourcePlacemark = MKPlacemark(coordinate: sourceLocation, addressDictionary: nil)
        let destinationPlacemark = MKPlacemark(coordinate: destinationLocation, addressDictionary: nil)
        
        let sourceMapItem = MKMapItem(placemark: sourcePlacemark)
        let destinationMapItem = MKMapItem(placemark: destinationPlacemark)
        
        let sourceAnnotation = MKPointAnnotation()
        if let location = sourcePlacemark.location {
            sourceAnnotation.coordinate = location.coordinate
        }
        
        sourceAnnotation.title = InterfaceString.Map.CurrentLocation
        
        let destinationAnnotation = MKPointAnnotation()
        if let location = destinationPlacemark.location {
            destinationAnnotation.coordinate = location.coordinate
        }
        
        destinationAnnotation.title = viewModel.expandedTitleText()
        
        // add annotations to mapview
        mapView.showAnnotations([sourceAnnotation,destinationAnnotation], animated: true )
        
        let directionRequest = MKDirectionsRequest()
        directionRequest.source = sourceMapItem
        directionRequest.destination = destinationMapItem
        directionRequest.transportType = .automobile
        
        // Calculate the direction
        let directions = MKDirections(request: directionRequest)
        
        directions.calculate { [weak self] response, error -> Void in
            guard let response = response else { return }
            guard let strongSelf = self else { return }
            
            if let error = error {
                log.error("Error: \(error)")
                return
            }
            
            let route = response.routes[0]
            strongSelf.mapView.add((route.polyline), level: MKOverlayLevel.aboveRoads)
            
            let rect = route.polyline.boundingMapRect
            strongSelf.mapView.setRegion(MKCoordinateRegionForMapRect(rect), animated: true)
            
            LocationService.shared.stopUpdatingLocation()
        }
    }
}

// MARK: - LocationServiceDelegate
extension MapViewController: LocationServiceDelegate {
    func didFindLocation(currentLocation: CLLocation) {
        showRoute(fromLocation: currentLocation)
    }
    
    func didFailFindingLocation(error: Error) {
        log.error("Error: \(error)")
        let alert = UIAlertController(title: "Error Finding Location", message: "\(error)", preferredStyle: .alert)
        alert.show(self, sender: nil)
    }
}

// MARK: - MKMapViewDelegate
extension MapViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let renderer = MKPolylineRenderer(overlay: overlay)
        renderer.strokeColor = .carolinaBlue()
        renderer.lineWidth = 4.0
        
        return renderer
    }
}
