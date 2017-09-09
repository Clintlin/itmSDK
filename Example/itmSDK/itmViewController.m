//
//  itmViewController.m
//  itmSDK
//
//  Created by Clintlin on 08/04/2017.
//  Copyright (c) 2017 Clintlin. All rights reserved.
//

#import "itmViewController.h"
#import <itmSDK/itmSDK.h>
#import "itmBrushView.h"

@interface itmViewController ()

@end

@implementation itmViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [itmBrushView showInView:self.view];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
