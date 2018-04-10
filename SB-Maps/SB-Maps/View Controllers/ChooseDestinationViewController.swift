//
//  ViewController.swift
//  SB-Maps
//
//  Created by Kerry Knight on 4/10/18.
//  Copyright © 2018 Kerry Knight. All rights reserved.
//

import UIKit
import SnapKit

// MARK: - Life Cycle
class ChooseDestinationViewController: UIViewController {
    let workButton = Button()
    let vacationButton = Button()
    
    struct Size {
        static let buttonHeight: CGFloat = 44
        static let buttonInset: CGFloat = Constants.Geometry.padding
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        configureButtons()
    }
}

// MARK: - Private Methods
fileprivate extension ChooseDestinationViewController {
    func configureButtons() {
        view.addSubview(workButton)
        view.addSubview(vacationButton)
        
        workButton.setTitle(InterfaceString.Selection.Work, for: .normal)
        vacationButton.setTitle(InterfaceString.Selection.Vacation, for: .normal)
        
        workButton.tag = LocationSelection.newYork.rawValue
        vacationButton.tag = LocationSelection.cancun.rawValue
        
        workButton.addTarget(self, action: #selector(buttonTapped(button:)), for: .touchUpInside)
        vacationButton.addTarget(self, action: #selector(buttonTapped(button:)), for: .touchUpInside)
        
        workButton.snp.makeConstraints { make in
            make.bottom.equalTo(self.view.snp.centerY).offset(-(Size.buttonInset + Size.buttonHeight)/2)
            make.centerX.equalTo(self.view)
            make.height.equalTo(Size.buttonHeight)
            make.width.equalTo(self.view).offset(-2 * Size.buttonInset)
        }
        
        vacationButton.snp.makeConstraints { make in
            make.centerX.width.height.equalTo(workButton)
            make.top.equalTo(workButton.snp.bottom).offset(Size.buttonInset)
        }
    }
    
    @objc
    func buttonTapped(button: Button) {
        if let location = LocationSelection(rawValue: button.tag) {
            pushMapViewController(location: location)
        }
    }
    
    func pushMapViewController(location: LocationSelection) {
        let map = MapViewController(location: location)
        navigationController?.pushViewController(map, animated: true)
    }
}

