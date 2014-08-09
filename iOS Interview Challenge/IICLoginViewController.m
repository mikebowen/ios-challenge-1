//
//  IICViewController.m
//  iOS Interview Challenge
//
//  Created by Bowen, Mike on 8/8/14.
//  Copyright (c) 2014 sandbox. All rights reserved.
//

#import "IICLoginViewController.h"
#import "IICUser.h"

NSString *const kWelcomeSegueIdentifier = @"WelcomeSegueIdentifier";

@interface IICLoginViewController () <UITextFieldDelegate>

@property (nonatomic, strong) IICUser *user;
@property (weak, nonatomic) IBOutlet UITextField *usernameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
- (IBAction)submitTapped:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIButton *submitButton;

@end

@implementation IICLoginViewController

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self != nil)
    {
        _user = [[IICUser alloc] init];
    }
    return self;
}

- (void)dealloc
{
    self.usernameTextField.delegate = nil;
    self.passwordTextField.delegate = nil;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.usernameTextField.delegate = self;
    self.passwordTextField.delegate = self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    // Reset user object when view is presented, either from initial app load or navigation back
    self.user = [[IICUser alloc] init];
    self.usernameTextField.text = self.user.username;
    self.passwordTextField.text = self.user.password;
    
    //Make username field first responder so user can edit value immediately
    [self.usernameTextField becomeFirstResponder];
    
}
- (IBAction)submitTapped:(UIButton *)sender
{
    self.user.username = self.usernameTextField.text;
    self.user.password = self.passwordTextField.text;
    
    // Check if user object is valid, if show, present next view controller, if not present errors through alert view
    if (sender == self.submitButton)
    {
        if([self.user isUserValid])
        {
            [self performSegueWithIdentifier:kWelcomeSegueIdentifier sender:sender];
        }
        else
        {
            NSString *usernameError = [self.user usernameValidationError];
            NSString *passwordError = [self.user passwordValidationError];
            
            NSString *displayError = @"";
            if(usernameError != nil)
                displayError = [[displayError stringByAppendingString:usernameError] stringByAppendingString:@"\n"];
            
            if(passwordError != nil)
                displayError = [displayError stringByAppendingString:passwordError];
            
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error" message:displayError delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alertView show];
        }
    }
}

#pragma mark UITextFieldDelegate
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if(textField == self.usernameTextField)
    {
        self.user.username = textField.text;
        NSString *usernameValidation = [self.user usernameValidationError];
        // If there is an issue with the validation of the username, set the text field background to red
        [self setTextFieldValidationColor:(usernameValidation==nil) forTextField:textField];
    }
    
    if(textField == self.passwordTextField)
    {
        self.user.password = textField.text;
        NSString *passwordValidation = [self.user passwordValidationError];
        // If there is an issue with the validation of the password, set the text field background to red
        [self setTextFieldValidationColor:(passwordValidation==nil) forTextField:textField];
    }
    [textField resignFirstResponder];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField == self.usernameTextField)
    {
        [textField resignFirstResponder];
        [self.passwordTextField becomeFirstResponder];
    }
    if (textField == self.passwordTextField)
    {
        [textField resignFirstResponder];
    }
    return YES;
}

#pragma mark - Helper Methods

- (void)setTextFieldValidationColor:(BOOL)isValid forTextField:(UITextField*)textField
{
    if(isValid)
        [textField setBackgroundColor:[UIColor whiteColor]];
    else
        [textField setBackgroundColor:[UIColor colorWithRed:0.8f green:0.0f blue:0.0f alpha:0.5f]];
}

@end

