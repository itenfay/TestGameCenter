[如果此项目能帮助到你，你就给它一颗星，谢谢！(If this project can help you, you will give it a star. Thanks!)](https://github.com/dgynfi/TestGameCenter)

[![License MIT](https://img.shields.io/badge/license-MIT-green.svg?style=flat)](LICENSE)&nbsp;

## TestGameCenter

通过封装的 `DYFGameCenterWrapper` 类完成 Game Center 的授权认证。( Completes the Game Center authentication access through encapsulated  `DYFGameCenterWrapper`  class.)

## Group (ID:614799921)

<div align=left>
&emsp; <img src="https://github.com/dgynfi/TestGameCenter/raw/master/images/g614799921.jpg" width="30%" /> 
</div>

## Logs

```
2016-08-01 17:18:26.361782+0100 TestGameCenter[14287:4090066] -[ViewController authenticate:]_block_invoke [Line: 28] [Player] id: G:1885390510, alias: 狂人得香槟, displayName: 我

2016-08-01 17:21:49.945390+0800 TestGameCenter[14287:4090066] -[ViewController authenticateFromViewController:]_block_invoke [Line: 38] [Player] id: G:1885390510, alias: 狂人得香槟, displayName: 我
```

## Usage

- 如何测试 Game Center 授权认证？(How to test the Game Center authentication?)

1. 在苹果开发者后台，创建并勾选 Game Center 的证书，然后生成 mobileprovision 配置文件，如何创建证书和生成配置文件？请大家在网上搜索一下，这里不再阐述。

2. 在 iTunes Store 中创建应用，打开 Game Cemter 选项。

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

## Notification

- Adding Observer

当玩家的认证信息发生了改变时，即玩家在系统设置中的 Game Center 中切换了另一个账号，应用就会通知观察者，从而开发者在应用中处理一些相关的任务。

```ObjC
- (void)addAuthenticationObserver {
    [NSNotificationCenter.defaultCenter addObserver:self selector:@selector(playerAuthenticationDidChange:) name:GKPlayerAuthenticationDidChangeNotificationName object:nil];
}


- (void)playerAuthenticationDidChange:(NSNotification *)noti {
    GKLog(@"[GameCenter] [Notification] object: %@, userInfo: %@", noti.object, noti.userInfo);
}
```

- Removing Observer

```ObjC
- (void)removeAuthenticationObserver {
    [NSNotificationCenter.defaultCenter removeObserver:self name:GKPlayerAuthenticationDidChangeNotificationName object:nil];
}
```

##  Code Sample

- [Code Sample Portal](https://github.com/dgynfi/TestGameCenter/blob/master/TestGameCenter/ViewController.m)
