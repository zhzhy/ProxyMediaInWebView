//
//  MediaLoaderFactory.h
//  TTPod
//
//  Created by DjangoZhang on 14/11/28.
//
//

#import "MediaLoader.h"

@interface MediaLoaderFactory : NSObject

+ (instancetype)sharedInstance;

- (MediaLoader *)createMediaLoader;
- (void)removeMediaLoader:(MediaLoader *)mediaLoader;

@end
