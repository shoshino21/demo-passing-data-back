//
//  DelegateMainViewController.m
//  demo-passing-data-back
//
//  Created by shoshino21 on 5/26/17.
//  Copyright © 2017 shoshino21. All rights reserved.
//

#import "DelegateMainViewController.h"

#import "DelegateNameViewController.h"
#import "DelegateJobViewController.h"

typedef NS_ENUM(NSUInteger, SHOTableSection) {
  SHOTableSectionName,
  SHOTableSectionJob
};

@interface DelegateMainViewController () <UITableViewDataSource, UITableViewDelegate, SHOInputNameDelegate> {
  UITableView *_myTableView;
  NSString *_nameStr;
  NSString *_jobStr;
}

@end

@implementation DelegateMainViewController

#pragma mark - Lifecycle

- (void)viewDidLoad {
  [super viewDidLoad];
  self.view.backgroundColor = [UIColor whiteColor];

  [self initProperties];
  [self initTableView];
}

- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];
  self.navigationItem.title = kTabTitle1;
}

#pragma mark - Initialize

- (void)initProperties {
  _nameStr = kDefaultName;
  _jobStr = kDefaultJob;
}

- (void)initTableView {
  _myTableView = [[UITableView alloc] initWithFrame:self.view.frame];
  _myTableView.dataSource = self;
  _myTableView.delegate = self;
  _myTableView.backgroundColor = [UIColor whiteColor];

  [self.view addSubview:_myTableView];
}

#pragma mark - UITableViewDataSource

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

  SHOTableSection section = (SHOTableSection)indexPath.row;

  switch (section) {
    case SHOTableSectionName:
      cell.textLabel.text = kFieldTitleName;
      cell.detailTextLabel.text = _nameStr ?: @"";
      break;
    case SHOTableSectionJob:
      cell.textLabel.text = kFieldTitleJob;
      cell.detailTextLabel.text = _jobStr ?: @"";
      break;
  }

  return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  SHOTableSection section = (SHOTableSection)indexPath.row;

  switch (section) {
    case SHOTableSectionName: {
      DelegateNameViewController *nameViewCtrl = [DelegateNameViewController new];
      nameViewCtrl.delegate = self;
      [nameViewCtrl settingValue:_nameStr];
      [self.navigationController pushViewController:nameViewCtrl animated:YES];
      break;
    }

    case SHOTableSectionJob: {
      DelegateJobViewController *jobViewCtrl = [DelegateJobViewController new];
      [self.navigationController pushViewController:jobViewCtrl animated:YES];
      break;
    }
  }
}

#pragma mark - SHOInputNameDelegate

- (void)viewController:(DelegateNameViewController *)aViewCtrl
    didFinishInputName:(NSString *)inputedName
{
  _nameStr = inputedName;
  [_myTableView reloadData];
}

@end
