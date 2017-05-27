//
//  NotificationInputViewController.h
//  demo-passing-data-back
//
//  Created by shoshino21 on 5/27/17.
//  Copyright © 2017 shoshino21. All rights reserved.
//

typedef NS_ENUM(NSUInteger, SHOInputType) {
  SHOInputTypeName = 0,
  SHOInputTypeJob
};

@interface NotificationInputViewController : UIViewController

- (void)settingInputType:(SHOInputType)inputType currentValue:(NSString *)currentValue;

@end
