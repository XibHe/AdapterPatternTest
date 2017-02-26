//
//  MediaHandleAction.h
//  AdapterPatternTest
//
//  Created by Peng he on 2017/2/25.
//  Copyright © 2017年 Peng he. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "MediaHandleDelegate.h"

@interface MediaHandleAction : NSObject
{
    id <MediaHandleDelegate> _delegate;
}

// 动态注册新的Action
+ (void)registerMediaHandleAction:(MediaHandleAction *)mediaHandleAct andKey:(NSString *) actKey;

// 获取注册的Action
+ (NSDictionary *)mediaHandleActions;

// 具体的执行方法
- (void)performActionWichController:(UIViewController *)controller callbackClass:(NSObject *)callbackClass;

@end
