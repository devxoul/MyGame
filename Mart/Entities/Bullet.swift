//
//  Bullet.swift
//  Mart
//
//  Created by 전수열 on 11/15/15.
//  Copyright © 2015 Suyeol Jeon. All rights reserved.
//

import SpriteKit

class Bullet: SKShapeNode {

    let origin: CGPoint
    var velocity: CGFloat = 10
    var range: CGFloat = 500
    var damage: Int = 10

    init(origin: CGPoint) {
        self.origin = origin
        super.init()
        self.position = origin
        self.path = UIBezierPath(rect: CGRect(x: 0, y: 0, width: 3, height: 5)).CGPath
        self.fillColor = UIColor.orangeColor()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
