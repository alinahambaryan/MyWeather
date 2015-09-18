//
//  ViewController.m
//  MyWeather
//
//  Created by ALINA HAMBARYAN on 9/18/15.
//  Copyright (c) 2015 ALINA HAMBARYAN. All rights reserved.
//

#import "ForcastVC.h"
#import "MyWeatherDefines.h"
#import "NetworkManager.h"
#import "Reachability.h"
#import "CommonMethods.h"

@interface ForcastVC ()<UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UILabel *lblCityName;
@property (weak, nonatomic) IBOutlet UILabel *lblShortInfo;
@property (weak, nonatomic) IBOutlet UITableView *weekTableView;

@property (weak, nonatomic) IBOutlet UILabel *lblSunRize;
@property (weak, nonatomic) IBOutlet UILabel *lblSunRizeValue;

@property (weak, nonatomic) IBOutlet UILabel *lblSunset;
@property (weak, nonatomic) IBOutlet UILabel *lblSunsetValue;

@property (weak, nonatomic) IBOutlet UILabel *lblClouds;
@property (weak, nonatomic) IBOutlet UILabel *lblCloudsValue;

@property (weak, nonatomic) IBOutlet UILabel *lblRain;
@property (weak, nonatomic) IBOutlet UILabel *lblRainValue;

@property (weak, nonatomic) IBOutlet UILabel *lblHumidity;
@property (weak, nonatomic) IBOutlet UILabel *lblHumidityValue;

@property (weak, nonatomic) IBOutlet UILabel *lblPression;
@property (weak, nonatomic) IBOutlet UILabel *lblPressionValue;

@property (nonatomic, nonatomic) NSDictionary *cityData;
@property (nonatomic, nonatomic) NSArray *weekData;

@end

@implementation ForcastVC

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{
    return [self.weekData count];
}

#pragma mark - UITableViewDelegate
- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ForcastCell" forIndexPath:indexPath];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ForcastCell"];
    }
    return cell;
}

-(void)initIBOutlets
{
    [self.weekTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"ForcastCell"];

    self.lblSunRize.text = SUNRISE;
    self.lblSunset.text = SUNSET;
    self.lblClouds.text = CLOUDS;
    self.lblRain.text = RAIN;
    self.lblHumidity.text = HUMIDITY;
    self.lblPression.text = PRESSION;
}

-(void)updateIBOutlets
{
    self.lblCityName.text = [[self.cityData objectForKey:@"city"]objectForKey:@"name"];
    self.weekData = [self.cityData objectForKey:@"list"] ;
    NSDictionary * today = [self.weekData firstObject];
    self.lblShortInfo.text = [[[today objectForKey:@"weather"] firstObject]objectForKey:@"description"];
    
    self.lblSunRizeValue.text = [self.cityData objectForKey:@""];
    self.lblSunsetValue.text = [self.cityData objectForKey:@""];
    self.lblCloudsValue.text =[self.cityData objectForKey:@""];
    self.lblRainValue.text = [self.cityData objectForKey:@""];
    self.lblPression.text =[self.cityData objectForKey:@""];
    self.lblPressionValue.text = [self.cityData objectForKey:@""];
    
    [self.weekTableView reloadData];
}

-(void)loadData
{
    Reachability *networkReachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus networkStatus = [networkReachability currentReachabilityStatus];
    
    if (networkStatus == NotReachable)
    {
        [[CommonMethods sharedCommonMethods] showAlertWithTitle:EMPTY_STRING
                                                    withMessage:NO_INTERNET_CONNECTION];
        return;
    }
    [[NetworkManager sharedManager]fetchWeatherData:^(NSDictionary *cityForcastData, NSError *error)
    {
        self.cityData = cityForcastData;

        if (error) {
            return ;
        }
        dispatch_async(dispatch_get_main_queue(), ^{
          [self updateIBOutlets];
        });
    }];
}

#pragma mark - UIViewControllerLyfecycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self initIBOutlets];
    [self loadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
