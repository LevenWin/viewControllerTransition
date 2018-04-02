//
//  MiniAppTransition.m
//  pageTransition
//
//  Created by leven on 2018/3/25.
//  Copyright © 2018年 leven. All rights reserved.
//

#import "MiniAppTransition.h"
#import "MainViewController.h"
#import "MiniAppViewController.h"

@implementation MiniAppTransition

+ (instancetype)transitionWithType:(LWNavTransitionType)type {
    MiniAppTransition *obj = [MiniAppTransition new];
    obj.type = type;
    return obj;
}

- (void)pushAnimation:(id <UIViewControllerContextTransitioning>)transitionContext {
    MainViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    MiniAppViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    CGRect toVCInitinalFrame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);

    toVCInitinalFrame = CGRectMake(toVCInitinalFrame.origin.x, toVCInitinalFrame.size.height, toVCInitinalFrame.size.width, toVCInitinalFrame.size.height);
    
    toVC.view.frame = toVCInitinalFrame;

    UIView *containerView = [transitionContext containerView];
    fromVC.view.layer.anchorPoint = CGPointMake(0.5, 1);
    fromVC.view.frame = CGRectMake(0, 0, fromVC.view.frame.size.width, fromVC.view.frame.size.height);
    
    [containerView addSubview:fromVC.view];
    [containerView addSubview:toVC.view];
   
    CATransform3D outer = CATransform3DIdentity;
    outer.m34 = -1.0 / 500.0;
    outer = CATransform3DRotate(outer, M_PI_4/20, 1, 0,0);
    [UIView animateWithDuration:[self transitionDuration:transitionContext] delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        toVC.view.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
        fromVC.view.layer.transform =outer;
    } completion:^(BOOL finished) {
        fromVC.view.layer.anchorPoint = CGPointMake(0.5, 0.5);
        fromVC.view.frame = CGRectMake(0, 0, fromVC.view.frame.size.width, fromVC.view.frame.size.height);

        [transitionContext completeTransition:YES];
    }];
}
- (void)popAnimation:(id <UIViewControllerContextTransitioning>)transitionContext {
    MiniAppViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    MainViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    CGRect fromeVCInitinalFrame =  CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    fromVC.view.frame = fromeVCInitinalFrame;

    fromeVCInitinalFrame = CGRectMake(fromeVCInitinalFrame.origin.x, fromeVCInitinalFrame.size.height, fromeVCInitinalFrame.size.width, fromeVCInitinalFrame.size.height);
    UIView *containerView = [transitionContext containerView];
   
    [containerView addSubview:toVC.view];
    [containerView addSubview:fromVC.view];
    
    toVC.view.layer.anchorPoint = CGPointMake(0.5, 1);
    toVC.view.frame = CGRectMake(0, 0, toVC.view.frame.size.width, toVC.view.frame.size.height);
    CATransform3D outer = CATransform3DIdentity;
    outer.m34 = -1.0 / 500.0;
    outer = CATransform3DRotate(outer, M_PI_4/20, 1, 0,0);
    toVC.view.layer.transform = outer;
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext] delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        toVC.view.layer.transform = CATransform3DIdentity;
        fromVC.view.frame = fromeVCInitinalFrame;
    } completion:^(BOOL finished) {
       
        if ([transitionContext transitionWasCancelled]) {
            fromVC.view.frame =  CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
        }else{
            toVC.view.layer.anchorPoint = CGPointMake(0.5, 0.5);
            toVC.view.frame = CGRectMake(0, 0, toVC.view.frame.size.width, toVC.view.frame.size.height);
            toVC.view.layer.transform = CATransform3DIdentity;
        }
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
    }];
}


@end
