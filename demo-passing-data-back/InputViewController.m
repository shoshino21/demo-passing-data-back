//
//  InputViewController.m
//  demo-passing-data-back
//
//  Created by shoshino21 on 5/26/17.
//  Copyright © 2017 shoshino21. All rights reserved.
//

#import "InputViewController.h"

// shTODO:to kill
#define kScreenBounds [UIScreen mainScreen].bounds
#define kScreenWidth kScreenBounds.size.width
#define kScreenHeight kScreenBounds.size.height
#define kStatusBarHeight [UIApplication sharedApplication].statusBarFrame.size.height

@interface InputViewController () <UITextFieldDelegate> {
  UITextField *_nameTextField;
}

@end

@implementation InputViewController

- (void)viewDidLoad {
  [super viewDidLoad];

  _nameTextField = [[UITextField alloc] initWithFrame:CGRectMake(20, 60, kScreenWidth - 20, 30)];
  _nameTextField.delegate = self;
  [self.view addSubview:_nameTextField];
}

@end
