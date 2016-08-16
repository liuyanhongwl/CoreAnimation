//
//  ReplicatorLayerView.m
//  CoreAnimation
//
//  Created by Hong on 16/8/6.
//  Copyright © 2016年 Hong. All rights reserved.
//

#import "ReplicatorLayerView.h"

@implementation ReplicatorLayerView

+ (Class)layerClass
{
    return [CAReplicatorLayer class];
}

- (CAReplicatorLayer *)replicatorLayer
{
    return (CAReplicatorLayer *)self.layer;
}

- (void)initLayer
{
    [self replicatorLayer].instanceCount = 2;
    
    CATransform3D tf = CATransform3DIdentity;
    CGFloat verticalOffset = CGRectGetHeight(self.frame) + 2;
    tf = CATransform3DTranslate(tf, 0, verticalOffset, 0);
//    tf = CATransform3DRotate(tf, M_PI, 1, 0, 0);
    tf = CATransform3DScale(tf, 1, -1, 0);
    [self replicatorLayer].instanceTransform = tf;
    
    [self replicatorLayer].instanceAlphaOffset = -0.6;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initLayer];
    }
    return self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    [self initLayer];
}

@end
