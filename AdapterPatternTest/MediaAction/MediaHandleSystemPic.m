//
//  MediaHandleSystemPic.m
//  AdapterPatternTest
//
//  Created by Peng he on 2017/2/25.
//  Copyright © 2017年 Peng he. All rights reserved.
//

#import "MediaHandleSystemPic.h"

@interface MediaHandleSystemPic()<UIImagePickerControllerDelegate>
{
    UIViewController * _parentController;
}

@end

@implementation MediaHandleSystemPic

+ (void)load
{
    [MediaHandleAction registerMediaHandleAction:[[MediaHandleSystemPic alloc] init] andKey:@"systemPic"];
}

- (void)performActionWichController:(UIViewController *)controller callbackClass:(NSObject *)callbackClass
{
    _parentController = controller;
    _delegate = (id)callbackClass;
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *photographAction = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        picker.editing = YES;
        picker.allowsEditing = YES;
        picker.delegate = (id)self;
        [_parentController presentViewController:picker animated:YES completion:nil];

    }];
    
    UIAlertAction *albumAction = [UIAlertAction actionWithTitle:@"从相册选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = (id)self;
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        picker.allowsEditing = YES;
        [_parentController presentViewController:picker animated:YES completion:nil];

    }];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    [alertController addAction:photographAction];
    [alertController addAction:albumAction];
    [alertController addAction:cancelAction];

    [_parentController presentViewController:alertController animated:YES completion:^{
        
    }];

}

#pragma mark - UIImagePickerControllerDelegate
- (void) imagePickerController: (UIImagePickerController*) picker didFinishPickingMediaWithInfo: (NSDictionary*) info
{
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    UIImage *edit = [info objectForKey:@"UIImagePickerControllerEditedImage"];
    UIImage *originalImage = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
    NSLog(@" EditedImage %@ ",NSStringFromCGSize(edit.size));
    NSLog(@" OriginalImage %@ ",NSStringFromCGSize(originalImage.size));
    UIImage *aImage = edit;
    NSData * imageData = UIImageJPEGRepresentation(aImage,0.5);
    
    if (_delegate && [_delegate respondsToSelector:@selector(returnMedidaData:)])
    {
        [_delegate returnMedidaData:imageData];
    }
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:nil];
}

@end
