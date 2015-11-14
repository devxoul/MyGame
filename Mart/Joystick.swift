//
//  Joystick.swift
//  Mart
//
//  Created by 전수열 on 11/15/15.
//  Copyright © 2015 Suyeol Jeon. All rights reserved.
//

import SpriteKit

class Joystick: SKNode {

    let background = SKShapeNode(circleOfRadius: 70)
    let button = SKShapeNode(circleOfRadius: 30)

    private(set) var angle: CGFloat = 0
    private(set) var value: CGFloat = 0

    var x: CGFloat {
        return self.value * cos(self.angle)
    }
    var y: CGFloat {
        return self.value * sin(self.angle)
    }
    

    override init() {
        super.init()
        self.userInteractionEnabled = true

        self.background.fillColor = UIColor.lightGrayColor().colorWithAlphaComponent(0.5)
        self.button.fillColor = UIColor.grayColor().colorWithAlphaComponent(0.8)

        self.addChild(self.background)
        self.addChild(self.button)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        guard let touch = touches.first else {
            return
        }
        self.button.position = touch.locationInNode(self)

        let buttonDistance = sqrt(pow(self.button.position.x, 2) + pow(self.button.position.y, 2))
        let totalDistance = (self.background.frame.width - self.button.frame.width) / 2
        self.value = min(1, buttonDistance / totalDistance)
        self.angle = atan2(self.button.position.y, self.button.position.x) - CGFloat(M_PI_2)
    }

    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.button.position = .zero
        self.value = 0
    }

}
