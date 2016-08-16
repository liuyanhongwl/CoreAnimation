//
//  CATextLayerViewController.m
//  CoreAnimation
//
//  Created by Hong on 16/8/2.
//  Copyright © 2016年 Hong. All rights reserved.
//

#import "CATextLayerViewController.h"
#import <CoreText/CoreText.h>
#import "TextLayerLabel.h"

@interface CATextLayerViewController ()

@property (nonatomic, strong) CATextLayer *textLayer;

@property (nonatomic, assign) CGFloat layerX;
@property (nonatomic, assign) CGFloat layerY;
@property (nonatomic, assign) CGFloat layerWidth;
@property (nonatomic, assign) CGFloat layerHeight;

@end

@implementation CATextLayerViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    CGFloat statusHeight = CGRectGetHeight([UIApplication sharedApplication].statusBarFrame);
    CGFloat navigationHeight = CGRectGetHeight(self.navigationController.navigationBar.frame);
    self.layerX = 20;
    self.layerY = statusHeight + navigationHeight + 20;
    self.layerWidth = CGRectGetWidth(self.view.frame) - 2 * self.layerX;
    self.layerHeight = CGRectGetHeight(self.view.frame) / 3.0;
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    NSArray *titles = @[@"普通的CATextLayer", @"富文本的CATextLayer", @"UILabel的替代品"];
    for (int i = 0; i < titles.count; i ++) {
        NSString *title = titles[i];
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitle:title forState:UIControlStateNormal];
        button.frame = CGRectMake(20, self.layerY + self.layerHeight + 20 + (20 + 40) * i, self.layerWidth, 40);
        button.backgroundColor = [UIColor colorWithRed:0.5 green:0.2 blue:0.2 + 0.2 * i alpha:1];
        [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        button.tag = i;
        [self.view addSubview:button];
    }
    
}

- (void)buttonAction:(UIButton *)button
{
    [self clearLayer];
    
    switch (button.tag) {
        case 0:
        {
            [self normalLayer];
        }
            break;
            
        case 1:
        {
            [self richLayer];
        }
            break;
            
        case 2:
        {
            [self labelLayer];
        }
            break;
            
        default:
            break;
    }
}

- (void)clearLayer
{
    [self.textLayer removeFromSuperlayer];
    self.textLayer = nil;
}

/*普通的CATextLayer*/
- (void)normalLayer
{
    self.textLayer = [[CATextLayer alloc] init];
    self.textLayer.frame = CGRectMake(self.layerX, self.layerY, self.layerWidth, self.layerHeight);
    [self.view.layer addSublayer:self.textLayer];
    
    UIFont *font = [UIFont systemFontOfSize:22];
    CFStringRef fontName = (__bridge CFStringRef)(font.fontName);
    CGFontRef fontRef = CGFontCreateWithFontName(fontName);
    self.textLayer.font = fontRef;
    self.textLayer.fontSize = font.pointSize;
    CGFontRelease(fontRef);
    
    self.textLayer.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1].CGColor;
    self.textLayer.foregroundColor = [UIColor grayColor].CGColor;
    //    textLayer.truncationMode = kCATruncationStart;  //截取
    self.textLayer.alignmentMode = kCAAlignmentCenter;
    self.textLayer.wrapped = YES;  //换行
    self.textLayer.contentsScale = [UIScreen mainScreen].scale;  //这里不设置的话会出现像素化，除非CATextLayer成为UIView的宿主图层。
    
    self.textLayer.string = @"The text layer provides simple text layout and rendering of plain or attributed strings. The first line is aligned to the top of the layer.";
}

/*富文本的CATextLayer*/
- (void)richLayer
{
    self.textLayer = [[CATextLayer alloc] init];
    self.textLayer.frame = CGRectMake(self.layerX, self.layerY, self.layerWidth, self.layerHeight);
    [self.view.layer addSublayer:self.textLayer];
    
    self.textLayer.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1].CGColor;
    self.textLayer.wrapped = YES;
    self.textLayer.contentsScale = [UIScreen mainScreen].scale;
    self.textLayer.alignmentMode = kCAAlignmentRight;
    
    NSString *text = @"The text layer provides simple text layout and rendering of plain or attributed strings. The first line is aligned to the top of the layer.";
    NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:text];
    
    //UIKit
    UIFont *font = [UIFont systemFontOfSize:20 weight:1];
    [string setAttributes:@{
                            NSFontAttributeName : font,
                            NSForegroundColorAttributeName : [UIColor greenColor]
                            } range:NSMakeRange(0, text.length)];
    
    [string setAttributes:@{
                            NSFontAttributeName : font,
                            NSForegroundColorAttributeName : [UIColor redColor]
                            } range:[text rangeOfString:@"simple text layout"]];
    
    //CoreText
//    UIFont *font = [UIFont systemFontOfSize:20 weight:20];
//    CTFontRef fontRef = CTFontCreateWithName((__bridge CFStringRef)font.fontName, font.pointSize, NULL);
//    [string setAttributes:@{
//                            (__bridge id)kCTFontAttributeName : (__bridge id)fontRef,
//                            (__bridge id)kCTForegroundColorAttributeName : (__bridge id)[UIColor greenColor].CGColor
//                            } range:NSMakeRange(0, text.length)];
//    
//    [string setAttributes:@{
//                            (__bridge id)kCTFontAttributeName : (__bridge id)fontRef,
//                            (__bridge id)kCTForegroundColorAttributeName : (__bridge id)[UIColor redColor].CGColor
//                            } range:[text rangeOfString:@"simple text layout"]];
    
    self.textLayer.string = string;
}

/*UILabel的替代品*/
- (void)labelLayer
{
    TextLayerLabel *label = [[TextLayerLabel alloc] init];
    label.frame = CGRectMake(self.layerX, self.layerY, self.layerWidth, self.layerHeight);
    label.text = @"The text layer provides simple text layout and rendering of plain or attributed strings. The first line is aligned to the top of the layer.";
    label.font = [UIFont systemFontOfSize:20 weight:0.5];
    label.layer.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1].CGColor;
    label.textColor = [UIColor brownColor];
    self.textLayer = (CATextLayer *)label.layer;
    [self.view.layer addSublayer:self.textLayer];
}

@end
