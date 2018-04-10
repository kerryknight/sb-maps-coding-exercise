//
//  MapViewModel.swift
//  SB-Maps
//
//  Created by Kerry Knight on 4/10/18.
//  Copyright © 2018 Kerry Knight. All rights reserved.
//

import Foundation
import CoreLocation

enum LocationSelection: Int {
    case newYork
    case cancun
}

enum LocationCoordinates {
    case newYork(lat: CLLocationDegrees, lng: CLLocationDegrees)
    case cancun(lat: CLLocationDegrees, lng: CLLocationDegrees)
}

class MapViewModel: NSObject {
    let location: LocationSelection
    let regionRadius: CLLocationDistance = 1000
    
    init(location: LocationSelection) {
        log.debug("location: \(location)")
        self.location = location
        super.init()
    }
}

// MARK: - Public Methods
extension MapViewModel {
    public func titleText() -> String {
        switch location {
        case .cancun:
            return "To Cancún, Mexico"
        case .newYork:
            return "To New York, NY"
        }
    }
    
    public func getLocationCoordinates() -> LocationCoordinates {
        switch location {
        case .cancun:
            return LocationCoordinates.newYork(lat: 21.1213285, lng: -86.9192737)
        case .newYork:
            return LocationCoordinates.cancun(lat: 40.7107446, lng: -74.0103045)
        }
    }
}

// new york
// lat: 40.7107446,
// long: -74.0103045

// cancun
// lat: 21.1213285,
// long: -86.9192737
