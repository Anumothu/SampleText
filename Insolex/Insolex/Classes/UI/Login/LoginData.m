//
//  LoginData.m
//  Insolex
//
//  Created by Almand on 19/08/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "LoginData.h"


@implementation LoginData
@synthesize txtusername;
@synthesize txtpassword;
@synthesize responcedata;
@synthesize rememberpasswordon;



#pragma mark -
#pragma mark class methods

// api operation
-(BOOL) performApiOperation:(apioperation) apiname
{
        
    ServerIntractor *sevicehandler =[[ServerIntractor alloc] init];
    
    NSString *localapiname =  [[NSString alloc] initWithFormat:@"%d",APILOGIN];
        sevicehandler.apiname = localapiname;
    [localapiname release];
    NSString *temstr = self.txtusername;
        
    NSString *namestr =[[NSString alloc] initWithFormat:@"%@",[temstr stringByReplacingOccurrencesOfString:@" " withString:@""]];
    
    temstr = self.txtpassword;
    NSString *pwdstr =[[NSString alloc] initWithFormat:@"%@",[temstr stringByReplacingOccurrencesOfString:@" " withString:@""]];
        
        NSDictionary *dic =[[NSDictionary alloc] initWithObjectsAndKeys:namestr,USERNAME,pwdstr,PASSWORD, nil];
    
    [namestr release];
    [pwdstr release];
        
        sevicehandler.reqdic = dic;
        
        [dic release];
        
        [sevicehandler PostMethod];
        
        
        if(sevicehandler.resdic != nil)
        {
           if([[[sevicehandler.resdic objectForKey:@"posts"] objectForKey:@"reponse_id"] intValue] == 1)
           {
               NSData *data = [NSKeyedArchiver archivedDataWithRootObject:sevicehandler.resdic];
               [[NSUserDefaults standardUserDefaults] setValue:data forKey:USERDETAILS];
               
               [sevicehandler releaseMemory];
               [sevicehandler release];
           
               return YES;
           }
            else
            {
                NSDictionary *dic =[[NSDictionary alloc] initWithObjectsAndKeys:@"101",@"error",nil];
                self.responcedata = dic;
                [dic release];
                
                [sevicehandler releaseMemory];
                [sevicehandler release];
                return NO;

            }
        }
        else
        {
            NSDictionary *dic =[[NSDictionary alloc] initWithObjectsAndKeys:sevicehandler.errorcode,@"error",nil];
            self.responcedata = dic;
            [dic release];
            
            [sevicehandler releaseMemory];
             [sevicehandler release];
            return NO;
        }
    
    
    return YES;
}


-(BOOL) moduleSubmission
{
    NSData *data=[[NSUserDefaults standardUserDefaults] objectForKey:USERDETAILS];
    NSDictionary *dic= [NSKeyedUnarchiver unarchiveObjectWithData:data];
    
    dic =[dic objectForKey:@"posts"];
    
    if(dic != nil)
    {
        if([dic objectForKey:PROGRAMENAME] && [dic objectForKey:PROGRAMENAME] != (id) kCFNull)
        {
            if([[dic objectForKey:PROGRAMENAME] isEqualToString:@"Surgical Technology"])
                return YES;
        }
    }
    

    return NO;
}
-(void) rememberPassword:(BOOL) yesorno
{
    PlistPerfomer *plistperformer =[[PlistPerfomer alloc] init];
    plistperformer.filename = @"insolex-properties";
    plistperformer.tagname = @"properties";
    NSDictionary *dic =[[plistperformer read] objectForKey:@"properties"];
    if(yesorno)
    {
        
        NSString *str =[plistperformer encodedata:txtusername];
        NSString *pwdstr =[plistperformer encodedata:txtpassword];
        
        [dic setValue:@"1" forKey:@"RememberUsername"];
        [dic setValue:str forKey:USERNAME];
        [dic setValue:pwdstr forKey:PASSWORD];
        plistperformer.writedata = dic;
        
        
    }
    else
    {
        [dic setValue:@"0" forKey:@"RememberUsername"];
        [dic setValue:@"" forKey:USERNAME];
        [dic setValue:@"" forKey:PASSWORD];
        plistperformer.writedata = dic;
    }
    [plistperformer write];
    [plistperformer releaseMemory];
    [plistperformer release];
}


-(BOOL)rememberpasswordon
{
    PlistPerfomer *plistperformer =[[PlistPerfomer alloc] init];
    plistperformer.filename = @"insolex-properties";
    plistperformer.tagname = @"properties";
    
    NSDictionary *dic =[[plistperformer read] objectForKey:@"properties"];
    NSString *remember =[dic objectForKey:@"RememberUsername"];
    
    rememberpasswordon = [remember boolValue];
    
    if(rememberpasswordon)
    {
        self.txtusername = [plistperformer decode:[dic objectForKey:USERNAME]];
        self.txtpassword = [plistperformer decode:[dic objectForKey:PASSWORD]];
    }
    
    [plistperformer releaseMemory];
    [plistperformer release];
    return rememberpasswordon;
    
}


-(void) releaseMemory
{
    [txtusername release];
    [txtpassword release];
    [responcedata release];
}

@end
