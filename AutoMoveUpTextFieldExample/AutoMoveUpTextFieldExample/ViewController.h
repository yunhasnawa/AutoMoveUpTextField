//
//  ViewController.h
//  AutoMoveUpTextFieldExample
//
//  Created by Yoppy Yunhasnawa on 14/12/15.
//  Copyright © 2015 Yoppy Yunhasnawa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UITextFieldDelegate>

@property (strong, nonatomic) IBOutlet UITextField *textFieldMessage;
@property (strong, nonatomic) IBOutlet UITextView *textViewChat;

- (IBAction)sendButtonClick:(id)sender;

@end