//
//  DelegateNameViewController.h
//  demo-passing-data-back
//
//  Created by shoshino21 on 5/26/17.
//  Copyright © 2017 shoshino21. All rights reserved.
//

@class DelegateNameViewController;

@protocol SHOInputNameDelegate <NSObject>

- (void)viewController:(DelegateNameViewController *)aViewCtrl
    didFinishInputName:(NSString *)inputedName;

@end

@interface DelegateNameViewController : UIViewController

@property (nonatomic, weak) id<SHOInputNameDelegate> delegate;

- (void)settingValue:(NSString *)aValue;

@end
