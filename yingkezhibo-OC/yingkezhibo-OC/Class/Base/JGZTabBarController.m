//
//  JGZTabBarController.m
//  yingkezhibo-OC
//
//  Created by 江贵铸 on 2016/12/11.
//  Copyright © 2016年 江贵铸. All rights reserved.
//

#import "JGZTabBarController.h"
#import "JGZBaseNavController.h"
#import "JGZShowController.h"
#import "JGZMeController.h"
#import "JGZLiveController.h"
#import "JGZTabBar.h"
#import "JGZLocationManager.h"
@interface JGZTabBarController ()<JGZTabBarDelegate>
@property (nonatomic,strong) JGZTabBar *jgzTabBar;
@end

@implementation JGZTabBarController
-(JGZTabBar *)jgzTabBar{
    if (!_jgzTabBar) {
        _jgzTabBar = [[JGZTabBar alloc] initWithFrame:CGRectMake(0, 200, UIScreenW, 49)];
        _jgzTabBar.delegate = self;
    }
    return _jgzTabBar;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    self.jgzTabBar.frame = self.tabBar.frame;
    [self.view addSubview:self.jgzTabBar];
    [self.tabBar removeFromSuperview];
}

-(void)initUI{
    JGZShowController *ShowController = [[JGZShowController alloc] init];
    ShowController.tabBarItem.title=@"";
    JGZBaseNavController *ShowNav = [[JGZBaseNavController alloc] initWithRootViewController:ShowController];
    
    JGZMeController *MeController = [[JGZMeController alloc] init];
    MeController.tabBarItem.title=@"";
    JGZBaseNavController *MeNav = [[JGZBaseNavController alloc] initWithRootViewController:MeController];
    self.viewControllers = @[ShowNav,MeNav];

}
#pragma mark-JGZTabBarDelegate
-(void)JGZTabBarItemClick:(JGZTabBar *)TabBar ItemType:(TabBarItemType)ItemType{
    if (ItemType==TabBarItemShow) {
        self.selectedIndex = 0;
    }else if (ItemType==TabBarItemMe){
        self.selectedIndex = 1;
    }else{
        NSLog(@"去");
        JGZLiveController *controller = [[JGZLiveController alloc] init];
        JGZBaseNavController *Nav = [[JGZBaseNavController alloc] initWithRootViewController:controller];
        [self presentViewController:Nav animated:YES completion:nil];
    }

}

@end
