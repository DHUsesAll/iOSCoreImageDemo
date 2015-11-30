//
//  CIFilterChainingViewController.m
//  CoreImageDemo
//
//  Created by DreamHack on 15-11-27.
//  Copyright (c) 2015年 DreamHack. All rights reserved.
//

#import "CIFilterChainingViewController.h"

@interface CIFilterChainingViewController ()

@end

@implementation CIFilterChainingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIImage * image = [UIImage imageNamed:@"field.png"];
    
    CIImage * myCIImage = [[CIImage alloc] initWithImage:image];
    
    CIFilter * hueAdjust = [CIFilter filterWithName:@"CIHueAdjust"];
    [hueAdjust setValue: myCIImage forKey: kCIInputImageKey];
    [hueAdjust setValue: @2.094f forKey: kCIInputAngleKey];
    
//    hueAdjust = [CIFilter filterWithName:@"CIHueAdjust" keysAndValues:
//                 kCIInputImageKey, myCIImage,
//                 kCIInputAngleKey, @2.094f,
//                 nil];
    CIImage *result = [hueAdjust valueForKey: kCIOutputImageKey];
    
    CIFilter *gloom = [CIFilter filterWithName:@"CIGloom"];
    [gloom setDefaults];
    [gloom setValue: result forKey: kCIInputImageKey];
    [gloom setValue: @25.0f forKey: kCIInputRadiusKey];
    [gloom setValue: @0.75f forKey: kCIInputIntensityKey];
    result = [gloom valueForKey: kCIOutputImageKey];
    
    CIFilter *bumpDistortion = [CIFilter filterWithName:@"CIBumpDistortion"];
    [bumpDistortion setDefaults];
    [bumpDistortion setValue: result forKey: kCIInputImageKey];
    [bumpDistortion setValue: [CIVector vectorWithX:200 Y:150]
                      forKey: kCIInputCenterKey];
    [bumpDistortion setValue: @100.0f forKey: kCIInputRadiusKey];
    [bumpDistortion setValue: @3.0f forKey: kCIInputScaleKey];
    result = [bumpDistortion valueForKey: kCIOutputImageKey];
    
    EAGLContext *myEAGLContext = [[EAGLContext alloc]
                                  initWithAPI:kEAGLRenderingAPIOpenGLES2];
    NSDictionary *options = @{ kCIContextWorkingColorSpace : [NSNull null] };
    CIContext *myContext = [CIContext contextWithEAGLContext:myEAGLContext
                                                     options:options];
    
    UIImageView * originImageView = [[UIImageView alloc] initWithFrame:CGRectMake(60, 80, 300, 180)];
    originImageView.image = image;
    [self.view addSubview:originImageView];
    
    
    UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(60, 300, 300, 180)];
    [self.view addSubview:imageView];
    
    CGImageRef cgImage = [myContext createCGImage:result fromRect:[result extent]];
    
    imageView.image = [UIImage imageWithCGImage:cgImage];
    
    CGImageRelease(cgImage);
}


@end
