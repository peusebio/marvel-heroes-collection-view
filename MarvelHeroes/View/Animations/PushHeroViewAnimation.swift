//
//  PushHeroViewAnimation.swift
//  MarvelHeroes
//
//  Created by Pedro Eusébio on 05/07/2020.
//  Copyright © 2020 Pedro Eusébio. All rights reserved.
//

import UIKit

class PushHeroViewAnimation: NSObject, UIViewControllerAnimatedTransitioning {
    private let originFrame: CGRect

    init(originFrame: CGRect) {
      self.originFrame = originFrame
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 2.0
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
//        // 1
//        guard let fromVC = transitionContext.viewController(forKey: .from),
//          let toVC = transitionContext.viewController(forKey: .to),
//          let snapshot = toVC.view.snapshotView(afterScreenUpdates: true)
//          else {
//            return
//        }
//
//        // 2
//        let containerView = transitionContext.containerView
//        let finalFrame = transitionContext.finalFrame(for: toVC)
//
//        // 3
//        snapshot.frame = originFrame
//        snapshot.layer.cornerRadius = 10
//        snapshot.layer.masksToBounds = true
//
//        // 1
//        containerView.addSubview(toVC.view)
//        containerView.addSubview(snapshot)
//        toVC.view.isHidden = true
//
//        // 2
//        AnimationHelper.perspectiveTransform(for: containerView)
//        snapshot.layer.transform = AnimationHelper.yRotation(.pi / 2)
//        // 3
//        let duration = transitionDuration(using: transitionContext)
//
//        UIView.animateKeyframes(
//          withDuration: duration,
//          delay: 0,
//          options: .calculationModeCubic,
//          animations: {
//            // 2
//            UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 1/3) {
//              fromVC.view.layer.transform = AnimationHelper.yRotation(-.pi / 2)
//            }
//
//            // 3
//            UIView.addKeyframe(withRelativeStartTime: 1/3, relativeDuration: 1/3) {
//              snapshot.layer.transform = AnimationHelper.yRotation(0.0)
//            }
//
//            // 4
//            UIView.addKeyframe(withRelativeStartTime: 2/3, relativeDuration: 1/3) {
//              snapshot.frame = finalFrame
//              snapshot.layer.cornerRadius = 0
//            }
//        },
//          // 5
//          completion: { _ in
//            toVC.view.isHidden = false
//            snapshot.removeFromSuperview()
//            fromVC.view.layer.transform = CATransform3DIdentity
//            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
//        })
        guard let toViewController = transitionContext.viewController(forKey: .to)
        else {
            return
        }
        transitionContext.containerView.addSubview(toViewController.view)
        toViewController.view.alpha = 0
        
        let duration = self.transitionDuration(using: transitionContext)
        UIView.animate(withDuration: duration, animations: {
            toViewController.view.alpha = 1
        }, completion: { _ in
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        })
    }
}
