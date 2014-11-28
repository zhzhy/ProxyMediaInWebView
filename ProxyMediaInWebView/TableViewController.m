//
//  ViewController.m
//  ProxyMediaInWebView
//
//  Created by DjangoZhang on 14/11/28.
//  Copyright (c) 2014年 DjangoZhang. All rights reserved.
//

#import "TableViewController.h"

#import <AVFoundation/AVFoundation.h>

@interface TableViewController ()

@property(nonatomic, strong) AVPlayer *mediaPlayer;
@end

@implementation TableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self playMedia];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSURL *)mediaURL {
    return [NSURL URLWithString:@"http://u5.a.yximgs.com/upic/2014/07/04/22/BMjAxNDA3MDQyMjA0MjRfODQ0MjQ5MF8yXw==.mp4"];
}

- (void)playMedia {
    AVURLAsset *asset = [AVURLAsset URLAssetWithURL:[self mediaURL] options:nil];
    
    AVPlayerItem *playerItem = [AVPlayerItem playerItemWithAsset:asset];
    self.mediaPlayer = [[AVPlayer alloc] initWithPlayerItem:playerItem];
    
    AVPlayerLayer *playerLayer = [AVPlayerLayer playerLayerWithPlayer:self.mediaPlayer];
    playerLayer.videoGravity = AVLayerVideoGravityResizeAspect;
    playerLayer.frame = self.view.bounds;
    [self.view.layer addSublayer:playerLayer];
    
    [playerItem addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew context:NULL];
}

#pragma NSKeyValueObserving

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if (self.mediaPlayer.currentItem.status == AVPlayerItemStatusReadyToPlay) {
        [self.mediaPlayer play];
    }
}

@end
