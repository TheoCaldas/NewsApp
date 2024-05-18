//
//  UISearchBar.swift
//  NewsApp
//
//  Created by Theo Necyk Agner Caldas on 14/05/24.
//

import UIKit

extension UISearchBar{
    
    func setColors(background: UIColor, bar: UIColor, textIcons: UIColor){
        barTintColor = background
        searchTextField.backgroundColor = bar
        
        searchTextField.tintColor = textIcons
        searchTextField.textColor = textIcons
        searchTextField.leftView?.tintColor = textIcons
        
        if let clearButton = searchTextField.value(forKey: "_clearButton") as? UIButton {
            let templateImage = clearButton.imageView?.image?.withRenderingMode(.alwaysTemplate)
            clearButton.setImage(templateImage, for: [])
            clearButton.tintColor = textIcons
        }
    }
    
    func setPlaceholder(_ text: String, color: UIColor){
        searchTextField.attributedPlaceholder = NSAttributedString.init(string: text, attributes: [NSAttributedString.Key.foregroundColor:color])
    }
}
