//
//  SubmitCaseData.m
//  Insolex
//
//  Created by Almand on 19/08/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "SubmitCaseData.h"


@implementation SubmitCaseData
@synthesize rowdata;
@synthesize rolename;
@synthesize casedate;
@synthesize category;
@synthesize specialty;
@synthesize procedure;
@synthesize preceptor;
@synthesize title;
//@synthesize surgicalrole;


-(void) initialize
{
    self.rolename = nil;
    self.casedate = nil;
    self.category = nil;
    self.specialty = nil;
    self.procedure = nil;
    self.preceptor = nil;
    self.title= nil;
    

}

-(void) releaseMemory
{
    if(rowdata != nil)
    {
        [rowdata release];
    }
    
    self.rolename = nil;
    self.casedate = nil;
    self.category = nil;
    self.specialty = nil;
    self.procedure = nil;
    self.preceptor = nil;
    self.title= nil;

}

-(NSArray *) getSubmissionTrackData
{
   
    NSArray *arr = [[NSArray alloc] initWithObjects:@"Case Date",@"Surgical Role",@"Surgical Category",@"Specialty",@"Procedure",@"Preceptor Name",@"Preceptor's Acadamic Title",@"Submit", nil];
    if(self.rowdata != nil)
    {
        [self.rowdata release];
    }
    self.rowdata = [arr mutableCopy];
    return [arr autorelease];
}

-(NSArray *) getSurgicalAssistData
{
    
    NSArray *arr = [[NSArray alloc ] initWithObjects:@"Case Date",@"Surgical Category",@"Specialty",@"Procedure",@"Preceptor Name",@"Preceptor's Acadamic Title",@"Submit", nil];
    
    if(self.rowdata != nil)
    {
        [self.rowdata release];
    }
    self.rowdata = [arr mutableCopy];
    return [arr autorelease];

    

}


-(void) UpdateData:(NSString *)str :(NSInteger) row
{
    [rowdata replaceObjectAtIndex:row withObject:str];
}


-(BOOL) Validation:(modules) module
{
    // this is only for assit not for track
    if(self.casedate == nil || self.category ==  nil || self.specialty == nil || self.procedure == nil || self.preceptor == nil || self.title == nil)
    {
        return NO;
    }
    if(module == MODULE_SUBMISSION)
    {
        if(self.rolename == nil)
            return NO;
    }
    else
    {
        self.rolename = @"";
    }
    return YES;
}


-(BOOL) performAPI
{
    
    
    ServerIntractor *sevicehandler =[[ServerIntractor alloc] init];
    
    NSString *nameapi = [NSString stringWithFormat:@"%d",APISUBMITCASE];
    sevicehandler.apiname = nameapi;  
    NSData *data=[[NSUserDefaults standardUserDefaults] objectForKey:USERDETAILS];
    
    NSDictionary *dic1= [NSKeyedUnarchiver unarchiveObjectWithData:data];

    dic1 =[dic1 objectForKey:@"posts"];
    
    NSString *studentd =[NSString stringWithFormat:@"%@",[dic1 objectForKey:STUDENTID]];
    NSString *institutionid =[NSString stringWithFormat:@"%@",[dic1 objectForKey:INSTITUTIONID]];
    
    NSDictionary *dic =[[NSDictionary alloc] initWithObjectsAndKeys:studentd,@"studentid",institutionid,@"institutionid",self.casedate,DATE,self.rolename,SURGICALROLE,self.specialty,SPECIALTY,self.preceptor,PRECEPTOR,self.procedure,PROCEDURE,self.title,TITLE,self.category,CATEGORY,nil];
   
    sevicehandler.reqdic = dic;
    
    [dic release];
    
    [sevicehandler PostMethod];
    
    
    if(sevicehandler.resdic != nil)
    {
        //=================
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"successfully send"  delegate:self cancelButtonTitle:@"ok" otherButtonTitles: nil, nil];
		[alert show];
		[alert release];
        
        //=================
        [sevicehandler releaseMemory];
        [sevicehandler release];
        return YES;
    }
    else
    {
        NSLog(@"dic=%@",sevicehandler.resdic);
        
        //=================
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"successfully send"  delegate:self cancelButtonTitle:@"ok" otherButtonTitles: nil, nil];
		[alert show];
		[alert release];
        
        //=================
        [sevicehandler releaseMemory];
        [sevicehandler release];
        return NO;
    }
    

}


#pragma mark -


-(NSArray *) getRole
{
    PlistPerfomer *listhandler =[[PlistPerfomer alloc] init];
    listhandler.filename = @"Staticlist_Property_List";
    
    NSDictionary *dic = [listhandler read];
    
    [listhandler releaseMemory];
    [listhandler release];
    return [dic objectForKey:@"Role"];
    
}
-(NSArray *) getCaterory:(modules) module
{
    
    PlistPerfomer *listhandler =[[PlistPerfomer alloc] init];
    listhandler.filename = @"Staticlist_Property_List";
    
    NSDictionary *dic = [listhandler read];
    
    if(module == MODULE_SUBMISSION)
    {
        dic =[dic objectForKey:@"Surgical_Technology"];
    }
    else
    {
        dic =[dic objectForKey:@"Surgical_Assistent"];
    }
    
    [listhandler releaseMemory];
    [listhandler release];
    return [dic allKeys];
    
    
}
-(NSArray *) getSpecialty:(modules) module :(NSString *) categoryname
{
    PlistPerfomer *listhandler =[[PlistPerfomer alloc] init];
    listhandler.filename = @"Staticlist_Property_List";
    
    NSDictionary *dic = [listhandler read];
    
    if(module == MODULE_SUBMISSION)
    {
        dic =[dic objectForKey:@"Surgical_Technology"];
    }
    else
    {
        dic =[dic objectForKey:@"Surgical_Assistent"];
    }
    
       NSArray *arr =[dic objectForKey:categoryname];
    
    if([categoryname isEqualToString:@"Choosen"])
    {
        NSData *data=[[NSUserDefaults standardUserDefaults] objectForKey:USERDETAILS];
        
        NSDictionary *dic= [NSKeyedUnarchiver unarchiveObjectWithData:data];
        
        NSString *str =[[dic objectForKey:@"posts"] objectForKey:@"choosen-specialty"];
        arr =[NSArray arrayWithObject:str];
    }
    
    [listhandler releaseMemory];
    [listhandler release];
    return arr;
    
}

@end
