//
// Created by Hong on 16/7/11.
// Copyright (c) 2016 Hong. All rights reserved.
//

#import "TransformViewController.h"

@class CGAffinetransform;

@interface TransformViewController ()
{
    CALayer *layer;
    CALayer *actionLayer;
}

@end

@implementation TransformViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];

    CGFloat width = CGRectGetWidth(self.view.frame);
    CGFloat height = CGRectGetHeight(self.view.frame);

    actionLayer = [[CALayer alloc] init];
    actionLayer.frame = CGRectMake(width - 80 - 20, height - 30 - 20, 80, 30);
//    CGContextRef *context = CGImage
//    CGBitmapContextCreateImage()
    actionLayer.contents = @"transform";
    [self.view.layer addSublayer:actionLayer];

    layer = [[CALayer alloc] init];
    layer.frame = CGRectMake(100, 100, 100, 100);
    layer.backgroundColor = [UIColor blueColor].CGColor;
    [self.view.layer addSublayer:layer];

}

- (void)startTransform
{
    CGAffineTransform transform = CGAffineTransformIdentity;
    transform = CGAffineTransformScale(transform, 0.5, 0.5);
    transform = CGAffineTransformRotate(transform, M_PI_4);
    transform = CGAffineTransformTranslate(transform, 200, 0);
    layer.affineTransform = transform;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    CGPoint point = [[touches anyObject] locationInView:self.view];
    CALayer *layer = [self.view.layer hitTest:point];

    if (layer == actionLayer){
        [self startTransform];
    }
}

@end