//
//  BlockMainViewController.m
//  demo-passing-data-back
//
//  Created by shoshino21 on 5/26/17.
//  Copyright © 2017 shoshino21. All rights reserved.
//

#import "BlockMainViewController.h"
#import "BlockInputViewController.h"

@interface BlockMainViewController () <UITableViewDataSource, UITableViewDelegate> {
  UITableView *_myTableView;
  NSString *_currentName;
  NSString *_currentJob;
}

@end

////////////////////////////////////////////////////////////////////////////////////////////////////

@implementation BlockMainViewController

#pragma mark - Lifecycle

- (void)viewDidLoad {
  [super viewDidLoad];
  self.view.backgroundColor = [UIColor yellowColor];

  [self initProperties];
  [self initTableView];
}

- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];
  self.navigationItem.title = kTabTitleBlock;
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
  declareWeakSelf();
  BlockInputViewController *inputViewCtrl = [BlockInputViewController new];

  switch (indexPath.row) {
    case SHOInputTypeName: {
      inputViewCtrl.inputType = SHOInputTypeName;
      inputViewCtrl.inputValue = _currentName;

      // 以 block 帶入修改值後的對應處理
      // (注意 retain cycle issue)
      inputViewCtrl.completionHandler = ^(NSString *inputValue) {
        declareStrongSelf();

        strongSelf->_currentName = inputValue;
        [strongSelf reloadRowWithInputType:indexPath.row];
      };

      break;
    }

    case SHOInputTypeJob: {
      inputViewCtrl.inputType = SHOInputTypeJob;
      inputViewCtrl.inputValue = _currentJob;

      inputViewCtrl.completionHandler = ^(NSString *inputValue) {
        declareStrongSelf();

        strongSelf->_currentJob = inputValue;
        [strongSelf reloadRowWithInputType:indexPath.row];
      };

      break;
    }
  }

  [self.navigationController pushViewController:inputViewCtrl animated:YES];
}

@end
