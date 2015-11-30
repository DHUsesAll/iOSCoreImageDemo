//
//  CICopyMachineViewController.m
//  CoreImageDemo
//
//  Created by DreamHack on 15-11-26.
//  Copyright (c) 2015年 DreamHack. All rights reserved.
//

#import "CICopyMachineViewController.h"
#import "CICopyMachineView.h"

@implementation CICopyMachineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    CICopyMachineView * view = [[CICopyMachineView alloc] initWithFrame:CGRectMake(100, 100, 276, 208)];
    [self.view addSubview:view];
    
    self.view.backgroundColor = [UIColor whiteColor];
}

@end
