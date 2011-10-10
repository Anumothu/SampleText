//
//  InsolexAppDelegate.h
//  Insolex
//
//  Created by Almand on 18/08/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//
//***************************************************************************
// FlowlogicController is our master controler for navigating the page.
// flow logic controllre have the navigation controller.
// project flow structure is
// appdelegate -> flowlogic controller (it has the navigation controller)-> View Controller <-> data model
//                                                                                          <-> view (xib)




//****************************************************************************
#import <UIKit/UIKit.h>
#import "FlowLogicController.h"
#import "PlistPerfomer.h"

@interface InsolexAppDelegate : NSObject <UIApplicationDelegate> {

}

@property (nonatomic, retain) IBOutlet UIWindow *window;

@end
