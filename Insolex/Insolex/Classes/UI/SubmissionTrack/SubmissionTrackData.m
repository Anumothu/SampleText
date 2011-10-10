//
//  SubmissionTrackData.m
//  Insolex
//
//  Created by Almand on 19/08/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "SubmissionTrackData.h"


@implementation SubmissionTrackData
@synthesize trackdata;
@synthesize errorString;
//@synthesize dictionary;



#pragma mark -
//name of the user
-(NSString *) userName
{
    NSString *str =nil;
    
    NSData *data=[[NSUserDefaults standardUserDefaults] objectForKey:USERDETAILS];
    
    NSDictionary *dic1= [NSKeyedUnarchiver unarchiveObjectWithData:data];

    NSDictionary *dic =[dic1 objectForKey:@"posts"];
    
    str = [dic objectForKey:NAME];
    
    return str;
    
}

// program name
-(NSString *) ProgramName
{
    NSString *str =nil;
    
    NSData *data=[[NSUserDefaults standardUserDefaults] objectForKey:USERDETAILS];
    
    NSDictionary *dic1= [NSKeyedUnarchiver unarchiveObjectWithData:data];
    
    NSDictionary *dic =[dic1 objectForKey:@"posts"];
    
    if(dic != nil)
    {
        if([dic objectForKey:PROGRAMENAME] && [dic objectForKey:PROGRAMENAME] != (id) kCFNull)
        {
            str = [dic objectForKey:PROGRAMENAME];
        }
    }
    
    return str;
}


#pragma mark -
// total number of submited or to be submitted
-(NSString *) sectiontotal:(NSInteger) section
{
    
    NSString *totaltag = nil;
    NSString *title = nil;
    
    NSString *titlestring = @"";
    if(section == 0)
    {

       totaltag = TOTALSUBMITTEDCASE;
        title = @"No. Of Cases Submitted : ";
        
    }
    else if(section == 1)
    {

        totaltag = TOTALCASENOTSUBMITTED;
       title = @"No. Of Cases To Be Submitted : ";
    }
    
    
     if(trackdata != nil)
    {
        if([trackdata objectForKey:totaltag] && [trackdata objectForKey:totaltag] != (id) kCFNull)
        

        {
            titlestring =[NSString stringWithFormat:@"%@",[trackdata objectForKey:totaltag]];
        }
    
    }
    NSLog(@"title=%@",title);
    NSLog(@"titlestring=%@",titlestring);
    
    //return  [NSString stringWithFormat:@"%@%@",title,titlestring];
    return  [NSString stringWithFormat:@"%@%@",title,titlestring];
    
}

-(NSDictionary *) trackassist:(NSInteger) section
{
    NSDictionary *dic = [self.trackdata mutableCopy];
    
    if(section == 1)
    {
        if([dic objectForKey:NON_GENERAL] && [dic objectForKey:NON_GENERAL] == (id) kCFNull)
        {
            [dic setValue:@"0" forKey:NON_GENERAL];
        }
        if([dic objectForKey:NON_CHOSENSPECIALTY] && [dic objectForKey:NON_CHOSENSPECIALTY] == (id) kCFNull)
        {
            [dic setValue:@"0" forKey:NON_CHOSENSPECIALTY];
        }

        if([dic objectForKey:NON_OTHERSPECIALTY] && [dic objectForKey:NON_OTHERSPECIALTY] == (id) kCFNull)
        {
            [dic setValue:@"0" forKey:NON_OTHERSPECIALTY];
        }
    }
    else
    {
        if([dic objectForKey:GENERAL] && [dic objectForKey:GENERAL] == (id) kCFNull)
        {
            [dic setValue:@"0" forKey:NON_GENERAL];
        }
        else
        {
            [dic setValue:[dic objectForKey:GENERAL] forKey:NON_GENERAL];
        }
        if([dic objectForKey:CHOSENSPECIALTY] && [dic objectForKey:CHOSENSPECIALTY] == (id) kCFNull)
        {
            [dic setValue:@"0" forKey:NON_CHOSENSPECIALTY];
        }
        else
        {
            [dic setValue:[dic objectForKey:CHOSENSPECIALTY] forKey:NON_GENERAL];
        }
        if([dic objectForKey:OTHERSPECIALTY] && [dic objectForKey:OTHERSPECIALTY] == (id) kCFNull)
        {
            [dic setValue:@"0" forKey:NON_OTHERSPECIALTY];
        }
        else
        {
            [dic setValue:[dic objectForKey:OTHERSPECIALTY] forKey:NON_GENERAL];
        }

    }
    
    return [dic autorelease];
}

// detail description
-(NSDictionary *) detailCell:(NSInteger) section
{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithDictionary:self.trackdata];
    
    NSString *strzero = [[NSString alloc] initWithString:@"0"];

    if(section == 0) // submitted test case
    {
        if([dic objectForKey:SCRUB1_GENERAL] == (id) kCFNull)
        {
            [dic setObject:strzero forKey:SCRUB1_GENERAL];
        }
        if([dic objectForKey:SCRUB1_SURGICAL] == (id) kCFNull)
        {
            [dic setObject:strzero forKey:SCRUB1_SURGICAL];
        }
        if([dic objectForKey:SCRUB1_ENDOSCOPY] == (id) kCFNull)
        {
            [dic setObject:strzero forKey:SCRUB1_ENDOSCOPY];
        }
        if([dic objectForKey:SCRUB1_LABOR] == (id) kCFNull)
        {
            [dic setObject:strzero forKey:SCRUB1_LABOR];
        }
        if([dic objectForKey:SCRUB2_GENERAL] == (id) kCFNull)
        {
            [dic setObject:strzero forKey:SCRUB2_GENERAL];
        }
        
        if([dic objectForKey:SCRUB2_SURGICAL] == (id) kCFNull)
        {
            [dic setObject:strzero forKey:SCRUB2_SURGICAL];
        }
        
        if([dic objectForKey:SCRUB2_ENDOSCOPY] == (id) kCFNull)
        {
            [dic setObject:strzero forKey:SCRUB2_ENDOSCOPY];
        }
        if([dic objectForKey:SCRUB2_LABOR] == (id) kCFNull)
        {
            [dic setObject:strzero forKey:SCRUB2_LABOR];
        }
        

    }
    else if(section == 1)  // not submitted test case
    {
        if([dic objectForKey:NON_SCRUB1_GENERAL] == (id) kCFNull)
        {
            [dic setObject:strzero forKey:SCRUB1_GENERAL];
        }
        else
        {
            [dic setObject:[dic objectForKey:NON_SCRUB1_GENERAL] forKey:SCRUB1_GENERAL];
        }
        
        if([dic objectForKey:NON_SCRUB1_SURGICAL] == (id) kCFNull)
        {
            [dic setObject:strzero forKey:SCRUB1_SURGICAL];
        }
        else
        {
              [dic setObject:[dic objectForKey:NON_SCRUB1_SURGICAL] forKey:SCRUB1_SURGICAL];
        }
        if([dic objectForKey:NON_SCRUB1_ENDOSCOPY] == (id) kCFNull)
        {
            [dic setObject:strzero forKey:SCRUB1_ENDOSCOPY];
        }
        else
        {
            [dic setObject:[dic objectForKey:NON_SCRUB1_ENDOSCOPY] forKey:SCRUB1_ENDOSCOPY];

        }
        if([dic objectForKey:NON_SCRUB1_LABOR] == (id) kCFNull)
        {
            [dic setObject:strzero forKey:SCRUB1_LABOR];
        }
        else
        {
            [dic setObject:[dic objectForKey:NON_SCRUB1_LABOR] forKey:SCRUB1_LABOR];
        }
        if([dic objectForKey:NON_SCRUB2_GENERAL] == (id) kCFNull)
        {
            [dic setObject:strzero forKey:SCRUB2_GENERAL];
        }
        else
        {
             [dic setObject:[dic objectForKey:NON_SCRUB2_GENERAL] forKey:SCRUB2_GENERAL];
        }
        
        if([dic objectForKey:NON_SCRUB2_SURGICAL] == (id) kCFNull)
        {
            [dic setObject:strzero forKey:SCRUB2_SURGICAL];
        }
        else
        {
             [dic setObject:[dic objectForKey:NON_SCRUB2_SURGICAL] forKey:SCRUB2_SURGICAL];
        }
        
        if([dic objectForKey:NON_SCRUB2_ENDOSCOPY] == (id) kCFNull)
        {
            [dic setObject:strzero forKey:SCRUB2_ENDOSCOPY];
        }
        else
        {
            [dic setObject:[dic objectForKey:NON_SCRUB2_ENDOSCOPY] forKey:SCRUB2_ENDOSCOPY];
        }
        if([dic objectForKey:NON_SCRUB2_LABOR] == (id) kCFNull)
        {
            [dic setObject:strzero forKey:SCRUB2_LABOR];
        }
        else
        {
             [dic setObject:[dic objectForKey:NON_SCRUB2_LABOR] forKey:SCRUB2_LABOR];
        }

    }
    
         
    [strzero release];
    return  (NSDictionary *)[dic autorelease];
    
}

#pragma mark -

-(BOOL) performApi
{
    BOOL isapiSccess = NO;
    
        ServerIntractor *sevicehandler =[[ServerIntractor alloc] init];
        
        NSString *name = [NSString stringWithFormat:@"%d",APISUBTRACK];
        sevicehandler.apiname = name;
        //========================     
        NSData *data=[[NSUserDefaults standardUserDefaults] objectForKey:USERDETAILS];
        
        NSDictionary *dic= [NSKeyedUnarchiver unarchiveObjectWithData:data];
        NSLog(@"%@",dic);
        
        NSString *userid=[[dic objectForKey:@"posts"]objectForKey:@"user_id"];
        NSString *insid=[[dic objectForKey:@"posts"]objectForKey:@"Institution_id"];
        NSString *instructorname=[[dic objectForKey:@"posts"]objectForKey:@"Instructor_name"];
        NSLog(@"userid=%@",userid);
        NSLog(@"insid=%@",insid);
        NSLog(@"instructorname=%@",instructorname);
        //========================        
        
        NSDictionary *dic1 =[[NSDictionary alloc] initWithObjectsAndKeys:userid,STUDENT1ID,insid,INSTITUTION1ID,instructorname,INSTRUCTOR1NAME, nil];
        
        sevicehandler.reqdic = dic1;
        NSLog(@"%@",sevicehandler.reqdic);
        
        
        [dic1 release];
        
        [sevicehandler PostMethod];
        
        
        if(sevicehandler.resdic != nil)
        {

            
            if([[[sevicehandler.resdic objectForKey:@"posts"] objectForKey:@"reponse_id"] intValue] == 1)
            {
              
                NSDictionary *dic =[[NSDictionary alloc] initWithDictionary:[sevicehandler.resdic objectForKey:@"posts"]]; 
                
                if(trackdata != nil)
                {
                    [trackdata release];
                }
                trackdata=[dic retain];
                
                [dic release];
                isapiSccess = YES;
                
            }
            else
            {
              //  to do error alert
             
                isapiSccess = YES;
                
            }
 

        }
       else
       {
           //errorString =sevicehandler.errorcode;
           errorString = @"104";
           isapiSccess = NO;
       }
          
    [sevicehandler releaseMemory];
    [sevicehandler release];
    
    
    return isapiSccess;
    
}

-(void) releaseMemory
{
    [self.trackdata release];
    [self.errorString release];
}

@end
