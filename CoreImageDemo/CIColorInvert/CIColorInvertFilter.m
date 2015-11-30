//
//  CIColorInvert.m
//  CoreImageDemo
//
//  Created by DreamHack on 15-11-27.
//  Copyright (c) 2015年 DreamHack. All rights reserved.
//

#import "CIColorInvertFilter.h"

@implementation CIColorInvertFilter

- (CIImage *) outputImage
{
    CIFilter *filter = [CIFilter filterWithName:@"CIColorMatrix" keysAndValues:
                        kCIInputImageKey, _inputImage,
                        @"inputRVector", [CIVector vectorWithX: -1 Y:0 Z:0],
                        @"inputGVector", [CIVector vectorWithX:0 Y:-1 Z:0 ],
                        @"inputBVector", [CIVector vectorWithX: 0 Y:0 Z:-1],
                        @"inputBiasVector", [CIVector vectorWithX:1 Y:1 Z:1],
                        nil];
    return filter.outputImage;
}

@end
