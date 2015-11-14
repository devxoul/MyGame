//
//  Then.swift
//  StyleShare
//
//  Created by 전수열 on 9/30/15.
//  Copyright © 2015 StyleShare Inc. All rights reserved.
//

import Foundation

public protocol Then {}
extension NSObject: Then {}

extension Then {

    /// Initialize 후에 속성들을 설정하는 코드를 블럭으로 사용할 수 있도록 해줍니다. 코딩 양을 획기적으로 줄여줍니다.
    ///
    /// 예시:
    ///
    ///     let queue = NSOperationQueue().then {
    ///         $0.maxConcurrentOperationCount = 1
    ///     }
    public func then(block: Self -> Void) -> Self {
        block(self)
        return self
    }

}
