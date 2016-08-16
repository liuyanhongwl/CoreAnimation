//
//  CAScrollViewLayerViewController.m
//  CoreAnimation
//
//  Created by Hong on 16/8/8.
//  Copyright © 2016年 Hong. All rights reserved.
//

#import "CAScrollViewLayerViewController.h"
#import "ScrollLayerView.h"

@interface CAScrollViewLayerViewController ()

@end

@implementation CAScrollViewLayerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    ScrollLayerView *scrollView = [[ScrollLayerView alloc] init];
    scrollView.frame = CGRectMake(0, 0, 100, 100);
    scrollView.center = self.view.center;
    [self.view addSubview:scrollView];
    
    UIImageView *logo = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"logo"]];
    [scrollView addSubview:logo];
    
    scrollView.backgroundColor = [UIColor orangeColor];
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
