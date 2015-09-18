//
//  CommonMethods.m
//  AlinaTest
//
//  Created by ALINA HAMBARYAN on 02.03.15.
//  Copyright (c) 2015 Alina Hambaryan. All rights reserved.
//

#import "CommonMethods.h"
#import <UIKit/UIKit.h>

@implementation CommonMethods

+ (instancetype)sharedCommonMethods {
    
    static CommonMethods *sharedInstance = nil;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        sharedInstance = [[CommonMethods alloc] init];
    });
    
    return sharedInstance;
}

- (void)showAlertWithTitle:(NSString *)title withMessage:(NSString *)message {
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title
                                                    message:message
                                                   delegate:self
                                          cancelButtonTitle:@"Ok"
                                          otherButtonTitles:nil, nil];
    [alert show];
}

@end
