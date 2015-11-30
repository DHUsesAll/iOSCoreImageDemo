//
//  CIChromaKeyFilter.h
//  CoreImageDemo
//
//  Created by DreamHack on 15-11-27.
//  Copyright (c) 2015年 DreamHack. All rights reserved.
//

#import <CoreImage/CoreImage.h>

@interface CIChromaKeyFilter : CIFilter

@property (nonatomic, strong) CIImage * inputImage;

@end
