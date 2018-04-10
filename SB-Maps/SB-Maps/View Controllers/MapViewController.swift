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
    
    init(location: Location) {
        self.viewModel = MapViewModel(location: location)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        mapView.showsUserLocation = true
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        mapView.showsUserLocation = false
        super.viewDidDisappear(animated)
    }
    
    deinit {
        mapView.delegate = nil
        mapView.removeFromSuperview()
    }
}

fileprivate extension MapViewController {
    
}
