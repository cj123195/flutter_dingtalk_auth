#import "DingtalkAuthPlugin.h"
#import <ADTOpenAuthSDK/ADTOpenAuthSDK.h>

@interface DingtalkAuthPlugin () <ADTOpenAuthAPIDelegate>
@property (nonatomic, strong) FlutterResult authResult;
@end

@implementation DingtalkAuthPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  FlutterMethodChannel* channel = [FlutterMethodChannel
      methodChannelWithName:@"dingtalk_auth"
            binaryMessenger:[registrar messenger]];
  DingtalkAuthPlugin* instance = [[DingtalkAuthPlugin alloc] init];
  [registrar addMethodCallDelegate:instance channel:channel];
  [registrar addApplicationDelegate:instance];
}

- (void)handleMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result {
    if ([@"registerApp" isEqualToString:call.method]) {
        NSDictionary *arguments = call.arguments;
        NSString *appId = arguments[@"appId"];
        NSString *bundleId = arguments[@"bundleId"];
        BOOL res = [ADTOpenAuthAPI registerApp:appId identifier:bundleId];
        result(@(res));
    } else if ([@"auth" isEqualToString:call.method]) {
        UIViewController *topVC = [self topViewController];
                if (!topVC) {
                    result([FlutterError errorWithCode:@"NO_VIEWCONTROLLER"
                                             message:@"无法获取顶层视图控制器"
                                             details:nil]);
                    return;
                }
        
        self.authResult = result;
        NSDictionary *arguments = call.arguments;
        
        ADTOpenAuthReq *req = [ADTOpenAuthReq new];
        // 必选参数
        req.redirectUrl = arguments[@"redirectUri"];
        req.responseType = @"code";
        req.scope = arguments[@"scope"];
        req.prompt = arguments[@"prompt"];
        req.state = arguments[@"state"];
        NSLog(@"Auth Request Parameters: %@", @{
            @"redirectUrl": req.redirectUrl ?: @"",
            @"scope": req.scope,
            @"prompt": req.prompt,
            @"state": req.state
        });
        BOOL res = [ADTOpenAuthAPI sendReq:req onViewController:topVC];
        if (!res) {
            result([FlutterError errorWithCode:@"SEND_REQUEST_FAILED"
                                     message:@"发送授权请求失败"
                                     details:nil]);
        }
    } else {
        result(FlutterMethodNotImplemented);
    }
}

// 添加获取顶层控制器的方法
- (UIViewController *)topViewController {
    UIWindow *keyWindow = UIApplication.sharedApplication.keyWindow;
    UIViewController *rootViewController = keyWindow.rootViewController;
    return [self topViewControllerWithRootViewController:rootViewController];
}

- (UIViewController *)topViewControllerWithRootViewController:(UIViewController *)rootViewController {
    if ([rootViewController isKindOfClass:[UINavigationController class]]) {
        UINavigationController *nav = (UINavigationController *)rootViewController;
        return [self topViewControllerWithRootViewController:nav.visibleViewController];
    }
    if ([rootViewController isKindOfClass:[UITabBarController class]]) {
        UITabBarController *tab = (UITabBarController *)rootViewController;
        return [self topViewControllerWithRootViewController:tab.selectedViewController];
    }
    if (rootViewController.presentedViewController) {
        return [self topViewControllerWithRootViewController:rootViewController.presentedViewController];
    }
    return rootViewController;
}

#pragma mark - AppDelegate methods
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options {
    return [ADTOpenAuthAPI handleOpenURL:url delegate:self];
}

#pragma mark ADTOpenAuthAPIDelegate

- (void)onResp:(ADTBaseResp *)resp {
    if ([resp isKindOfClass:[ADTOpenAuthResp class]]) {
        ADTOpenAuthResp *authResp = (ADTOpenAuthResp *)resp;
        
        if (self.authResult) {
            self.authResult(authResp.authCode);
            self.authResult = nil;
        }
    }
}

@end
