//
//  NSAttributedStringTransformer.swift
//  bikeFinder
//
//  Created by Lane Faison on 1/23/21.
//

import UIKit
import CoreData

@objc(NSAttributedStringTransformer)
class NSAttributedStringTransformer: NSSecureUnarchiveFromDataTransformer {
    override class var allowedTopLevelClasses: [AnyClass] {
        return super.allowedTopLevelClasses + [NSAttributedString.self]
    }
}
