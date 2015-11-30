//
//  CIAutoEnhancementViewController.m
//  CoreImageDemo
//
//  Created by DreamHack on 15-11-27.
//  Copyright (c) 2015年 DreamHack. All rights reserved.
//

#import "CIAutoEnhancementViewController.h"
#import <ImageIO/ImageIO.h>

@interface CIAutoEnhancementViewController ()

@end

@implementation CIAutoEnhancementViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    CIImage * myImage = [CIImage imageWithContentsOfURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"robot" ofType:@"jpg"]]];
    
    id orientationProperty = [[myImage properties] valueForKey:(__bridge id)kCGImagePropertyOrientation];
    NSDictionary *options = nil;
    if (orientationProperty) {
        options = @{CIDetectorImageOrientation : orientationProperty};
    }
    
    NSArray *adjustments = [myImage autoAdjustmentFiltersWithOptions:options];
    for (CIFilter *filter in adjustments) {
        [filter setValue:myImage forKey:kCIInputImageKey];
        myImage = filter.outputImage;
    }
    
    CIContext * context = [CIContext contextWithOptions:nil];
    CGImageRef cgImage = [context createCGImage:myImage fromRect:[myImage extent]];
    
    UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(80, 80, 250, 250)];
    
    imageView.image = [UIImage imageWithCGImage:cgImage];
    CGImageRelease(cgImage);
    [self.view addSubview:imageView];
}

@end
