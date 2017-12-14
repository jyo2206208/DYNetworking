//
//  HomePageApi.h
//  DYNetworking
//
//  Created by farfetch on 2017/12/13.
//

#import "DYRequest.h"

@interface HomePageApi : DYRequest

+ (RACSignal *)homePageSignalByGenderCode:(NSString *)genderCode;

@end
