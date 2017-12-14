//
//  DYWeather.h
//  DYNetworking_Example
//
//  Created by farfetch on 2017/12/14.
//  Copyright © 2017年 jyo2206208. All rights reserved.
//

#import "DYRequest.h"

@interface DYWeather : DYRequest

+ (RACSignal *)WeatherInfoFor:(NSString *)location secretKey:(NSString *)key;

@end
