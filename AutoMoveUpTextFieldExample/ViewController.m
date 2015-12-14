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

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Added Methods

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
    return @[self.textFieldMessage];
}

- (IBAction)sendButtonClick:(id)sender
{
    [self dismissKeyboard];
}

@end
