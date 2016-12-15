//
//  JGZLocationManager.h
//  yingkezhibo-OC
//
//  Created by 江贵铸 on 2016/12/13.
//  Copyright © 2016年 江贵铸. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AMapFoundationKit/AMapFoundationKit.h>
#import <AMapLocationKit/AMapLocationKit.h>

typedef void (^LocationBlock)(CLLocation *location, AMapLocationReGeocode *regeocode);
@interface JGZLocationManager : NSObject
+(instancetype)shareManager;
-(void)UpdateLocationOnce:(LocationBlock)block;
-(void)UpdateLocationAlways:(LocationBlock)block;
-(void)StopLocation;
@property (nonatomic,copy) CLLocation *location;//!< 定位坐标
@property (nonatomic, copy) NSString *formattedAddress;//!< 格式化地址
@property (nonatomic, copy) NSString *country;  //!< 国家
@property (nonatomic, copy) NSString *province; //!< 省/直辖市
@property (nonatomic, copy) NSString *city;     //!< 市
@property (nonatomic, copy) NSString *district; //!< 区
@property (nonatomic, copy) NSString *citycode; //!< 城市编码
@property (nonatomic, copy) NSString *adcode;   //!< 区域编码

@property (nonatomic, copy) NSString *street;   //!< 街道名称
@property (nonatomic, copy) NSString *number;   //!< 门牌号

@property (nonatomic, copy) NSString *POIName;  //!< 兴趣点名称
@property (nonatomic, copy) NSString *AOIName;  //!< 所属兴趣点名称
@end
