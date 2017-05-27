//
//  Macro.h
//  demo-passing-data-back
//
//  Created by shoshino21 on 5/26/17.
//  Copyright © 2017 shoshino21. All rights reserved.
//

#define kScreenBounds     [UIScreen mainScreen].bounds
#define kScreenWidth      kScreenBounds.size.width
#define kScreenHeight     kScreenBounds.size.height
#define kStatusBarHeight  [UIApplication sharedApplication].statusBarFrame.size.height

#define declareWeakSelf()   __weak __typeof(self) weakSelf = self;
#define declareStrongSelf() __strong __typeof(weakSelf) strongSelf = weakSelf
