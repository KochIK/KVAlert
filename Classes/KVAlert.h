//
//  KVAlert.h
//  KVAlert
//
//  Created by PintaWebWare on 30.11.16.
//  Copyright © 2016 Kochergin Vlad. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface KVAlert : NSObject

typedef void(^KVAlertWithButton)(NSUInteger buttonPresed);
typedef void(^KVAlertWithTextField)(NSUInteger buttonPresed, NSArray<UITextField *> *textField);
typedef void(^KVAlertResponse)(void);

+ (void)alertWithTitle:(NSString *)title message:(NSString *)message preferredStyle:(UIAlertControllerStyle)preferredStyle completion:(KVAlertResponse)completion;

+ (void)alertWithTitle:(NSString *)title message:(NSString *)message buttons:(NSArray *)buttons preferredStyle:(UIAlertControllerStyle)preferredStyle completion:(KVAlertWithButton)completion;

+ (void)alertWithTitle:(NSString *)title message:(NSString *)message buttons:(NSArray *)buttons textField:(NSArray <UITextField *> *)textField completion:(KVAlertWithTextField)completion;

@end
