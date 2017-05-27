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

@end

////////////////////////////////////////////////////////////////////////////////////////////////////

@implementation NotificationMainViewController

#pragma mark - Lifecycle

- (void)viewDidLoad {
  [super viewDidLoad];
  self.view.backgroundColor = [UIColor greenColor];

  [self initProperties];
  [self initTableView];

  [self addObservers];
}

- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];
  self.navigationItem.title = kTabTitleNotification;
}

- (void)dealloc {
  [self removeObservers];
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
  _myTableView.alpha = 0.9f;

  [self.view addSubview:_myTableView];
}

#pragma mark -- Notification

- (void)addObservers {
  [[NSNotificationCenter defaultCenter] addObserver:self
                                           selector:@selector(receiveValueChangedNotification:)
                                               name:kValueChangedNotification
                                             object:nil];
}

- (void)removeObservers {
  [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - Private Methods

- (void)reloadRowWithInputType:(SHOInputType)inputType {
  dispatch_async(dispatch_get_main_queue(), ^{
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:inputType inSection:0];
    [_myTableView reloadRowsAtIndexPaths:@[ indexPath ] withRowAnimation:NO];
  });
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

  // 移除選擇欄位時的陰影
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
  NotificationInputViewController *inputViewCtrl = [NotificationInputViewController new];

  switch (indexPath.row) {
    case SHOInputTypeName:
      inputViewCtrl.inputType = SHOInputTypeName;
      inputViewCtrl.inputValue = _currentName;
      break;

    case SHOInputTypeJob:
      inputViewCtrl.inputType = SHOInputTypeJob;
      inputViewCtrl.inputValue = _currentJob;
      break;
  }

  [self.navigationController pushViewController:inputViewCtrl animated:YES];
}

#pragma mark - Value changed

/**
 接收到修改值通知後的處理
 */
- (void)receiveValueChangedNotification:(NSNotification *)noti {
  NSDictionary *userInfoDict = noti.userInfo;

  if (![userInfoDict isKindOfClass:[NSDictionary class]]) {
    return;
  }

  SHOInputType inputType = [userInfoDict[kNotifyInputType] integerValue];
  NSString *inputValue = userInfoDict[kNotifyInputValue];

  switch (inputType) {
    case SHOInputTypeName:
      _currentName = inputValue;
      break;

    case SHOInputTypeJob:
      _currentJob = inputValue;
      break;
  }

  // 只更新對應的資料列
  [self reloadRowWithInputType:inputType];
}

@end
