//
//  NetworkManager.h
//  AlinaTest
//
//  Created by ALINA HAMBARYAN on 02.03.15.
//  Copyright (c) 2015 Alina Hambaryan. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^CityDataFetchCompletion)(NSDictionary *, NSError *);


@interface NetworkManager : NSObject

+ (instancetype)sharedManager;

- (void)fetchWeatherData:(CityDataFetchCompletion)completion;

@end
