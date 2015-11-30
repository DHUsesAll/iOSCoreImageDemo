//
//  CIChromaKeyViewController.m
//  CoreImageDemo
//
//  Created by DreamHack on 15-11-27.
//  Copyright (c) 2015年 DreamHack. All rights reserved.
//

#import "CIChromaKeyViewController.h"
#import "CIChromaKeyFilter.h"

@interface CIChromaKeyViewController ()

@end

@implementation CIChromaKeyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    CIImage * ciImage = [CIImage imageWithContentsOfURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"person" ofType:@"png"]]];
    
    CIChromaKeyFilter * filter = [CIChromaKeyFilter new];
    filter.inputImage = ciImage;
    
    ciImage = filter.outputImage;
    
    UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(80, 120, 164, 194)];
    [self.view addSubview:imageView];
    
    CIContext * context = [CIContext contextWithOptions:nil];
    
    CGImageRef cgImage = [context createCGImage:ciImage fromRect:[ciImage extent]];
    imageView.image = [UIImage imageWithCGImage:cgImage];
    CGImageRelease(cgImage);
    
    
}

@end
