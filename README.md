# AutoMoveUpTextFieldExample
An easy and simple helper to have iOS textfield moves up automatically when keyboard appear.

All you need to do are:
1. Add the folder 'Helper' to your project.
2. Import UIViewController+YYHelper.h to any view controller that has text input you want to be auto moved when UIKeyboard appears.
3. Make sure your view controller is being the delegate of your text input: <UITextFieldDelegate> or <UITextInputDelegate>, or both depends on your need.
4. The library will look good on real device, but in simulator it may not work if you connect the simulator to hardware keyboard. To disable it, select 'Hardware' -> Keyboard -> Uncheck 'Connect Hardware Keyboard' on simulator window.

The rest of code lines are explained in the ViewController source file file in the example.