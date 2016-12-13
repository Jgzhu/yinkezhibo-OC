//
//  JGZTabBar.h
//  yingkezhibo-OC
//
//  Created by 江贵铸 on 2016/12/11.
//  Copyright © 2016年 江贵铸. All rights reserved.
//

#import <UIKit/UIKit.h>
@class JGZTabBar;
typedef NS_ENUM(NSInteger,TabBarItemType) {
    TabBarItemLive = 10,
    TabBarItemShow = 100,
    TabBarItemMe
};

@protocol JGZTabBarDelegate <NSObject>

-(void)JGZTabBarItemClick:(JGZTabBar *)TabBar ItemType:(TabBarItemType)ItemType;

@end
@interface JGZTabBar : UIView
@property (nonatomic,weak)id<JGZTabBarDelegate>delegate;
@end
