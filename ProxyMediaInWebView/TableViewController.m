//
//  ViewController.m
//  ProxyMediaInWebView
//
//  Created by DjangoZhang on 14/11/28.
//  Copyright (c) 2014年 DjangoZhang. All rights reserved.
//

#import "TableViewController.h"
#import "WebViewController.h"

@interface TableViewController ()

@end

@implementation TableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark 

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellID = @"CellID";
    NSArray *titleArray = @[@"Audio", @"Video"];
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    
    cell.textLabel.text = titleArray[indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSArray *mediaURLArray = @[[NSURL URLWithString:@"http://so.bq.yymommy.com/song/?song_id=338360"], [NSURL URLWithString:@"http://u5.a.yximgs.com/upic/2014/07/04/22/BMjAxNDA3MDQyMjA0MjRfODQ0MjQ5MF8yXw==.mp4"]];
    
    WebViewController *controller = [[WebViewController alloc] init];
    controller.URL = [mediaURLArray objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:controller animated:YES];
}

@end
