//
//  NotificationMainViewController.m
//  demo-passing-data-back
//
//  Created by shoshino21 on 5/26/17.
//  Copyright © 2017 shoshino21. All rights reserved.
//

#import "NotificationMainViewController.h"
#import "NotificationInputViewController.h"

@interface NotificationMainViewController () <UITableViewDataSource, UITableViewDelegate> {
  UITableView *_myTableView;
  NSString *_currentName;
  NSString *_currentJob;
}

@property (nonatomic, strong) NotificationInputViewController *inputViewCtrl;

@end

@implementation NotificationMainViewController

#pragma mark - Lifecycle

- (void)viewDidLoad {
  [super viewDidLoad];
  self.view.backgroundColor = [UIColor whiteColor];

  [self initProperties];
  [self initTableView];
}

- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];
  self.navigationItem.title = kTabTitleNotification;
}

#pragma mark - Initialize

- (void)initProperties {
  _currentName = kDefaultName;
  _currentJob = kDefaultJob;
}

- (void)initTableView {
  _myTableView = [[UITableView alloc] initWithFrame:self.view.frame];
  _myTableView.dataSource = self;
  _myTableView.delegate = self;
  _myTableView.backgroundColor = [UIColor whiteColor];

  [self.view addSubview:_myTableView];
}

#pragma mark - Custom Accessors

- (NotificationInputViewController *)inputViewCtrl {
  // Lazy loading
  if (!_inputViewCtrl) {
    _inputViewCtrl = [NotificationInputViewController new];
  }

  return _inputViewCtrl;
}

#pragma mark - UITableView

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  static NSString *cellIdentifierStr;
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifierStr];

  if (!cell) {
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1
                                  reuseIdentifier:cellIdentifierStr];
  }

  cell.selectionStyle = UITableViewCellSelectionStyleNone;

  switch (indexPath.row) {
    case SHOInputTypeName:
      cell.textLabel.text = kFieldTitleName;
      cell.detailTextLabel.text = _currentName;
      break;

    case SHOInputTypeJob:
      cell.textLabel.text = kFieldTitleJob;
      cell.detailTextLabel.text = _currentJob;
      break;
  }

  return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  switch (indexPath.row) {
    case SHOInputTypeName:
      [self.inputViewCtrl settingInputType:SHOInputTypeName currentValue:_currentName];
      break;

    case SHOInputTypeJob:
      [self.inputViewCtrl settingInputType:SHOInputTypeJob currentValue:_currentJob];
      break;
  }

  [self.navigationController pushViewController:self.inputViewCtrl animated:YES];
}

@end
