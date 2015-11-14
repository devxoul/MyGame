//
//  Entity.swift
//  Mart
//
//  Created by 전수열 on 11/15/15.
//  Copyright © 2015 Suyeol Jeon. All rights reserved.
//

import SpriteKit

extension SKNode {

    var rotation: CGFloat {
        get {
            return self.zRotation + CGFloat(M_PI_2)
        }
        set {
            self.zRotation = newValue - CGFloat(M_PI_2)
        }
    }

}
