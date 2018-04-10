//
//  UIImage+Additions.swift
//

import UIKit
import CoreGraphics

extension UIImage {
	class func imageFromColor(_ color: UIColor) -> UIImage {
		let rect = CGRect(x: 0, y: 0, width: 1, height: 1)
		UIGraphicsBeginImageContext(rect.size);
		let context: CGContext = UIGraphicsGetCurrentContext()!;
		context.setFillColor(color.cgColor);
		context.fill(rect);
		let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()!;
		UIGraphicsEndImageContext();
		return image;
	}
}
