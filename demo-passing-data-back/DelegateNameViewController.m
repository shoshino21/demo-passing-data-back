//
//  DelegateNameViewController.m
//  demo-passing-data-back
//
//  Created by shoshino21 on 5/26/17.
//  Copyright © 2017 shoshino21. All rights reserved.
//

#import "DelegateNameViewController.h"

@interface DelegateNameViewController () <UITextFieldDelegate> {
  UITextField *_textField;
  NSString *_nameStr;
}

@end

@implementation DelegateNameViewController

#pragma mark - Lifecycle

- (void)viewDidLoad {
  [super viewDidLoad];
  self.view.backgroundColor = [UIColor whiteColor];

  CGRect textFieldFrame = CGRectMake(40,
                                     kDefaultNavigationBarHeight + kStatusBarHeight + 40,
                                     kScreenWidth - 40 * 2,
                                     kDefaultTextFieldHeight);

  _textField = [[UITextField alloc] initWithFrame:textFieldFrame];
  _textField.delegate = self;
  _textField.backgroundColor = [UIColor whiteColor];
  _textField.borderStyle = UITextBorderStyleRoundedRect;
  [self.view addSubview:_textField];

  _textField.text = _nameStr;

  [self initNavigationBar];
}

- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];
  self.navigationItem.title = kFieldTitleName;
}

- (void)initNavigationBar {
  UIBarButtonItem *doneBarButton =
  [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone
                                                target:self
                                                action:@selector(donePressed:)];

  self.navigationItem.rightBarButtonItem = doneBarButton;
}

- (void)donePressed:(id)sender {
  _nameStr = _textField.text;

  if ([self.delegate respondsToSelector:@selector(viewController:didFinishInputName:)]) {
    [self.delegate viewController:self didFinishInputName:_nameStr];
  }

  [self.navigationController popViewControllerAnimated:YES];
}

- (void)settingValue:(NSString *)aValue {
  _nameStr = aValue;
}

@end
