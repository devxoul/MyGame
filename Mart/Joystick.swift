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

    private(set) var angle = CGFloat(M_PI_2)
    private(set) var value = CGFloat(0)

    var dx: CGFloat {
        return self.value * cos(self.angle)
    }
    var dy: CGFloat {
        return self.value * sin(self.angle)
    }

    private(set) var pressed = false
    

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

    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.pressed = true
    }

    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        guard let touch = touches.first else {
            return
        }
        self.button.position = touch.locationInNode(self)

        let buttonDistance = distance(self.button.position, .zero)
        let totalDistance = (self.background.frame.width - self.button.frame.width) / 2
        self.value = min(1, buttonDistance / totalDistance)
        self.angle = atan2(self.button.position.y, self.button.position.x)
    }

    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.button.position = .zero
        self.value = 0
        self.pressed = false
    }

    override func touchesCancelled(touches: Set<UITouch>?, withEvent event: UIEvent?) {
        self.pressed = false
    }

}
