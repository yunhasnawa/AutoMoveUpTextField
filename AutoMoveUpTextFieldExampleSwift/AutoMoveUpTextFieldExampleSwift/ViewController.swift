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
    @IBOutlet var textViewChat: UITextView!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.textViewChat.text = ""
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: Added methods. All methods and commented code below this mark you should add it to your project
    
    override func viewWillDisappear(animated: Bool)
    {
        self.unregisterMoveUpViewOnKeyboadShown()  // No need to track text field when the view is gone.
    }
    
    override func viewWillAppear(animated: Bool)
    {
        self.registerMoveUpViewOnKeyboadShown()  // Confirm auto move up
        self.setUpDistanceAddition(6.0) // Custom up distance. The bigger the value the higer text field will moves up
        self.setNeedsTextViewInvisibleDismissButton() // Enable dismiss keyboard when user taps empty area
    }
    
    override func superviewForTextInputView(textInputView: UIView!) -> UIView!
    {
        return self.view  // The parent view of currently observed text view
    }
    
    override func textFieldsRegisteredForDismissButton() -> [AnyObject]!
    {
        return [self.textFieldMessage] // Which text input you need to have auto muve up behavior. You can put more than one components inside the array returned by this function.
    }
    
    // MARK: Tester. These are not mandatory
    
    @IBAction func sendButtonClick(sender: AnyObject)
    {
        self.addText()
        
        self.dismissKeyboard();
    }
    
    private func addText()
    {
        var chat = self.textViewChat.text!
        
        let newChat = self.textFieldMessage.text!
        
        chat += newChat + "\n"
        
        self.textViewChat.text = chat
        
        self.textFieldMessage.text = ""
    }
    
    override func textFieldShouldReturn(textField: UITextField) -> Bool
    {
        self.addText()
        
        textField.resignFirstResponder()
        
        return true;
    }
}

