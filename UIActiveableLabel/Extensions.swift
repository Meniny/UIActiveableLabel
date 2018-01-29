//
//  Extensions.swift
//  UIActiveableLabel
//
//  Created by Elias Abel on 04/09/16.
//  Copyright © 2016 Meniny Lab. All rights reserved.
//

import Foundation

extension String {
    internal func trim(to maximumCharacters: Int) -> String {
        return "\(self[..<index(startIndex, offsetBy: maximumCharacters)])" + "..."
    }
}
