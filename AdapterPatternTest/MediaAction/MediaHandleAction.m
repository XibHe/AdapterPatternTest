//
//  MediaHandleAction.m
//  AdapterPatternTest
//
//  Created by Peng he on 2017/2/25.
//  Copyright © 2017年 Peng he. All rights reserved.
//

#import "MediaHandleAction.h"
#import "MediaHandleSystemPic.h"
#import "MediaHandleVideo.h"

@implementation MediaHandleAction

static NSMutableDictionary * mediaHandleActions = nil;

+ (void)registerCommonAction
{
    [MediaHandleSystemPic load];
    [MediaHandleVideo load];
}

+ (void)registerMediaHandleAction:(MediaHandleAction *)mediaHandleAct andKey:(NSString *)actKey
{
    @synchronized(self){
        if (!mediaHandleActions)
        {
            mediaHandleActions = [NSMutableDictionary dictionary];
            [MediaHandleAction registerCommonAction];
        }
        [mediaHandleActions setObject:mediaHandleAct forKey:actKey];
    }
}

+ (NSDictionary *)mediaHandleActions
{
    NSDictionary * acts = nil;
    @synchronized(self){
        if (!mediaHandleActions)
        {
            mediaHandleActions = [NSMutableDictionary dictionary];
            [MediaHandleAction registerCommonAction];
        }
        acts = mediaHandleActions;
    }
    
    return acts;
}

- (void)performAction
{
    
}

- (void)returnMedidaData:(NSString *)data
{
    
}

- (void)performActionWichController:(UIViewController *)controller callbackClass:(NSObject *)callbackClass
{
    
}

@end
