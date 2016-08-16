//
//  CATransformLayerViewController.m
//  CoreAnimation
//
//  Created by Hong on 16/8/2.
//  Copyright © 2016年 Hong. All rights reserved.
//

#import "CATransformLayerViewController.h"

@interface CATransformLayerViewController ()

@property (nonatomic, strong) CALayer *cube1;
@property (nonatomic, strong) CALayer *cube2;

@end

@implementation CATransformLayerViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.layer.backgroundColor = [UIColor whiteColor].CGColor;
    
    CATransform3D tf = CATransform3DIdentity;
    tf.m34 = - 1 / 500.0;
    self.view.layer.sublayerTransform = tf;
    
    CATransform3D tf1 = CATransform3DIdentity;
    tf1 = CATransform3DTranslate(tf1, -200, -200, 0);
    self.cube1 = [self cubeWithTransform:tf1];
    [self.view.layer addSublayer:self.cube1];
    
    CATransform3D tf2 = CATransform3DIdentity;
    tf2 = CATransform3DTranslate(tf2, 0, 100, 0);
    tf2 = CATransform3DRotate(tf2, M_PI_4, 1, 0, 0);
    tf2 = CATransform3DRotate(tf2, M_PI_4, 0, 1, 0);
    self.cube2 = [self cubeWithTransform:tf2];
    [self.view.layer addSublayer:self.cube2];
}

- (CALayer *)faceWithTransform:(CATransform3D)transform
{
    CALayer *layer = [[CALayer alloc] init];
    layer.frame = CGRectMake(0, 0, 100, 100);
    
    CGFloat red = arc4random() % 255 / 255.0;
    CGFloat green = arc4random() % 255 / 255.0;
    CGFloat blue = arc4random() % 255 / 255.0;
    layer.backgroundColor = [UIColor colorWithRed:red green:green blue:blue alpha:1].CGColor;
    
    layer.transform = transform;
    
    return layer;
}

- (CATransformLayer *)cubeWithTransform:(CATransform3D)transform
{
    CATransformLayer *cube = [[CATransformLayer alloc] init];
    
    //1
    CATransform3D tf = CATransform3DMakeTranslation(0, 0, 50);
    [cube addSublayer:[self faceWithTransform:tf]];
    
    //2
    tf = CATransform3DMakeTranslation(50, 0, 0);
    tf = CATransform3DRotate(tf, M_PI_2, 0, 1, 0);
    [cube addSublayer:[self faceWithTransform:tf]];
    
    //3
    tf = CATransform3DMakeTranslation(0, -50, 0);
    tf = CATransform3DRotate(tf, M_PI_2, 1, 0, 0);
    [cube addSublayer:[self faceWithTransform:tf]];
    
    //4
    tf = CATransform3DMakeTranslation(-50, 0, 0);
    tf = CATransform3DRotate(tf, M_PI_2, 0, -1, 0);
    [cube addSublayer:[self faceWithTransform:tf]];
    
    //5
    tf = CATransform3DMakeTranslation(0, 50, 0);
    tf = CATransform3DRotate(tf, M_PI_2, -1, 0, 0);
    [cube addSublayer:[self faceWithTransform:tf]];
    
    //6
    tf = CATransform3DMakeTranslation(0, 0, -50);
    [cube addSublayer:[self faceWithTransform:tf]];
    
    cube.position = self.view.center;
//    cube.position = CGPointMake(10, 64);
    
    cube.transform = transform;
    
    return cube;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = touches.anyObject;
    
    CGPoint point = [touch locationInView:self.view];
    
    if ([self.view.layer hitTest:point] == self.view.layer) {
        CATransform3D tf = self.cube2.transform;
        tf = CATransform3DRotate(tf, M_PI, 0, 1, 0);

        self.cube2.transform = tf;
    }
}


@end
