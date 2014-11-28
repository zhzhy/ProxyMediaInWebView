//
//  MediaLoaderFactory.m
//  TTPod
//
//  Created by DjangoZhang on 14/11/28.
//
//

#import "MediaLoaderFactory.h"

static MediaLoaderFactory *SharedMediaLoaderFactory = nil;

@interface MediaLoaderFactory ()

@property(nonatomic, retain) NSMutableArray *mediaLoaderArray;
@property(nonatomic, retain) NSRecursiveLock *mediaLoaderArrayLock;
@end

@implementation MediaLoaderFactory

+ (instancetype)sharedInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (SharedMediaLoaderFactory == nil) {
            SharedMediaLoaderFactory = [[MediaLoaderFactory alloc] init];
        }
    });
    
    return SharedMediaLoaderFactory;
}

- (instancetype)init {
    if (self = [super init]) {
        _mediaLoaderArray = [[NSMutableArray alloc] init];
        _mediaLoaderArrayLock = [[NSRecursiveLock alloc] init];
    }
    
    return self;
}

- (MediaLoader *)createMediaLoader {
    MediaLoader *mediaLoader = [[MediaLoader alloc] init];
    
    [self.mediaLoaderArrayLock lock];
    [self.mediaLoaderArray addObject:mediaLoader];
    [self.mediaLoaderArrayLock unlock];
    
    return mediaLoader;
}

- (void)removeMediaLoader:(MediaLoader *)mediaLoader {
    [self.mediaLoaderArrayLock lock];
    [self.mediaLoaderArray removeObject:mediaLoader];
    [self.mediaLoaderArrayLock unlock];
}

@end
