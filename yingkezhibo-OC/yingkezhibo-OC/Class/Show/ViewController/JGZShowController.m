//
//  JGZShowController.m
//  yingkezhibo-OC
//
//  Created by 江贵铸 on 2016/12/11.
//  Copyright © 2016年 江贵铸. All rights reserved.
//

#import "JGZShowController.h"
#import "JGZFocuseController.h"
#import "JGZHotController.h"
#import "JGZNearController.h"
#import "JGZScrollTabBarController.h"
@interface JGZShowController ()

@end

@implementation JGZShowController

- (void)viewDidLoad {
    [super viewDidLoad];
    //self.title = @"123";
    self.automaticallyAdjustsScrollViewInsets=NO;
    self.view.backgroundColor = [UIColor cyanColor];
    [self CreatSubController];
}
-(void)CreatSubController{
    CGRect STBControllerFrame = CGRectMake(0, 0, UIScreenW, UIScreenH-60-49);
    NSArray *TitleArray=@[@"关注",@"热门刚刚",@"附近",@"关注居行业规范",@"热门",@"附近",@"关注",@"热门",@"附近",@"关注",@"热门",@"附近"];
    JGZFocuseController *FocuseController = [[JGZFocuseController alloc] init];
    JGZHotController *HotController = [[JGZHotController alloc] init];
    JGZNearController *NearController = [[JGZNearController alloc] init];
    CGRect TitleViewFrame = CGRectMake(0, 0, UIScreenW-120, 40);
    NSArray *ContentArray = @[FocuseController,HotController,NearController,FocuseController,HotController,NearController,FocuseController,HotController,NearController,FocuseController,HotController,NearController];
    CGRect ContentFrame = CGRectMake(0, 0, UIScreenW, UIScreenH-60-49);    
    __weak typeof(self) weakSelf = self;
    JGZScrollTabBarController *ScrollTabBarController = [[JGZScrollTabBarController alloc] initWithFrame:STBControllerFrame TitleArray:TitleArray IsOnNav:YES TitleViewFrame:TitleViewFrame ContentArray:ContentArray ContentFrame:ContentFrame TitleView:^(UIView *TitleView) {
    weakSelf.navigationItem.titleView = TitleView;
}];
    [ScrollTabBarController show];
    [self.view addSubview:ScrollTabBarController];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
