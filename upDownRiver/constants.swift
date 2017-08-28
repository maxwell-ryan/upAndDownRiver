//
//  constants.swift
//  upDownRiver
//
//  Created by maxwell on 8/23/17.
//  Copyright © 2017 bergerMacPro. All rights reserved.
//

import Foundation
import UIKit

extension String {
    var hex: Int? {
        return Int(self, radix: 16)
    }
}

extension UIColor {
    convenience init(hex: Int) {
        self.init(hex: hex, a: 1.0)
    }
    
    convenience init(hex: Int, a: CGFloat) {
        self.init(r: (hex >> 16) & 0xff, g: (hex >> 8) & 0xff, b: hex & 0xff, a: a)
    }
    
    convenience init(r: Int, g: Int, b: Int) {
        self.init(r: r, g: g, b: b, a: 1.0)
    }
    
    convenience init(r: Int, g: Int, b: Int, a: CGFloat) {
        self.init(red: CGFloat(r) / 255.0, green: CGFloat(g) / 255.0, blue: CGFloat(b) / 255.0, alpha: a)
    }
    
    convenience init?(hexString: String) {
        guard let hex = hexString.hex else {
            return nil
        }
        self.init(hex: hex)
    }
}

struct colorScheme {
    static let blueberry: UIColor = UIColor(hex: 0x6B7A8F)
    static let apricot = UIColor(hex: 0xF7882F)
    static let citrus = UIColor(hex: 0xF7C331)
    static let appleCore = UIColor(hex: 0xDCC7AA)
}
