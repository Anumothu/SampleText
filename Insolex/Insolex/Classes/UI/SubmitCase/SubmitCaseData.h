//
//  SubmitCaseData.h
//  Insolex
//
//  Created by Almand on 19/08/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ServerIntractor.h"
#import "PlistPerfomer.h"


@interface SubmitCaseData : NSObject {
    NSMutableArray *rowdata;
    
    
    NSString *date;
    NSString *category;
    NSString *specialty;
    NSString *procedure;
    NSString *name;
    NSString *title;
    NSString *rolename;
    
    //NSString  *surgicalrole;
   

}
@property (nonatomic,retain) NSMutableArray *rowdata;
@property (nonatomic,copy) NSString *rolename;
@property (nonatomic,copy) NSString *casedate;
@property (nonatomic,copy) NSString *category;
@property (nonatomic,copy) NSString *specialty;
@property (nonatomic,copy) NSString *procedure;
@property (nonatomic,copy) NSString *preceptor;
@property (nonatomic,copy) NSString *title;
//@property (nonatomic,retain)NSString *surgicalrole;

-(NSArray *) getSubmissionTrackData;
-(NSArray *) getSurgicalAssistData;

-(void) UpdateData:(NSString *)str :(NSInteger) row;

-(BOOL) Validation:(modules) module;



-(BOOL) performAPI;

-(void) releaseMemory;

-(NSArray *) getRole;
-(NSArray *) getCaterory:(modules) module;
-(NSArray *) getSpecialty:(modules) module :(NSString *) category;
@end
