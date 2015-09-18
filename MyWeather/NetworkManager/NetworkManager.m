//
//  NetworkManager.m
//  AlinaTest
//
//  Created by ALINA HAMBARYAN on 02.03.15.
//  Copyright (c) 2015 Alina Hambaryan. All rights reserved.
//

#import "NetworkManager.h"
#import "MyWeatherDefines.h"
#import "Reachability.h"
#import <AFNetworking/AFNetworking.h>

#define HTTP_RESPONSE_NOT_200_DOMAIN         @"HttpResponseNot200"

@interface NetworkManager ()

@property (nonatomic, strong) NSURLSession *defaultSession;
@property (nonatomic) NSMutableDictionary *downloadTaskDictionary;

@end

@implementation NetworkManager


- (instancetype)init {
    
    self = [super init];
    if (self) {
        _defaultSession = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
        _downloadTaskDictionary = [[NSMutableDictionary alloc] init];
    }
    
    return self;
}

+ (instancetype)sharedManager {
    
    static NetworkManager *sharedInstance = nil;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        sharedInstance = [[NetworkManager alloc] init];
    });
    
    return sharedInstance;
}

- (void)fetchWeatherData:(CityDataFetchCompletion)completion {
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:LYON_FORCAST_URL]];
    __block NSError *error = nil;
    
    NSURLSessionTask *cityFetchTask = [self.defaultSession dataTaskWithRequest:request
                                                                 completionHandler:^(NSData *data, NSURLResponse *response, NSError *requestError) {
                                                                     NSDictionary *cityDictionary = [[NSDictionary alloc] init];
                                                                     
                                                                     if (requestError) {
                                                                         error = requestError;
                                                                     }
                                                                     else {
                                                                         NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
                                                                         if (httpResponse.statusCode == 200) {
                                                                             if ([data length] > 0) {
                                                                                 cityDictionary = [NSJSONSerialization JSONObjectWithData:data
                                                                                                                                     options:0
                                                                                                                                       error:&error];
                                                                             }
                                                                         }
                                                                         else {
                                                                             error = [[NSError alloc] initWithDomain:HTTP_RESPONSE_NOT_200_DOMAIN
                                                                                                                code:httpResponse.statusCode
                                                                                                            userInfo:nil];
                                                                         }
                                                                     }
                                                                     
                                                                     dispatch_queue_t queue = dispatch_get_main_queue();
                                                                     dispatch_async(queue, ^{
                                                                         completion(cityDictionary, error);
                                                                     });
                                                                 }];
    [cityFetchTask resume];
}


@end
