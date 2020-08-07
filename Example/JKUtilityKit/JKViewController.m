//
//  JKViewController.m
//  JKUtilityKit
//
//  Created by jkayb123cool@gmail.com on 07/31/2020.
//  Copyright (c) 2020 jkayb123cool@gmail.com. All rights reserved.
//

#import "JKViewController.h"
#import "JKUtility.h"

@interface JKViewController ()

@end

@implementation JKViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [JKUtility jumpToSetting];
    });
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
