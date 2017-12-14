//
//  DYWeather.m
//  DYNetworking_Example
//
//  Created by farfetch on 2017/12/14.
//  Copyright © 2017年 jyo2206208. All rights reserved.
//

#import "DYWeather.h"

@interface DYWeather()

@property (nonatomic, copy) NSString *location;
@property (nonatomic, copy) NSString *secretKey;

@end

@implementation DYWeather

- (NSString *)url {
    return @"/s6/weather/forecast";
}

- (NSDictionary *)parameters {
    return @{@"location":self.location,
            @"key":self.secretKey
             };
}

- (DYRequestMethod)method {
    return DYRequestMethodGET;
}


+ (RACSignal *)WeatherInfoFor:(NSString *)location secretKey:(NSString *)key {
    DYWeather *api = [[DYWeather alloc] init];
    api.location = location;
    api.secretKey = key;
    return [api signal];
}

@end
