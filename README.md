# DYNetworking

[![CI Status](http://img.shields.io/travis/jyo2206208/DYNetworking.svg?style=flat)](https://travis-ci.org/jyo2206208/DYNetworking)

[**中文说明**](Docs/README_cn.md)

## What is DYNetworking

DYNetworking is an iOS netwokring library using [ReactiveObjC](https://github.com/ReactiveCocoa/ReactiveObjC) 。It encapsulated every networking request into RACSignal，to lety Foundation Reactive Programming more eazy。It also support discrete encapsulation，that's very useful in a big project。

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.  
1. create a class named DYNetworkingConfig，and config with baseUrl

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

2. Create a subClass of DYRequest

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

use this method to get the RACSignal

```objectivec
[[DYWeather WeatherInfoFor:@"北京" secretKey:@"8b4907ecad6449cb92476b7f888284ac"] subscribeNext:^(id  _Nullable x) {
        NSLog(@"data = %@",x);
}];
```



## Requirements
last support `iOS 9.3`。

## Installation

DYNetworking is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'DYNetworking'
```

## Features

- [x] main project and interface
- [x] global configuration
- [ ] RACCommand support
- [ ] cache base on configuration
- [ ] networking observe
- [ ] UT and CI
- [ ] mock data



## Author

jyo2206208, shaggon.du@farfetch.com

## License

DYNetworking is available under the MIT license. See the LICENSE file for more info.

123