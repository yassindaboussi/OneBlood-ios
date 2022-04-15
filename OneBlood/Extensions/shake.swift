//
//  shake.swift
//  OneBlood
//
//  Created by Mac2021 on 15/4/2022.
//

import Foundation
import UIKit
extension UIView{
    func shake(duration timeDuration: Double = 0.07, repeat countRepeat: Float = 3){
            let animation = CABasicAnimation(keyPath: "position")
            animation.duration = timeDuration
            animation.repeatCount = countRepeat
            animation.autoreverses = true
            animation.fromValue = NSValue(cgPoint: CGPoint(x: self.center.x - 10, y: self.center.y))
            animation.toValue = NSValue(cgPoint: CGPoint(x: self.center.x + 10, y: self.center.y))
            self.layer.add(animation, forKey: "position")
        }
}
