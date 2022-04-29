//
//  HexColor.swift
//  OneBlood
//
//  Created by Mac2021 on 29/4/2022.
//

import Foundation
import UIKit

extension UIColor {
    
    // Setup custom colours we can use throughout the app using hex values
    static let CustomMaron = UIColor(hex: 0x181838)
    static let CustomBlue = UIColor(hex: 0x381818)
    static let transparentBlack = UIColor(hex: 0x000000, a: 0.5)
    static let rgbRed = UIColor(red: 255, green: 0, blue: 0)
    
    // Create a UIColor from RGB
    convenience init(red: Int, green: Int, blue: Int, a: CGFloat = 1.0) {
        self.init(
            red: CGFloat(red) / 255.0,
            green: CGFloat(green) / 255.0,
            blue: CGFloat(blue) / 255.0,
            alpha: a
        )
    }
    
    // Create a UIColor from a hex value (E.g 0x000000)
    convenience init(hex: Int, a: CGFloat = 1.0) {
        self.init(
            red: (hex >> 16) & 0xFF,
            green: (hex >> 8) & 0xFF,
            blue: hex & 0xFF,
            a: a
        )
    }
}
