//
//  Hero.swift
//  Mart
//
//  Created by 전수열 on 11/15/15.
//  Copyright © 2015 Suyeol Jeon. All rights reserved.
//

import SpriteKit

class Hero: SKSpriteNode {

    var velocity: CGFloat = 3

    convenience init() {
        self.init(imageNamed: "Spaceship")
        self.size = CGSize(width: 40, height: 40)
    }

}
