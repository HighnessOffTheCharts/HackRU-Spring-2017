//
//  GameScene.swift
//  FolledoPong
//
//  Created by Samuel Folledo on 12/4/16.
//  Copyright © 2016 Samuel Folledo. All rights reserved.
//

import SpriteKit
import GameplayKit

let BallCategoryName = "ball"
let PaddleCategoryName = "paddle"
let BlockCategoryName = "block"
let GameMessageName = "gameMessage"

let BallCategory   : UInt32 = 0x1 << 0
let BottomCategory : UInt32 = 0x1 << 1
let BlockCategory  : UInt32 = 0x1 << 2
let PaddleCategory : UInt32 = 0x1 << 3
let BorderCategory : UInt32 = 0x1 << 4



class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var fingerOnPlayer1 = false
    var fingerOnPlayer2 = false
    
//    var energyBall = SKSpriteNode()
    
    var ball = SKSpriteNode()
    var player2Paddle = SKSpriteNode()
    var player1Paddle = SKSpriteNode()
    var gameBG = SKSpriteNode()
    
//    var mainBoost = SKSpriteNode()
    
    var score1: Int = 0
    var score2: Int = 0
    
    var player1Score = SKLabelNode()
    var player2Score = SKLabelNode()
    
    var ballSpeedX:Int = 200
    var ballSpeedY:Int = 200
    
    let gameOverScore:Int = 10
    
    override func didMove(to view: SKView) {
        
        startGame()
        
//        energyBall = self.childNode(withName: "energyBall") as! SKSpriteNode
        
        ball = self.childNode(withName: "ball") as! SKSpriteNode
        player2Paddle = self.childNode(withName: "player2Paddle") as! SKSpriteNode
        player1Paddle = self.childNode(withName: "player1Paddle") as! SKSpriteNode
        gameBG = self.childNode(withName: "gameBG") as! SKSpriteNode
        
//        mainBoost = self.childNode(withName: "mainBoost") as! SKSpriteNode
        
        player1Score = self.childNode(withName: "player1Score") as! SKLabelNode
//        player1Score = SKLabelNode(fontNamed: "Impact")
//        player1Score.text = "0"
        player2Score = self.childNode(withName: "player2Score") as! SKLabelNode
//        player2Score = SKLabelNode(fontNamed: "Impact")
//        player2Score.text = "0"
        
        //add impulse on the ball so it starts moving when the game starts
        ball.physicsBody?.applyImpulse(CGVector(dx:ballSpeedX , dy:ballSpeedY))
        
        //borders
        let borderBody = SKPhysicsBody(edgeLoopFrom: self.frame)
        borderBody.friction = 0
        self.physicsBody = borderBody
        
        //physicsWorld
        physicsWorld.gravity = CGVector(dx: 0.0, dy: 0.0)
        physicsWorld.contactDelegate = self
                
        
        
        
    }
    
    //startGame
    func startGame(){
        score1 = 0
        score2 = 0
    }
    
    
    
    //addScore
    func addScore(PlayerWhoWon: SKSpriteNode){
        //puts the ball back to the y=0 and random x position
        ball.position = CGPoint(x: CGFloat(randomNumber(range: -360 ... 360)), y: 0)
        //resets the ball's impulse/velocity
        ball.physicsBody?.velocity = CGVector(dx: 0.5 , dy: 0.5)
        
        
        var actionArray = [SKAction]()
    
        var gameOverScore:Int = 10
        var point: Int = 1
//        if UserDefaults.standard.bool(forKey: "hard"){
//            ballSpeedX = 36
//            ballSpeedY = 36
//            gameOverScore = 24
//            point = 2
//        }
        
        
        if PlayerWhoWon == player1Paddle{
            score1 += point
            ball.physicsBody?.applyImpulse(CGVector(dx:ballSpeedX , dy:ballSpeedY))
        }
        else if PlayerWhoWon == player2Paddle{
            score2 += point
            ball.physicsBody?.applyImpulse(CGVector(dx:-ballSpeedX , dy:-ballSpeedY))
        }
        
        //assign enemyScore.text and mainScore.text to their corresponding score[0,0]
        player2Score.text = "\(score2)"
        player1Score.text = "\(score1)"
        
        
        
        actionArray.append(SKAction.run{
            if self.score1 == gameOverScore{
                let transition = SKTransition.flipHorizontal(withDuration: 0.5)
                let gameOver = SKScene(fileNamed: "GameOverScene") as! GameOverScene
                self.view?.presentScene(gameOver, transition: transition)
//                gameOver.enemyLabel.text = "YOU FUCKING LOSER!!!"
//                gameOver.mainScoreLabel.text = "Score: \(self.score1)"
//                gameOver.mainLabel.text = "YOU LUCKY WINNER!"
//                gameOver.enemyScoreLabel.text = "Score: \(self.score2)"
                
            }else if self.score2 == gameOverScore{
                let transition = SKTransition.flipHorizontal(withDuration: 0.5)
                let gameOver = SKScene(fileNamed: "GameOverScene") as! GameOverScene
                self.view?.presentScene(gameOver, transition: transition)
//                gameOver.enemyLabel.text = "YOU WINNER BIC BOIII"
//                gameOver.score2GG = self.score2
//                gameOver.mainLabel.text = "YOU FUCKING PIECE OF SHIT!!"
//                gameOver.score1GG = self.score1
                //                gameOver.mainScoreLabel.text = "\(self.score1)"
                //                gameOver.enemyScoreLabel.text = "\(self.score2)"
            }
        })
        
        
        //make a run function on the alien to pass allong actionArray
        ball.run(SKAction.sequence(actionArray))
        
    }
    
    
    //randOmNumber generator
    func randomNumber(range: ClosedRange<Int> = -800...800) -> Int {
        let min = range.lowerBound
        let max = range.upperBound
        return Int(arc4random_uniform(UInt32(1 + max - min))) + min
    }
    
    
    //touchesBegan
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        
        let mainDelay:Double = 0.0
//        if UserDefaults.standard.bool(forKey: "hard"){
//            mainDelay = 0.24
//        }
        
        for touch in touches{
            
//            if touch.location.y >> 0 { //player2 touches
//                let location = touch.location(in: self)
//                player1Paddle.run(SKAction.moveTo(x: location.x , duration: mainDelay))
//                
//            }
//            else if touch.location.y <= 0{ //player1 touches
//                let location = touch.location(in: self)
//                player1Paddle.run(SKAction.moveTo(x: location.x , duration: mainDelay))
//                
//            }
//            else {
//                print("No touch was done")
//            }
//            
//            touches.anyObject()
            
            let location = touch.location(in: self)
            player1Paddle.run(SKAction.moveTo(x: location.x , duration: mainDelay))
//            mainBoost.run(SKAction.moveTo(x: location.x , duration: mainDelay))
        }
        
//        if ball.position.y == mainBoost.position.y && ball.position.x == mainBoost.position.x {
            //dont let the ball move if it equals the mainBoost's position
//            ball.physicsBody?.applyImpulse(CGVector(dx:0 , dy:0))
        
    }
    
    
    //touchesMoved
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        //copy pasted from touchesBegan
        
        
//        var mainDelay:Double = 0.2
//        if UserDefaults.standard.bool(forKey: "hard"){
//            mainDelay = 0.24
//        }
        
        for touch in touches{
            let location = touch.location(in: self)
            player1Paddle.run(SKAction.moveTo(x: location.x , duration: 0))
//            mainBoost.run(SKAction.moveTo(x: location.x , duration: mainDelay))
        }
        
        
//        if ball.position.y == mainBoost.position.y && ball.position.x == mainBoost.position.x {
//            //dont let the ball move if it equals the mainBoost's position
//            ball.physicsBody?.applyImpulse(CGVector(dx:0 , dy:0))
//            
//        }
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
//        var ballSpeedX:Int = 24
//        var ballSpeedY:Int = 24
//        if UserDefaults.standard.bool(forKey: "hard"){
//            ballSpeedX = 36
//            ballSpeedY = 36
//        }
        
        var mainDelay:Double = 0.0
//        if UserDefaults.standard.bool(forKey: "hard"){
//            mainDelay = 0.24
//        }
        for touch in touches{
            let location = touch.location(in: self)
            player1Paddle.run(SKAction.moveTo(x: location.x , duration: mainDelay))
//            mainBoost.run(SKAction.moveTo(x: location.x , duration: mainDelay))
        }
        
        if ball.position.y == player1Paddle.position.y && ball.position.x == player1Paddle.position.x {
            //dont let the ball move if it equals the mainBoost's position
            ball.physicsBody?.applyImpulse(CGVector(dx:ballSpeedX, dy:ballSpeedY))
            
            if ball.position.y == player2Paddle.position.y && ball.position.x == player2Paddle.position.x {
                ball.physicsBody?.applyImpulse(CGVector(dx:ballSpeedX, dy:ballSpeedY))
            }
        }
    }
    
    
//    func energyAdd(){
//        
//        print(" ")
//        
//    }
//    
//    func addRocks(){
//        
//        let rocks = SKSpriteNode(imageNamed: "rocks")
//        let minY = -250
//        let maxY = 250
//        let rangeY = maxY - minY
//        
//        let actualY = CGFloat(arc4random()).truncatingRemainder(dividingBy: rangeY) + minY
//        
//        let left = arc4random() % 2
//        let actualX = (left == 0) ? -rocks.size.width / 2 : size.width + rocks.size.width / 2
//        
//        rocks.position = CGPoint(x: actualX, y: actualY)
//        rocks.name = "rocks"
//        rocks.zPosition = 1
//        addChild(rocks)
//        
//        let minDuration = 4.0
//        let maxDuration = 6.0
//        let rangeDuration = maxDuration - minDuration
//        let actualDuration = Double(arc4random()).truncatingRemainder(dividingBy: rangeDuration) + minDuration
//        
//        let actionMove = SKAction.move(to: CGPoint(x: size.width / 2, y: actualY), duration: actualDuration)
//        let actionMoveDone = SKAction.removeFromParent()
//        
//        //hitAction
//        let hitAction = SKAction.run({
////            if self.life > 0 {
////                self.life -= 1
////            }
////            self.livesLabel.text = "Lives: \(Int(self.life))"
//            
//            let blink = SKAction.sequence([SKAction.fadeOut(withDuration: 0.1),
//                                           SKAction.fadeIn(withDuration: 0.1)])
//            
////            let checkGameOverAction = SKAction.run({
////                if self.life <= 0 {
////                    let transition = SKTransition.fade(withDuration: 1.0)
////                    let gameOverScene = GameOverScene(size: self.size)
////                    self.view?.presentScene(gameOverScene, transition: transition)
////                }
////            })
////            self.lowerTorso.run(SKAction.sequence([blink, blink, checkGameOverAction]))
//        })
//        
//        rocks.run(SKAction.sequence([actionMove, hitAction, actionMoveDone]))
//        
//        let angle = left == 0 ? CGFloat(-90).degreesToRadians() : CGFloat(90).degreesToRadians()
//        let rotate = SKAction.repeatForever(SKAction.rotate(byAngle: angle, duration: 0.2))
//        rocks.run(SKAction.repeatForever(rotate))
//        
//        
//    }
    
    
    override func update(_ currentTime: TimeInterval) {
        
        //have the enemy paddle move with the ball's x-position with the ball's x-position with a delay of 1.0 seconds
        //harder
        var enemyDelay:Double = 0.2
//        if UserDefaults.standard.bool(forKey: "hard"){
//            enemyDelay = 0.12
//        }
        
        player2Paddle.run(SKAction.moveTo(x: ball.position.x , duration: enemyDelay))
        
        //checks ball's y position
        if ball.position.y <= player1Paddle.position.y - 20{
            addScore(PlayerWhoWon: player2Paddle)
        }
        else if ball.position.y >= player2Paddle.position.y + 20{
            addScore(PlayerWhoWon: player1Paddle)
        }
    }
}
