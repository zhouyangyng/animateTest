//
//  AppDelegate.m
//  test
//
//  Created by mac1 on 2017/8/21.
//  Copyright © 2017年 mac1. All rights reserved.
//

#import "AppDelegate.h"
#import <Bugly/Bugly.h>
#import <execinfo.h>
#import <signal.h>

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    [Bugly startWithAppId:@"d14e4ddce8"];
    
    // 改1
    
    
//    InstallSignalHandler();
    
    return YES;
}

//void InstallSignalHandler(void)
//{
//    signal(SIGHUP, SignalExceptionHandler);
//    signal(SIGINT, SignalExceptionHandler);
//    signal(SIGQUIT, SignalExceptionHandler);
//
//    signal(SIGABRT, SignalExceptionHandler);
//    signal(SIGILL, SignalExceptionHandler);
//    signal(SIGSEGV, SignalExceptionHandler);
//    signal(SIGFPE, SignalExceptionHandler);
//    signal(SIGBUS, SignalExceptionHandler);
//    signal(SIGPIPE, SignalExceptionHandler);
//}
//
//void SignalExceptionHandler(int signal)
//{
//    NSMutableString *mstr = [[NSMutableString alloc] init];
//    [mstr appendString:@"Stack:\n"];
//    void* callstack[128];
//    int i, frames = backtrace(callstack, 128);
//    char** strs = backtrace_symbols(callstack, frames);
//    for (i = 0; i <frames; ++i) {
//        [mstr appendFormat:@"%s\n", strs[i]];
//    }
//    [SignalHandler saveCreash:mstr];
//
//}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
