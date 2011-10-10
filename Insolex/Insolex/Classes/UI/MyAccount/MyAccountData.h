//
//  MyAccountData.h
//  Insolex
//
//  Created by Almand on 19/08/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ServerIntractor.h"

typedef enum
{
    API_CHANGEPASSWORD = 100,
    API_NEWNUMBER
}apiname;

@interface MyAccountData : NSObject {
    NSDictionary *resdata;
    NSString *errorcode;
    NSString *mobno;
}

@property(nonatomic,retain) NSDictionary *resdata;
@property(nonatomic,copy) NSString *errorcode;
@property(nonatomic,copy)NSString *mobno;

// in myaccount view, name, program name, number, device are the static data.
-(NSArray *) myAccountStaticData;

// user detail must provide in login api. we must store it in an NSUserdefault class.
// from that need to sctucture data, make an array
-(NSArray *) structueData;

// in myaccount view, need to perform two api. One is Change Username , Change Ph number
-(BOOL) PerformApi:(apiname) apiname :(id) reqdata;

-(void) releaseMemory;

@end
