//
//  CIColorInvert.h
//  CoreImageDemo
//
//  Created by DreamHack on 15-11-27.
//  Copyright (c) 2015年 DreamHack. All rights reserved.
//

#import <CoreImage/CoreImage.h>

@interface CIColorInvertFilter : CIFilter

@property (retain, nonatomic) CIImage *inputImage;

@end
