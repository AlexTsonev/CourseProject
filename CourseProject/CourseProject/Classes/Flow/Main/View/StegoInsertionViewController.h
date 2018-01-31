//
//  ViewController.h
//  CourseProject
//
//  Created by Alex Tsonev on 31.01.18.
//  Copyright © 2018 Alex Tsonev. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol StegoInsertionViewControllerDelegate

- (void)didInsertStegoIntoImage:(UIImage *)stegoImage;

@end

@interface StegoInsertionViewController : UIViewController

@property(weak, nonatomic) id<StegoInsertionViewControllerDelegate> delegate;

@end

