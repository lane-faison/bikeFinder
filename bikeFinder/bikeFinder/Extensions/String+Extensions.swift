//
//  String+Extensions.swift
//  bikeFinder
//
//  Created by Lane Faison on 1/26/21.
//

import UIKit

extension String {
    
    // Returns a flag emoji with country initials (ex. 'US' -> '🇺🇸 - US')
    func flag() -> String {
        let base : UInt32 = 127397
        var s = ""
        for v in self.unicodeScalars {
            s.unicodeScalars.append(UnicodeScalar(base + v.value)!)
        }
        return "\(String(s)) - \(self.uppercased())"
    }
}
