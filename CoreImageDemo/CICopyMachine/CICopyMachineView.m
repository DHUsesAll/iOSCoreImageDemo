//
//  CICopyMachineView.m
//  CoreImageDemo
//
//  Created by DreamHack on 15-11-26.
//  Copyright (c) 2015年 DreamHack. All rights reserved.
//

#import "CICopyMachineView.h"

@interface CICopyMachineView ()
{
    CGFloat thumbnailWidth;
    CGFloat thumbnailHeight;
    NSTimeInterval base;
    CIFilter * transition;
    CIContext * context;
}

@property (nonatomic, strong) CIImage * sourceImage;
@property (nonatomic, strong) CIImage * targetImage;

@end

@implementation CICopyMachineView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        NSTimer    *timer;
        NSURL      *url;
        thumbnailWidth  = CGRectGetWidth(frame);
        thumbnailHeight = CGRectGetHeight(frame);
        url   = [NSURL fileURLWithPath: [[NSBundle mainBundle]
                                         pathForResource: @"boots" ofType: @"png"]];
        [self setSourceImage: [CIImage imageWithContentsOfURL: url]];
        url   = [NSURL fileURLWithPath: [[NSBundle mainBundle]
                                         pathForResource: @"skier" ofType: @"png"]];
        [self setTargetImage: [CIImage imageWithContentsOfURL: url]];
        timer = [NSTimer scheduledTimerWithTimeInterval: 1.0/30.0
                                                 target: self
                                               selector: @selector(timerFired:)
                                               userInfo: nil
                                                repeats: YES];
        base = [NSDate timeIntervalSinceReferenceDate];
        [[NSRunLoop currentRunLoop] addTimer: timer
                                     forMode: NSDefaultRunLoopMode];
        [[NSRunLoop currentRunLoop] addTimer: timer
                                     forMode: UITrackingRunLoopMode];
    }
    return self;
}

- (void)setupTransition
{
    CGFloat w = thumbnailWidth;
    CGFloat h = thumbnailHeight;
    CIVector *extent = [CIVector vectorWithX: 0  Y: 0  Z: w  W: h];
    transition  = [CIFilter filterWithName: @"CICopyMachineTransition"];
    // Set defaults on OS X; not necessary on iOS.
    [transition setDefaults];
    [transition setValue: extent forKey: kCIInputExtentKey];
}

- (void)timerFired:(NSTimer *)timer
{
    CGRect  cg = self.bounds;
    CGFloat t = 0.4 * ([NSDate timeIntervalSinceReferenceDate] - base);
    if (context == nil) {
        context = [CIContext contextWithOptions:nil];
    }
    
    if (transition == nil) {
        [self setupTransition];
    }
    
    CIImage * image = [self imageForTransition: t + 0.1];
    CGImageRef cgImage = [context createCGImage:image fromRect:cg];
    self.layer.contents = (__bridge id)cgImage;
    CGImageRelease(cgImage);
}

- (CIImage *)imageForTransition: (float)t
{
    // Remove the if-else construct if you don't want the transition to loop
    if (fmodf(t, 2.0) < 1.0f) {
        [transition setValue: _sourceImage  forKey: kCIInputImageKey];
        [transition setValue: _targetImage  forKey: kCIInputTargetImageKey];
    } else {
        [transition setValue: _targetImage  forKey: kCIInputImageKey];
        [transition setValue: _sourceImage  forKey: kCIInputTargetImageKey];
    }
    [transition setValue: @( 0.5 * (1 - cos(fmodf(t, 1.0f) * M_PI)) )
                  forKey: kCIInputTimeKey];
    CIFilter  *crop = [CIFilter filterWithName: @"CICrop"
                                 keysAndValues:
                       kCIInputImageKey, [transition valueForKey: kCIOutputImageKey],
                       @"inputRectangle", [CIVector vectorWithX: 0  Y: 0
                                                              Z: thumbnailWidth  W: thumbnailHeight],
                       nil];
    return [crop valueForKey: kCIOutputImageKey];
}
@end
