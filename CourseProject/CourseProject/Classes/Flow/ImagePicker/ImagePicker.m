//
//  ImagePicker.m
//  TeamProject
//
//  Created by Oleksii Tsoniev on 1/12/18.
//  Copyright © 2018 EPAM. All rights reserved.
//

#import "ImagePicker.h"


@interface ImagePicker ()

@property(strong, nonatomic) UIViewController *sourceViewController;
@property(weak, nonatomic) ImagePickerDelegate delegate;

@end

@implementation ImagePicker

- (void)presentImagePickerIn:(UIViewController *)sourceViewController
                    delegate:(ImagePickerDelegate)delegate {
    self.sourceViewController = sourceViewController;
    [sourceViewController presentViewController:[self alertController] animated:YES completion:nil];
    self.delegate = delegate;
}

- (UIAlertController *)alertController {
    UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:@"Photo Source"
                                                                         message:@"Choose a source"
                                                                  preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *cameraAction = [UIAlertAction actionWithTitle:@"Camera"
                                                           style:UIAlertActionStyleDefault
                                                         handler:^(UIAlertAction * _Nonnull action) {
                                                             [self presentImagePickerWithType:UIImagePickerControllerSourceTypeCamera];
                                                         }];
    UIAlertAction *libraryAction = [UIAlertAction actionWithTitle:@"Photo Library"
                                                            style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction * _Nonnull action) {
                                                              [self presentImagePickerWithType:UIImagePickerControllerSourceTypePhotoLibrary];
                                                          }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel"
                                                           style:UIAlertActionStyleCancel
                                                         handler:nil];
    [actionSheet addAction:cameraAction];
    [actionSheet addAction:libraryAction];
    [actionSheet addAction:cancelAction];
    
    return actionSheet;
}

- (void)presentImagePickerWithType:(UIImagePickerControllerSourceType)sourceType {
    if ([UIImagePickerController isSourceTypeAvailable:sourceType]) {
        UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
        imagePicker.sourceType = sourceType;
        imagePicker.delegate = self.delegate;
        [self.sourceViewController presentViewController:imagePicker animated:YES completion:nil];
    }
}
@end
