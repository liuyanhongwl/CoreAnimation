//
//  CAShapeLayerViewController.m
//  CoreAnimation
//
//  Created by Hong on 16/8/2.
//  Copyright © 2016年 Hong. All rights reserved.
//

#import "CAShapeLayerViewController.h"

@interface CAShapeLayerViewController()

@end

@implementation CAShapeLayerViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    CGPoint center = self.view.center;
    
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(center.x - 80, center.y - 100, 160, 200)];
    [path moveToPoint:CGPointMake(center.x - 50, center.y - 40)];
    [path addArcWithCenter:CGPointMake(center.x - 40, center.y - 40) radius:10 startAngle:-M_PI endAngle:M_PI clockwise:YES];
    [path moveToPoint:CGPointMake(center.x + 50, center.y - 40)];
    [path addArcWithCenter:CGPointMake(center.x + 40, center.y - 40) radius:10 startAngle:0 endAngle:2 * M_PI clockwise:YES];
    UIBezierPath *mouthPath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(center.x - 40, center.y + 40, 80, 20) byRoundingCorners:UIRectCornerTopRight cornerRadii:CGSizeMake(20, 20)];
    [path appendPath:mouthPath];
    
    CAShapeLayer *shapeLayer = [[CAShapeLayer alloc] init];
    shapeLayer.strokeColor = [UIColor blueColor].CGColor;
    shapeLayer.fillColor = [UIColor clearColor].CGColor;
    shapeLayer.lineWidth = 2;
    shapeLayer.path = path.CGPath;
    [self.view.layer addSublayer:shapeLayer];
}

@end

