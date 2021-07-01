//
//  UISearchBar.swift
//  santaApp
//
//  Created by 노영재 on 2021/07/01.
//

import UIKit

extension UISearchBar {
    
    func setPlaceholderColor(_ color: UIColor, _ searchBar : UISearchBar) {
        if let textfield = searchBar.value(forKey: "searchField") as? UITextField {
            textfield.attributedPlaceholder = NSAttributedString(string: textfield.placeholder ?? "", attributes: [NSAttributedString.Key.foregroundColor : color])
        }
    }
    
    func setTextFieldColor(_ color: UIColor, _ searchBar: UISearchBar) {
        if let textfield = searchBar.value(forKey: "searchField") as? UITextField {
            textfield.backgroundColor = color
        }
    }
}
