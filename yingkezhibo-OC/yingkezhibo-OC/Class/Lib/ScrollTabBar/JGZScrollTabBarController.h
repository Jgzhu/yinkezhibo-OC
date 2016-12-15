//
//  JGZScrollTabBarController.h
//  yingkezhibo-OC
//
//  Created by 江贵铸 on 2016/12/14.
//  Copyright © 2016年 江贵铸. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^TitleBlock)(UIView *TitleView);
@interface JGZScrollTabBarController : UIView
/**
 *frame->self的尺寸
 *TitleArray->Title字符串数组
 *IsOnNav->是否放在NavGationBar上面，如果YES，则TitleViewframe需要传值；如果NO，则TitleViewframe不需要传值
 *ContentArray->子控制器数组
 *Contentframe->子控制器尺寸
 *TitleView->TitleView回调，放在Nav上面（如果IsOnNav==YES，则需要这一项；）
 */
-(instancetype)initWithFrame:(CGRect)frame TitleArray:(NSArray *)titleArray IsOnNav:(BOOL)IsOnNav TitleViewFrame:(CGRect)TitleViewframe ContentArray:(NSArray *)ContentArray ContentFrame:(CGRect)Contentframe TitleView:(TitleBlock)TitleBlock;
-(void)show;
@end
