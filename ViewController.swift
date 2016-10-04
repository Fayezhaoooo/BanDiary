//
//  ViewController.swift
//  BanDiary
//
//  Created by ZhaoYanfei on 9/2/16.
//  Copyright © 2016 FayeZhao. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UIViewControllerTransitioningDelegate {

    // Properties
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var enterButton: UIButton!
    @IBOutlet weak var welcomeBG: UIImageView!
    
    let transition = CircularTransition()
    
    // viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        applyMotion(toView: welcomeBG, magnitude: -10)
        applyMotion(toView: label, magnitude: 5)
        
    }
    
    // prepare for segue
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let secondVC = segue.destinationViewController
        secondVC.transitioningDelegate = self
        secondVC.modalPresentationStyle = .Custom
    }
    
    // dismiss controller
    func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.transitionMode = .dismiss
        transition.startingPoint = enterButton.center
        transition.circleColor = enterButton.backgroundColor!
        
        return transition
    }
    
    // present controller
    func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.transitionMode = .present
        transition.startingPoint = enterButton.center
        transition.circleColor = enterButton.backgroundColor!
        
        return transition
    }
    
    // applyMotion
    func applyMotion(toView view: UIView, magnitude: Float) {
        let xMotion = UIInterpolatingMotionEffect(keyPath: "center.x", type: .TiltAlongHorizontalAxis)
        xMotion.minimumRelativeValue = -magnitude
        xMotion.maximumRelativeValue = magnitude
        
        let yMotion = UIInterpolatingMotionEffect(keyPath: "center.y", type: .TiltAlongVerticalAxis)
        yMotion.minimumRelativeValue = -magnitude
        yMotion.maximumRelativeValue = magnitude
        
        let group = UIMotionEffectGroup()
        group.motionEffects = [xMotion, yMotion]
        
        view.addMotionEffect(group)
        
    }

    // didReceiveMemoryWarning
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

