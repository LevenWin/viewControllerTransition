//
//  MiniAppViewController.m
//  pageTransition
//
//  Created by leven on 2018/3/25.
//  Copyright © 2018年 leven. All rights reserved.
//

#import "MiniAppViewController.h"
#import "MiniAppTransition.h"
#import "LWInteractiveTransition.h"

@interface MiniAppViewController ()
@property (strong, nonatomic) IBOutlet UIImageView *imageView;
@property (nonatomic, strong) LWInteractiveTransition *interactiveTransition;
@end

@implementation MiniAppViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _imageView.userInteractionEnabled = NO;
    self.navigationController.navigationBarHidden = YES;
    _interactiveTransition =  [LWInteractiveTransition interactiveTransitionWithTransitionType:LWInteractiveTransitionTypePop GestureDirection:UIRectEdgeLeft viewController:self];
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC {
    if (operation == UINavigationControllerOperationPush) {
        return [MiniAppTransition transitionWithType:LWNavTransitionPush];
    }else if(operation == UINavigationControllerOperationPop){
        return [MiniAppTransition transitionWithType:LWNavTransitionPop];
    }
    return nil;
}

- (id<UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController interactionControllerForAnimationController:(id<UIViewControllerAnimatedTransitioning>)animationController{
    //手势开始的时候才需要传入手势过渡代理，如果直接点击pop，应该传入空，否者无法通过点击正常pop
    return _interactiveTransition.interation ? _interactiveTransition : nil;
}

@end
