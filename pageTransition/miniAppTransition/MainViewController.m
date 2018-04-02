//
//  MainViewController.m
//  pageTransition
//
//  Created by leven on 2018/3/25.
//  Copyright © 2018年 leven. All rights reserved.
//

#import "MainViewController.h"
#import "MiniAppViewController.h"
#import "MiniAppTransition.h"
#import "MiniNavigationViewController.h"

@interface MainViewController ()<UIViewControllerTransitioningDelegate>
{
    BOOL animated;
}
@property (strong, nonatomic) IBOutlet UIImageView *imageView;
@property (nonatomic, strong) MiniAppTransition *transition;
@end

@implementation MainViewController

- (void)viewDidLoad {
    self.view.backgroundColor = [UIColor blackColor];
    [super viewDidLoad];
    _imageView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapClick)];
    [_imageView addGestureRecognizer:tap];
    self.navigationController.navigationBarHidden = YES;
    _imageView.layer.anchorPoint = CGPointMake(0.5, 1.0);
    self.imageView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width,[UIScreen mainScreen].bounds.size.height);
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

- (IBAction)backClick:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)tapClick {
    MiniAppViewController *vc = [[MiniAppViewController alloc] init];
    MiniNavigationViewController *navi = [[MiniNavigationViewController alloc] initWithRootViewController:vc];
    vc.title = @"miniApp";
    self.navigationController.delegate = vc;
    [self.navigationController pushViewController:vc animated:YES];
}

@end
