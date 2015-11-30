//
//  CIFaceDetectingViewController.m
//  CoreImageDemo
//
//  Created by DreamHack on 15-11-27.
//  Copyright (c) 2015年 DreamHack. All rights reserved.
//

#import "CIFaceDetectingViewController.h"

@interface CIFaceDetectingViewController ()

@end

@implementation CIFaceDetectingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIImage * image = [UIImage imageNamed:@"tbbt.png"];
    
    UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 252, 251)];
    CGPoint center = self.view.center;
    imageView.center = center;
    imageView.image = image;
    [self.view addSubview:imageView];
    
    CIImage * myImage = [CIImage imageWithContentsOfURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"tbbt" ofType:@"png"]]];
    NSLog(@"%@",[myImage properties]);
    CIContext *context = [CIContext contextWithOptions:nil];
    NSDictionary *opts = @{ CIDetectorAccuracy : CIDetectorAccuracyHigh };
    CIDetector *detector = [CIDetector detectorOfType:CIDetectorTypeFace
                                              context:context
                                              options:opts];
    opts = @{ CIDetectorImageOrientation :
                  @1 };
    NSArray *features = [detector featuresInImage:myImage options:opts];
    
    for (CIFaceFeature *f in features)
    {
        // 人脸的bounds是按原图比例给的，并且坐标系原点在左下角，所以要转换一下
        UIView * faceBoundsView = [[UIView alloc] initWithFrame:CGRectScale(f.bounds, 0.5)];
        faceBoundsView.layer.borderColor = [UIColor yellowColor].CGColor;
        faceBoundsView.layer.borderWidth = 3;
        [imageView addSubview:faceBoundsView];
        NSLog(@"%@",NSStringFromCGRect(f.bounds));
        if (f.hasLeftEyePosition)
            NSLog(@"Left eye %g %g", f.leftEyePosition.x, f.leftEyePosition.y);
        if (f.hasRightEyePosition)
            NSLog(@"Right eye %g %g", f.rightEyePosition.x, f.rightEyePosition.y);
        if (f.hasMouthPosition)
            NSLog(@"Mouth %g %g", f.mouthPosition.x, f.mouthPosition.y);
    }
}


CGRect CGRectScale(CGRect rect, CGFloat scale)
{
    return CGRectMake(rect.origin.x * scale, 251 - (rect.origin.y * scale + rect.size.height * scale), rect.size.width * scale, rect.size.height * scale);
}

@end
