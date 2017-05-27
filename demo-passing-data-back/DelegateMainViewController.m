//
//  DelegateMainViewController.m
//  demo-passing-data-back
//
//  Created by shoshino21 on 5/26/17.
//  Copyright © 2017 shoshino21. All rights reserved.
//

#import "DelegateMainViewController.h"
#import "DelegateInputViewController.h"

@interface DelegateMainViewController () <UITableViewDataSource, UITableViewDelegate, SHOInputDelegate> {
  UITableView *_myTableView;
  DelegateInputViewController *_inputViewCtrl;

  NSString *_currentName;
  NSString *_currentJob;
}

@property (nonatomic, strong, readonly) DelegateInputViewController *inputViewCtrl;

@end

////////////////////////////////////////////////////////////////////////////////////////////////////

@implementation DelegateMainViewController

@synthesize inputViewCtrl = _inputViewCtrl;

#pragma mark - Lifecycle

- (void)viewDidLoad {
  [super viewDidLoad];
  self.view.backgroundColor = [UIColor whiteColor];

  [self initProperties];
  [self initTableView];
}

- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];
  self.navigationItem.title = kTabTitleDelegate;
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

- (DelegateInputViewController *)inputViewCtrl {
  // Lazy loading
  if (!_inputViewCtrl) {
    _inputViewCtrl = [DelegateInputViewController new];
    _inputViewCtrl.delegate = self;
  }

  return _inputViewCtrl;
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
      self.inputViewCtrl.inputType = SHOInputTypeName;
      self.inputViewCtrl.inputValue = _currentName;
      break;

    case SHOInputTypeJob:
      self.inputViewCtrl.inputType = SHOInputTypeJob;
      self.inputViewCtrl.inputValue = _currentJob;
      break;
  }

  [self.navigationController pushViewController:self.inputViewCtrl animated:YES];
}

#pragma mark - SHOInputDelegate

- (void)viewController:(DelegateInputViewController *)aViewCtrl
    didFinishInputting:(NSString *)inputedValue
             inputType:(SHOInputType)inputType
{
  switch (inputType) {
    case SHOInputTypeName:
      _currentName = inputedValue;
      break;

    case SHOInputTypeJob:
      _currentJob = inputedValue;
      break;
  }

  // 只更新對應的資料列
  [self reloadRowWithInputType:inputType];
}

@end
