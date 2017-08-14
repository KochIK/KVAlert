//
//  KVAlert.m
//  KVAlert
//
//  Created by PintaWebWare on 30.11.16.
//  Copyright © 2016 Kochergin Vlad. All rights reserved.
//

#pragma clang diagnostic ignored "-Warc-performSelector-leaks"

#import "KVAlert.h"
#import <objc/runtime.h>

#define UIKitLocalizedString(key) [[NSBundle bundleWithIdentifier:@"com.apple.UIKit"] localizedStringForKey:key value:@"" table:nil]

@implementation KVAlert

+ (UIAlertController *)getEmptyAler:(NSString *)title message:(NSString *)message preferredStyle:(UIAlertControllerStyle)preferredStyle{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:preferredStyle];
    
    return alertController;
}

+ (void)alertWithTitle:(NSString *)title message:(NSString *)message preferredStyle:(UIAlertControllerStyle)preferredStyle completion:(KVAlertResponse)completion{
    
    UIAlertController *alertController = [self getEmptyAler:title message:message preferredStyle:preferredStyle];
    
    UIAlertAction *cancelButton = [UIAlertAction actionWithTitle:UIKitLocalizedString(@"Cancel") style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        if(completion)
            completion();
    }];
    [alertController addAction:cancelButton];
    [self presentKVAlertOnRootViewController:alertController];
}

+ (void)alertWithTitle:(NSString *)title message:(NSString *)message buttons:(NSArray *)buttons preferredStyle:(UIAlertControllerStyle)preferredStyle completion:(KVAlertWithButton)completion{
    
    UIAlertController *alertController = [self getEmptyAler:title message:message preferredStyle:preferredStyle];
    
    UIAlertAction *cancelButton = [UIAlertAction actionWithTitle:UIKitLocalizedString(@"Cancel") style:UIAlertActionStyleCancel handler:nil];
    [alertController addAction:cancelButton];
    
    [self addButtonsKVAlert:alertController buttons:buttons completion:^(NSUInteger buttonPresed) {
        if(completion)
            completion(buttonPresed);
    }];
    
    [self presentKVAlertOnRootViewController:alertController];
}

+ (void)alertWithTitle:(NSString *)title message:(NSString *)message buttons:(NSArray *)buttons textField:(NSArray <UITextField *> *)textField completion:(KVAlertWithTextField)completion{
    
    UIAlertController *alertController = [self getEmptyAler:title message:message preferredStyle:UIAlertControllerStyleAlert];
    
    NSArray *methodArray = [self DumpObjcMethods:[textField[0] class]];
    
    if(alertController.preferredStyle != UIAlertControllerStyleActionSheet)
        for (UITextField *textFieldObject in textField) {
            [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textFieldAllert) {
                for(NSString *methodString in methodArray){
                    
                    SEL setMethod = NSSelectorFromString([methodString copy]);
                    SEL getMethod = NSSelectorFromString([self setMethodToGet:[methodString copy]]);
                    
                    if([textFieldAllert respondsToSelector:setMethod] && [textFieldObject respondsToSelector:getMethod]){
                        [textFieldAllert performSelector:setMethod withObject:[textFieldObject performSelector:getMethod]];
                    }
                    textFieldAllert.secureTextEntry = textFieldObject.isSecureTextEntry;
                }
            }];
        };
    
    [self addButtonsKVAlert:alertController buttons:buttons completion:^(NSUInteger buttonPresed) {
        if(completion)
            completion(buttonPresed, [alertController textFields]);
    }];
    
    UIAlertAction *cancelButton = [UIAlertAction actionWithTitle:UIKitLocalizedString(@"Cancel") style:UIAlertActionStyleCancel handler:nil];
    [alertController addAction:cancelButton];
    
    [self presentKVAlertOnRootViewController:alertController];
}

+ (void)addButtonsKVAlert:(UIAlertController *)alertController buttons:(NSArray *)buttons completion:(KVAlertWithButton)completion{
    NSUInteger indexButton = 0;
    for (NSString *buttonName in buttons){
        UIAlertAction *alertAction = [UIAlertAction actionWithTitle:buttonName style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            if(completion){
                completion(indexButton);
            }
        }];
        [alertController addAction:alertAction];
        indexButton++;
    }
}

+ (void)presentKVAlertOnRootViewController:(UIAlertController *)alertController{
    UIViewController *currentViewController = [self getTopMostViewController];
    [currentViewController presentViewController:alertController animated:YES completion:nil];
}

#pragma marl - Additional Method

+ (NSString *)setMethodToGet:(NSString *)methodString{
    
    NSString *method = [methodString stringByReplacingOccurrencesOfString:@"set" withString:@""];
    method = [method stringByReplacingOccurrencesOfString:@":" withString:@""];
    method = [method lowercaseString];
    
    return method;
}

+ (NSArray *)DumpObjcMethods:(Class)clz{
    
    unsigned int methodCount = 0;
    Method *methods = class_copyMethodList(clz, &methodCount);
    NSMutableArray *methodArray = [NSMutableArray new];
    
    for (unsigned int i = 0; i < methodCount; i++) {
        Method method = methods[i];
        
        NSString *methodString = [NSString stringWithFormat:@"%s",sel_getName(method_getName(method))];
        if([methodString containsString:@"set"] && ![methodString containsString:@"_"] && [methodString containsString:@":"]){
            [methodArray addObject:methodString];
        }
    }
    free(methods);
    return methodArray;
}

+ (UIViewController*)getTopMostViewController{
    UIViewController *presentedViewController = [UIApplication sharedApplication].keyWindow.rootViewController;
    UIViewController *topView;
    while(presentedViewController.presentedViewController){
        presentedViewController = presentedViewController.presentedViewController;
        topView = presentedViewController;
    }
    if([topView isKindOfClass:[UINavigationController class]])
        for(UIViewController *view in presentedViewController.childViewControllers){
            topView = view;
        }
    
    return topView ? topView : presentedViewController;
}

+ (UIViewController *) topViewController:(UIViewController *)controller{
    BOOL isPresenting = NO;
    do {
        // this path is called only on iOS 6+, so -presentedViewController is fine here.
        UIViewController *presented = [controller presentedViewController];
        isPresenting = presented != nil;
        if(presented != nil) {
            controller = presented;
        }
        
    } while (isPresenting);
    
    return controller;
}

@end
