//
//  LWInteractiveTransition.h
//  pageTransition
//
//  Created by leven on 2018/4/2.
//  Copyright © 2018年 leven. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^GestureStartBlock)();

typedef NS_ENUM(NSUInteger, LWInteractiveTransitionType) {//手势控制哪种转场
    LWInteractiveTransitionTypePresent = 0,
    LWInteractiveTransitionTypeDismiss,
    LWInteractiveTransitionTypePush,
    LWInteractiveTransitionTypePop,
};

@interface LWInteractiveTransition : UIPercentDrivenInteractiveTransition
@property (nonatomic, readonly) LWInteractiveTransitionType type;
@property (nonatomic, strong) UIViewController *viewController;
@property (nonatomic, assign) BOOL interation;
@property (nonatomic, copy) GestureStartBlock gestureStartBlock;

+ (instancetype)interactiveTransitionWithTransitionType:(LWInteractiveTransitionType)type
                                       GestureDirection:(UIRectEdge)rectEdge
                                         viewController:(UIViewController *)viewController;

@end
