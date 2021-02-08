//
//  Strings+Extension.swift
//  Aswani
//
//  Created by Aswani on 11/26/20.
//  Copyright © 2020 Aswani. All rights reserved.
//

import Foundation

extension String {
     public func localized(withValue value: String = "") -> String {
        return String(format: NSLocalizedString(self, comment: "" ), value)
    }
}
