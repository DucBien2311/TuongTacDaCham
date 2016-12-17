//
//  Items.swift
//  lolApp
//
//  Created by NguyenDucBien on 12/16/16.
//  Copyright © 2016 NguyenDucBien. All rights reserved.
//

import UIKit

class Item: UIImageView, UIGestureRecognizerDelegate {
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setup()
    }
    
    func setup () {
        self.userInteractionEnabled = true
        
        self.multipleTouchEnabled = true
        
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(Item.onPan(_:)))
        self.addGestureRecognizer(panGesture)
        
//        panGesture.maximumNumberOfTouches = 1
//        panGesture.minimumNumberOfTouches = 1
        
        let pinchGesture = UIPinchGestureRecognizer(target: self, action: #selector(Item.pinchImage(_:)))
        self.addGestureRecognizer(pinchGesture)
        
        let rotateGesture = UIRotationGestureRecognizer(target: self, action: #selector(Item.rotateItems(_:)))
        rotateGesture.delegate = self
        self.addGestureRecognizer(rotateGesture)
    }
    
    func gestureRecognizer(gestureRecognizer:UIGestureRecognizer,
        shouldRecognizeSimultaneouslyWithGestureRecognizer:UIGestureRecognizer) -> Bool {
        return true
    }
    
    
    func onPan (panGesture: UIPanGestureRecognizer) {
        if (panGesture.state == .Began || panGesture.state == .Changed)
        {
            let point = panGesture.locationInView(self.superview)
            self.center = point
        }
    }
    
    func pinchImage(pinchGestureRecognizer: UIPinchGestureRecognizer) {
        if let view = pinchGestureRecognizer.view
        {
            view.transform = CGAffineTransformScale(view.transform, pinchGestureRecognizer.scale, pinchGestureRecognizer.scale)
            pinchGestureRecognizer.scale = 1
        }
    }
    
    func rotateItems (rotateGestureRecognizer: UIRotationGestureRecognizer) {
        if let view = rotateGestureRecognizer.view
        {
            view.transform = CGAffineTransformRotate(view.transform, rotateGestureRecognizer.rotation)
            rotateGestureRecognizer.rotation = 0
        }
    }
    
    
    
}
