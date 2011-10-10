//
//  ServerIntractor.m
//  Insolex
//
//  Created by Almand on 19/08/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ServerIntractor.h"
#import "JSON.h"

@implementation ServerIntractor
@synthesize apiname;
@synthesize url;
@synthesize reqdic;
@synthesize resdic;

@synthesize errorcode;

@synthesize isrealapi;




-(void) GetMethod
{
    // to do
    // 
    
}
-(void) PostMethod
{

    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
    
    //----------------------------
    // url formation
    NSString *tempurl  = [NSString stringWithFormat:[self urlFetcher],[[NSUserDefaults standardUserDefaults] objectForKey:@"Hostname"]];
    NSString *sr =[self DictionaryToJsonConverter:self.reqdic];
    
    NSString *urlformation = [NSString stringWithFormat:@"%@%@",tempurl,sr];
    self.url =urlformation;
    
    NSLog(@"%@",self.url);
    
    //---------------------------------------------------------------
    
    self.url =[self.url stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
    
    NSURL *requsturl =[NSURL URLWithString:self.url];
    NSLog(@"************** %@",self.url);
    
    NSMutableURLRequest *request = [[[NSMutableURLRequest alloc] init] autorelease];
    [request setURL:requsturl];
   // NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:requsturl];
    [request setHTTPMethod:@"POST"];
    
 
       
    NSMutableDictionary* headers = [[[NSMutableDictionary alloc] init] autorelease];
    
    [headers setValue:@"application/json" forKey:@"Content-Type"];
    [headers setValue:@"application/json" forKey:@"Accept"];
    
    [request setAllHTTPHeaderFields:headers];	
   

    NSError *Error;
    NSURLResponse *response = [[[NSURLResponse alloc] init] autorelease];
    
      
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&Error];
    
    
    NSHTTPURLResponse* httpResponse = (NSHTTPURLResponse*)response;
    int responseStatusCode = [httpResponse statusCode];
    
    
    NSString *responseString;
    
    if(responseStatusCode == 200 ){
        if(data != nil && [data length]>0  ) {
            responseString = [[NSString alloc] initWithFormat:@"%.*s", [data length], [data bytes]];	
        
            self.resdic = (NSDictionary *)[responseString JSONValue];
            
            [responseString release];
            
            
        }
    }
    else if(responseStatusCode == 0)
    {
        //[self informDelegateOfFailureWithMessage:NETWORKERROR];
        self.resdic = nil;
        self.errorcode = @"500";
    }
    else {
      //  [self informDelegateOfFailureWithMessage:INTERNALERROR];
        self.resdic = nil;
        self.errorcode = @"404";

    }
    

    [pool drain];

    
    
    
}



-(NSString *) DictionaryToJsonConverter:(NSDictionary *) dic
{
    
	NSString *str =[NSString stringWithString:@""];
	//str = @"";
	if(dic != nil)
	{
		NSArray *keyarr =[dic allKeys];
		NSArray *valarr =[dic allValues];
		
		for (int i =0; i <[keyarr count]; i++) {
			str =[str stringByAppendingFormat:@"%@=%@&",[keyarr objectAtIndex:i],[valarr objectAtIndex:i]];
			
		}
		
		str =[str substringToIndex:[str length]-1];
	}
	
    return str;
}



-(NSString *) urlFetcher
{
    switch ([self.apiname intValue]) {
        case 1000:
            return URLLOGIN;
            break;
        case 1001:
            return URLSUBTRACK;
            break;

        case 1002:
            return URLSUBMITCASE;
            break;

        case 1003:
            return URLUPDATEPHONE;
            break;

        case 1004:
            return URLUPDATEPASSWORD;
            break;

        default:
            break;
    }
    
    return nil;
}


-(void) releaseMemory
{
    [self.apiname release];
    [self.url release];
    [self.reqdic release];
    
    if(self.resdic != nil)
    {
        [self.resdic release];
    }
    
    if(self.errorcode != nil)
    {
        [self.errorcode release];
    }
}
@end
