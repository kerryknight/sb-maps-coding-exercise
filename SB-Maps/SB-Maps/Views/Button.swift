//
//  Button.swift
//  Button
//
//  Created by Kerry Knight on 9/28/16.
//

import UIKit
import SnapKit

@IBDesignable

public class Button: UIButton {
    override public var isEnabled: Bool {
        didSet { updateStyle() }
    }

	override public var isHighlighted: Bool {
		didSet { updateStyle() }
	}
	
    override public var isSelected: Bool {
        didSet { updateStyle() }
    }

    @IBInspectable
    var borderColor: UIColor? = .darkCarolinaBlue() {
        didSet {
            updateOutline()
        }
    }
    
    var cornerRadius: CGFloat? {
        didSet {
            setNeedsLayout()
        }
    }
    
    required override public init(frame: CGRect) {
        super.init(frame: frame)
        sharedSetup()
    }

    required public init?(coder: NSCoder) {
        super.init(coder: coder)
        sharedSetup()
    }

    public override func awakeFromNib() {
        super.awakeFromNib()

        if buttonType != .custom {
            print("Warning, Button instance '\(String(describing: currentTitle))' should be configured as 'Custom', not \(buttonType)")
        }

        updateStyle()
    }

    func sharedSetup() {
        titleLabel?.adjustsFontSizeToFitWidth = true
        titleLabel?.minimumScaleFactor = 0.5
        titleLabel?.numberOfLines = 1
        setTitleColor(.white, for: .normal)
        setTitleColor(.gray(), for: .disabled)
        layer.borderWidth = 1
        updateStyle()
    }
    
    func updateStyle() {
        backgroundColor = isEnabled ? .carolinaBlue() : .lightGray()
        updateOutline()
    }
    
    func updateOutline() {
        if let borderColor = borderColor, isEnabled {
            layer.borderColor = borderColor.cgColor
        }
        else if borderColor != nil && !isEnabled {
            layer.borderColor = UIColor.darkCarolinaBlue().cgColor
        }
        else {
            layer.borderColor = nil
        }
    }

    public override func titleRect(forContentRect contentRect: CGRect) -> CGRect {
        var titleRect = super.titleRect(forContentRect: contentRect)
        let delta: CGFloat = 4
        titleRect.size.height += 2 * delta
        titleRect.origin.y -= delta
        return titleRect
    }
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        
        if let cornerRadius = cornerRadius {
            layer.cornerRadius = cornerRadius
        }
        else {
            layer.cornerRadius = 8
        }
    }
}

public class SpinnerButton: Button {
    public let spinner = UIActivityIndicatorView(activityIndicatorStyle: .gray)
    var baseColor: UIColor = UIColor.carolinaBlue() {
        didSet {
            backgroundColor = baseColor
        }
    }
    
    override func updateStyle() {
        super.updateStyle()
        
        if isHighlighted || isSelected {
            backgroundColor = baseColor.adjust(by: -10)
        }
        else if !isEnabled {
            backgroundColor = .lightGray()
        }
        else {
            backgroundColor = baseColor
        }
    }
    
    override func sharedSetup() {
        super.sharedSetup()
        
        setTitleColor(.white, for: .normal)
        addSubview(spinner)
        
        spinner.snp.makeConstraints { make in
            make.center.equalTo(self)
        }
        
        updateStyle()
    }
}
