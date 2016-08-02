//
//  CATextLayerLabel.m
//  CoreAnimation
//
//  Created by Hong on 16/8/2.
//  Copyright © 2016年 Hong. All rights reserved.
//

#import "CATextLayerLabel.h"

@implementation CATextLayerLabel

+(Class)layerClass
{
    return [CATextLayer class];
}

- (CATextLayer *)textLayer
{
    return (CATextLayer *)self.layer;
}

- (void)initLayer
{
    [self textLayer].wrapped = YES;
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

- (void)setText:(NSString *)text
{
    [super setText:text];
    
    [self textLayer].string = text;
}

- (void)setTextColor:(UIColor *)textColor
{
    [super setTextColor:textColor];
    
    [self textLayer].foregroundColor = textColor.CGColor;
}

- (void)setFont:(UIFont *)font
{
    [super setFont:font];
    
    [self textLayer].font = CGFontCreateWithFontName((__bridge CFStringRef)font.fontName);
    
    [self textLayer].fontSize = font.pointSize;
    
}


@end
