//
//  UIWindow+Visible.m
//
//  Created by dyf on 2016/10/19.
//  Copyright © 2016 dyf. All rights reserved.
//

#import "UIWindow+Visible.h"

#define AppWindow [[[UIApplication sharedApplication] delegate] window]

@implementation UIWindow (Visible)

+ (UIWindow *)visibleWindow {
    return AppWindow;
}

+ (UIViewController *)visibleViewController {
    return [self visibleViewControllerWithViewController:AppWindow.rootViewController];
}

+ (UIViewController *)visibleViewControllerWithViewController:(UIViewController *)viewController {
    if ([viewController isKindOfClass:[UITabBarController class]]) {
        UITabBarController *tabBarController = (UITabBarController *)viewController;
        return [self visibleViewControllerWithViewController:tabBarController.selectedViewController];
    } else if ([viewController isKindOfClass:[UINavigationController class]]) {
        UINavigationController *navigationController = (UINavigationController *)viewController;
        return [self visibleViewControllerWithViewController:navigationController.visibleViewController];
    } else if (viewController.presentedViewController) {
        UIViewController *presentedViewController = viewController.presentedViewController;
        return [self visibleViewControllerWithViewController:presentedViewController];
    } else {
        return viewController;
    }
}

@end
