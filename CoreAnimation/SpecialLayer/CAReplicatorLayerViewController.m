//
//  CAReplicatorLayerViewController.m
//  CoreAnimation
//
//  Created by Hong on 16/8/5.
//  Copyright © 2016年 Hong. All rights reserved.
//

#import "CAReplicatorLayerViewController.h"
#import "ReplicatorLayerView.h"

@interface CAReplicatorLayerViewController ()

@property (nonatomic, strong) CAReplicatorLayer *layer;
@property (nonatomic, strong) ReplicatorLayerView *replicatorView;

@end

@implementation CAReplicatorLayerViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSLog(@"self.class=%@", self.class);
    NSLog(@"super.class=%@", super.class);
    NSLog(@"self.superclass=%@", self.superclass);
    
    self.view.layer.backgroundColor = [UIColor whiteColor].CGColor;
    
    CATransform3D tf = CATransform3DIdentity;
    tf.m34 = -1 / 500.0;
    self.view.layer.sublayerTransform = tf;
    
    //Replicator Layer
    self.layer = [[CAReplicatorLayer alloc] init];
    self.layer.frame = CGRectMake(0, 0, 30, 30);
    self.layer.position = CGPointMake(CGRectGetMidX(self.view.frame), 100);
    self.layer.instanceCount = 1;
    tf = CATransform3DIdentity;
    tf = CATransform3DTranslate(tf, 0, 60, 0);
    tf = CATransform3DRotate(tf, 2 * M_PI / 10.0, 0, 0, 1);
    tf = CATransform3DTranslate(tf, 0, -60, 0);
    self.layer.instanceTransform = tf;
//    self.layer.backgroundColor = [UIColor orangeColor].CGColor;
//    self.layer.instanceColor = [UIColor redColor].CGColor;
    self.layer.instanceRedOffset = -0.075f;
    self.layer.instanceBlueOffset = -0.075f;
    self.layer.instanceGreenOffset = -0.075f;
    [self.view.layer addSublayer:self.layer];
    
    //Layer
    CALayer *subLayer = [CALayer layer];
    subLayer.frame = CGRectMake(0, 0, 30, 30);
    subLayer.backgroundColor = [UIColor colorWithWhite:0.8 alpha:1].CGColor;
    tf = CATransform3DIdentity;
    tf = CATransform3DRotate(tf, M_PI / 4, 1, 0, 0);
    subLayer.transform = tf;
    [self.layer addSublayer:subLayer];
    
    //UIView
    self.replicatorView = [[ReplicatorLayerView alloc] initWithFrame:CGRectMake(0, 0, 200, 100)];
    self.replicatorView.center = CGPointMake(CGRectGetMidX(self.view.frame), CGRectGetHeight(self.view.frame) - 250);
    self.replicatorView.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:self.replicatorView];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"logo"]];
    imageView.frame = self.replicatorView.bounds;
    [self.replicatorView addSubview:imageView];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event
{

    NSUInteger count = [event allTouches].count;
    if (count == 1) {
        self.layer.instanceCount = (self.layer.instanceCount == 10) ? 1 : 10;
    }else if (count == 2) {
        //是否允许子视图有3D效果， 默认无。
        self.layer.preservesDepth = !self.layer.preservesDepth;
    }
}

@end
