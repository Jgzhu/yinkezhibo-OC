//
//  JGZScrollTabBarController.m
//  yingkezhibo-OC
//
//  Created by 江贵铸 on 2016/12/14.
//  Copyright © 2016年 江贵铸. All rights reserved.
//

#import "JGZScrollTabBarController.h"

@interface JGZScrollTabBarController ()<UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UICollectionViewDataSource>
@property (nonatomic,copy) TitleBlock titleblock;
@property (nonatomic,strong) UIView *TitleView;
@property (nonatomic,assign) CGRect TitleViewframe;
@property (nonatomic,strong) UIImageView *SelectedTitleBgView;
@property (nonatomic,getter=IsOnNav) BOOL OnNav;
@property (nonatomic,strong) NSArray *TitleArray;
@property (nonatomic,strong) NSMutableArray *TitleLabelArray;
@property (nonatomic,assign) NSInteger PreLabelIndex;
@property (nonatomic,strong) UIScrollView *TitleScrollView;

@property (nonatomic,strong) NSArray*ContentArray;
@property (nonatomic,assign) CGRect SingelContentframe;
@property (nonatomic,strong) UICollectionView *ContentCollectionView;
@property (nonatomic,strong) UICollectionViewFlowLayout *FlowLayout;

@property (nonatomic,assign) CGFloat CurrentOffSetX;

@property (nonatomic) BOOL IsScroll;
@property (nonatomic) BOOL IsFirst;
@end

static NSString *CollectionCellID = @"CollectionCellID";
@implementation JGZScrollTabBarController
-(NSArray *)TitleArray{
    if (!_TitleArray) {
        _TitleArray = [NSArray array];
    }
    return _TitleArray;
}
-(NSMutableArray *)TitleLabelArray{
    if (!_TitleLabelArray) {
        _TitleLabelArray = [NSMutableArray arrayWithCapacity:0];
    }
    return _TitleLabelArray;
}

-(NSArray *)ContentArray{
    if (!_ContentArray) {
        _ContentArray = [NSArray array];
    }
    return _ContentArray;
}
-(instancetype)initWithFrame:(CGRect)frame TitleArray:(NSArray *)titleArray IsOnNav:(BOOL)IsOnNav TitleViewFrame:(CGRect)TitleViewframe ContentArray:(NSArray *)ContentArray ContentFrame:(CGRect)Contentframe TitleView:(TitleBlock)TitleBlock{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor redColor];
        self.IsFirst=YES;
        self.titleblock = TitleBlock;
        self.OnNav = IsOnNav;
        self.TitleArray = titleArray;
        self.TitleViewframe = TitleViewframe;
        
        self.ContentArray = ContentArray;
        self.SingelContentframe = Contentframe;
        
    }
    return self;
}

-(void)show{
    [self CreatTitleView:self.TitleViewframe];
    [self CreatContentView:self.SingelContentframe];
}

#pragma mark-Titleview的创建和监听点击
-(void)CreatTitleView:(CGRect)TitleViewframe{
    self.TitleView = [[UIView alloc] initWithFrame:TitleViewframe];
    UIScrollView *TitleScrollView = [[UIScrollView alloc] initWithFrame:self.TitleView.bounds];
    self.TitleScrollView = TitleScrollView;
    TitleScrollView.showsVerticalScrollIndicator=NO;
    TitleScrollView.showsHorizontalScrollIndicator = NO;
    [self.TitleView addSubview:TitleScrollView];
    CGFloat TitleBtnX = 5;
    int i=0;
    for (NSString *TitleString in self.TitleArray) {
        UILabel *TitleLabel = [[UILabel alloc] init];
        TitleLabel.text = TitleString;
        TitleLabel.font = [UIFont systemFontOfSize:16];
        TitleLabel.textColor = [UIColor whiteColor];
        [TitleLabel sizeToFit];
        TitleLabel.tag =i;
        TitleLabel.frame = CGRectMake(TitleBtnX, 0, TitleLabel.frame.size.width+10, TitleViewframe.size.height);
        TitleLabel.textAlignment = NSTextAlignmentCenter;
        [TitleScrollView addSubview:TitleLabel];
        TitleBtnX = TitleBtnX+TitleLabel.frame.size.width;
        TitleLabel.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(TitleLabelClick:)];
        [TitleLabel addGestureRecognizer:tap];
        
        [self.TitleLabelArray addObject:TitleLabel];
        i++;
    }
    if (TitleBtnX<TitleViewframe.size.width) {
        self.TitleView.width = TitleBtnX+5;
    }else{
        TitleScrollView.contentSize= CGSizeMake(TitleBtnX+5, TitleViewframe.size.height);
    }
    self.SelectedTitleBgView = [[UIImageView alloc] init];
    self.SelectedTitleBgView.image = [UIImage imageNamed:@"TitleBgIcon.png"];
    [TitleScrollView addSubview:self.SelectedTitleBgView];
    if (self.TitleLabelArray.count>0) {
        [self SetTitleLabelFrameForCurrentIndex:0 NextIndex:0 Scale:1 IsClick:YES];
    }
    
    if (self.OnNav==YES) {
        if (self.titleblock) {
         self.titleblock(self.TitleView);
        }
    }else{
        [self addSubview:self.TitleView];
    }
}
-(void)TitleLabelClick:(UITapGestureRecognizer *)tap{
    UILabel *ClickLabel = (UILabel *)tap.view;
    self.IsScroll = NO;
    [self SetTitleLabelFrameForCurrentIndex:self.PreLabelIndex NextIndex:ClickLabel.tag Scale:1 IsClick:YES];
    
}
-(void)SetTitleLabelFrameForCurrentIndex:(NSInteger)CurrentIndex NextIndex:(NSInteger)NextIndex Scale:(CGFloat)Scale IsClick:(BOOL)IsClick{
    UILabel *CurrentLabel = self.TitleLabelArray[CurrentIndex];
    UILabel *NextLabel = self.TitleLabelArray[NextIndex];
    if (CurrentIndex==NextIndex) {
        Scale=1.0;
        
    }
    if (IsClick==YES) {
        if (CurrentIndex==NextIndex&&self.IsFirst==NO) {
            return;
        }
        CGFloat Duration=0.0;
        if (self.IsFirst==NO) {
            Duration = 0.25;
        }
        [UIView animateWithDuration:Duration animations:^{
            CurrentLabel.transform =CGAffineTransformMakeScale(1.2-0.2*Scale, 1.2-0.2*Scale);
            NextLabel.transform =CGAffineTransformMakeScale(1.0+0.2*Scale, 1.0+0.2*Scale);
            self.SelectedTitleBgView.centerX +=(NextLabel.centerX-CurrentLabel.centerX)*Scale;
            //self.SelectedTitleBgView.width +=(NextLabel.width*1.2-CurrentLabel.width)*Scale;
        } completion:^(BOOL finished) {
            self.SelectedTitleBgView.frame =NextLabel.frame;
            //self.SelectedTitleBgView.transform =CGAffineTransformMakeScale(1.2, 1.2);
        }];
        self.PreLabelIndex = NextIndex;
        self.IsFirst=NO;
        [self.ContentCollectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:self.PreLabelIndex inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
        NSIndexPath *indexpath = [NSIndexPath indexPathForItem:self.PreLabelIndex inSection:0];
        [self.ContentCollectionView reloadItemsAtIndexPaths:@[indexpath]];
    }else{
        CurrentLabel.transform =CGAffineTransformMakeScale(1.2-0.2*Scale, 1.2-0.2*Scale);
        NextLabel.transform =CGAffineTransformMakeScale(1.0+0.2*Scale, 1.0+0.2*Scale);
        self.PreLabelIndex=NextIndex;
        if (NextLabel.centerX>CurrentLabel.centerX) {
         self.SelectedTitleBgView.centerX = CurrentLabel.centerX+(NextLabel.centerX-CurrentLabel.centerX)*Scale;
        }else{
        self.SelectedTitleBgView.centerX = CurrentLabel.centerX-(CurrentLabel.centerX-NextLabel.centerX)*Scale;
        }
    }
    for (UILabel *label in self.TitleLabelArray) {
        if (label.tag!=CurrentLabel.tag&&label.tag!=NextLabel.tag) {
            [UIView animateWithDuration:0.25 animations:^{
                label.transform = CGAffineTransformIdentity;
            }];
            
        }
    }

    if (Scale==1.0) {
        CGFloat MaxX = CGRectGetMaxX(NextLabel.frame);
        if (self.TitleScrollView.contentOffset.x+self.TitleScrollView.width<=MaxX) {
            if (NextIndex==self.ContentArray.count-1) {
                [self.TitleScrollView setContentOffset:CGPointMake(MaxX-self.TitleScrollView.width, 0) animated:YES];
            }else{
                UILabel *NextNextLabel = self.TitleLabelArray[NextIndex+1];
                MaxX = CGRectGetMaxX(NextNextLabel.frame);
                [self.TitleScrollView setContentOffset:CGPointMake(MaxX-self.TitleScrollView.width, 0) animated:YES];
            }
            
        }else if (CGRectGetMinX(NextLabel.frame)<=self.TitleScrollView.contentOffset.x){
            if (NextIndex==0) {
                [self.TitleScrollView setContentOffset:CGPointMake(NextLabel.frame.origin.x, 0) animated:YES];
            }else{
                UILabel *NextNextLabel = self.TitleLabelArray[NextIndex-1];
                [self.TitleScrollView setContentOffset:CGPointMake(NextNextLabel.frame.origin.x, 0) animated:YES];
            }
            
        }
   
    }
}

#pragma mark-Contentview的创建和滚动
-(void)CreatContentView:(CGRect)SingelViewFrame{
    UICollectionViewFlowLayout *FlowLayout = [[UICollectionViewFlowLayout alloc] init];
    self.FlowLayout = FlowLayout;
    FlowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    FlowLayout.minimumLineSpacing = 0;
    FlowLayout.minimumInteritemSpacing = 0;
    FlowLayout.itemSize =SingelViewFrame.size;
    UICollectionView *ContentCollectionView = [[UICollectionView alloc] initWithFrame:SingelViewFrame collectionViewLayout:self.FlowLayout];
    self.ContentCollectionView = ContentCollectionView;
    ContentCollectionView.delegate = self;
    ContentCollectionView.dataSource = self;
    self.ContentCollectionView.pagingEnabled = YES;
    self.ContentCollectionView.showsVerticalScrollIndicator = NO;
    self.ContentCollectionView.showsHorizontalScrollIndicator = NO;
    [self.ContentCollectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:CollectionCellID];
    self.ContentCollectionView.backgroundColor = [UIColor cyanColor];
    [self addSubview:ContentCollectionView];
}
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.ContentArray.count;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CollectionCellID forIndexPath:indexPath];
    UIViewController *controller = self.ContentArray[indexPath.item];
    controller.view.frame = self.SingelContentframe;
    [cell addSubview:controller.view];
    return cell;
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    self.CurrentOffSetX = scrollView.contentOffset.x;
    self.IsScroll = YES;

}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [self ScrollViewScrolling:scrollView];
}
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    [self ScrollViewScrolling:scrollView];
}
-(void)ScrollViewScrolling:(UIScrollView *)scrollView{

    if (self.IsScroll==YES) {
        CGFloat offsetX = scrollView.contentOffset.x;
        NSInteger NextIndex=0;
        NSInteger CurrentIndex=0;
        CGFloat Scale = 0.0;
        
        if (self.CurrentOffSetX>offsetX) {
            //向右滑动
            NextIndex = floorf(offsetX/self.SingelContentframe.size.width);
            //Scale = (self.CurrentOffSetX-offsetX)/self.SingelContentframe.size.width;
            Scale =1- ((offsetX/self.SingelContentframe.size.width)-NextIndex);
            if (Scale==0) {
                Scale=1;
            }

            if (Scale==1) {
                CurrentIndex = NextIndex;
            }else{
                if (NextIndex>=self.ContentArray.count-1) {
                    CurrentIndex = NextIndex;
                }else{
                    CurrentIndex = NextIndex+1;
                }
            }
            if (NextIndex<0) {
                NextIndex = 0;
                CurrentIndex=0;
            }
            NSLog(@"向右%ld--%ld--%f",CurrentIndex,(long)NextIndex,Scale);
        }else{
            //向左滑动
            if (offsetX>self.CurrentOffSetX) {
                if (offsetX<0) {
                    offsetX = 0;
                }
                CurrentIndex = floorf(offsetX/self.SingelContentframe.size.width);
                Scale = (offsetX/self.SingelContentframe.size.width)-CurrentIndex;
                if (Scale==0) {
                    Scale=1;
                }
                if (Scale==1) {
                    NextIndex = CurrentIndex;
                }else{
                    NextIndex = CurrentIndex+1;
                }
                if (CurrentIndex>=self.ContentArray.count-1) {
                    NextIndex = CurrentIndex;
                }
            }else{
                NextIndex = ceilf(offsetX/self.SingelContentframe.size.width);
                if (NextIndex>=self.ContentArray.count-1) {
                    
                    NextIndex = self.ContentArray.count-1;
                }else if (NextIndex<0){
                    NextIndex = 0;
                }
                CurrentIndex = NextIndex;
                Scale = 1.0;
                
            }
            NSLog(@"向左%ld--%ld--%f",CurrentIndex,(long)NextIndex,Scale);
        }
        
        [self SetTitleLabelFrameForCurrentIndex:CurrentIndex NextIndex:NextIndex Scale:Scale IsClick:NO];
    }
}
@end
