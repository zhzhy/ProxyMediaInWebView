//
//  AVURLAsset+RequestRemoteFile.m
//  TTPod
//
//  Created by DjangoZhang on 14/11/19.
//
//

#import "AVURLAsset+RequestRemoteFile.h"
#import "ClassMethodPair.h"
#import "NSObject+MethodSwizzling.h"
#import "MediaLoaderFactory.h"
#import "NSURL+ExtendedURL.h"

@implementation AVURLAsset (RequestRemoteFile)

+ (void)load {
    Class currentClass = [self class];
    ClassMethodPair *originalAddObjectPair = [ClassMethodPair classMethodPairWithClass:currentClass withSelector:@selector(initWithURL:options:)];
    ClassMethodPair *replacedAddObjectPair = [ClassMethodPair classMethodPairWithClass:currentClass withSelector:@selector(initWithProxiedRequestRemoteFileURL:options:)];
    
    [self replaceClassPair:originalAddObjectPair withAnother:replacedAddObjectPair];
}

- (instancetype)initWithProxiedRequestRemoteFileURL:(NSURL *)URL options:(NSDictionary *)options {
    NSURL *requestedURL = [URL URLByReplaceSchemeWithString:@"proxy"];

    if (self = [self initWithProxiedRequestRemoteFileURL:requestedURL options:options]) {
        [self.resourceLoader setDelegate:[[MediaLoaderFactory sharedInstance] createMediaLoader]
                                   queue:dispatch_get_main_queue()];
    }
    
    return self;
}

@end
