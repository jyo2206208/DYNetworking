//
//  DYNetworkingTests.m
//  DYNetworkingTests
//
//  Created by jyo2206208 on 12/12/2017.
//  Copyright (c) 2017 jyo2206208. All rights reserved.
//

@import XCTest;
#import "DYWeather.h"

@interface Tests : XCTestCase

@end

@implementation Tests

- (void)testGET {
    XCTestExpectation *expectation = [self expectationWithDescription:@"Request should succeed"];
    [[DYWeather WeatherInfoFor:@"北京" secretKey:@"8b4907ecad6449cb92476b7f888284ac"] subscribeNext:^(id  _Nullable x) {
        NSLog(@"data = %@",x);
        XCTAssertNotNil(x);
        [expectation fulfill];
    }];
    [self waitForExpectationsWithTimeout:10 handler:nil];
}

@end

