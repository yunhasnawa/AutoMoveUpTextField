//
//  UIViewController+YYHelper.m
//  Appsence
//
//  Created by Yoppy Yunhasnawa on 9/28/13.
//  Copyright (c) 2013 Yunhasnawa. All rights reserved.
//

#import "UIViewController+YYHelper.h"
#import "YYAppHelper.h"

@implementation UIViewController (YYHelper)

UITextField* _activeTextField;
UITextView* _activeTextView;
CGFloat _upDistanceAddition = 0.f;
CGRect _originalViewFrame;
CGRect _movedUpViewFrame;
UIButton* _invisibleButton;
CGFloat _textInputBottomTreshold = 0.f;
CGRect _keyboardFrame;
BOOL _isUp = NO;

const CGFloat kDefaultUpDistanceAddition = 10.f;

#pragma mark - Input view delegates

- (void) textFieldDidBeginEditing:(UITextField *)textField
{
    _activeTextField = textField;
    
    // Switch active text input view
    _activeTextView = nil;
}

- (void) textViewDidBeginEditing:(UITextView *)textView
{
    _activeTextView = textView;
    
    // Switch active text input view
    _activeTextField = nil;
}

- (void) textFieldDidEndEditing:(UITextField *)textField
{
    _activeTextField = nil;
}

- (void) textViewDidEndEditing:(UITextView *)textView
{
    _activeTextView = nil;
}

#pragma mark - Getter & setter

- (void) setUpDistanceAddition:(CGFloat) upDistanceAddition
{
    _upDistanceAddition = upDistanceAddition;
}

- (CGFloat) upDistanceAddition
{
    return _upDistanceAddition;
}

- (void) setOriginalViewFrame:(CGRect) originalViewFrame
{
    _originalViewFrame = originalViewFrame;
}

- (CGRect) originalViewFrame
{
    return _originalViewFrame;
}

- (void) setMovedUpViewFrame:(CGRect) movedUpViewFrame
{
    _movedUpViewFrame = movedUpViewFrame;
}

- (CGRect) movedUpViewFrame
{
    return _movedUpViewFrame;
}

- (void) setKeyboardFrame:(CGRect) keyboardFrame
{
    _keyboardFrame = keyboardFrame;
}

- (CGRect) keyboardFrame
{
    return _keyboardFrame;
}

- (UITextField*) activeTextField
{
    return _activeTextField;
}

- (UITextView*) activeTextView
{
    return _activeTextView;
}

- (void) setTextInputViewBottomTreshold:(CGFloat) treshold
{
    _textInputBottomTreshold = treshold;
}

- (CGFloat) textInputViewBottomTreshold
{
    return _textInputBottomTreshold;
}

- (void) setIsUp:(BOOL) isUp
{
    _isUp = isUp;
}

- (BOOL) isUp
{
    return _isUp;
}

#pragma mark - Helpers

- (BOOL) isRegisteredDismissButtonTextField:(UITextField*) textField
{
    if([self respondsToSelector:@selector(textFieldsRegisteredForDismissButton)])
    {
        NSArray* textFields = [self textFieldsRegisteredForDismissButton];
        
        if([textFields count] > 0)
        {
            if([textFields indexOfObject:textField] != NSNotFound)
            {
                return YES;
            }
        }
    }
    
    return NO;
}

- (CGFloat) upDistanceWithNotification:(NSNotification*) notification
{
    CGFloat screenHeight = [[UIScreen mainScreen] bounds].size.height;
    
    CGRect keyboardFrame = [[[notification userInfo] objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue];
    
    CGRect inputViewframe = [self frameOfTextInputViewRelativeToSelfView]; // Y nya ngawur.
    
    CGRect inputViewFrameOnWindow = [self frameInWindowOfFrame:inputViewframe];
    
    CGFloat keyboardHeight = keyboardFrame.size.height;
    
    CGFloat keyboardTop = screenHeight - keyboardHeight;
    
    CGFloat inputViewBottom = inputViewFrameOnWindow.origin.y + inputViewFrameOnWindow.size.height + [self textInputViewBottomTreshold];
    
    CGFloat differences = inputViewBottom - keyboardTop;
    
    if(differences > 0)
    {
        CGFloat addition = [self upDistanceAddition];
        
        return differences += (addition + kDefaultUpDistanceAddition);
    }
    else
    {
        return 0.f;
    }
}

- (CGRect) frameInWindowOfFrame:(CGRect) frame
{
    UIWindow* window = self.view.window;
    
    CGPoint convertedPoint = frame.origin;
    
    CGPoint pointInWindow = [self.view convertPoint:convertedPoint toView:window];
    
    frame.origin = pointInWindow;
    
    return frame;
}

- (UIView*) textInputView
{
    if([self activeTextField] != nil)
    {
        return [self activeTextField];
    }
    else
    {
        return [self activeTextView];
    }
}

- (CGRect) frameOfTextInputViewRelativeToSelfView
{
    UIView* inputSuperView = [[self textInputView] superview];
    
    if([self respondsToSelector:@selector(superviewForTextInputView:)])
    {
        inputSuperView = [self superviewForTextInputView:[self textInputView]];
    }
    
    CGRect inputViewFrame = [[self textInputView] frame];
    
    if(inputSuperView == [self view])
    {
        return inputViewFrame;
    }
    else
    {
        CGFloat y = [inputSuperView frame].origin.y + inputViewFrame.origin.y;
        
        inputViewFrame.origin.y = y;
        
        return inputViewFrame;
    }
}

- (CGRect) frameAboveKeyboard
{
    CGRect frame = [self originalViewFrame];
    
    CGRect keyboardFrame = [self keyboardFrame];
    
    frame.size.height -= keyboardFrame.size.height;
    frame.origin.y = frame.size.height;
    
    return frame;
}

#pragma mark - Publics

- (void) registerMoveUpViewOnKeyboadShown
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShowWithNotification:) name:UIKeyboardWillShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHideWithNotification:) name:UIKeyboardWillHideNotification object:nil];
}

- (void) unregisterMoveUpViewOnKeyboadShown
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void) setNeedsTextViewInvisibleDismissButton
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(createInvisibleDismissButtonWithNotification:) name:UIKeyboardDidShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(destroyInvisibleDismissButtonWithNotification:) name:UIKeyboardDidHideNotification object:nil];
}

#pragma mark - Keyboard event handler

/*
 - (void) testMethod
 {
 CGRect originalFrame = [[self view] frame];
 CGRect newFrame = originalFrame;
 
 // Save original frame
 [self setOriginalViewFrame:originalFrame];
 
 CGFloat upDistance = 220.f;
 
 // Move up the view
 newFrame.origin.y -= upDistance;
 
 // Adjust the height so the view doesn't have a 'hole' at bottom
 //newFrame.size.height += upDistance;
 
 NSLog(@"MOVE UP! %f point..", upDistance);
 
 [UIView beginAnimations:@"moveUp" context:NULL];
 
 [[self view] setFrame:newFrame];
 
 [UIView commitAnimations];
 }
 */

- (void) keyboardWillShowWithNotification:(NSNotification *)notification
{
    if([self isUp])
    {
        NSLog(@"The view has been moved up!");
        return;
    }
    
    CGRect originalFrame = [[self view] frame];
    CGRect newFrame = originalFrame;
    
    // Save original frame
    [self setOriginalViewFrame:originalFrame];
    
    CGFloat upDistance = [self upDistanceWithNotification:notification];
    
    if(upDistance <= 0)
        return;
    
    // Move up the view
    newFrame.origin.y -= upDistance;
    
    // Adjust the height so the view doesn't have a 'hole' at bottom
    // EDIT: This one jeopardize the view if the prroject uses auto layout
    // It is because autolayout constraint makes the text input sticks to its parent view.
    // If parent view is not moving then the input will also not move.
    // Finally, the input will stay on its position.
    //newFrame.size.height += upDistance;
    
    [UIView beginAnimations:@"moveUp" context:NULL];
    
    [[self view] setFrame:newFrame];
    
    [self setMovedUpViewFrame:newFrame];
    
    [UIView commitAnimations];
    
    NSLog(@"MOVE UP! %f point..", upDistance);
    
    [self setIsUp:YES];
}

- (void) keyboardWillHideWithNotification:(NSNotification *)notification
{
    if(![self isUp])
    {
        NSLog(@"The view is already in normal state!");
        return;
    }
    
    CGRect avf = [self.view frame];        // Actual View Frame
    CGRect ovf = [self originalViewFrame]; // Original View Frame
    CGRect mvf = [self movedUpViewFrame];  // Moved-up View Frame
    
    if(CGRectEqualToRect(avf, mvf))
    {
        [UIView beginAnimations:@"moveDown" context:NULL];
        
        [[self view] setFrame:ovf];
        
        [UIView commitAnimations];
        
        CGRectLog(self.inputView.frame, @"Down!!! Input View Frame:");
    }
    
    [self setIsUp:NO];
}

- (UIButton*) invisibleButton
{
    if(_invisibleButton == nil)
    {
        _invisibleButton = [UIButton buttonWithType:UIButtonTypeCustom];
        
        CGRect frame = [self frameAboveKeyboard];
        
        [_invisibleButton setFrame:frame];
        
        [_invisibleButton addTarget:self action:@selector(dismissKeyboard) forControlEvents:UIControlEventTouchUpInside];
        
        [_invisibleButton setBackgroundColor:[UIColor clearColor]];
    }
    
    return _invisibleButton;
}

- (void) dismissKeyboard
{
    [[self activeTextView] resignFirstResponder];
    
    [[self activeTextField] resignFirstResponder];
}

- (void) saveKeyboardFrameWithNotification:(NSNotification*) notification
{
    NSDictionary* keyboardInfo = [notification userInfo];
    NSValue* keyboardFrameBegin = [keyboardInfo valueForKey:UIKeyboardFrameBeginUserInfoKey];
    CGRect keyboardFrameBeginRect = [keyboardFrameBegin CGRectValue];
    
    [self setKeyboardFrame:keyboardFrameBeginRect];
}

#pragma mark - Invisible dismiss button for UITextView

// TODO: Change method naming to the standard like in the #keyboard event handler
- (void) createInvisibleDismissButtonWithNotification:(NSNotification*) notification
{
    UIView* inputView = [self textInputView];
    
    if(inputView != nil)
    {
        BOOL isKindOfTextView = [inputView isKindOfClass:UITextView.class];
        BOOL isRegistered = [self isRegisteredDismissButtonTextField:(UITextField*)inputView];
        
        if(isKindOfTextView || isRegistered)
        {
            //NSLog(@"DISMISS BUTTON APPEAR!");
            
            // Save keyboard frame
            [self saveKeyboardFrameWithNotification:notification];
            
            [[self view] insertSubview:[self invisibleButton] atIndex:0];
            
            // For testing
            //[[self invisibleButton] setBackgroundColor:[UIColor greenColor]];
        }
    }
    else
    {
        NSLog(@"ERROR: You should assign proper delegate for the desired text view!");
    }
}

- (void) destroyInvisibleDismissButtonWithNotification:(NSNotification*) notification
{
    //NSLog(@"DESTROY DISMISS BUTTON!");
    
    [[self invisibleButton] removeFromSuperview];
}

@end
