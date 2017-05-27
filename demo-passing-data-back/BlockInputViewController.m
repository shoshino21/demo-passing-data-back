//
//  BlockInputViewController.m
//  demo-passing-data-back
//
//  Created by shoshino21 on 5/27/17.
//  Copyright © 2017 shoshino21. All rights reserved.
//

#import "BlockInputViewController.h"

@interface BlockInputViewController () <UITextFieldDelegate> {
  UITextField *_textField;
}

@end

@implementation BlockInputViewController

#pragma mark - Lifecycle

- (void)viewDidLoad {
  [super viewDidLoad];
  self.view.backgroundColor = [UIColor whiteColor];

  [self initTextField];
  [self initNavigationBar];
}

- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];

  [self refreshTitleAndValue];

  // 進入輸入畫面直接顯示螢幕鍵盤
  [self showKeyboardInstantly];
}

#pragma mark - Initialize

- (void)initTextField {
  CGRect textFieldFrame = CGRectMake(40,
                                     kDefaultNavigationBarHeight + kStatusBarHeight + 40,
                                     kScreenWidth - 40 * 2,
                                     kDefaultTextFieldHeight);

  _textField = [[UITextField alloc] initWithFrame:textFieldFrame];
  _textField.delegate = self;
  _textField.backgroundColor = [UIColor whiteColor];
  _textField.borderStyle = UITextBorderStyleRoundedRect;
  [self.view addSubview:_textField];
}

- (void)initNavigationBar {
  UIBarButtonItem *doneBarButton =
  [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone
                                                target:self
                                                action:@selector(donePressed:)];

  self.navigationItem.rightBarButtonItem = doneBarButton;
}

- (void)refreshTitleAndValue {
  switch (_inputType) {
    case SHOInputTypeName:
      self.navigationItem.title = kFieldTitleName;
      break;
      
    case SHOInputTypeJob:
      self.navigationItem.title = kFieldTitleJob;
      break;
  }

  _textField.text = _inputValue;
}

#pragma mark - Actions

- (IBAction)donePressed:(id)sender {
  self.inputValue = _textField.text;

  [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - Private Methods

- (void)showKeyboardInstantly {
  [_textField becomeFirstResponder];
}

@end
