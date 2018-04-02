//
//  LWNavTransition.m
//  pageTransition
//
//  Created by leven on 2018/3/23.
//  Copyright © 2018年 leven. All rights reserved.
//

#import "LWNavTransition.h"
#import "ViewController.h"
#import "PushedViewController.h"

@implementation LWNavTransition
+ (instancetype)transitionWithType:(LWNavTransitionType)type {
    LWNavTransition *obj = [LWNavTransition new];
    obj.type = type;
    return obj;
}

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return 0.5;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext {
    switch (_type) {
        case LWNavTransitionPush:
            [self pushAnimation:transitionContext];
            break;
        case LWNavTransitionPop:
            [self popAnimation:transitionContext];
            break;
        default:
            break;
    }
}
- (void)pushAnimation:(id <UIViewControllerContextTransitioning>)transitionContext {
    ViewController *vc = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    PushedViewController *pvc = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *containerView = [transitionContext containerView];
    UIView *tempImageView = [vc.imageView snapshotViewAfterScreenUpdates:NO];
    tempImageView.frame = vc.imageView.frame;
    vc.imageView.hidden = YES;
    pvc.view.alpha = 0;
    [containerView addSubview:pvc.view];
    [containerView addSubview:vc.view];
    [containerView addSubview:tempImageView];
    pvc.imageView.hidden = YES;
    [UIView animateWithDuration:[self transitionDuration:transitionContext] delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        tempImageView.frame = CGRectMake(0, 44 + [UIApplication sharedApplication].statusBarFrame.size.height, [UIScreen mainScreen].bounds.size.width, 250);
        pvc.view.alpha = 1;
        vc.view.alpha = 0;
    } completion:^(BOOL finished) {
        tempImageView.hidden = YES;
        vc.view.alpha = 1;
        vc.imageView.hidden = NO;
        pvc.imageView.hidden = NO;
        pvc.imageView.image = [UIImage imageNamed:@"transition.jpg"];
        //如果动画过渡取消了就标记不完成，否则才完成，这里可以直接写YES，如果有手势过渡才需要判断，必须标记，否则系统不会中动画完成的部署，会出现无法交互之类的bug
        [transitionContext completeTransition:YES];
    }];
}

- (void)popAnimation:(id <UIViewControllerContextTransitioning>)transitionContext {
    PushedViewController *pvc = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    ViewController *vc = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *containerView = [transitionContext containerView];
    
    UIView *tempImageView = [pvc.imageView snapshotViewAfterScreenUpdates:NO];
    tempImageView.frame = pvc.imageView.frame;
    vc.imageView.hidden = YES;
    vc.view.alpha = 0;
    pvc.imageView.hidden = YES;
    [containerView addSubview:vc.view];
    [containerView addSubview:pvc.view];
    [containerView addSubview:tempImageView];
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext] delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        tempImageView.frame = vc.imageView.frame;
        pvc.view.alpha = 0;
        vc.view.alpha = 1;
    } completion:^(BOOL finished) {
        tempImageView.hidden = YES;
        vc.imageView.hidden = NO;
        pvc.view.alpha = 1;
        //如果动画过渡取消了就标记不完成，否则才完成，这里可以直接写YES，如果有手势过渡才需要判断，必须标记，否则系统不会中动画完成的部署，会出现无法交互之类的bug
        [transitionContext completeTransition:YES];
    }];
    
}

@end
