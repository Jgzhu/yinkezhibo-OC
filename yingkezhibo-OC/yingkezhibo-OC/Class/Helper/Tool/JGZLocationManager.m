//
//  JGZLocationManager.m
//  yingkezhibo-OC
//
//  Created by 江贵铸 on 2016/12/13.
//  Copyright © 2016年 江贵铸. All rights reserved.
//

#import "JGZLocationManager.h"
#import <AMapFoundationKit/AMapFoundationKit.h>
#import <AMapLocationKit/AMapLocationKit.h>

@interface JGZLocationManager ()
@property (nonatomic,strong) AMapLocationManager *LocationManager;
@end
@implementation JGZLocationManager
+(instancetype)shareManager{
    static JGZLocationManager *_manager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _manager = [[JGZLocationManager alloc] init];
    });
    return _manager;
}
-(instancetype)init{
    self=[super init];
    if (self) {
       
    }
    return self;
}
-(void)UpdateLocation{
    
    [AMapServices sharedServices].apiKey =@"1a96400576a43d75d8d45fb7af48c1c5";
    self.LocationManager = [[AMapLocationManager alloc] init];
    // 带逆地理信息的一次定位（返回坐标和地址信息）
    [self.LocationManager setDesiredAccuracy:kCLLocationAccuracyNearestTenMeters];
    //   定位超时时间，最低2s，此处设置为2s
    self.LocationManager.locationTimeout =2;
    //   逆地理请求超时时间，最低2s，此处设置为2s
    self.LocationManager.reGeocodeTimeout = 2;
    
    // 带逆地理（返回坐标和地址信息）。将下面代码中的 YES 改成 NO ，则不会返回地址信息。
    [self.LocationManager requestLocationWithReGeocode:YES completionBlock:^(CLLocation *location, AMapLocationReGeocode *regeocode, NSError *error) {
        
        if (error)
        {
            //NSLog(@"locError:{%ld - %@};", (long)error.code, error.localizedDescription);
            
            if (error.code == AMapLocationErrorLocateFailed)
            {
                return;
            }
        }
        
        //NSLog(@"location:%@", location);
        
        if (regeocode)
        {
           // NSLog(@"reGeocode:%@", regeocode);
            /**
             formattedAddress;//!< 格式化地址
             country;  //!< 国家
             province; //!< 省/直辖市
             city;     //!< 市
             district; //!< 区
             citycode; //!< 城市编码
             adcode;   //!< 区域编码
             street;   //!< 街道名称
             number;   //!< 门牌号
             POIName;  //!< 兴趣点名称
             AOIName;  //!< 所属兴趣点名称
             */
            self.formattedAddress = regeocode.formattedAddress;
            self.country = regeocode.country;
            self.province = regeocode.province;
            self.city = regeocode.city;
            self.district = regeocode.district;
            self.citycode = regeocode.citycode;
            self.adcode = regeocode.adcode;
            self.street = regeocode.street;
            self.number = regeocode.number;
            self.POIName = regeocode.POIName;
            self.AOIName = regeocode.AOIName;
        }
    }];


}
@end
