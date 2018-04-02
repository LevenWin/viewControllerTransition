//
//  LWNavTransition.h
//  pageTransition
//
//  Created by leven on 2018/3/23.
//  Copyright © 2018年 leven. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, LWNavTransitionType) {
    LWNavTransitionPush,
    LWNavTransitionPop
};

@interface LWNavTransition : NSObject <UIViewControllerAnimatedTransitioning>
@property (nonatomic, assign) LWNavTransitionType type;

+ (instancetype)transitionWithType:(LWNavTransitionType)type;

@end
