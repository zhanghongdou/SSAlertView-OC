//
//  ViewController.m
//  SSAlertView2
//
//  Created by 爱利是 on 16/8/5.
//  Copyright © 2016年 haohao. All rights reserved.
//

#import "ViewController.h"
#import "SSAlertView.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}
- (IBAction)btnClick:(id)sender {
    SSAlertView *alertView = [[SSAlertView alloc]initWithTitle:@"温馨提示" AlertMessage:@"请注意请注意请注意请注意请注意请注意请注意请注意请注意请注意请注意请注意请注意请注意请注意请注意请注意请注意请注意请注意请注意请注意请注意请注意请注意请注意请注意请注意请注意请注意请注意请注意请注意请注意" cancelButtonTitle:@"取消" otherButtonTitles:@[@"按钮1", @"按钮2"]];
    alertView.mode = SSAlertViewModeError;
    alertView.leaveModel = SSAlertLeaveModeRight;
    alertView.clickBlock = ^(NSInteger index) {
        NSLog(@"点击了按钮-----%ld", index);
    };
    [alertView show];
}


- (IBAction)btnClick2:(id)sender {
    SSAlertView *alertView = [[SSAlertView alloc]initWithTitle:@"温馨提示" AlertMessage:@"请注意请注意请注意请注意请注意请注意请注意请注意请注意请注意请注意请注意请注意请注意请注意请注意请注意请注意请注意请注意请注意请注意请注意请注意请注意请注意请注意请注意请注意请注意请注意请注意请注意请注意" cancelButtonTitle:@"取消" otherButtonTitles:@[@"按钮1"]];
    alertView.mode = SSAlertViewModeSuccess;
    alertView.leaveModel = SSAlertLeaveModeLeft;
    alertView.clickBlock = ^(NSInteger index) {
        NSLog(@"点击了按钮-----%ld", index);
    };
    [alertView show];
}
- (IBAction)btnClick3:(id)sender {
    SSAlertView *alertView = [[SSAlertView alloc]initWithTitle:@"温馨提示" AlertMessage:@"请注意请注意请注意请注意请注意请注意请注意请注意请注意请注意请注意请注意请注意请注意请注意请注意请注意请注意请注意请注意请注意请注意请注意请注意请注意请注意请注意请注意请注意请注意请注意请注意请注意请注意" cancelButtonTitle:@"取消" otherButtonTitles:nil];
    alertView.mode = SSAlertViewModeWarning;
    alertView.leaveModel = SSAlertLeaveModeBottom;
    alertView.clickBlock = ^(NSInteger index) {
        NSLog(@"点击了按钮-----%ld", index);
    };
    [alertView show];
}
- (IBAction)btnClick5:(id)sender {
    SSAlertView *alertView = [[SSAlertView alloc]initWithTitle:@"温馨提示" AlertMessage:@"请注意请注意请注意请注意请注意请注意请注意请注意请注意请注意请注意请注意请注意请注意请注意请注意请注意请注意请注意请注意请注意请注意请注意请注意请注意请注意请注意请注意请注意请注意请注意请注意请注意请注意" cancelButtonTitle:@"取消" otherButtonTitles:@[@"确定"]];
    alertView.mode = SSAlertViewModeWarning;
    alertView.leaveModel = SSAlertLeaveModeBottom;
    alertView.clickBlock = ^(NSInteger index) {
        NSLog(@"点击了按钮-----%ld", index);
    };
    [alertView show];
    
}
- (IBAction)btnClick4:(id)sender {
    SSAlertView *alertView = [[SSAlertView alloc]initWithTitle:@"温馨提示" AlertMessage:@"请注意请注意请注意请注意请注意请注意请注意请注意请注意请注意请注意请注意请注意请注意请注意请注意请注意请注意请注意请注意请注意请注意请注意请注意请注意请注意请注意请注意请注意请注意请注意请注意请注意请注意" cancelButtonTitle:@"取消" otherButtonTitles:@[@"按钮1", @"按钮2"]];
    alertView.mode = SSAlertViewModeSuccess;
    alertView.clickBlock = ^(NSInteger index) {
        NSLog(@"点击了按钮-----%ld", index);
    };
    [alertView show];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
