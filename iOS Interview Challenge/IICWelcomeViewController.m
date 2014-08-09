//
//  IICWelcomeViewController.m
//  iOS Interview Challenge
//
//  Created by Bowen, Mike on 8/8/14.
//  Copyright (c) 2014 sandbox. All rights reserved.
//

#import "IICWelcomeViewController.h"

@interface IICWelcomeViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *welcomeImageView;

@end

@implementation IICWelcomeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Add tap gesture recognizer to image view to show alert when tapped
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageViewTapped:)];
    [self.welcomeImageView addGestureRecognizer:tapGesture];
}

- (void)imageViewTapped:(UITapGestureRecognizer*)sender
{
    if (sender.state == UIGestureRecognizerStateEnded)
    {
        // Present "Hello World" alert view when the image view is tapped
        if (sender.view  == self.welcomeImageView)
        {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:@"Hello World" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alertView show];
        }
    }
}


@end
