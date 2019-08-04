# TestGameCenter

GameCenter登录集成，简单接入测试

`Author: dyf` <br>
`Date: 2016/8/1`

https://github.com/dgynfi/TestGameCenter

## Usage
```ObjC
[[GKLocalPlayer localPlayer] setAuthenticateHandler:^(UIViewController * _Nullable viewController, NSError * _Nullable error) {
	if (!error) {
		if (viewController) {
			[UIWindow.visibleViewController presentViewController:viewController animated:YES completion:nil];
		} else {
			if (![GKLocalPlayer localPlayer].isAuthenticated) {
				GKLocalPlayer *player = [GKLocalPlayer localPlayer];
				NSLog(@"login: id->%@, name->%@, alias->%@", player.playerID, player.displayName, player.alias);
			}
		}
	} else {
		NSLog(@"error: %@, %@", @(error.code), error.localizedDescription);
	}
}];
```
## 注册oAuth改变通知
```ObjC
- (void)registerGameCenterObserver {
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(gkplayerAuthenticationChanged:) name:GKPlayerAuthenticationDidChangeNotificationName object:nil];
}

- (void)gkplayerAuthenticationChanged:(NSNotification *)notification {
	GKLocalPlayer *player = (GKLocalPlayer *)notification.object;
	if (!player.playerID) {

	}
}
```

## 移除oAuth改变通知
```ObjC
- (void)unregisterGameCenterObserver {
	[[NSNotificationCenter defaultCenter] removeObserver:self name:GKPlayerAuthenticationDidChangeNotificationName object:nil];
}
```

