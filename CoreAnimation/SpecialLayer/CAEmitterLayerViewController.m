//
//  CAEmitterLayerViewController.m
//  CoreAnimation
//
//  Created by Hong on 16/8/15.
//  Copyright © 2016年 Hong. All rights reserved.
//

#import "CAEmitterLayerViewController.h"

@interface CAEmitterLayerViewController ()

@property (nonatomic, strong) CAEmitterLayer *layer;

@end

@implementation CAEmitterLayerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    _layer = [[CAEmitterLayer alloc] init];
    self.layer.frame = CGRectMake(0, 0, 100, 100);
    self.layer.position = self.view.center;
//    self.layer.backgroundColor = [UIColor cyanColor].CGColor;
    self.layer.emitterPosition = CGPointMake(CGRectGetWidth(self.layer.frame)/2.0, CGRectGetHeight(self.layer.frame)/2.0);
    self.layer.renderMode = kCAEmitterLayerAdditive;
    [self.view.layer addSublayer:self.layer];
    
    CAEmitterCell *cell = [[CAEmitterCell alloc] init];
    //color
    cell.color = [UIColor redColor].CGColor;
    cell.greenSpeed = 0.1;
    cell.blueSpeed = 0.1;
    //other
    cell.birthRate = 5;
    cell.contents = (__bridge id)[UIImage imageNamed:@"sun"].CGImage;
    cell.contentsRect = CGRectMake(0, 0, 0.3, 0.3);
    //life time
    cell.lifetime = 10;
    cell.lifetimeRange = 2;
    //emission
//    cell.emissionLatitude = 1;
    cell.emissionLongitude = -M_PI / 2.0;
    cell.emissionRange = M_PI / 2.0;
    //velocity
    cell.velocity = 40;
    
    self.layer.emitterCells = @[cell];
    
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
