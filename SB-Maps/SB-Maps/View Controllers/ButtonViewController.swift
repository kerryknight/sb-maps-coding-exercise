//
//  ViewController.swift
//  SB-Maps
//
//  Created by Kerry Knight on 4/10/18.
//  Copyright © 2018 Kerry Knight. All rights reserved.
//

import UIKit
import SnapKit

class ButtonViewController: UIViewController {
    let workButton = SpinnerButton()
    let vacationButton = SpinnerButton()
    
    struct Size {
        static let buttonHeight: CGFloat = 44
        static let buttonInset: CGFloat = Constants.Geometry.padding
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        configureButtons()
    }
    
    // MARK: - Private Methods
    func configureButtons() {
        view.addSubview(workButton)
        view.addSubview(vacationButton)
        
        workButton.setTitle(InterfaceString.ButtonView.Work, for: .normal)
        vacationButton.setTitle(InterfaceString.ButtonView.Vacation, for: .normal)
        
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
}

