//
//  CATiledLayerViewController.m
//  CoreAnimation
//
//  Created by Hong on 16/8/12.
//  Copyright © 2016年 Hong. All rights reserved.
//

#import "CATiledLayerViewController.h"

@interface CATiledLayerViewController ()

@property (nonatomic, strong) CATiledLayer *layer;

@end

@implementation CATiledLayerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(20, 100, CGRectGetWidth(self.view.frame) - 40, CGRectGetWidth(self.view.frame) - 40)];
    scrollView.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:scrollView];
    
    //内存使用 20M突变到140M
//    CALayer *layer = [[CALayer alloc] init];
//    UIImage *image = [UIImage imageNamed:@"IMG_1069.jpg"];
//    layer.contents = (__bridge id)image.CGImage;
//    layer.frame = CGRectMake(0,0,image.size.width,image.size.height);
//    [scrollView.layer addSublayer:layer];
//    scrollView.contentSize = layer.frame.size;
    
    CGFloat scale = [UIScreen mainScreen].scale;
    _layer = [[CATiledLayer alloc] init];
    self.layer.frame = CGRectMake(0, 0, 10982/scale, 2950/scale);
    self.layer.delegate = self;
    self.layer.contentsScale = scale;
    [scrollView.layer addSublayer:self.layer];
    scrollView.contentSize = self.layer.frame.size;
    
    [self.layer setNeedsDisplay];
}

- (void)drawLayer:(CATiledLayer *)layer inContext:(CGContextRef)ctx
{
    CGRect bounds = CGContextGetClipBoundingBox(ctx);
    CGFloat scale = [UIScreen mainScreen].scale;
    NSInteger x = floor(bounds.origin.x * scale / layer.tileSize.width);
    NSInteger y = floor(bounds.origin.y * scale / layer.tileSize.height);
//    NSInteger x = floor(bounds.origin.x / layer.tileSize.width);
//    NSInteger y = floor(bounds.origin.y / layer.tileSize.height);
    
    NSString *imageName = [NSString stringWithFormat:@"IMG_0525_%li_%li", x, y];
    NSLog(@"%@", imageName);
    NSString *imagePath = [[NSBundle mainBundle] pathForResource:imageName ofType:@"jpg"];
    UIImage *image = [UIImage imageWithContentsOfFile:imagePath];
    
    UIGraphicsPushContext(ctx);
    [image drawInRect:bounds];
    UIGraphicsPopContext();
}

- (void)dealloc
{
    self.layer.delegate = nil;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end


