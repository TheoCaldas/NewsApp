//
//  UIColor.swift
//  NewsApp
//
//  Created by Theo Necyk Agner Caldas on 14/05/24.
//

import UIKit

extension UIColor {
    
    convenience init(r: CGFloat, g: CGFloat, b: CGFloat, a: CGFloat) {
        let max: CGFloat = 255.0
        self.init(red: r / max, green: g / max, blue: b / max, alpha: a)
    }
    
    static let background = UIColor(r: 30, g: 30, b: 30, a: 1)
    static let primary = UIColor(r: 255, g: 255, b: 255, a: 1)
    static let secondary = UIColor(r: 211, g: 211, b: 211, a: 1)
    static let tertiary = UIColor(r: 217, g: 217, b: 217, a: 0.42)
    static let cellBackground = UIColor(r: 0, g: 0, b: 0, a: 0.9)
}
