//
//  AppDelegate.h
//  LinekeLive
//
//  Created by CoderTan on 2017/6/21.
//  Copyright © 2017年 CoderTan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Reachability.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>
@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, strong) Reachability  *hostReach;
@property (nonatomic, assign) void(^SatusFinishedBlock)(NetworkStatus networkStatus);
/// 转场动画更改根控制器
- (void)animationRoot:(AnimServiceType)type;

@end

