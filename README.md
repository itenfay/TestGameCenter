[如果你觉得能帮助到你，请给一颗小星星。谢谢！(If you think it can help you, please give it a star. Thanks!)](https://github.com/dgynfi/TestGameCenter)

[![License MIT](https://img.shields.io/badge/license-MIT-green.svg?style=flat)](LICENSE)&nbsp;

## TestGameCenter

测试 Game Center 的登录认证，通过自己封装的 `DYFGameCenterWrapper` 类完成 Game Center 的认证对接。(Tests the Game Center authentication and completes the Game Center authentication access through myself encapsulated  `DYFGameCenterWrapper`  class.)

## 技术交流群(群号:155353383) 

欢迎加入技术交流群，一起探讨技术问题。<br />
![](https://github.com/dgynfi/TestGameCenter/raw/master/images/qq155353383.jpg)

## 日志

```
2016-08-01 17:18:26.361782+0100 TestGameCenter[14287:4090066] -[ViewController authenticate:]_block_invoke [Line: 28] [Player] id: G:1885390510, alias: 狂人得香槟, displayName: 我

2016-08-01 17:21:49.945390+0800 TestGameCenter[14287:4090066] -[ViewController authenticateFromViewController:]_block_invoke [Line: 38] [Player] id: G:1885390510, alias: 狂人得香槟, displayName: 我
```

## 使用说明

- 如何测试Game Center认证？(How to test the Game Center authentication?)

1. 在苹果开发者后台，创建并勾选Game Center的证书，然后生成mobileprovision配置文件，如何创建证书和生成配置文件？请大家在网上搜索一下，这里不再阐述。

2. 在iTunes Store中创建应用，打开Game Cemter选项。

- 授权并测试 (Authentication and Testing)

```ObjC
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

- (DYFGameCenterWrapper *)gcWrapper {
    if (!_gcWrapper) {
        _gcWrapper = [[DYFGameCenterWrapper alloc] init];
    }
    return _gcWrapper;
}
```

## 通知观察

   当玩家的认证信息发生了改变时，即可认为玩家在系统设置中的Game Center上切换了另一个账号，应用就会通知观察者，从而开发者在应用中处理一些相关的任务。

```ObjC
- (void)addAuthenticationObserver {
    [NSNotificationCenter.defaultCenter addObserver:self selector:@selector(playerAuthenticationDidChange:) name:GKPlayerAuthenticationDidChangeNotificationName object:nil];
}


- (void)playerAuthenticationDidChange:(NSNotification *)noti {
    GKLog(@"[GameCenter] [Notification] object: %@, userInfo: %@", noti.object, noti.userInfo);
}
```

## 移除通知观察

```ObjC
    [NSNotificationCenter.defaultCenter removeObserver:self name:GKPlayerAuthenticationDidChangeNotificationName object:nil];
```

## Sample Codes

- [Sample Codes Gateway](https://github.com/dgynfi/TestGameCenter/blob/master/TestGameCenter/ViewController.m)
