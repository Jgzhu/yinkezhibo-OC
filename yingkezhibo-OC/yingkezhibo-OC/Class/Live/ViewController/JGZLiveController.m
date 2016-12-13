//
//  JGZLiveController.m
//  yingkezhibo-OC
//
//  Created by 江贵铸 on 2016/12/13.
//  Copyright © 2016年 江贵铸. All rights reserved.
//

#import "JGZLiveController.h"
#import "JGZLocationManager.h"
@interface JGZLiveController ()

@end

@implementation JGZLiveController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setBgViewImage];
    [self setAllSubViews];
    }
-(void)setBgViewImage{
    self.view.backgroundColor = [UIColor cyanColor];
    UIImageView *bgView = [[UIImageView alloc] initWithFrame:UIScreenBounds];
    bgView.image = [UIImage imageNamed:@"bg_zbfx"];
    [self.view addSubview:bgView];

}

-(void)setAllSubViews{
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [backBtn setImage:[UIImage imageNamed:@"launch_close"] forState:UIControlStateNormal];
    [backBtn sizeToFit];
    backBtn.center = CGPointMake(UIScreenW-backBtn.frame.size.width*0.5, backBtn.frame.size.height*0.5);
    [backBtn addTarget:self action:@selector(backBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backBtn];
    
    UIButton *LacationBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [LacationBtn setImage:[UIImage imageNamed:@"launch_map_on"] forState:UIControlStateNormal];
    [LacationBtn setTitle:[JGZLocationManager shareManager].city forState:UIControlStateNormal];
    [LacationBtn.titleLabel setFont:[UIFont systemFontOfSize:13]];
    [LacationBtn sizeToFit];
    LacationBtn.center = CGPointMake(10+LacationBtn.frame.size.width*0.5, backBtn.center.y);
    [LacationBtn addTarget:self action:@selector(LacationBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:LacationBtn];
    
    UIButton *startBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [startBtn setBackgroundImage:[UIImage imageNamed:@"room_button"] forState:UIControlStateNormal];
    [startBtn setTitle:@"开始直播" forState:UIControlStateNormal];
    [startBtn.titleLabel setFont:[UIFont systemFontOfSize:19]];
    [startBtn sizeToFit];
    [startBtn addTarget:self action:@selector(startBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:startBtn];
    startBtn.center = self.view.center;
    
    UITextField *roomTitle = [[UITextField alloc] initWithFrame:CGRectMake(20, CGRectGetMinY(startBtn.frame)-50, UIScreenW-20*2, 40)];
    roomTitle.font= [UIFont systemFontOfSize:22];
    roomTitle.textAlignment = NSTextAlignmentCenter;
    roomTitle.textColor =[UIColor whiteColor];
    roomTitle.placeholder=@"给直播写个标题吧";
    [self.view addSubview:roomTitle];
}
-(void)backBtnClick{

    [self dismissViewControllerAnimated:YES completion:nil];
    
}
-(void)LacationBtnClick{
    
    
}
-(void)startBtnClick{
    
    
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setHidden:YES];

}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
 [self.navigationController.navigationBar setHidden:NO];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
