//
//  ViewController.m
//  CoreAnimation
//
//  Created by Hong on 16/7/8.
//  Copyright (c) 2016 Hong. All rights reserved.
//


#import "ViewController.h"


@interface ViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *dataArray;

@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];

    _dataArray = @[
                   @"TransformViewController",
                   @"CAShapeLayerViewController",
                   @"CATextLayerViewController",
                   @"CATransformLayerViewController",
                   @"CAGradientLayerViewController",
                   @"CAReplicatorLayerViewController",
                   @"CAScrollViewLayerViewController",
                   @"CATiledLayerViewController",
                   @"CAEmitterLayerViewController"
                   ];

}

#pragma mark - Delegate
#pragma mark UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([UITableViewCell class])];
    if (!cell){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([UITableViewCell class])];
    }
    cell.textLabel.text = [self.dataArray objectAtIndex:indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    Class class = NSClassFromString([self.dataArray objectAtIndex:indexPath.row]);
    if (class){
        id vc = [[class alloc] init];
        if (vc && [vc isKindOfClass:[UIViewController class]]){
            [self.navigationController pushViewController:vc animated:YES];
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
