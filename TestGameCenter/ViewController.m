//
//  ViewController.m
//  TestGameCenter
//
//  Created by dyf on 16/8/1.
//  Copyright © 2016 dyf. All rights reserved.
//

#import "ViewController.h"
#import "DYFGameCenterWrapper.h"

@interface ViewController ()

@property (strong, nonatomic) DYFGameCenterWrapper *gcWrapper;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)authenticate:(id)sender {
    [self.gcWrapper authenticateWithCompletion:^(GKLocalPlayer *player, NSError *error) {
        if (!error) {
            GKLog(@"[Player] id: %@, alias: %@, displayName: %@", player.playerID, player.alias, player.displayName);
        } else {
            GKLog(@"[Error] code: %zi, reason: %@", error.code, error.localizedDescription);
        }
    }];
}

- (IBAction)authenticateFromViewController:(id)sender {
    [self.gcWrapper authenticateFromViewController:self completion:^(GKLocalPlayer *player, NSError *error) {
        if (!error) {
            GKLog(@"[Player] id: %@, alias: %@, displayName: %@", player.playerID, player.alias, player.displayName);
        } else {
            GKLog(@"[Error] code: %zi, reason: %@", error.code, error.localizedDescription);
        }
    }];
}

- (IBAction)reportScore:(id)sender {
    [self.gcWrapper reportScore:200 forLeaderboardID:GKLocalPlayer.localPlayer.playerID];
}

- (DYFGameCenterWrapper *)gcWrapper {
    if (!_gcWrapper) {
        _gcWrapper = [[DYFGameCenterWrapper alloc] init];
    }
    return _gcWrapper;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
