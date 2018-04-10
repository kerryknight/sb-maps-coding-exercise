//
//  LocationService.swift
//  SB-Maps
//
//  Created by Kerry Knight on 4/10/18.
//  Copyright © 2018 Kerry Knight. All rights reserved.
//
//  Adapted from: https://github.com/igroomgrim/CLLocationManager-Singleton-in-Swift

import Foundation
import CoreLocation

public protocol LocationServiceDelegate {
    func didFindLocation(currentLocation: CLLocation)
    func didFailFindingLocation(error: Error)
}

// MARK: - Life Cycle
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

// MARK: - Public Methods
public extension LocationService {
    func isAuthorized() -> Bool {
        return CLLocationManager.authorizationStatus() == .authorizedWhenInUse
    }
    
    func startUpdatingLocation() {
        self.locationManager?.startUpdatingLocation()
    }
    
    func stopUpdatingLocation() {
        self.locationManager?.stopUpdatingLocation()
    }
}

// MARK: - Private Methods
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
        if self.isAuthorized() {
            self.startUpdatingLocation()
        }
    }
}
