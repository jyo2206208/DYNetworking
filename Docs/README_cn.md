# DYNetworking

[![CI Status](http://img.shields.io/travis/jyo2206208/DYNetworking.svg?style=flat)](https://travis-ci.org/jyo2206208/DYNetworking)

## DYNetworking是什么

DYNetworking是一套使用了 [ReactiveObjC](https://github.com/ReactiveCocoa/ReactiveObjC) 的iOS网络库。他把每个网络请求都封装成标准的RACSignal，让基于RAC的异步编程更便捷。同时他还支持离散式网络请求封装，非常适合在模块化的大型项目中使用。

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.  
1. 新建一个DYNetworkingConfig的类，并配置好baseUrl

```objectivec
#import <Foundation/Foundation.h>

@interface DYNetworkingConfig : NSObject

@end

#import "DYNetworkingConfig.h"

@implementation DYNetworkingConfig

+ (NSString *)baseUrl {
    return @"https://free-api.heweather.com";
}

@end

```

2. 新建继承自DYRequest的类

```objectivec
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
```

然后通过调用这个方法获得信号

```objectivec
[[DYWeather WeatherInfoFor:@"北京" secretKey:@"8b4907ecad6449cb92476b7f888284ac"] subscribeNext:^(id  _Nullable x) {
        NSLog(@"data = %@",x);
}];
```



## Requirements
该项目最低支持 `iOS 9.3`。

## Installation

DYNetworking is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'DYNetworking'
```

## Features

- [x] 主体结构和接口
- [x] 全局配置功能
- [ ] 基于RACCommand的返回
- [ ] 可配置的缓存策略
- [ ] 网络监测
- [ ] UT和CI
- [ ] mock数据



## Author

jyo2206208, shaggon.du@farfetch.com

## License

DYNetworking is available under the MIT license. See the LICENSE file for more info.
