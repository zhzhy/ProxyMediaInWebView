//
//  NSURL+ExtendedURL.h
//  CachableAVPlayer
//
//  Created by DjangoZhang on 14/11/28.
//  Copyright (c) 2014年 hanzc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSURL (ExtendedURL)

- (NSURL *)URLByReplaceSchemeWithString:(NSString *)scheme;

@end
