//
//  MediaHandleVideo.m
//  AdapterPatternTest
//
//  Created by Peng he on 2017/2/25.
//  Copyright © 2017年 Peng he. All rights reserved.
//

#import "MediaHandleVideo.h"
#import <AVFoundation/AVFoundation.h>
#import <MobileCoreServices/MobileCoreServices.h>

#define DOCUMENTPATH [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)objectAtIndex:0]//文档路径

@interface MediaHandleVideo ()
{
    UIViewController * _parentControler;
}
@end

@implementation MediaHandleVideo

+ (void)load
{
    [MediaHandleAction registerMediaHandleAction:[[MediaHandleVideo alloc] init] andKey:@"video"];
}

- (void)performActionWichController:(UIViewController *)controller callbackClass:(NSObject *)callbackClass
{
    _parentControler = controller;
    _delegate = (id)callbackClass;
    
    UIImagePickerController * picker = [[UIImagePickerController alloc] init];
    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    picker.mediaTypes=@[(NSString *)kUTTypeMovie];
    picker.videoQuality=UIImagePickerControllerQualityTypeIFrame1280x720;
    picker.cameraCaptureMode=UIImagePickerControllerCameraCaptureModeVideo;
    picker.delegate = (id)self;
    [_parentControler presentViewController:picker animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [picker dismissViewControllerAnimated:YES completion:nil];
    //将视频存本地
    NSURL *videoURL = [info objectForKey:UIImagePickerControllerMediaURL];
    NSData *videoData = [NSData dataWithContentsOfURL:videoURL];
    
    NSString *videoPath = [DOCUMENTPATH stringByAppendingFormat:@"/vid1.mp4"];
    
    NSURL * selectedVideoUrl = [info objectForKey:UIImagePickerControllerMediaURL];
    AVPlayerItem *playerItem = [AVPlayerItem playerItemWithURL:selectedVideoUrl];
    
    CMTime duration = playerItem.duration;
    float seconds = CMTimeGetSeconds(duration);
    NSLog(@"duration: %f", seconds);
    
    if ([videoData writeToFile:videoPath atomically:NO])
    {
        if (_delegate && [_delegate respondsToSelector:@selector(returnMedidaData:)])
        {
            [_delegate returnMedidaData:videoPath];
        }
    }
}


@end
