//
//  LWInteractiveTransition.m
//  pageTransition
//
//  Created by leven on 2018/4/2.
//  Copyright © 2018年 leven. All rights reserved.
//

#import "LWInteractiveTransition.h"
@interface LWInteractiveTransition ()
@property (nonatomic) LWInteractiveTransitionType type;
@end

@implementation LWInteractiveTransition

+ (instancetype)interactiveTransitionWithTransitionType:(LWInteractiveTransitionType)type
                                       GestureDirection:(UIRectEdge)rectEdge
                                         viewController:(UIViewController *)viewController {
    LWInteractiveTransition *transition = [LWInteractiveTransition new];
    transition.viewController = viewController;
    transition.type = type;
    [transition addEdgeGesture:rectEdge];
    return transition;
}

- (void)addEdgeGesture:(UIRectEdge)rectEdge {
    UIScreenEdgePanGestureRecognizer *pan = [[UIScreenEdgePanGestureRecognizer alloc] initWithTarget:self action:@selector(handleGesture:)];
    pan.edges = rectEdge;
    [self.viewController.view addGestureRecognizer:pan];
}


/**
 *  手势过渡的过程
 */
- (void)handleGesture:(UIScreenEdgePanGestureRecognizer *)panGesture{
    //手势百分比
    CGFloat persent = 0;
    switch (panGesture.edges) {
        case UIRectEdgeRight:{
            CGFloat transitionX = -[panGesture translationInView:panGesture.view].x;
            persent = transitionX / panGesture.view.frame.size.width;
        }
            break;
        case UIRectEdgeNone:
        case UIRectEdgeAll:
        case UIRectEdgeLeft:{
            CGFloat transitionX = [panGesture translationInView:panGesture.view].x;
            persent = transitionX / panGesture.view.frame.size.width;
        }
            break;
        case UIRectEdgeBottom:{
            CGFloat transitionY = -[panGesture translationInView:panGesture.view].y;
            persent = transitionY / panGesture.view.frame.size.width;
        }
            break;
        case UIRectEdgeTop:{
            CGFloat transitionY = [panGesture translationInView:panGesture.view].y;
            persent = transitionY / panGesture.view.frame.size.width;
        }
            break;
    }
    switch (panGesture.state) {
        case UIGestureRecognizerStateBegan:
            //手势开始的时候标记手势状态，并开始相应的事件
            self.interation = YES;
            [self startGesture];
            break;
        case UIGestureRecognizerStateChanged:{
            //手势过程中，通过updateInteractiveTransition设置pop过程进行的百分比
            [self updateInteractiveTransition:persent];
            break;
        }
        case UIGestureRecognizerStateFailed:
        case UIGestureRecognizerStateCancelled:
        case UIGestureRecognizerStateEnded:{
            //手势完成后结束标记并且判断移动距离是否过半，过则finishInteractiveTransition完成转场操作，否者取消转场操作
            self.interation = NO;
            if (persent > 0.5) {
                [self finishInteractiveTransition];
            }else{
                [self cancelInteractiveTransition];
            }
            break;
        }
        default:
            break;
    }
}

- (void)startGesture{
    switch (_type) {
        case LWInteractiveTransitionTypePresent: !_gestureStartBlock ?: _gestureStartBlock();
            break;
        case LWInteractiveTransitionTypeDismiss:
            [_viewController dismissViewControllerAnimated:YES completion:nil];
            break;
        case LWInteractiveTransitionTypePush: !_gestureStartBlock ?: _gestureStartBlock();
            break;
        case LWInteractiveTransitionTypePop:
            [_viewController.navigationController popViewControllerAnimated:YES];
            break;
    }
}
@end
