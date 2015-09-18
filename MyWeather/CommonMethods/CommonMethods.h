//
//  CommonMethods.h
//  AlinaTest
//
//  Created by ALINA HAMBARYAN on 02.03.15.
//  Copyright (c) 2015 Alina Hambaryan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CommonMethods : NSObject


+ (instancetype)sharedCommonMethods;

- (void)showAlertWithTitle:(NSString *)title withMessage:(NSString *)message;

@end
