//
//  LoginData.h
//  Insolex
//
//  Created by Almand on 19/08/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ServerIntractor.h"
#import "PlistPerfomer.h"



// in login page we need to perfom 4 api 
typedef enum 
{
    API_LOGIN,
    API_FORGETUSERNAME,
    API_FORGETPASSWORD,
    API_REMEMBERUSERNAME
}apioperation;

@interface LoginData : NSObject {
 
    NSString *txtusername;
    NSString *txtpassword;
    
    
    NSDictionary *responcedata;
    
    BOOL rememberpasswordon;
    
}
@property (nonatomic,copy)  NSString *txtusername;
@property (nonatomic,copy)  NSString *txtpassword;
@property (nonatomic,retain)  NSDictionary *responcedata;

@property (nonatomic,assign)  BOOL rememberpasswordon; 
#pragma mark -

-(BOOL) performApiOperation:(apioperation) apiname;

-(void) rememberPassword:(BOOL) yesorno;

-(BOOL) moduleSubmission;


-(void) releaseMemory;

@end
