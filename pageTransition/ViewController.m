//
//  ViewController.m
//  pageTransition
//
//  Created by leven on 2018/3/23.
//  Copyright © 2018年 leven. All rights reserved.
//

#import "ViewController.h"
#import "PushedViewController.h"
#import "MainViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIImage *image = [UIImage imageNamed:@"transition.jpg"];
    self.imageView.image = image;
    
    // Do any additional setup after loading the view, typically from a nib.
}
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    self.navigationController.delegate = nil;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
}

- (IBAction)miniAppClick:(id)sender {
    MainViewController *vc = [[MainViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)pushClick:(id)sender {
    PushedViewController *vc = [[PushedViewController alloc] init];
    self.navigationController.delegate = vc;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
