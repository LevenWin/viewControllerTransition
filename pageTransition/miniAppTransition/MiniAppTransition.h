//
//  MiniAppTransition.h
//  pageTransition
//
//  Created by leven on 2018/3/25.
//  Copyright © 2018年 leven. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "LWNavTransition.h"

@interface MiniAppTransition : LWNavTransition

- (void)pushAnimation:(id <UIViewControllerContextTransitioning>)transitionContext;
- (void)popAnimation:(id <UIViewControllerContextTransitioning>)transitionContext ;

@end
