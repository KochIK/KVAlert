//
//  ViewController.m
//  KVAlert
//
//  Created by yvp on 8/14/17.
//  Copyright © 2017 Vlad Kochergin. All rights reserved.
//

#import "ViewController.h"
#import "KVAlert.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UITextField *textField;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Action

- (IBAction)showAlertWithButtonAction:(UIButton *)sender{
    [KVAlert alertWithTitle:@"Title" message:@"Message" buttons:@[@"First", @"Second"] preferredStyle:UIAlertControllerStyleAlert completion:^(NSUInteger buttonPresed) {
        NSLog(@"Alert With Buttons - Close");
        switch (buttonPresed) {
            case 0:
                NSLog(@"\tFirst button pressed");
                break;
            case 1:
                NSLog(@"\tSecond button pressed");
                break;
        }
    }];
}

- (IBAction)showAlertWithTextFieldAction:(UIButton *)sender{
    UITextField *secondTextField = [UITextField new];
    [secondTextField setPlaceholder:@"Second text field"];
    [secondTextField setText:@"Text"];
    
    [KVAlert alertWithTitle:@"Title" message:@"Message" buttons:@[@"First", @"Second"] textField:@[self.textField, secondTextField] completion:^(NSUInteger buttonPresed, NSArray<UITextField *> *textField) {
        NSLog(@"Alert With TextField - Close");
        NSLog(@"\t Button pressed - %li", (long)buttonPresed);
        NSLog(@"\t TextField 0 - %@", [textField firstObject].text);
        NSLog(@"\t TextField 1 - %@", [textField lastObject].text);
    }];
}

- (IBAction)showDefaultAlertAction:(id)sender {
    [KVAlert alertWithTitle:@"Title" message:@"Message" preferredStyle:UIAlertControllerStyleActionSheet completion:^{
        NSLog(@"Default Alert - Close");
    }];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

@end
