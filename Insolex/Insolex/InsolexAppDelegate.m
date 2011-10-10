//
//  InsolexAppDelegate.m
//  Insolex
//
//  Created by Almand on 18/08/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "InsolexAppDelegate.h"

@implementation InsolexAppDelegate


@synthesize window=_window;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    [[FlowLogicController sharedInstance] initFlowController];
    [self.window addSubview:[FlowLogicController sharedInstance].flowcontroller.view];
    
    //=======================================================
    
    // initial settings
    [self performSelector:@selector(loadInsloxProperties)];
    //=======================================================
    
    
    
    
       [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
     */
}


- (void)applicationWillEnterForeground:(UIApplication *)application
{
    /*
     Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
     */
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    /*
     Called when the application is about to terminate.
     Save data if appropriate.
     See also applicationDidEnterBackground:.
     */
}

- (void)dealloc
{
    [_window release];
    [super dealloc];
}

#pragma mark -
#pragma mark class methods
// this is nothing but, just load the intial values which one need for the whole project.
// hostname is the ip address or domain name.
-(void) loadInsloxProperties
{
    // load the host name
    
    PlistPerfomer *plisthandler =[[PlistPerfomer alloc] init];
    
    plisthandler.filename = @"insolex-properties";
    NSDictionary *dic =[plisthandler read];
    NSString *str =[dic objectForKey:@"Hostname"];
    
    [[NSUserDefaults standardUserDefaults] setValue:str forKey:@"Hostname"];
    
    NSDictionary *dic1 =[dic objectForKey:@"Alert"];
    [[NSUserDefaults standardUserDefaults] setValue:dic1 forKey:@"Alert"];
    [plisthandler releaseMemory];
    [plisthandler release];
    
    //-----------------------------------------------------------
}
@end
