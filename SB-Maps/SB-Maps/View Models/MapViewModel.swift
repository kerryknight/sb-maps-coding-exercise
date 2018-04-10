//
//  MapViewModel.swift
//  SB-Maps
//
//  Created by Kerry Knight on 4/10/18.
//  Copyright © 2018 Kerry Knight. All rights reserved.
//

import Foundation

enum Location: Int {
    case newYork
    case cancun
}

class MapViewModel: NSObject {
    let location: Location
    init(location: Location) {
        log.debug("location: \(location)")
        self.location = location
        super.init()
    }
}
