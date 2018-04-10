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

// MARK: - Life Cycle
class MapViewModel: NSObject {
    let location: LocationSelection
    let regionRadius: CLLocationDistance = 1000
    
    init(location: LocationSelection) {
        self.location = location
        super.init()
    }
}

// MARK: - Public Methods
extension MapViewModel {
    public func titleText() -> String {
        switch location {
        case .cancun:
            return "¡Vamos a México!"
        case .newYork:
            return "To New York, NY"
        }
    }
    
    public func expandedTitleText() -> String {
        switch location {
        case .cancun:
            return "Cancún, Quintana Roo, México"
        case .newYork:
            return "222 Broadway, New York, NY 10038"
        }
    }

    public func getDestinationCoordinates() -> CLLocationCoordinate2D {
        switch location {
        case .cancun:
            return CLLocationCoordinate2D(latitude: 21.1213285, longitude: -86.9192737)
        case .newYork:
            return CLLocationCoordinate2D(latitude: 40.7107446, longitude: -74.0103045)
        }
    }
}
