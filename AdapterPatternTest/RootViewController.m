//
//  RootViewController.m
//  AdapterPatternTest
//
//  Created by Peng he on 2017/2/25.
//  Copyright © 2017年 Peng he. All rights reserved.
//

#import "RootViewController.h"
#import "MediaHandleSystemPic.h"
#import "MediaHandleVideo.h"

// 获取设备物理高度
#define ScreenHeight    [UIScreen mainScreen].bounds.size.height
// 获取设备物理宽度
#define ScreenWidth     [UIScreen mainScreen].bounds.size.width

@interface RootViewController ()
{
    NSArray *_dataSourceArray;
}
@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"适配器模式初探";
    self.tableView.rowHeight = ScreenWidth * 80 / 375 / 2;
    _dataSourceArray = @[@"调用系统相机/相册",@"调用系统摄像机"];
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 1;
}

#pragma mark - Table view data delegate
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIndentify = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentify];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentify];
    }
    
    cell.textLabel.text = _dataSourceArray[indexPath.section];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        
        return ScreenWidth * 20 / 375 / 2;
        
    } else {
        
        return 0.1;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return ScreenWidth * 20 / 375 / 2;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section == 0) {
        
        MediaHandleSystemPic * album = [[MediaHandleAction mediaHandleActions] objectForKey:@"systemPic"];
        [album performActionWichController:self callbackClass:self];
        
    } else if (indexPath.section == 1) {
        
        MediaHandleVideo * video = [[MediaHandleAction mediaHandleActions] objectForKey:@"video"];
        [video performActionWichController:self callbackClass:self];
    }

}

@end
