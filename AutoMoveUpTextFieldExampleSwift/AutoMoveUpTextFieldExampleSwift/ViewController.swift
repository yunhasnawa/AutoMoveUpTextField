//
//  ViewController.swift
//  AutoMoveUpTextFieldExampleSwift
//
//  Created by Yoppy Yunhasnawa on 15/12/15.
//  Copyright © 2015 Yoppy Yunhasnawa. All rights reserved.
//

import UIKit

class ViewController: UIViewController
{
    @IBOutlet var textFieldMessage: UITextField!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.yellowColor();
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: Added Methods
    
    override func viewWillDisappear(animated: Bool)
    {
        self.unregisterMoveUpViewOnKeyboadShown();  // No need to track text field when the view is gone.
    }
    
    override func viewWillAppear(animated: Bool)
    {
        self.registerMoveUpViewOnKeyboadShown();
        self.setUpDistanceAddition(6.0);
        self.setNeedsTextViewInvisibleDismissButton();
    }
    
    override func superviewForTextInputView(textInputView: UIView!) -> UIView!
    {
        return self.view;
    }
    
    override func textFieldsRegisteredForDismissButton() -> [AnyObject]!
    {
        return [self.textFieldMessage];
    }
    
    @IBAction func sendButtonClick(sender: AnyObject)
    {
        //self.testMethod();
        self.dismissKeyboard();
    }
}

