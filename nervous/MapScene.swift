//
//  MapScene.swift
//  nervous
//
//  Created by Sam Sulaimanov on 20/09/14.
//  Copyright (c) 2014 ethz. All rights reserved.
//

import SpriteKit


class GameScene: SKScene {
    override func didMoveToView(view: SKView) {
        
        self.physicsWorld.gravity = CGVector(0,0)
        
        
        for i in 1...10 {
            let sprite: SKSpriteNode = SKSpriteNode(imageNamed: "ball.png")
            sprite.position = CGPointMake(CGRectGetMidX(self.frame)+CGFloat(i), CGRectGetMidY(self.frame))

            sprite.physicsBody = SKPhysicsBody(circleOfRadius: 10)
            sprite.physicsBody?.dynamic = true
            sprite.physicsBody?.restitution = 2
            sprite.physicsBody?.affectedByGravity = true
            sprite.physicsBody?.allowsRotation = true

            
            self.addChild(sprite)
            
        }
    }
}