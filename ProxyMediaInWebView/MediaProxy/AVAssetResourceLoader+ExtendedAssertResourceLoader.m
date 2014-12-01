//
//  AVAssetResourceLoader+ExtendedAssertResourceLoader.m
//  ProxyMediaInWebView
//
//  Created by DjangoZhang on 14/12/1.
//  Copyright (c) 2014年 DjangoZhang. All rights reserved.
//

#import "AVAssetResourceLoader+ExtendedAssertResourceLoader.h"
#import "ClassMethodPair.h"
#import "NSObject+MethodSwizzling.h"
#import "MediaLoader.h"

@implementation AVAssetResourceLoader (ExtendedAssertResourceLoader)

+ (void)load {
    Class currentClass = [self class];
    ClassMethodPair *originalAddObjectPair = [ClassMethodPair classMethodPairWithClass:currentClass withSelector:@selector(setDelegate:queue:)];
    ClassMethodPair *replacedAddObjectPair = [ClassMethodPair classMethodPairWithClass:currentClass withSelector:@selector(setExtendedDelegate:queue:)];
    
    [self replaceClassPair:originalAddObjectPair withAnother:replacedAddObjectPair];
}

- (void)setExtendedDelegate:(id<AVAssetResourceLoaderDelegate>)delegate queue:(dispatch_queue_t)delegateQueue {
    if ([delegate isKindOfClass:[MediaLoader class]]) {
         [self setExtendedDelegate:delegate queue:delegateQueue];
    }
}

@end
