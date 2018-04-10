//
//  LocationService.swift
//  SB-Maps
//
//  Created by Kerry Knight on 4/10/18.
//  Copyright © 2018 Kerry Knight. All rights reserved.
//

import Foundation
import CoreLocation

public protocol LocationServiceDelegate {
    func didFindLocation(currentLocation: CLLocation)
    func didFailFindingLocation(error: Error)
}

public class LocationService: NSObject {
    static let shared = LocationService()
    private(set) var locationManager: CLLocationManager?
    private(set) var currentLocation: CLLocation?
    public var delegate: LocationServiceDelegate?
    
    override init() {
        super.init()
        
        self.locationManager = CLLocationManager()
        
        guard let locationManager = self.locationManager else {
            return
        }
        
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.delegate = self
    }
}

public extension LocationService {
    func isAuthorized() -> Bool {
        return CLLocationManager.authorizationStatus() == .authorizedWhenInUse
    }
    
    func startUpdatingLocation() {
        print("Starting Location Updates")
        self.locationManager?.startUpdatingLocation()
    }
    
    func stopUpdatingLocation() {
        print("Stop Location Updates")
        self.locationManager?.stopUpdatingLocation()
    }
}

fileprivate extension LocationService {
    func updateLocation(_ currentLocation: CLLocation){
        guard let delegate = self.delegate else { return }
        delegate.didFindLocation(currentLocation: currentLocation)
    }
    
    func updateLocationDidFailWithError(_ error: Error) {
        guard let delegate = self.delegate else { return }
        delegate.didFailFindingLocation(error: error)
    }
}

// MARK: - CLLocationManagerDelegate
extension LocationService: CLLocationManagerDelegate {
    public func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        log.debug("Found locations: \(locations)")
        guard let location = locations.last else { return }
        
        // singleton for get last(current) location
        self.currentLocation = location
        
        // use for real time update location
        updateLocation(location)
    }
    
    public func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        log.error("Did fail to update: \(error)")
        updateLocationDidFailWithError(error)
    }
    
    public func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        log.debug("Authorization status changed: \(status)")
        if self.isAuthorized() {
            self.startUpdatingLocation()
        }
    }
}
