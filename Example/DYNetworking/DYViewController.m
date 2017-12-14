//
//  DYViewController.m
//  DYNetworking
//
//  Created by jyo2206208 on 12/12/2017.
//  Copyright (c) 2017 jyo2206208. All rights reserved.
//

#import "DYViewController.h"
#import "DYNetworking.h"
#import "DYWeather.h"
#import "DYPostTest.h"

@interface DYViewController ()

@end

@implementation DYViewController

- (IBAction)click:(id)sender {
    
    [[DYWeather WeatherInfoFor:@"北京" secretKey:@"8b4907ecad6449cb92476b7f888284ac"] subscribeNext:^(id  _Nullable x) {
        NSLog(@"data = %@",x);
    }];
    
//    [[DYPostTest postTest] subscribeNext:^(id  _Nullable x) {
//        NSLog(@"data = %@",x);
//    }];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
