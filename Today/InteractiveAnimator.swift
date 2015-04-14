//
//  RevealAnimator.swift
//  LogoReveal
//
//  Created by Marin Todorov on 1/15/15.
//  Copyright (c) 2015 Razeware LLC. All rights reserved.
//

import UIKit

class InteractiveAnimator: UIPercentDrivenInteractiveTransition, UIViewControllerAnimatedTransitioning {
    
    let animationDuration = 0.5
    var operation: UINavigationControllerOperation = .Push
    
    weak var storedContext: UIViewControllerContextTransitioning?
    
    var interactive = false
    
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning) -> NSTimeInterval {
        return animationDuration
    }
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        
        storedContext = transitionContext
        
        if operation == .Push {
            // create a tuple of our screens
            let screens : (from:UIViewController, to:UIViewController) = (transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey)!, transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey)!)
            let fromVC = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey) as! MainViewController
            let toVC = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey) as! BlurbAddViewController
            let duration = self.transitionDuration(transitionContext)
            transitionContext.containerView().addSubview(toVC.view)
            transitionContext.containerView().addSubview(fromVC.view)
            UIView.animateWithDuration(duration, delay: 0.0, options: UIViewAnimationOptions.CurveEaseOut, animations: {
                
                    toVC.view.transform = CGAffineTransformIdentity
                    self.offStageMenuControllerInteractive(fromVC)
                   // self.onStageMenuControllerForBlurbAddViewController(toVC)


                },
                completion:  { (finished: Bool) in
                    
                    if(transitionContext.transitionWasCancelled()){
                        
                        transitionContext.completeTransition(false)
                        // bug: we have to manually add our 'to view' back http://openradar.appspot.com/radar?id=5320103646199808
                     //   UIApplication.sharedApplication().keyWindow!.addSubview(screens.from.view)
                        
                    }
                    else {
                        
                        transitionContext.completeTransition(true)
                        // bug: we have to manually add our 'to view' back http://openradar.appspot.com/radar?id=5320103646199808
                    //    UIApplication.sharedApplication().keyWindow!.addSubview(screens.to.view)
                        
                    }
                    
                    
                }
            )
            
        } else if operation == .Pop {
            // create a tuple of our screens
            let screens : (from:UIViewController, to:UIViewController) = (transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey)!, transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey)!)
            let fromVC = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey) as! BlurbAddViewController
            let toVC = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey) as! MainViewController
            let duration = self.transitionDuration(transitionContext)
            transitionContext.containerView().addSubview(toVC.view)
            transitionContext.containerView().addSubview(fromVC.view)
            UIView.animateWithDuration(duration, delay: 0.0, options: UIViewAnimationOptions.CurveEaseIn, animations: {
                self.onStageMenuController(toVC) // onstage items: slide in
                self.offStageMenuControllerInteractiveForAddBlurbViewController(fromVC)
             //   toVC.view.transform = CGAffineTransformIdentity
               // self.offStageMenuControllerInteractive(fromVC)
                
                },
                completion:  { (finished: Bool) in
                    
                    if(transitionContext.transitionWasCancelled()){
                        
                        transitionContext.completeTransition(false)
                        // bug: we have to manually add our 'to view' back http://openradar.appspot.com/radar?id=5320103646199808
                        //   UIApplication.sharedApplication().keyWindow!.addSubview(screens.from.view)
                        
                    }
                    else {
                        
                        transitionContext.completeTransition(true)
                        // bug: we have to manually add our 'to view' back http://openradar.appspot.com/radar?id=5320103646199808
                        //    UIApplication.sharedApplication().keyWindow!.addSubview(screens.to.view)
                        
                    }
                    
                    
                }
            )
            
        }
        
    }
    
   
    func handlePan(pan: UIPanGestureRecognizer) {
        
        // how much distance have we panned in reference to the parent view?
        let translation = pan.translationInView(pan.view!)
        
        // do some math to translate this to a percentage based value
        let d =  -translation.y / CGRectGetHeight(pan.view!.bounds)
        
        // now lets deal with different states that the gesture recognizer sends
        switch (pan.state) {
            
        
            
        case UIGestureRecognizerState.Changed:
            
            // update progress of the transition
            self.updateInteractiveTransition(d)
            break
            
        default: // .Ended, .Cancelled, .Failed ...
            
            // return flag to false and finish the transition
            self.interactive = false
            if(d > 0.5){
                // threshold crossed: finish
                self.finishInteractiveTransition()
            }
            else {
                // threshold not met: cancel
                self.cancelInteractiveTransition()
            }
        }

    }
    
    func handleBlurbPan(pan: UIPanGestureRecognizer) {
        
        // how much distance have we panned in reference to the parent view?
        let translation = pan.translationInView(pan.view!)
        
        // do some math to translate this to a percentage based value
        let d =  translation.y / CGRectGetHeight(pan.view!.bounds)
        println(translation.y)

        // now lets deal with different states that the gesture recognizer sends
        switch (pan.state) {
            
            
        case UIGestureRecognizerState.Changed:
            
            // update progress of the transition
            self.updateInteractiveTransition(d)
            break
            
        default: // .Ended, .Cancelled, .Failed ...
            
            // return flag to false and finish the transition
           // self.interactive = false
            if(d < 0.5){
                // threshold crossed: finish
               // self.finishInteractiveTransition()
            }
            else {
                // threshold not met: cancel
               // self.cancelInteractiveTransition()
            }
        }
        
    }
    
    
    
    
    
    
    func offStage(amount: CGFloat) -> CGAffineTransform {
        return CGAffineTransformMakeTranslation(0, amount)
    }
    
    func offStageMenuControllerInteractive(mainViewController: MainViewController){
        
        mainViewController.bottomView.alpha = 0
        
        // setup paramaters for 2D transitions for animations
        let offstageOffset  :CGFloat = -450
        
        mainViewController.bottomView.transform = self.offStage(offstageOffset)
        mainViewController.weatherView.transform = self.offStage(offstageOffset)
        mainViewController.whatHappenedText.transform = self.offStage(offstageOffset)
        mainViewController.iconView.transform = self.offStage(offstageOffset)

        
    }
    
    
    func offStageMenuControllerInteractiveForAddBlurbViewController(blurbAddViewController: BlurbAddViewController){
        
        
        let onStageOffset  :CGFloat = 100
        
        blurbAddViewController.view.transform = self.offStage(onStageOffset)
        
        
    }
    
    
  
    func onStageMenuController(mainViewController: MainViewController){
        
        // prepare menu to fade in
        mainViewController.bottomView.alpha = 1
        mainViewController.bottomView.transform = CGAffineTransformIdentity
        mainViewController.weatherView.transform = CGAffineTransformIdentity
        mainViewController.whatHappenedText.transform = CGAffineTransformIdentity
        mainViewController.iconView.transform = CGAffineTransformIdentity


        
    }
    
    
    func onStageMenuControllerForBlurbAddViewController(blurbAddViewController: BlurbAddViewController){
        
        let onStageOffset  :CGFloat = -10

        blurbAddViewController.topView.transform = self.onStage(onStageOffset)
      
    }
    
    func onStage(amount: CGFloat) -> CGAffineTransform {
        return CGAffineTransformMakeTranslation(0, amount)
    }
    
    
  
    
    
}
