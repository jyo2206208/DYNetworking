//
//  HomePageApi.m
//  DYNetworking
//
//  Created by farfetch on 2017/12/13.
//

#import "HomePageApi.h"

@interface HomePageApi()

@property (nonatomic, copy) NSString *genderCode;

@end

@implementation HomePageApi

- (NSString *)url {
    return [NSString stringWithFormat:@"https://api.farfetch.net/ext/ffcom/api/v1/mobile/homepage/%@/",self.genderCode];
}

- (NSDictionary *)httpHeader {
    return @{@"FF-Country":@"CN"};
}



+ (RACSignal *)homePageSignalByGenderCode:(NSString *)genderCode {
    HomePageApi *api = [[HomePageApi alloc] init];
    api.genderCode = genderCode;
    return [api signal];
}

@end
