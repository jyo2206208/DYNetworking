//
//  DYRequest.m
//  DYNetworking
//
//  Created by farfetch on 2017/12/13.
//

#import "DYRequest.h"
#import "objc/runtime.h"

NSString * DYPercentEscapedStringFromString(NSString *string) {
    static NSString * const kAFCharactersGeneralDelimitersToEncode = @":#[]@";
    static NSString * const kAFCharactersSubDelimitersToEncode = @"!$&'()*+,;=";
    
    NSMutableCharacterSet * allowedCharacterSet = [[NSCharacterSet URLQueryAllowedCharacterSet] mutableCopy];
    [allowedCharacterSet removeCharactersInString:[kAFCharactersGeneralDelimitersToEncode stringByAppendingString:kAFCharactersSubDelimitersToEncode]];
    
    static NSUInteger const batchSize = 50;
    
    NSUInteger index = 0;
    NSMutableString *escaped = @"".mutableCopy;
    
    while (index < string.length) {
        NSUInteger length = MIN(string.length - index, batchSize);
        NSRange range = NSMakeRange(index, length);
        
        range = [string rangeOfComposedCharacterSequencesForRange:range];
        
        NSString *substring = [string substringWithRange:range];
        NSString *encoded = [substring stringByAddingPercentEncodingWithAllowedCharacters:allowedCharacterSet];
        [escaped appendString:encoded];
        
        index += range.length;
    }
    
    return escaped;
}

@implementation DYRequest

- (RACSignal *)signal {
    return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[self requestUrl]];
        request.allHTTPHeaderFields = [self requestAllHTTPHeaderFields];
        request.HTTPMethod = [self requestHTTPMethod];
        
        
        NSURLSessionDataTask *dataTask=[[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
            if (error) {
                [subscriber sendError:error];
            } else {
                [subscriber sendNext:[NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil]];
            }
        }];
        [dataTask resume];
        
        return nil;
    }];
}

- (NSString *)url {
    return @"";
}

- (NSDictionary *)parameters {
    return nil;
}

- (DYRequestMethod)method {
    return DYRequestMethodGET;
}

- (NSDictionary *)httpHeader {
    return nil;
}



- (NSURL *)requestUrl {
    if ([self url]) {
        return [NSURL URLWithString:[NSString stringWithFormat:@"%@%@%@",[self requestBaseUrl],[self url],[self requestParamsSerializedString]]];
    }
    return [NSURL URLWithString:@""];
}

- (NSDictionary *)requestAllHTTPHeaderFields {
    return [self httpHeader];
}

- (NSString *)requestParamsSerializedString {
    NSDictionary *paramsDic = [self parameters];
    if (paramsDic) {
        return [self URLEncodedStringValueFromDictionary:paramsDic];
    }
    
    return @"";
}

- (NSString *)requestBaseUrl {
    Class class = NSClassFromString(@"DYNetworkingConfig");
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
    return [class performSelector:NSSelectorFromString(@"baseUrl")];
#pragma clang diagnostic pop
}

- (NSString *)requestHTTPMethod {
    DYRequestMethod method = [self method];
    switch (method) {
        case DYRequestMethodGET:
            return @"GET";
            break;
        case DYRequestMethodPOST:
            return @"POST";
            break;
        case DYRequestMethodHEAD:
            return @"HEAD";
            break;
        case DYRequestMethodPUT:
            return @"PUT";
            break;
        case DYRequestMethodDELETE:
            return @"DELETE";
            break;
        case DYRequestMethodPATCH:
            return @"PATCH";
            break;
            
        default:
            return nil;
            break;
    }
}

- (NSString *)URLEncodedStringValueFromDictionary:(NSDictionary *)dic {
    NSMutableString *queryString = [NSMutableString stringWithFormat:@"?"];
    [dic enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        [queryString appendString:[NSString stringWithFormat:@"%@=%@&", DYPercentEscapedStringFromString(key), DYPercentEscapedStringFromString([obj description])]];
    }];
    
    return [queryString substringToIndex:([queryString length]-1)];
}


@end
