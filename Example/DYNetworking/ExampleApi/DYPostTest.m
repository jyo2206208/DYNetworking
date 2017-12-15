//
//  DYPostTest.m
//  DYNetworking_Example
//
//  Created by farfetch on 2017/12/14.
//  Copyright © 2017年 jyo2206208. All rights reserved.
//

#import "DYPostTest.h"

@implementation DYPostTest

- (NSString *)url {
    return @"/post";
}

- (DYRequestMethod)method {
    return DYRequestMethodPOST;
}


+ (RACSignal *)postTest {
    DYPostTest *api = [[DYPostTest alloc] init];
    return [api signal];
}

@end
