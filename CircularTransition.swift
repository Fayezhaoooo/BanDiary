//
//  CircularTransition.swift
//  BanDiary
//
//  Created by ZhaoYanfei on 9/5/16.
//  Copyright © 2016 FayeZhao. All rights reserved.
//

import UIKit

class CircularTransition: NSObject {
    var circle = UIView()
    
    var startingPoint = CGPoint.zero {
        didSet {
            circle.center = startingPoint
        }
    }
    
    var circleColor = UIColor.whiteColor()
    
    var duration = 0.3
    
    enum CircularTransitionMode: Int {
        case present, dismiss, pop
    }
    
    var transitionMode: CircularTransitionMode = .present
}

extension CircularTransition: UIViewControllerAnimatedTransitioning {
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
        return duration
    }
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        let containerView = transitionContext.containerView()
        
        if transitionMode == .present {
            if let presentedView = transitionContext.viewForKey(UITransitionContextToViewKey) {
                let viewCenter = presentedView.center
                let viewSize = presentedView.frame.size
                
                let circle = UIView()
                circle.frame = frameForCircle(withViewCenter: viewCenter, size: viewSize, startPoint: startingPoint)
                circle.layer.cornerRadius = circle.frame.size.height / 2
                circle.center = startingPoint
                circle.backgroundColor = circleColor
                circle.transform = CGAffineTransformMakeScale(0.001, 0.001)
                containerView!.addSubview(circle)
                
                presentedView.center = startingPoint
                presentedView.transform = CGAffineTransformMakeScale(0.001, 0.001)
                presentedView.alpha = 0
                containerView!.addSubview(presentedView)
                
                UIView.animateWithDuration(duration, animations: {self.circle.transform = CGAffineTransformIdentity
                    presentedView.transform = CGAffineTransformIdentity
                    presentedView.alpha = 1
                    presentedView.center = viewCenter
                    },
                    completion: {(success: Bool) in transitionContext.completeTransition(success)
                })
            }
            
        } else {
            let transitionModeKey = (transitionMode == .pop) ? UITransitionContextToViewKey : UITransitionContextFromViewKey
            
            if let returningView = transitionContext.viewForKey(transitionModeKey) {
                let viewCenter = returningView.center
                let viewSize = returningView.frame.size
                
                circle.frame = frameForCircle(withViewCenter: viewCenter, size: viewSize, startPoint: startingPoint)
                circle.layer.cornerRadius = circle.frame.size.height / 2
                circle.center = startingPoint
                
                UIView.animateWithDuration(duration, animations: {self.circle.transform = CGAffineTransformMakeScale(0.001, 0.001)
                    returningView.transform = CGAffineTransformMakeScale(0.001, 0.001)
                    returningView.center = self.startingPoint
                    returningView.alpha = 0
                    if self.transitionMode == .pop {
                        containerView?.insertSubview(returningView, belowSubview: returningView)
                        containerView?.insertSubview(self.circle, belowSubview: returningView)
                    }}, completion: {(success: Bool) in
                        returningView.center = viewCenter
                        returningView.removeFromSuperview()
                        self.circle.removeFromSuperview()
                        transitionContext.completeTransition(success)
                })
            }
        }
    }
    
    func frameForCircle(withViewCenter viewCenter: CGPoint, size viewSize: CGSize, startPoint: CGPoint) -> CGRect {
        let xLength = fmax(startingPoint.x, viewSize.width - startingPoint.x)
        let yLenth = fmax(startingPoint.y, viewSize.height - startingPoint.y)
        
        let offestVector = sqrt(xLength * xLength + yLenth * yLenth) * 2
        let size = CGSize(width: offestVector, height: offestVector)
        
        return CGRect(origin: CGPoint.zero, size: size)
        
    }
}

