//
//  DelegateInputViewController.h
//  demo-passing-data-back
//
//  Created by shoshino21 on 5/27/17.
//  Copyright © 2017 shoshino21. All rights reserved.
//

typedef NS_ENUM(NSUInteger, SHOInputType) {
  SHOInputTypeName = 0,
  SHOInputTypeJob
};


@class DelegateInputViewController;

@protocol SHOInputDelegate <NSObject>

- (void)viewController:(DelegateInputViewController *)aViewCtrl
    didFinishInputting:(NSString *)inputedValue
             inputType:(SHOInputType)inputType;

@end


@interface DelegateInputViewController : UIViewController

@property (nonatomic, weak) id<SHOInputDelegate> delegate;

@property (nonatomic, assign) SHOInputType inputType;
@property (nonatomic, strong) NSString *inputValue;

@end
