//
//  Enemy.swift
//  Mart
//
//  Created by 전수열 on 11/15/15.
//  Copyright © 2015 Suyeol Jeon. All rights reserved.
//

import SpriteKit

class Enemy: SKSpriteNode {

    var hp: Int = 100
    var velocity: CGFloat = 1

    convenience init() {
        self.init(imageNamed: "Spaceship")
        self.size = CGSize(width: 40, height: 40)
        self.velocity = randomf(1, 3)

        if let filter = CIFilter(name: "CIHueAdjust") {
            filter.setValue(2, forKey: "inputAngle")
            self.texture = self.texture?.textureByApplyingCIFilter(filter)
        }
    }
    
}
