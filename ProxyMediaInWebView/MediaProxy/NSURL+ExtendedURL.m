//
//  NSURL+ExtendedURL.m
//  CachableAVPlayer
//
//  Created by DjangoZhang on 14/11/28.
//  Copyright (c) 2014年 hanzc. All rights reserved.
//

#import "NSURL+ExtendedURL.h"

@implementation NSURL (ExtendedURL)

- (NSURL *)URLByReplaceSchemeWithString:(NSString *)scheme {
    NSString *requestedURLString = [[self absoluteString] stringByReplacingOccurrencesOfString:[self scheme] withString:scheme];
    NSURL *requestedURL = [NSURL URLWithString:requestedURLString];
    return requestedURL;
}

@end
