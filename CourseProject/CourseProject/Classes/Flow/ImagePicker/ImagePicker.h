//
//  ImagePicker.h
//  TeamProject
//
//  Created by Oleksii Tsoniev on 1/12/18.
//  Copyright © 2018 EPAM. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef id<UINavigationControllerDelegate, UIImagePickerControllerDelegate> ImagePickerDelegate;

@interface ImagePicker : NSObject

- (void)presentImagePickerIn:(UIViewController *)sourceViewController
                    delegate:(ImagePickerDelegate)delegate;

@end
