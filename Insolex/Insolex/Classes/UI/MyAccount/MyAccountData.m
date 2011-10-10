//
//  MyAccountData.m
//  Insolex
//
//  Created by Almand on 19/08/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MyAccountData.h"


@implementation MyAccountData
@synthesize resdata;
@synthesize errorcode;
@synthesize mobno;

-(NSArray *) myAccountStaticData
{
   NSArray *arr = [NSArray arrayWithObjects:@"Student  Name",@"Institution Name",@"Email Address",@"User ID",@"",@"Mobile Device",@"Mobile Number",nil];
    
    return arr;
}


-(NSArray *) structueData
{
    NSMutableArray *arr = [NSMutableArray arrayWithObjects:@"",@"",@"",@"",@"",@"",@"", nil];
    NSData *data=[[NSUserDefaults standardUserDefaults] objectForKey:USERDETAILS];
    
   NSDictionary *dic= [NSKeyedUnarchiver unarchiveObjectWithData:data];
    
    NSLog(@"dic=%@",dic);
    
    if(dic !=(id) kCFNull)
    {
        dic = [dic objectForKey:@"posts"];
        
        if(dic != (id) kCFNull)
        {
            if([dic objectForKey:NAME]&& [dic objectForKey:NAME] != (id) kCFNull)
            {
                [arr replaceObjectAtIndex:0 withObject:[dic objectForKey:NAME]];
            }

            if([dic objectForKey:INSTITUTIONNAME]&& [dic objectForKey:INSTITUTIONNAME] != (id) kCFNull)
            {
                [arr replaceObjectAtIndex:1 withObject:[dic objectForKey:INSTITUTIONNAME]];
            }
            if([dic objectForKey:EMAIL] && [dic objectForKey:EMAIL] != (id) kCFNull)
            {
                [arr replaceObjectAtIndex:2 withObject:[dic objectForKey:EMAIL]];
            }
            if([dic objectForKey:USERID] && [dic objectForKey:USERID] != (id) kCFNull)
            {
                [arr replaceObjectAtIndex:3 withObject:[NSString stringWithFormat:@"%@",[dic objectForKey:USERID]]];
            }
            if([dic objectForKey:DEVICENAME] && [dic objectForKey:DEVICENAME] != (id) kCFNull)
            {
                [arr replaceObjectAtIndex:5 withObject:[dic objectForKey:DEVICENAME]];
            }
            if([dic objectForKey:PHONENO] && [dic objectForKey:PHONENO] != (id) kCFNull)
            {
                [arr replaceObjectAtIndex:6 withObject:[NSString stringWithFormat:@"%@",[dic objectForKey:PHONENO]]];
            }

           

        }
    }
    
    return arr;
}

// in myaccount view, need to perform two api. One is Change Username , Change Ph number
-(BOOL) PerformApi:(apiname) apiname :(id) reqdata
{
    ServerIntractor *sevicehandler =[[ServerIntractor alloc] init];
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithCapacity:4];
    
    
    NSData *data=[[NSUserDefaults standardUserDefaults] objectForKey:USERDETAILS];
    
    NSDictionary *dic1= [NSKeyedUnarchiver unarchiveObjectWithData:data];
    
    NSDictionary *dic2 =[dic1 objectForKey:@"posts"];
    
    NSString *str =[NSString stringWithFormat:@"%@",[dic2 objectForKey:USERID]];
    
    [dic setObject:str forKey:@"userid"];
    //[dic
    
    
    if(apiname == API_NEWNUMBER)
    {
        NSString *nameapi =[NSString stringWithFormat:@"%d",APIUPDATEPHONE];
        sevicehandler.apiname = nameapi;
        [dic setObject:[NSString stringWithFormat:@"%@",reqdata] forKey:@"mobile_no"];
    }
    else
    {
        NSString *nameapi =  [NSString stringWithFormat:@"%d",APIUPDATEPASSWORD];
        sevicehandler.apiname = nameapi;
        [dic setObject:[NSString stringWithFormat:@"%@",reqdata] forKey:@"password"];
    }
    
       sevicehandler.reqdic =(NSDictionary *) dic;
    
    [dic release];
  
    [sevicehandler PostMethod];
    
    self.resdata = [sevicehandler.resdic retain];
    
    [sevicehandler releaseMemory];
    [sevicehandler release];
    
    if(resdata != nil)
    {
        NSLog(@"response=%@",resdata);
       
        NSDictionary *dic1= resdata;
        NSLog(@"dic1=%@",dic1);
        
        dic1 =[dic1 objectForKey:@"posts"];
        
        NSString *str =[dic1 objectForKey:@"mobileno"];
        mobno=str;
        
        
        return YES;
    }
    else
    {
        NSDictionary *dic =[[NSDictionary alloc] initWithObjectsAndKeys:sevicehandler.errorcode,@"error",nil];
        self.resdata = dic;
        [dic release];
        return NO;
        
    }
        
    
    
    return NO;

}


-(void) releaseMemory
{
    [resdata release];
    [mobno  release];
    [errorcode release];
}
@end
