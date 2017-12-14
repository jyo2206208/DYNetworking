//
//  DYRequest.h
//  DYNetworking
//
//  Created by farfetch on 2017/12/13.
//

#import <Foundation/Foundation.h>
#import <ReactiveObjC/ReactiveObjC.h>

typedef NS_ENUM(NSInteger, DYRequestMethod) {
    DYRequestMethodGET = 0,
    DYRequestMethodPOST,
    DYRequestMethodHEAD,
    DYRequestMethodPUT,
    DYRequestMethodDELETE,
    DYRequestMethodPATCH,
};

@interface DYRequest : NSObject

@property (nonatomic, copy) NSArray *params;

- (RACSignal *)signal;

@end
