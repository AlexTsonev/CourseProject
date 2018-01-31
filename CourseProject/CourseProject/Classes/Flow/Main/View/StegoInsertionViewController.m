//
//  ViewController.m
//  CourseProject
//
//  Created by Alex Tsonev on 31.01.18.
//  Copyright © 2018 Alex Tsonev. All rights reserved.
//

#import "StegoInsertionViewController.h"
#import <ISStego/ISSteganographer.h>
#import "ImagePicker.h"

@interface StegoInsertionViewController () <UINavigationControllerDelegate, UIImagePickerControllerDelegate, StegoInsertionViewControllerDelegate>

@property(strong, nonatomic) ImagePicker *picker;
@property(weak, nonatomic) IBOutlet UIImageView *stegoImageView;
@property(weak, nonatomic) IBOutlet UITextField *messageTextField;


@end

@implementation StegoInsertionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.picker = [[ImagePicker alloc] init];
    self.delegate = self;
}

- (IBAction)imageDidTap:(UITapGestureRecognizer *)sender {
    [self.view endEditing:YES];
    [self.picker presentImagePickerIn:self delegate:self];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    UIImage *pickedImage = info[UIImagePickerControllerOriginalImage];
    if (pickedImage) {
        self.stegoImageView.image = pickedImage;
        [picker dismissViewControllerAnimated:YES completion:nil];
    }
}

- (IBAction)submitButtonDidTap:(UIButton *)sender {
    if (self.stegoImageView.image != nil && ![self.messageTextField.text isEqualToString:@""]) {
        [ISSteganographer hideData:self.messageTextField.text
                         withImage:self.stegoImageView.image completionBlock:^(id image, NSError *error) {
                             dispatch_async(dispatch_get_main_queue(), ^{
                                 if (error == nil) {
                                     self.stegoImageView.image = image;
                                     [self.delegate didInsertStegoIntoImage:image];
                                 } else {
                                     NSLog(@"Stego error: %@", error);
                                 }
                             });
                         }];
    }
}

- (void)didInsertStegoIntoImage:(UIImage *)stegoImage {
    [ISSteganographer dataFromImage:stegoImage completionBlock:^(NSData *data, NSError *error) {
        NSString *hiddenMessage = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"message: %@", hiddenMessage);
    }];
}

@end
