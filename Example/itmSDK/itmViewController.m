//
//  itmViewController.m
//  itmSDK
//
//  Created by Clintlin on 08/04/2017.
//  Copyright (c) 2017 Clintlin. All rights reserved.
//

#import "itmViewController.h"
#import <itmSDK/itmSDKBus.h>

@interface itmViewController ()

@end

@implementation itmViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    response_1 * response = [response_1 new];
    NSLog(@"%@",response);
    itmTimer * timer = [[itmTimer alloc] initWithInterval:0.2 target:nil selector:nil];
    [timer fire];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
