//
//  JGZLocationManager.m
//  yingkezhibo-OC
//
//  Created by 江贵铸 on 2016/12/13.
//  Copyright © 2016年 江贵铸. All rights reserved.
//

#import "JGZLocationManager.h"


@interface JGZLocationManager ()<AMapLocationManagerDelegate>
@property (nonatomic,strong) AMapLocationManager *LocationManager;
@property (nonatomic,copy) LocationBlock block;
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
        [AMapServices sharedServices].apiKey =@"1a96400576a43d75d8d45fb7af48c1c5";
        [AMapServices sharedServices].enableHTTPS = YES;
        self.LocationManager = [[AMapLocationManager alloc] init];
        // 带逆地理信息的一次定位（返回坐标和地址信息）
        [self.LocationManager setDesiredAccuracy:kCLLocationAccuracyHundredMeters];
        //   定位超时时间，最低2s，此处设置为2s
        self.LocationManager.locationTimeout =2;
        //   逆地理请求超时时间，最低2s，此处设置为2s
        self.LocationManager.reGeocodeTimeout = 2;
        [self updatelocation];
  
    }
    return self;
}
-(void)updatelocation{
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
            self.location =location;
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
            if (self.block) {
                self.block(location,regeocode);
            }
            
        }
    }];

}
#pragma mark--单次定位

-(void)UpdateLocationOnce:(LocationBlock)block{
    self.block = block;
    [self updatelocation];
   }
#pragma mark--开始持续定位
-(void)UpdateLocationAlways:(LocationBlock)block{
    self.block = block;
    self.LocationManager.delegate = self;
    [self.LocationManager setLocatingWithReGeocode:YES];
    [self.LocationManager startUpdatingLocation];

}
#pragma mark--停止持续定位
-(void)StopLocation{

    [self.LocationManager stopUpdatingLocation];
    
}
//- (void)amapLocationManager:(AMapLocationManager *)manager didUpdateLocation:(CLLocation *)location
//{
//    NSLog(@"location:{lat:%f; lon:%f; accuracy:%f}", location.coordinate.latitude, location.coordinate.longitude, location.horizontalAccuracy);
//}
- (void)amapLocationManager:(AMapLocationManager *)manager didUpdateLocation:(CLLocation *)location reGeocode:(AMapLocationReGeocode *)reGeocode
{
    //NSLog(@"location:{lat:%f; lon:%f; accuracy:%f}", location.coordinate.latitude, location.coordinate.longitude, location.horizontalAccuracy);
    if (reGeocode)
    {
        //NSLog(@"reGeocode:%@", reGeocode);
        if (self.block) {
            self.block(location,reGeocode);
        }
    }
}
@end
