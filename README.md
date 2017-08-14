# KVAlert
Easy implementation of alerts - KVAlert

## Installation

### Using CocoaPods

 KVAlert is available through [CocoaPods](http://cocoapods.org), to install 
 it simply add the following line to your Podfile:
 
    pod "KVAlert"
 
 ### Manual
 
  Download the project and add the files `KVAlert.{h,m}` to your project.

## Usage

    [KVAlert alertWithTitle:@"Title" message:@"Message" buttons:@[@"First", @"Second"] preferredStyle:UIAlertControllerStyleAlert 
    completion:^(NSUInteger buttonPresed) {
      NSLog(@"Alert With Buttons - Close");
      switch (buttonPresed) 
      {
        case 0:
           NSLog(@"\tFirst button pressed");
           break;
        case 1:
           NSLog(@"\tSecond button pressed");
           break;
      }
    }];
    
### Methods

    + (void)alertWithTitle:(NSString *)title 
                   message:(NSString *)message 
            preferredStyle:(UIAlertControllerStyle)preferredStyle  
                completion:(KVAlertResponse)completion;

    + (void)alertWithTitle:(NSString *)title 
                   message:(NSString *)message 
                   buttons:(NSArray *)buttons 
            preferredStyle:(UIAlertControllerStyle)preferredStyle 
                completion:(KVAlertWithButton)completion;

    + (void)alertWithTitle:(NSString *)title 
                   message:(NSString *)message 
                   buttons:(NSArray *)buttons 
                 textField:(NSArray  <UITextField *> *)textField 
                completion:(KVAlertWithTextField)completion;
  
## Author

 Vlad Kochergin, kargod@ya.ru
 
## License
 
 KVAlert is available under the MIT license. See the LICENSE file for more info.
