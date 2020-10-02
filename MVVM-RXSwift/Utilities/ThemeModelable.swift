//
//  ThemeModelable.swift
//  MVVM-RXSwift
//
//  Created by Nitkarsh Gupta on 02/10/20.
//

import UIKit

@objc
protocol ThemeApplicable {
    @objc func themeDidChange()
}

enum Font: Int {
    case firaSans, notoSans
}

class Theme {
    private init() {}
    
    static let shared = Theme()
    static let notification = Notification.Name(rawValue: "themeDidChange")
    
    var currentFont: Font = .firaSans
    
    let fonts = [["FiraSans-Regular", "NotoSans-Regular"],
                 ["FiraSans-SemiBold", "NotoSans-Bold"]]
    
    @discardableResult
    func changeTheme(to font: Font) -> Theme{
        self.currentFont = font
        NotificationCenter.default.post(name: Theme.notification, object: nil)
        return self
    }
    
    func textForFont(style: UIFont.TextStyle, size: CGFloat) -> UIFont {
        if style == .headline {
            return UIFont(name: fonts[1][currentFont.rawValue], size: size)!
        } else {
            return UIFont(name: fonts[0][currentFont.rawValue], size: size)!
        }
    }
    
}
