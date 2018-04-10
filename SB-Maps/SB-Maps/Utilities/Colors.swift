////
///  Colors.swift
//

import UIKit

private struct Colors {
    // grays
    static let lightGray = UIColor(hex: 0xF2F2F2)
    static let gray = UIColor(hex: 0xD2D4D3)
    
    // secondary palette
    static let darkCarolinaBlue = UIColor(hex: 0x3DB6E2)
    static let carolinaBlue = UIColor(hex: 0x71C6E5)
}

public extension UIColor {
    // grays
    class func lightGray() -> UIColor { return Colors.lightGray }
    class func gray() -> UIColor { return Colors.gray }
    
    // secondary palette
    class func darkCarolinaBlue() -> UIColor { return Colors.darkCarolinaBlue }
    class func carolinaBlue() -> UIColor { return Colors.carolinaBlue }
}
