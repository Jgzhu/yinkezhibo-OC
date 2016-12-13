//
//  JGZTabBar.m
//  yingkezhibo-OC
//
//  Created by 江贵铸 on 2016/12/11.
//  Copyright © 2016年 江贵铸. All rights reserved.
//

#import "JGZTabBar.h"

@interface JGZTabBar ()
@property (nonatomic,strong) NSArray *ItemsArray;
@property (nonatomic,strong) UIImageView *TabBarBgView;
@property (nonatomic,strong) UIButton *preBtn;
@property (nonatomic,strong) UIButton *LiveBtn;
@property (nonatomic,strong) NSMutableArray *ItemsBtnArray;

@end

@implementation JGZTabBar

-(UIButton *)LiveBtn{
    if (!_LiveBtn) {
        _LiveBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_LiveBtn setImage:[UIImage imageNamed:@"tab_launch"] forState:UIControlStateNormal];
        _LiveBtn.tag = TabBarItemLive;
        _LiveBtn.userInteractionEnabled= YES;
        [_LiveBtn addTarget:self action:@selector(TabBarItemClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _LiveBtn;
}
-(NSMutableArray *)ItemsBtnArray{
    if (!_ItemsBtnArray) {
        _ItemsBtnArray = [NSMutableArray arrayWithCapacity:0];
    }
    return _ItemsBtnArray;
}
-(NSArray *)ItemsArray{
    if (!_ItemsArray) {
        _ItemsArray = @[@"tab_live",@"tab_me"];
    }
    return _ItemsArray;
}
-(UIImageView *)TabBarBgView{
    if (!_TabBarBgView) {
        _TabBarBgView = [[UIImageView alloc] initWithFrame:self.bounds];
        _TabBarBgView.image = [UIImage imageNamed:@"global_tab_bg"];
        _TabBarBgView.userInteractionEnabled = YES;
    }
    return _TabBarBgView;
}
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.userInteractionEnabled = YES;
        [self addSubview:self.TabBarBgView];
        [self CreatTabBarItems];
    }
    return self;
}
-(void)CreatTabBarItems{
    
    for (int i=0; i<self.ItemsArray.count; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.tag = TabBarItemShow+i;
        [btn setImage:[UIImage imageNamed:self.ItemsArray[i]] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:[self.ItemsArray[i] stringByAppendingString:@"_p"]] forState:UIControlStateSelected];
        [btn setImage:[UIImage imageNamed:[self.ItemsArray[i] stringByAppendingString:@"_p"]] forState:UIControlStateHighlighted];
        [btn addTarget:self action:@selector(TabBarItemClick:) forControlEvents:UIControlEventTouchUpInside];
        
        if (i==0) {
            btn.selected = YES;
            self.preBtn= btn;
        }
        [self addSubview:btn];
        [self.ItemsBtnArray addObject:btn];
    }

    //创建中间按钮
    [self addSubview:self.LiveBtn];
}

-(void)layoutSubviews{
    [super layoutSubviews];
    CGFloat ItemW = UIScreenW/self.ItemsArray.count;
    CGFloat ItemH = self.frame.size.height;
    for (UIButton *btn in self.ItemsBtnArray) {
         btn.frame = CGRectMake((btn.tag-TabBarItemShow)*ItemW, 0, ItemW, ItemH);
    }
    //[self.LiveBtn sizeToFit];
    self.LiveBtn.frame = CGRectMake(self.center.x-40, -35, 80, 80);

}
-(void)TabBarItemClick:(UIButton *)btn{
    if (btn.tag==self.preBtn.tag) {
        return;
    }
    if (btn.tag!=TabBarItemLive) {
        btn.selected=YES;
        self.preBtn.selected = NO;
        self.preBtn = btn;
    }

    if ([self.delegate respondsToSelector:@selector(JGZTabBarItemClick:ItemType:)]) {
        if (btn.tag==TabBarItemShow) {
            [self.delegate JGZTabBarItemClick:self ItemType:TabBarItemShow];
        }else if (btn.tag ==TabBarItemShow+1){
            [self.delegate JGZTabBarItemClick:self ItemType:TabBarItemMe];
        }else{
            [self.delegate JGZTabBarItemClick:self ItemType:TabBarItemLive];
        }
    }

}
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    UIView *view = [super hitTest:point withEvent:event];
    if (view == nil) {
        CGPoint tempoint = [self.LiveBtn convertPoint:point fromView:self];
        if (CGRectContainsPoint(self.LiveBtn.bounds, tempoint))
        {
            view = self.LiveBtn;
        }
    }
    return view;
}
//-(BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event{
//    return YES;
//}
@end
