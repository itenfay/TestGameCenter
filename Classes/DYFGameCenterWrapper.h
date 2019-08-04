//
//  DYFGameCenterWrapper.h
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

#import <UIKit/UIKit.h>
#import <GameKit/GameKit.h> // @import GameKit;

#if DEBUG
#define GKLog(fmt, ...) NSLog((@"%s [Line: %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)
#endif

@interface DYFGameCenterWrapper : NSObject

/**
 Authenticates for game center with a completion handler.
 */
- (void)authenticateWithCompletion:(void (^)(GKLocalPlayer *player, NSError *error))completionHandler;

/**
 Authenticates for game center with a view controller and a completion handler.
 */
- (void)authenticateFromViewController:(UIViewController *)fromViewController completion:(void (^)(GKLocalPlayer *player, NSError *error))completionHandler;

/**
 Reports score for leaderboard indentifier.
 */
- (void)reportScore:(int64_t)score forLeaderboardID:(NSString *)indentifier;

@end

