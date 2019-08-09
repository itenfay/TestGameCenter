//
//  DYFGameCenterWrapper.m
//
//  Created by dyf on 16/8/1.
//  Copyright © 2016 dyf. All rights reserved.
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.
//

#import "DYFGameCenterWrapper.h"

@interface DYFGameCenterWrapper () <GKLocalPlayerListener, GKGameCenterControllerDelegate>

@end

@implementation DYFGameCenterWrapper

- (instancetype)init {
    self = [super init];
    if (self) {
        [self addAuthenticationObserver];
    }
    return self;
}

- (void)authenticateWithCompletion:(void (^)(GKLocalPlayer *player, NSError *error))completionHandler {
    [self authenticateFromViewController:nil completion:completionHandler];
}

- (void)authenticateFromViewController:(UIViewController *)fromViewController completion:(void (^)(GKLocalPlayer *, NSError *))completionHandler {
    if (GKLocalPlayer.localPlayer.isAuthenticated) {
        
        GKLocalPlayer *player = GKLocalPlayer.localPlayer;
        !completionHandler ?: completionHandler(player, nil);
        
    } else {
        [GKLocalPlayer.localPlayer setAuthenticateHandler:^(UIViewController * _Nullable viewController, NSError * _Nullable error) {
            
            if (!error) {
                
                if (viewController) {
                    
                    UIViewController *viewController = fromViewController;
                    if (!viewController) {
                        viewController = self.visibleViewController;
                    }
                    [viewController presentViewController:viewController animated:YES completion:NULL];
                    
                } else {
                    
                    GKLocalPlayer *player = GKLocalPlayer.localPlayer;
                    GKLog(@"[GameCenter] [Player] id: %@, name: %@, alias: %@", player.playerID, player.displayName, player.alias);
                    !completionHandler ?: completionHandler(player, nil);
                    
                }
                
            } else {
                
                GKLog(@"[GameCenter] [Error] code: %@, reason: %@", @(error.code), error.localizedDescription);
                !completionHandler ?: completionHandler(nil, error);
            }
            
        }];
    }
}

- (void)addAuthenticationObserver {
    [NSNotificationCenter.defaultCenter addObserver:self
                                           selector:@selector(playerAuthenticationDidChange:)
                                               name:GKPlayerAuthenticationDidChangeNotificationName
                                             object:nil];
}

- (void)removeAuthenticationObserver {
    [NSNotificationCenter.defaultCenter removeObserver:self
                                                  name:GKPlayerAuthenticationDidChangeNotificationName
                                                object:nil];
}

- (void)playerAuthenticationDidChange:(NSNotification *)noti {
    GKLog(@"[GameCenter] [Notification] object: %@, userInfo: %@", noti.object, noti.userInfo);
}

- (void)reportScore:(int64_t)score forLeaderboardID:(NSString *)indentifier {
    if (!GKLocalPlayer.localPlayer.isAuthenticated) {
        [self authenticateWithCompletion:NULL];
        return;
    }
    
    GKScore *scoreOjbect = [[GKScore alloc] initWithLeaderboardIdentifier:indentifier];
    scoreOjbect.value    = score;
    scoreOjbect.context  = 0;
    [GKScore reportScores:@[scoreOjbect] withCompletionHandler:^(NSError * _Nullable error) {
        
        if (!error) {
            
            GKGameCenterViewController *gcvc = [[GKGameCenterViewController alloc] init];
            gcvc.gameCenterDelegate    = self;
            gcvc.leaderboardIdentifier = indentifier;
            gcvc.viewState             = GKGameCenterViewControllerStateChallenges;
            [self.visibleViewController presentViewController:gcvc animated:YES completion:NULL];
            GKLog(@"[GameCenter] report score: %lld", score);
            
        } else {
            
            GKLog(@"[GameCenter] [Error] code: %@, reason: %@", @(error.code), error.localizedDescription);
        }
        
    }];
}

- (void)gameCenterViewControllerDidFinish:(GKGameCenterViewController *)gameCenterViewController {
    [gameCenterViewController dismissViewControllerAnimated:YES completion:NULL];
}

- (UIViewController *)visibleViewController {
    UIApplication *app   = UIApplication.sharedApplication;
    UIWindow *window     = app.delegate.window;
    UIViewController *vc = window.rootViewController;
    
    while (vc) {
        if ([vc isKindOfClass:[UITabBarController class]]) {
            UITabBarController *tbc    = (UITabBarController *)vc;
            vc = tbc.selectedViewController;
        } else if ([vc isKindOfClass:[UINavigationController class]]) {
            UINavigationController *nc = (UINavigationController *)vc;
            vc = nc.visibleViewController;
        } else {
            if (!vc.presentedViewController) {
                break;
            }
            vc = vc.presentedViewController;
        }
    }
    
    return vc;
}

- (void)dealloc {
    [self removeAuthenticationObserver];
    GKLog();
}

@end
