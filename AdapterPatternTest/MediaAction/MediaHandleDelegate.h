//
//  MediaHandleDelegate.h
//  AdapterPatternTest
//
//  Created by Peng he on 2017/2/25.
//  Copyright © 2017年 Peng he. All rights reserved.
//


#import <Foundation/Foundation.h>

@protocol MediaHandleDelegate <NSObject>

@optional

- (void)returnMedidaData:(id)mediaData;

@end
