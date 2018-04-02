//
//  PushedViewController.m
//  pageTransition
//
//  Created by leven on 2018/3/23.
//  Copyright © 2018年 leven. All rights reserved.
//

#import "PushedViewController.h"
#import "LWNavTransition.h"
#import "ThirdViewController.h"
#import "ViewController.h"

@interface PushedViewController ()
@end

@implementation PushedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}
- (IBAction)pushClick:(id)sender {
    ThirdViewController *vc = [[ThirdViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)popClick:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC {
    
    if (operation == UINavigationControllerOperationPush
        && [fromVC isKindOfClass:[ViewController class]]
        && [toVC isKindOfClass:[PushedViewController class]]) {
        return [LWNavTransition transitionWithType:LWNavTransitionPush];
    }else if(operation == UINavigationControllerOperationPop
             && [toVC isKindOfClass:[ViewController class]]
             && [fromVC isKindOfClass:[PushedViewController class]]){
        return [LWNavTransition transitionWithType:LWNavTransitionPop];
    }
    return nil;
}


@end
