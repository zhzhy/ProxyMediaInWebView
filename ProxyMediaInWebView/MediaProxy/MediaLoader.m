//
//  MediaLoader.m
//  TTPod
//
//  Created by DjangoZhang on 14/11/26.
//
//

#import "MediaLoader.h"
#import "MediaLoaderFactory.h"
#import "NSURL+ExtendedURL.h"

#import <MobileCoreServices/MobileCoreServices.h>
#import <UIKit/UIKit.h>

@interface MediaLoader () <NSURLConnectionDataDelegate>

@property(nonatomic, strong) NSMutableData *mediaData;
@property(nonatomic, strong) NSMutableArray *loadingRequest;
@property(nonatomic, strong) NSURLConnection *mediaConnection;
@property(nonatomic, strong) NSHTTPURLResponse *HTTPResponse;
@property(nonatomic, strong) AVAssetResourceLoader *resourceLoader;
@end

@implementation MediaLoader

- (instancetype)init {
    if (self = [super init]) {
        _mediaData = [[NSMutableData alloc] init];
        _loadingRequest = [[NSMutableArray alloc] init];
    }
    
    return self;
}

#pragma mark AVAssetResourceLoaderDelegate

- (BOOL)resourceLoader:(AVAssetResourceLoader *)resourceLoader shouldWaitForLoadingOfRequestedResource:(AVAssetResourceLoadingRequest *)loadingRequest {
    if (self.mediaConnection == nil) {
        self.resourceLoader = resourceLoader;
        
        NSURL *originalURL = [loadingRequest.request.URL URLByReplaceSchemeWithString:@"http"];
        self.mediaConnection = [NSURLConnection connectionWithRequest:[NSURLRequest requestWithURL:originalURL] delegate:self];
        [self.mediaConnection start];
    }
    
    [self.loadingRequest addObject:loadingRequest];
    
    if (![self isiOS6X]) {
        [self processLoadingRequest];
    }
    
    return YES;
}

- (void)resourceLoader:(AVAssetResourceLoader *)resourceLoader didCancelLoadingRequest:(AVAssetResourceLoadingRequest *)loadingRequest {
    [self.mediaConnection cancel];
    self.mediaConnection = nil;
    [self processLoadingRequest];
    [self.loadingRequest removeObject:loadingRequest];
    
    [self processFinshedMediaLoader];
}

#pragma mark  NSURLConnectionDataDelegate

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    self.HTTPResponse = (NSHTTPURLResponse *)response;
    if (![self isiOS6X]) {
        [self processLoadingRequest];
    }
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [self.mediaData appendData:data];
    if (![self isiOS6X]) {
        [self processLoadingRequest];
    }
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    if ([self isiOS6X]) {
        [self processLoadingRequestWithData:self.mediaData];
        [self.loadingRequest removeAllObjects];
    }else {
        [self processLoadingRequest];
    }
    
    self.mediaConnection = nil;
    
    [self processFinshedMediaLoader];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    if ([self isiOS6X]) {
        for (AVAssetResourceLoadingRequest *loadingRequest in self.loadingRequest) {
            [loadingRequest finishLoadingWithError:error];
        }
    }
    
    [self.loadingRequest removeAllObjects];
    [self processFinshedMediaLoader];
}

#pragma loading data

- (void)processLoadingRequest {
    NSMutableArray *finishedLoadingRequest = [NSMutableArray array];
    for (AVAssetResourceLoadingRequest *loadingRequest in self.loadingRequest) {
        [self fillContentInfomationRequest:loadingRequest.contentInformationRequest];
        [self fillResponseData:loadingRequest.dataRequest];
        
        if ([self isLoadingRequestFinished:loadingRequest.dataRequest]) {
            [loadingRequest finishLoading];
            [finishedLoadingRequest addObject:loadingRequest];
        }
    }
    
    [self.loadingRequest removeObjectsInArray:finishedLoadingRequest];
}

- (void)fillContentInfomationRequest:(AVAssetResourceLoadingContentInformationRequest *)contentInfomationRequest {
    if (contentInfomationRequest == nil || self.HTTPResponse == nil) {
        return;
    }
    
    CFStringRef contentType = UTTypeCreatePreferredIdentifierForTag(kUTTagClassMIMEType, (__bridge CFStringRef)self.HTTPResponse.MIMEType, NULL);
    contentInfomationRequest.byteRangeAccessSupported = YES;
    contentInfomationRequest.contentType = (__bridge NSString *)contentType;
    contentInfomationRequest.contentLength = self.HTTPResponse.expectedContentLength;
    CFRelease(contentType);
}

- (void)fillResponseData:(AVAssetResourceLoadingDataRequest *)dataRequest {
    NSUInteger beginIndex = [self beginIndexOfDataRequest:dataRequest];
    
    if ([self.mediaData length] >= beginIndex) {
        NSUInteger unusedDataLength = [self.mediaData length] - beginIndex;
        NSUInteger toSavedDataLength = MIN(unusedDataLength, dataRequest.requestedLength);
        [dataRequest respondWithData:[self.mediaData subdataWithRange:NSMakeRange(beginIndex, toSavedDataLength)]];
    }
}

- (BOOL)isLoadingRequestFinished:(AVAssetResourceLoadingDataRequest *)dataRequest {
    NSUInteger beginIndex = [self beginIndexOfDataRequest:dataRequest];
    
    if ([self.mediaData length] >= (beginIndex + dataRequest.requestedLength)) {
        return YES;
    }
    
    return NO;
}

- (NSUInteger)beginIndexOfDataRequest:(AVAssetResourceLoadingDataRequest *)dataRequest {
    int64_t beginIndex = dataRequest.requestedOffset;
    if (dataRequest.currentOffset > 0) {
        beginIndex = dataRequest.currentOffset;
    }
    
    return (NSUInteger)beginIndex;
}

- (void)processFinshedMediaLoader {
    [self.resourceLoader setDelegate:nil queue:nil];
    self.resourceLoader = nil;
    
    [[MediaLoaderFactory sharedInstance] removeMediaLoader:self];
}

- (void)processLoadingRequestWithData:(NSData *)data {
    if (self.HTTPResponse != nil && data != nil) {
        for (AVAssetResourceLoadingRequest *loadingRequest in self.loadingRequest) {
            [loadingRequest finishLoadingWithResponse:self.HTTPResponse data:data redirect:nil];
        }
    }
}

#pragma mark OS Version

- (BOOL)isiOS6X {
    return [[[UIDevice currentDevice] systemVersion] integerValue] == 6;
}

@end
