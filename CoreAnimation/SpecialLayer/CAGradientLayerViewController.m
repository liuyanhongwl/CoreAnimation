//
//  CAGradientLayerViewController.m
//  CoreAnimation
//
//  Created by Hong on 16/8/5.
//  Copyright © 2016年 Hong. All rights reserved.
//

#import "CAGradientLayerViewController.h"

@interface CAGradientLayerViewController ()

@property (nonatomic, strong) CAGradientLayer *layer;
@property (nonatomic, assign) BOOL needContinue;

@end

@implementation CAGradientLayerViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.layer.backgroundColor = [UIColor whiteColor].CGColor;
    
    _layer = [[CAGradientLayer alloc] init];
    self.layer.frame = CGRectMake(0, 0, 300, 300);
    self.layer.position = self.view.center;
    self.layer.colors = @[
                          (__bridge id)[UIColor redColor].CGColor,
                          (__bridge id)[UIColor orangeColor].CGColor,
                          (__bridge id)[UIColor yellowColor].CGColor,
                          (__bridge id)[UIColor greenColor].CGColor,
                          (__bridge id)[UIColor cyanColor].CGColor,
                          (__bridge id)[UIColor blueColor].CGColor,
                          (__bridge id)[UIColor purpleColor].CGColor
                          ];
    CGFloat unitLength = 1.0 / self.layer.colors.count;
    self.layer.locations = @[
                             @0,
                             @(unitLength),
                             @(unitLength*2),
                             @(unitLength*3),
                             @(unitLength*4),
                             @(unitLength*5),
                             @(unitLength*6)
                             ];
    self.layer.startPoint = CGPointMake(1, 0);
    self.layer.endPoint = CGPointMake(0, 1);
    [self.view.layer addSublayer:self.layer];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    self.needContinue = !self.needContinue;
    [self blinkAnimation];
}

- (void)blinkAnimation
{
    [CATransaction setCompletionBlock:^{
        if (self.needContinue) {
            [self blinkAnimation];
        }
    }];
    [self nextCompletionBlock];
}

- (void)nextCompletionBlock
{
    NSUInteger index = 0;
    NSUInteger targetIndex = 0;
    if ([self.layer.colors containsObject:(__bridge id)[UIColor whiteColor].CGColor]) {
        index = [self.layer.colors indexOfObject:(__bridge id)[UIColor whiteColor].CGColor];
        targetIndex = index + 1;
        if (targetIndex == self.layer.colors.count) {
            targetIndex = 0;
        }
    }
    
    NSMutableArray *colors = [NSMutableArray arrayWithArray:@[
                                                              (__bridge id)[UIColor redColor].CGColor,
                                                              (__bridge id)[UIColor orangeColor].CGColor,
                                                              (__bridge id)[UIColor yellowColor].CGColor,
                                                              (__bridge id)[UIColor greenColor].CGColor,
                                                              (__bridge id)[UIColor cyanColor].CGColor,
                                                              (__bridge id)[UIColor blueColor].CGColor,
                                                              (__bridge id)[UIColor purpleColor].CGColor
                                                              ]];
    [colors replaceObjectAtIndex:targetIndex withObject:(__bridge id)[UIColor whiteColor].CGColor];
    
    self.layer.colors = colors;
}

@end








