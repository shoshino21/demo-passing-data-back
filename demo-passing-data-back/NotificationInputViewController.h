//
//  NotificationInputViewController.h
//  demo-passing-data-back
//
//  Created by shoshino21 on 5/27/17.
//  Copyright © 2017 shoshino21. All rights reserved.
//

static NSString *const kValueChangedNotification = @"kValueChangedNotification";
static NSString *const kNotifyInputType = @"kNotifyInputType";
static NSString *const kNotifyInputValue = @"kNotifyInputValue";

typedef NS_ENUM(NSUInteger, SHOInputType) {
  SHOInputTypeName = 0,
  SHOInputTypeJob
};

////////////////////////////////////////////////////////////////////////////////////////////////////

@interface NotificationInputViewController : UIViewController

@property (nonatomic, assign) SHOInputType inputType;
@property (nonatomic, strong) NSString *inputValue;

@end
