//
//  ScrollLayerView.m
//  CoreAnimation
//
//  Created by Hong on 16/8/8.
//  Copyright © 2016年 Hong. All rights reserved.
//

#import "ScrollLayerView.h"

@implementation ScrollLayerView

+ (Class)layerClass
{
    return [CAScrollLayer class];
}

- (CAScrollLayer *)scrollLayer
{
    return (CAScrollLayer *)self.layer;
}

- (void)initLayer
{
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panAction:)];
    [self addGestureRecognizer:pan];
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

- (void)panAction:(UIPanGestureRecognizer *)pan
{
    //无边际
    CGPoint translation = [pan translationInView:self];
    
    CGPoint offset = self.bounds.origin;
    
    offset.x -= translation.x;
    offset.y -= translation.y;
    
    [[self scrollLayer] scrollToPoint:offset];
    
    [pan setTranslation:CGPointZero inView:self];
    
//    static CGFloat originX = 0;
//    static CGFloat originY = 0;
//    
//    if (pan.state == UIGestureRecognizerStateBegan) {
//        originX = self.bounds.origin.x;
//        originY = self.bounds.origin.y;
//    }else{
//        //自定义边际
//        CGPoint translation = [pan translationInView:self];
//        
//        CGPoint offset = CGPointMake(originX, originY);
//        
//        offset.x -= translation.x;
//        offset.y -= translation.y;
//        
////        offset = [self bouncesPoint:offset];
//        
//        [[self scrollLayer] scrollToPoint:offset];
//        
//    }
}

- (CGPoint)bouncesPoint:(CGPoint)point
{
    CGFloat offsetX = point.x;
    CGFloat offsetY = point.y;
    
    CGFloat targetX = self.bounds.origin.x + offsetX;
    CGFloat targetY = self.bounds.origin.y + offsetY;
    
    CGFloat width = CGRectGetWidth(self.bounds);
    CGFloat height = CGRectGetHeight(self.bounds);
    
    if (targetX < 0 || targetX > ([self contentSize].width - width)) {
        offsetX = pow(fabs(offsetX), 0.8) * (offsetX / fabs(offsetX));
    }
    
    if (targetY < 0 || targetY > ([self contentSize].height - height)) {
        offsetY = pow(fabs(offsetY), 0.8) * (offsetY / fabs(offsetY));
    }
    
    return CGPointMake(self.bounds.origin.x + offsetX, self.bounds.origin.y + offsetY);
}

- (CGSize)contentSize
{
    CGSize size = self.bounds.size;
    CALayer *layer = self.layer.sublayers.firstObject;
    if (layer) {
        size = layer.frame.size;
    }
    return size;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
