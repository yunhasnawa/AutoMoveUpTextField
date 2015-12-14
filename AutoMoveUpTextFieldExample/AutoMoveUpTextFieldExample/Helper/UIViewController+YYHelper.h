//
//  UIViewController+YYHelper.h
//  Appsence
//
//  Created by Yoppy Yunhasnawa on 9/28/13.
//  Copyright (c) 2013 Yunhasnawa. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol YYVIewControllerDelegate <NSObject>

@optional
- (UIView*) superviewForTextInputView:(UIView*) textInputView;
- (NSArray*) textFieldsRegisteredForDismissButton;

@end

@interface UIViewController (YYHelper)<UITextFieldDelegate, UITextViewDelegate, YYVIewControllerDelegate>

- (void) registerMoveUpViewOnKeyboadShown;
- (void) unregisterMoveUpViewOnKeyboadShown;
- (UITextField*) activeTextField;
- (UITextView*) activeTextView;
- (void) setUpDistanceAddition:(CGFloat) upDistanceAddition;
- (CGFloat) upDistanceAddition;
- (void) setNeedsTextViewInvisibleDismissButton;
- (void) setTextInputViewBottomTreshold:(CGFloat) treshold;
- (CGRect) frameAboveKeyboard;
- (void) dismissKeyboard;

@end
