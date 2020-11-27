//
//  AppDelegate.m
//  GBAirTickets
//
//  Created by Даниил Мурыгин on 25.11.2020.
//

#import "AppDelegate.h"
#import "TabBarController.h"
#import "NotificationCenter.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    CGRect windowFrame = [[UIScreen mainScreen] bounds];
    self.window = [[UIWindow alloc] initWithFrame: windowFrame];
    
    TabBarController *mapViewController = [[TabBarController alloc] init];
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController: mapViewController];
    
    self.window.rootViewController = navigationController;
    [self.window makeKeyAndVisible];
    
    [[NotificationCenter sharedInstance] registerService];
    return YES;
}

@end
