//
//  MainViewController.m
//  demo-passing-data-back
//
//  Created by shoshino21 on 5/26/17.
//  Copyright © 2017 shoshino21. All rights reserved.
//

#import "MainViewController.h"

#define kScreenBounds [UIScreen mainScreen].bounds
#define kScreenWidth kScreenBounds.size.width
#define kScreenHeight kScreenBounds.size.height
#define kStatusBarHeight [UIApplication sharedApplication].statusBarFrame.size.height

@interface MainViewController () <UITableViewDataSource, UITableViewDelegate> {
  UIView *_containerView;
  UITableView *_myTableView;
}

@end

@implementation MainViewController

#pragma mark - Lifecycle

- (void)viewDidLoad {
  [super viewDidLoad];

  [self initContainerView];
  [self initTableView];
}

#pragma mark - UI

- (void)initContainerView {
  _containerView = [[UIView alloc] initWithFrame:CGRectMake(0,
                                                            kStatusBarHeight,
                                                            kScreenWidth,
                                                            kScreenHeight - kStatusBarHeight)];
  _containerView.backgroundColor = [UIColor whiteColor];

  [self.view addSubview:_containerView];
}

- (void)initTableView {
  _myTableView = [[UITableView alloc] initWithFrame:_containerView.frame];
  _myTableView.dataSource = self;
  _myTableView.delegate = self;
  _myTableView.backgroundColor = [UIColor whiteColor];

  [_containerView addSubview:_myTableView];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  static NSString *cellIdentifierStr;
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifierStr];

  if (!cell) {
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1
                                  reuseIdentifier:cellIdentifierStr];
  }

  cell.textLabel.text = [NSString stringWithFormat:@"%ld", indexPath.row];
  cell.detailTextLabel.text = @"HAHA";

  cell.selectionStyle = UITableViewCellSelectionStyleNone;

  return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

}

#pragma mark - UITableViewDelegate

@end
