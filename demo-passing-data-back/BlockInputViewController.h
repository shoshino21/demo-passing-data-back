//
//  BlockInputViewController.h
//  demo-passing-data-back
//
//  Created by shoshino21 on 5/27/17.
//  Copyright © 2017 shoshino21. All rights reserved.
//

typedef NS_ENUM(NSUInteger, SHOInputType) {
  SHOInputTypeName = 0,
  SHOInputTypeJob
};

@interface BlockInputViewController : UIViewController

@property (nonatomic, assign) SHOInputType inputType;
@property (nonatomic, strong) NSString *inputValue;

@end
