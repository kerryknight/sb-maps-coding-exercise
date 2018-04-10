//
//  RavenButton.swift
//  Raven
//
//  Created by Kerry Knight on 9/28/16.
//  Copyright © 2017 JOMO, Inc. All rights reserved.
//

import UIKit
import SnapKit

@IBDesignable
// black button, gray text, and sets the correct font
public class RavenButton: UIButton {

    override public var isEnabled: Bool {
        didSet { updateStyle() }
    }

	override public var isHighlighted: Bool {
		didSet { updateStyle() }
	}
	
    override public var isSelected: Bool {
        didSet { updateStyle() }
    }

    func updateStyle() {
        backgroundColor = isEnabled ? .primaryGreen() : .lightGray()
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
            print("Warning, RavenButton instance '\(String(describing: currentTitle))' should be configured as 'Custom', not \(buttonType)")
        }

        updateStyle()
    }

    func sharedSetup() {
        titleLabel?.font = UIFont.mediumFont(13)
        titleLabel?.adjustsFontSizeToFitWidth = true
        titleLabel?.minimumScaleFactor = 0.5
        titleLabel?.numberOfLines = 1
        setTitleColor(.white, for: .normal)
        setTitleColor(.gray(), for: .disabled)
        updateStyle()
    }

    public override func titleRect(forContentRect contentRect: CGRect) -> CGRect {
        var titleRect = super.titleRect(forContentRect: contentRect)
        let delta: CGFloat = 4
        titleRect.size.height += 2 * delta
        titleRect.origin.y -= delta
        return titleRect
    }
}

// clear background, no border, lighter font weight
public class ClearButton: RavenButton {
	override func updateStyle() {
		backgroundColor = .clear
	}
	
	override func sharedSetup() {
		super.sharedSetup()
		setTitleColor(.mediumGray(), for: .normal)
		setTitleColor(.darkGray(), for: .highlighted)
		setTitleColor(.clear, for: .disabled)
		titleLabel?.font = UIFont.mediumFont(12)
	}
}

public class SpinnerButton: RavenButton {
    public let spinner = UIActivityIndicatorView(activityIndicatorStyle: .gray)
    var baseColor: UIColor = UIColor.white {
        didSet {
            backgroundColor = baseColor
        }
    }
    
    override func updateStyle() {
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
        layer.cornerRadius = 4
        addSubview(spinner)
        
        spinner.snp.makeConstraints { make in
            make.center.equalTo(self)
        }
    }
}

// light gray background, dark gray text
public class LightButton: RavenButton {

    override func updateStyle() {
        backgroundColor = isEnabled ? .lightGray() : .gray()
    }

    override func sharedSetup() {
        super.sharedSetup()
        setTitleColor(.gray(), for: .normal)
        setTitleColor(.gray(), for: .highlighted)
        setTitleColor(.mediumGray(), for: .disabled)
    }
}

// light navy button, navy text
public class LightPrimaryColorButton: RavenButton {
    override func updateStyle() {
        if !isEnabled {
            backgroundColor = .lightGray()
        }
        else if isHighlighted || isSelected {
            backgroundColor = .green()
        }
        else {
            backgroundColor = .primaryGreen()
        }
    }

    override func sharedSetup() {
        super.sharedSetup()
		titleLabel?.font = UIFont.mediumFont(13)
        setTitleColor(.white, for: .normal)
        layer.cornerRadius = 4
        updateStyle()
        setTitleColor(.lightGray(), for: .highlighted)
        setTitleColor(.lightGray(), for: .selected)
    }
}

// clear button, black text.  corners are either "fully" rounded (to match the
// height) or they can be set to any radius
public class RoundedButton: RavenButton {
	
	@IBInspectable
	var borderColor: UIColor? = .gray() {
        didSet {
            updateOutline()
        }
    }
	
    var cornerRadius: CGFloat? {
        didSet {
            setNeedsLayout()
        }
    }

    override public func sharedSetup() {
        super.sharedSetup()
        setTitleColor(.gray(), for: .normal)
        setTitleColor(.mediumGray(), for: .highlighted)
        setTitleColor(.gray(), for: .disabled)
        layer.borderWidth = 1
        updateStyle()
    }

    override func updateStyle() {
        backgroundColor = isEnabled ? .clear : .red()
        updateOutline()
    }

    func updateOutline() {
        if let borderColor = borderColor, isEnabled {
            layer.borderColor = borderColor.cgColor
        }
        else if borderColor != nil && !isEnabled {
            layer.borderColor = UIColor.red().cgColor
        }
        else {
            layer.borderColor = nil
        }
    }

    override public func layoutSubviews() {
        super.layoutSubviews()

        if let cornerRadius = cornerRadius {
            layer.cornerRadius = cornerRadius
        }
        else {
            layer.cornerRadius = min(frame.height, frame.width) / 2
        }
    }
}

// gray background with dark gray text
public class RoundedGrayButton: RoundedButton {
    override public func sharedSetup() {
        super.sharedSetup()
        borderColor = .white
        cornerRadius = 4
        setTitleColor(.mediumGray(), for: .normal)
        setTitleColor(.mediumGray(), for: .highlighted)
    }
	
	override func updateStyle() {
		if !isEnabled {
			backgroundColor = UIColor.lightGray().lighter(by: 20.0)
		}
		else if isHighlighted {
			backgroundColor = .gray()
		}
		else {
			backgroundColor = .lightGray()
		}
	}
}

// green background, white text.
public class PrimaryColorButton: RavenButton {
    override func sharedSetup() {
        super.sharedSetup()
        setTitleColor(.white, for: .normal)
        layer.cornerRadius = 4
        updateStyle()
    }
	
	override func updateStyle() {
		if !isEnabled {
			backgroundColor = .lightGray()
		}
		else if isHighlighted {
			backgroundColor = .green()
		}
		else {
			backgroundColor = .primaryGreen()
		}
	}
}

public class FacebookBlueButton: RavenButton {
    override func sharedSetup() {
        super.sharedSetup()
        setTitleColor(.white, for: .normal)
        layer.cornerRadius = 4
        updateStyle()
    }
    
    override func updateStyle() {
        backgroundColor = .facebookBlue()
        alpha = 1.0
        
        if !isEnabled {
            backgroundColor = .lightGray()
        }
        else if isHighlighted {
            alpha = 0.9
        }
    }
}

// black background, white text, white border
public class BlackButton: RoundedButton {
    override public func sharedSetup() {
        super.sharedSetup()
        setTitleColor(.white, for: .normal)
        setTitleColor(.gray(), for: .highlighted)
        borderColor = .white
        cornerRadius = 2
        layer.borderWidth = 2
        updateStyle()
    }
    
    override func updateStyle() {
        backgroundColor = .black
    }
}
