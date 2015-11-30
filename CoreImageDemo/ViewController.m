//
//  ViewController.m
//  CoreImageDemo
//
//  Created by DreamHack on 15-11-26.
//  Copyright (c) 2015年 DreamHack. All rights reserved.
//

#import "ViewController.h"

static NSString * const kTableViewCellIdentifier = @"kTableViewCellIdentifier";

@interface ViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView * tableView;
@property (nonatomic, strong) NSArray * viewControllers;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
    self.title = @"filter demos";
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.viewControllers.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:kTableViewCellIdentifier forIndexPath:indexPath];
    
    cell.textLabel.font = [UIFont systemFontOfSize:18];
    cell.textLabel.text = self.viewControllers[indexPath.row];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString * controllerName = self.viewControllers[indexPath.row];
    UIViewController * controller = [[NSClassFromString(controllerName) alloc] init];
    controller.title = [controllerName stringByReplacingCharactersInRange:NSMakeRange(controllerName.length-14, 14) withString:@""];
    
    [self.navigationController pushViewController:controller animated:YES];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
        _tableView.rowHeight = 60;
        _tableView.dataSource = self;
        _tableView.delegate = self;
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:kTableViewCellIdentifier];
    }
    return _tableView;
}

- (NSArray *)viewControllers
{
    if (!_viewControllers) {
        _viewControllers = @[@"CIFilterChainingViewController",@"CICopyMachineViewController",@"CIFaceDetectingViewController",@"CIAutoEnhancementViewController",@"CIColorInvertViewController",@"CIChromaKeyViewController"];
    }
    return _viewControllers;
}

@end
