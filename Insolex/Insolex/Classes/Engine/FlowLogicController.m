//
//  FlowLogicController.m
//  Insolex
//
//  Created by Almand on 19/08/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//	File created using Singleton XCode Template by Mugunth Kumar (http://mugunthkumar.com
//  Permission granted to do anything, commercial/non-commercial with this file apart from removing the line/URL above

#import "FlowLogicController.h"


static FlowLogicController *_instance;
@implementation FlowLogicController
@synthesize flowcontroller;

+ (FlowLogicController*)sharedInstance
{
	@synchronized(self) {
		
        if (_instance == nil) {
			
            _instance = [[super allocWithZone:NULL] init];
            
            // Allocate/initialize any member variables of the singleton class her
            // example
			//_instance.member = @"";
        }
    }
    return _instance;
}


#pragma mark Singleton Methods

+ (id)allocWithZone:(NSZone *)zone
{	
	return [[self sharedInstance]retain];	
}


- (id)copyWithZone:(NSZone *)zone
{
    return self;	
}

- (id)retain
{	
    return self;	
}

- (unsigned)retainCount
{
    return NSUIntegerMax;  //denotes an object that cannot be released
}

- (void)release
{
    //do nothing
}

- (id)autorelease
{
    return self;	
}

#pragma mark -
#pragma mark object methods
-(void) initFlowController
{
    // to do
    LoginViewController *lgcontroller =[[LoginViewController alloc] init];
    lgcontroller.delegate = self;
    UINavigationController *navigation =[[UINavigationController alloc] initWithRootViewController:lgcontroller];
    [lgcontroller release], lgcontroller = nil;
    
    flowcontroller = navigation;

    
}


#pragma flow logic delegate
-(void)goBack
{
    //to do
    [self.flowcontroller popViewControllerAnimated:YES];
}

- (void) showAlertPopup :(NSString *) title :(NSString *) msg
{
	
	UIAlertView *userAlert = [[UIAlertView alloc] initWithTitle:title 
														message:msg
													   delegate:nil 
											  cancelButtonTitle:nil 
											  otherButtonTitles:nil];
	[userAlert show];    
    [self performSelector:@selector(dismissAlert:) withObject:userAlert afterDelay:3];
	
}


-(void ) dismissAlert:(UIAlertView *) alert
{
    [alert dismissWithClickedButtonIndex:0 animated:YES];
    [alert release];
}

-(void)showView:(views)view :(id)data :(modules)module
{
    // to do
    switch (view) {
        case VIEW_SUBMISSION:
        {
            
            SubmissionTrackViewcontroller   *stcontroller =[[SubmissionTrackViewcontroller alloc] init];
            stcontroller.delegate = self;
            stcontroller.module = module;
             
            [flowcontroller pushViewController:stcontroller animated:YES];
            
            flowcontroller.navigationBarHidden =NO;
            flowcontroller.navigationBar.topItem.title = @"Submission Track";
           
            [stcontroller release];
        }
            break;
        case VIEW_MYACCOUNT:
        {
            flowcontroller.navigationBar.topItem.title = @"Back";
            MyAccountViewController *mycontroller =[[MyAccountViewController alloc] initWithStyle:UITableViewStylePlain];
            [flowcontroller pushViewController:mycontroller animated:YES];
            [mycontroller release];
            
            flowcontroller.navigationBar.topItem.title = @"My Account";
            

        }
            break;
        case VIEW_SUBMITCASE:
        {
             flowcontroller.navigationBar.topItem.title = @"Back";
            SubmitCaseViewController *sccontroller =[[SubmitCaseViewController  alloc] initWithStyle:UITableViewStyleGrouped];
            sccontroller.module = module;
            sccontroller.delegate = self;
            [flowcontroller pushViewController:sccontroller animated:YES];
            [sccontroller release];
            
            flowcontroller.navigationBar.topItem.title = @"Submit Case";
            
        }
            break;
        default:
            break;
    }
}


@end
