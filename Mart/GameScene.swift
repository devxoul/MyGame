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

    let moveJoystick = Joystick().then {
        $0.position.x = 100
        $0.position.y = 100
    }
    let attackJoystick = Joystick().then {
        $0.position.y = 100
    }

    let hero = Hero()
    var enemies = Set<Enemy>()
    var bullets = Set<Bullet>()

    var enemySpawner: NSTimer?
    var lastShootTime: NSTimeInterval = 0


    override func didMoveToView(view: SKView) {
        self.hero.position = CGPoint(x: self.frame.midX, y: self.frame.midY)

        // camera
        self.camera = self.cam
        self.addChild(self.cam)

        // interface
        self.cam.addChild(self.interfaceLayer)
        self.interfaceLayer.position = CGPoint(x: -self.size.width / 2, y: -self.size.height / 2)
        self.attackJoystick.position.x = self.frame.width - 100
        self.interfaceLayer.addChild(self.moveJoystick)
        self.interfaceLayer.addChild(self.attackJoystick)

        // game
        self.addChild(self.hero)

        self.enemySpawner = NSTimer.scheduledTimerWithTimeInterval(1,
            target: self,
            selector: "spawnEnemy",
            userInfo: nil,
            repeats: true
        )
    }

    override func update(currentTime: NSTimeInterval) {
        self.hero.rotation = self.attackJoystick.angle
        self.hero.position.x += self.hero.velocity * self.moveJoystick.dx
        self.hero.position.y += self.hero.velocity * self.moveJoystick.dy
        self.cam.position.x += 0.1 * (self.hero.position.x - self.cam.position.x)
        self.cam.position.y += 0.1 * (self.hero.position.y - self.cam.position.y)

        if currentTime % 1 == 0 {
            self.spawnEnemy()
        }

        for enemy in self.enemies {
            let dy = self.hero.position.y - enemy.position.y
            let dx = self.hero.position.x - enemy.position.x
            enemy.rotation = atan2(dy, dx)
            enemy.position.x += enemy.velocity * cos(enemy.rotation)
            enemy.position.y += enemy.velocity * sin(enemy.rotation)

            if distance(self.hero, enemy) <= 10 {
                enemy.removeFromParent()
                self.enemies.remove(enemy)
            }
        }

        if self.attackJoystick.pressed && currentTime > self.lastShootTime + 1 / self.hero.shootRate {
            self.shoot(currentTime)
        }

        for bullet in self.bullets {
            bullet.position.x += bullet.velocity * cos(bullet.rotation)
            bullet.position.y += bullet.velocity * sin(bullet.rotation)

            let hitEnemy = self.enemyHitByBullet(bullet)
            if let enemy = hitEnemy {
                enemy.hp -= bullet.damage
                if enemy.hp <= 0 {
                    enemy.removeFromParent()
                    self.enemies.remove(enemy)
                }

                guard let spark = SKEmitterNode(fileNamed: "Spark") else {
                    return
                }
                spark.position = bullet.position
                spark.alpha = 0.5
                spark.zPosition = 100
                spark.runAction(SKAction.sequence([.fadeAlphaTo(0, duration: 0.3), .removeFromParent()]))
                self.addChild(spark)
            }

            if hitEnemy != nil || distance(bullet.origin, bullet.position) > bullet.range {
                bullet.removeFromParent()
                self.bullets.remove(bullet)
            }
        }
    }

    func shoot(currentTime: NSTimeInterval) {
        let bullet = Bullet(origin: self.hero.position)
        bullet.rotation = self.hero.rotation
        self.addChild(bullet)
        self.bullets.insert(bullet)
        self.lastShootTime = currentTime
    }

    dynamic func spawnEnemy() {
        let enemy = Enemy()
        self.addChild(enemy)
        self.enemies.insert(enemy)

        let angle = randomf() * 2 * CGFloat(M_PI)
        let distance: CGFloat = 400
        enemy.position.x = self.hero.position.x + distance * cos(angle)
        enemy.position.y = self.hero.position.y + distance * sin(angle)
    }

    func enemyHitByBullet(bullet: Bullet) -> Enemy? {
        for enemy in self.enemies {
            if CGRectIntersectsRect(bullet.frame, enemy.frame) {
                return enemy
            }
        }
        return nil
    }

}
