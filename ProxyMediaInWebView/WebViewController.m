//
//  WebViewController.m
//  ProxyMediaInWebView
//
//  Created by DjangoZhang on 14/11/28.
//  Copyright (c) 2014年 DjangoZhang. All rights reserved.
//

#import "WebViewController.h"

@interface WebViewController ()

@property(nonatomic, strong) UIWebView *webView;
@end

@implementation WebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:self.webView];
    
    [self.webView loadRequest:[NSURLRequest requestWithURL:self.URL]];
}

@end
