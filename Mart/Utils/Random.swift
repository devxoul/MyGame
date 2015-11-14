//
//  Random.swift
//  Mart
//
//  Created by 전수열 on 11/15/15.
//  Copyright © 2015 Suyeol Jeon. All rights reserved.
//

import CoreGraphics

/// Returns a random `Int` from `(min..<max)`
func random(min: Int, _ max: Int) -> Int {
    return random() % (max - min) + min
}

/// Returns a random `CGFloat` from `(0..<1)`
func randomf() -> CGFloat {
    return CGFloat(random()) / CGFloat(INT_MAX)
}

/// Returns a random `CGFloat` from `(min..<max)`
func randomf(min: CGFloat, _ max: CGFloat) -> CGFloat {
    return randomf() % (max - min) + min
}
