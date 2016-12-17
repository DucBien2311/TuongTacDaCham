//
//  ViewController.swift
//  lolApp
//
//  Created by NguyenDucBien on 12/16/16.
//  Copyright © 2016 NguyenDucBien. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, UIGestureRecognizerDelegate {
    
    
    var audioPlayer = AVAudioPlayer()
    var ball = UIImageView()
    var radians = CGFloat()
    var ballRadious: CGFloat = 32.0
    var right: Bool = true
    var direct: CGFloat = 1
    var timer =  NSTimer()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addBall()
        playSong()
        startTime()
        
        
        let tapGeture = UITapGestureRecognizer(target: self, action: #selector(ViewController.onTap(_:)))
        self.view.addGestureRecognizer(tapGeture)
        
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(ViewController.panBall(_:)))
        panGesture.delegate = self
        ball.userInteractionEnabled = true
        ball.addGestureRecognizer(panGesture)
        
    }
    
    func startTime () {
        timer = NSTimer.scheduledTimerWithTimeInterval(0.02, target: self, selector: #selector(changeDirection), userInfo: nil, repeats: true)
    }
    
    
    func resetTimer()
    {
        timer.invalidate()
    }
    
    
    func panBall (panGesture: UIPanGestureRecognizer? = nil) {
        if (panGesture!.state == .Began || panGesture!.state == .Changed)
        {
            let point = panGesture!.locationInView(ball.superview)
            ball.center = point
            resetTimer()
        }else{
            startTime()
        }
    }
    
    
    func onTap (tapGeture: UITapGestureRecognizer)
    {
        let point = tapGeture.locationInView(self.view)
        let snowFlake = UIImageView(image: UIImage(named: "snowFlake.png"))
        snowFlake.bounds.size = CGSize(width: 20, height: 20)
        snowFlake.center = point
        self.view.addSubview(snowFlake)
    }
    
    func addBall()
    {
        let mainViewSize = self.view.bounds.size
        ball = UIImageView(image: UIImage(named: "ball"))
        ball.center = CGPointMake(ballRadious,mainViewSize.height * 0.5)
        self.view.addSubview(ball)
        
    }
    
    
    func rollBall()
    {
        var deltaAngle: CGFloat = 0.1
        radians = radians + deltaAngle
        ball.transform = CGAffineTransformMakeRotation(radians)
        
        
        self.ball.center = CGPointMake(self.ball.center.x + ballRadious * deltaAngle, self.ball.center.y + (ballRadious * deltaAngle) * direct )
        
        
        if ball.center.x + 32 > self.view.bounds.width
        {
            deltaAngle = -0.1
            right = false
        }
    }
    
    
    func ballRoll()
    {
        var deltaAngle: CGFloat = -0.1
        radians = radians + deltaAngle
        ball.transform = CGAffineTransformMakeRotation(radians)
        
        
        self.ball.center = CGPointMake(self.ball.center.x + ballRadious * deltaAngle, self.ball.center.y - (ballRadious * deltaAngle) * direct )
        
        
        if ball.center.x - 32 < 0
        {
            deltaAngle = 0.1
            right = true
        }
    }
    
    
    func changeDirection()
    {
        if right
        {
            changeDirect()
            rollBall()
        }
        else
        {
            changeDirect()
            ballRoll()
        }
    }
    
    
    func changeDirect()
    {
        if ball.center.y + 32 > self.view.bounds.height
        {
            direct = -1
        }
        else if ball.center.y - 32 < 0        {
            direct = 1
        }
    }
    
    func playSong()
    {
        let filePath = NSBundle.mainBundle().pathForResource("LC", ofType: ".mp3")
        let url = NSURL(fileURLWithPath: filePath!)
        audioPlayer = try! AVAudioPlayer(contentsOfURL: url)
        audioPlayer.prepareToPlay()
        audioPlayer.play()
    }
    
}

