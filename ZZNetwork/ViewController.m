//
//  ViewController.m
//  ZZNetwork
//
//  Created by 郑来贤 on 2018/5/28.
//  Copyright © 2018年 郑来贤. All rights reserved.
//

#import "ViewController.h"
#import "ZZRequest.h"
#import "WeatherApi.h"
#import "ZZMemoryCache.h"
#import "NSDate+ZZ.h"

@interface ViewController ()<ZZAsyRequestDelegate>
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    // test api http://www.weather.com.cn/data/sk/101190408.html check WeatherApi class
    {
        ZZRequest *req = [ZZRequest requestWithProto:[WeatherApi new] delegate:self];
        [req start];
    }
    
    {
        ZZRequest *req = [ZZRequest requestWithProto:[WeatherApi new] delegate:self];
        [req start];
    }
    ZZMemoryCache *cache = [ZZMemoryCache new];
    NSLog(@"start %f",[NSDate currentMediaTime]);
    for (int i = 0; i <1000000; i++) {
        [cache objectCacheForKey:@(i).stringValue];
        [cache setCache:@(i) forKey:@(i).stringValue];
    }
    NSLog(@"end %f",[NSDate currentMediaTime]);
}

- (void)didSendRequest:(ZZRequest *)request{
    NSLog(@"%@",NSStringFromSelector(_cmd));
}

- (void)didReciveData:(id)data request:(ZZRequest *)request{
    NSLog(@"%@-data:%@",NSStringFromSelector(_cmd),data);
    
}

- (void)didFailure:(NSError *)error request:(ZZRequest *)reqeust{
    NSLog(@"%@-data:%@",NSStringFromSelector(_cmd),error);
}

@end
