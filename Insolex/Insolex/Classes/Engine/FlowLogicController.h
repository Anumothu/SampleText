//
//  FlowLogicController.h
//  Insolex
//
//  Created by Almand on 19/08/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//	File created using Singleton XCode Template by Mugunth Kumar (http://mugunthkumar.com
//  Permission granted to do anything, commercial/non-commercial with this file apart from removing the line/URL above

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "FlowLogicDelegate.h"

#import "LoginViewController.h"
#import "SubmissionTrackViewcontroller.h"
#import "SubmitCaseViewController.h"
#import "MyAccountViewController.h"

@interface FlowLogicController : NSObject <FlowLogicDelegate>{
    UINavigationController *flowcontroller;
}
@property (nonatomic,retain) UINavigationController *flowcontroller;

+ (FlowLogicController*) sharedInstance;


#pragma mark-

-(void) initFlowController;

@end
