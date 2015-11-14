//
//  GameScene.swift
//  Mart
//
//  Created by 전수열 on 11/15/15.
//  Copyright (c) 2015 Suyeol Jeon. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {

    let cam = SKCameraNode()
    let interfaceLayer = SKNode()
    let joystick = Joystick().then {
        $0.position.x = 100
        $0.position.y = 100
    }

    let hero = Hero()


    override func didMoveToView(view: SKView) {
        self.hero.position = CGPoint(x: self.frame.midX, y: self.frame.midY)

        // camera
        self.camera = self.cam
        self.addChild(self.cam)

        // interface
        self.cam.addChild(self.interfaceLayer)
        self.interfaceLayer.position = CGPoint(x: -self.size.width / 2, y: -self.size.height / 2)
        self.interfaceLayer.addChild(self.joystick)

        // game
        self.addChild(self.hero)
    }

    override func update(currentTime: NSTimeInterval) {
        self.hero.zRotation = self.joystick.angle
        self.hero.position.x += self.hero.velocity * self.joystick.x
        self.hero.position.y += self.hero.velocity * self.joystick.y
        self.cam.position.x += 0.1 * (self.hero.position.x - self.cam.position.x)
        self.cam.position.y += 0.1 * (self.hero.position.y - self.cam.position.y)
    }

}
