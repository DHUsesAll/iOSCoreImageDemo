//
//  CIColorInvertViewController.m
//  CoreImageDemo
//
//  Created by DreamHack on 15-11-27.
//  Copyright (c) 2015年 DreamHack. All rights reserved.
//

#import "CIColorInvertViewController.h"
#import "CIColorInvertFilter.h"

@interface CIColorInvertViewController ()

@end

@implementation CIColorInvertViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(60, 60, 140, 140)];
    [self.view addSubview:imageView];
    
    CIImage * ciImage = [CIImage imageWithContentsOfURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"robot" ofType:@"jpg"]]];
    
    CIColorInvertFilter * colorInvert = [[CIColorInvertFilter alloc] init];
    colorInvert.inputImage = ciImage;
    
    ciImage = colorInvert.outputImage;
    CIContext * context = [CIContext contextWithOptions:nil];
    CGImageRef cgImage = [context createCGImage:ciImage fromRect:[ciImage extent]];
    imageView.image = [UIImage imageWithCGImage:cgImage];
    CGImageRelease(cgImage);
}


@end
