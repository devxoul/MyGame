//
//  Distance.swift
//  Mart
//
//  Created by 전수열 on 11/15/15.
//  Copyright © 2015 Suyeol Jeon. All rights reserved.
//

import SpriteKit

func distance(p1: CGPoint, _ p2: CGPoint) -> CGFloat {
    return sqrt(pow(p1.x - p2.x, 2) + pow(p1.y - p2.y, 2))
}

func distance(n1: SKNode, _ n2: SKNode) -> CGFloat {
    return distance(n1.position, n2.position)
}
