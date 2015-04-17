//
//  RevealAnimator.swift
//  LogoReveal
//
//  Created by Marin Todorov on 1/15/15.
//  Copyright (c) 2015 Razeware LLC. All rights reserved.
//

import UIKit

class InteractiveAnimator: UIPercentDrivenInteractiveTransition, UIViewControllerAnimatedTransitioning {
    
    let animationDuration = 1.0
    var operation: UINavigationControllerOperation = .Push
    
    weak var storedContext: UIViewControllerContextTransitioning?
    
    var interactive = false
    
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning) -> NSTimeInterval {
        return animationDuration
    }
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        
        
        if operation == .Push {
            // create a tuple of our screens
           
            let fromVC = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey) as! MainViewController
            let toVC = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey) as! BlurbAddViewController
            let duration = self.transitionDuration(transitionContext)
            transitionContext.containerView().addSubview(toVC.view)
            transitionContext.containerView().addSubview(fromVC.view)
            toVC.view.transform = CGAffineTransformTranslate(toVC.view.transform, 0, toVC.view.bounds.size.height-toVC.topView.bounds.size.height);

            UIView.animateWithDuration(duration, delay: 0.0, usingSpringWithDamping: 1, initialSpringVelocity: 0,  options: nil, animations: {
                        fromVC.view.transform = CGAffineTransformMakeTranslation(0, -toVC.view.bounds.size.height+toVC.topView.bounds.size.height-22)
                        toVC.view.transform = CGAffineTransformMakeTranslation(0, 0)
                },
                completion:  { (finished: Bool) in
                    if(transitionContext.transitionWasCancelled()){
                        transitionContext.completeTransition(false)
                        
                    }
                    else {
                        
                        transitionContext.completeTransition(true)
                        fromVC.view.transform = CGAffineTransformIdentity
                       // toVC.view.transform = CGAffineTransformIdentity
                        toVC.addBlurbTextField.becomeFirstResponder()

                    }
                    
                    
                }
            )
           
        } else if operation == .Pop {
            // create a tuple of our screens
           
            let fromVC = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey) as! BlurbAddViewController
            let toVC = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey) as! MainViewController
            let duration = self.transitionDuration(transitionContext)
            transitionContext.containerView().addSubview(toVC.view)
            transitionContext.containerView().addSubview(fromVC.view)
            //toVC.view.transform = CGAffineTransformTranslate(fromVC.view.transform, 0, toVC.view.bounds.size.height-22);
            
            UIView.animateWithDuration(duration, delay: 0.0, usingSpringWithDamping: 1, initialSpringVelocity: 0,  options: nil, animations: {
                fromVC.view.transform = CGAffineTransformMakeTranslation(0, toVC.view.bounds.size.height-toVC.bottomView.bounds.size.height+22)

                },
                completion:  { (finished: Bool) in
                    if(transitionContext.transitionWasCancelled()) {
                        transitionContext.completeTransition(false)
                    }
                    else {
                        transitionContext.completeTransition(true)
                        fromVC.view.transform = CGAffineTransformIdentity
                        if toVC.tableView.contentSize.height > toVC.tableView.frame.size.height {
                            let offset = CGPoint(x: 0, y: toVC.tableView.contentSize.height - toVC.tableView.frame.size.height)
                            toVC.tableView.setContentOffset(offset, animated: true)
                        }


                        
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
            if(d > 0.3){
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
        println(d)

        // now lets deal with different states that the gesture recognizer sends
        switch (pan.state) {
            
        case UIGestureRecognizerState.Changed:
            println("Changed")

            // update progress of the transition
            self.updateInteractiveTransition(d)
            break
            
        default: // .Ended, .Cancelled, .Failed ...
            println("default in")

            // return flag to false and finish the transition
            self.interactive = false
            if(d > 0.6){
                println("crossed")

                // threshold crossed: finish
                self.finishInteractiveTransition()
            }
            else {
                // threshold not met: cancel
                println("cancel")

                self.cancelInteractiveTransition()
            }
        }
        
    }
    
   
    
    func interactionControllerForPresentation(animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        // if our interactive flag is true, return the transition manager object
        // otherwise return nil
        return self.interactive ? self : nil
    }
    
    func interactionControllerForDismissal(animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return self.interactive ? self : nil
    }
    
  
    
    
}
