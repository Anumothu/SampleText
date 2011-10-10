//
//  FlowLogicDelegate.h
//  Insolex
//
//  Created by Almand on 19/08/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef enum
{
    VIEW_LOGIN,
    VIEW_SUBMISSION,
    VIEW_MYACCOUNT,
    VIEW_SUBMITCASE
}views;

typedef enum
{
    MODULE_SUBMISSION,
    MODULE_SUBMITASSIST
}modules;


@protocol FlowLogicDelegate <NSObject>

@optional
-(void)showView:(views)view :(id)data :(modules)module;
- (void) showAlertPopup :(NSString *) title :(NSString *) msg;
-(void) goBack;
@end
