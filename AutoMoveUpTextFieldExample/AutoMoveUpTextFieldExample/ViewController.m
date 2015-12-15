//
//  ViewController.m
//  AutoMoveUpTextFieldExample
//
//  Created by Yoppy Yunhasnawa on 14/12/15.
//  Copyright © 2015 Yoppy Yunhasnawa. All rights reserved.
//

#import "ViewController.h"
#import "UIViewController+YYHelper.h"

@interface ViewController ()

- (void) addText;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - Added methods. All methods and commented code below this mark you should add it to your project

- (void) viewWillDisappear:(BOOL)animated
{
    [self unregisterMoveUpViewOnKeyboadShown]; // No need to track text field when the view is gone.
}

- (void) viewWillAppear:(BOOL)animated
{
    [self registerMoveUpViewOnKeyboadShown]; // Confirm auto move up
    [self setUpDistanceAddition:6.f]; // Custom up distance. The bigger the value the higer text field will moves up
    [self setNeedsTextViewInvisibleDismissButton]; // Enable dismiss keyboard when user taps empty area
}

- (UIView*) superviewForTextInputView:(UIView *)textInputView
{
    return self.view; // The parent view of currently observed text view
}

- (NSArray*) textFieldsRegisteredForDismissButton
{
    return @[self.textFieldMessage]; // Which text input you need to have auto muve up behavior. You can put more than one components inside the array returned by this function.
}

#pragma mark - Tester. These are not mandatory

- (IBAction)sendButtonClick:(id)sender
{
    [self addText];
    
    [self dismissKeyboard]; // This is provided by the helper
}

- (void) addText
{
    NSString* chat = self.textViewChat.text;
    
    NSString* newChat = self.textFieldMessage.text;
    
    chat = [chat stringByAppendingFormat:@"%@\n", newChat];
    
    self.textViewChat.text = chat;
    
    self.textFieldMessage.text = @"";
}

- (BOOL) textFieldShouldReturn:(UITextField *)textField
{
    [self addText];
    
    [textField resignFirstResponder];
    
    return YES;
}

@end
