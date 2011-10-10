//
//  PlistPerfomer.m
//  Insolex
//
//  Created by Almand on 19/08/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "PlistPerfomer.h"


@implementation PlistPerfomer

@synthesize filename;
@synthesize tagname;
@synthesize writedata;

@synthesize tagnames;




-(void) initloader
{
    NSError *error;
	filename =[self.filename stringByAppendingString:@""];
	NSLog(@"%@",filename);
    
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDirectory = [paths objectAtIndex:0];
	path = [documentsDirectory stringByAppendingPathComponent:filename];
	NSLog(@"%@",path);
    
	NSFileManager *fileManager = [NSFileManager defaultManager];
	if (![fileManager fileExistsAtPath:path])
	{
		
		NSString *bundle = [[NSBundle mainBundle]pathForResource:filename ofType:@"plist"];
		[fileManager copyItemAtPath:bundle toPath:path error:&error];
		NSLog(@"File Write");
		
		
	}
	

}

-(NSDictionary *) read
{
    // to do
   	[self initloader];
	NSMutableDictionary *plistDict = [[[NSMutableDictionary alloc]initWithContentsOfFile:path] autorelease];
    
	//NSString *filePath = [[NSBundle mainBundle] pathForResource:filename ofType:@"plist"];
    //	NSMutableDictionary* plistDict = [[NSMutableDictionary alloc] initWithContentsOfFile:filePath];
    //	
	
	return plistDict;    

}

-(void) deletedata
{
    // to do
    [self initloader];
	
	NSMutableDictionary *plistDict = [[NSMutableDictionary alloc]initWithContentsOfFile:path];
    
    // to do
		
	[plistDict writeToFile:path atomically: YES];
    [plistDict release], plistDict = nil;
}


-(void) write
{
    // to do
    [self initloader];
	
	NSMutableDictionary *plistDict = [[NSMutableDictionary alloc]initWithContentsOfFile:path];
    
    if([writedata isKindOfClass:[NSString class]])
    {        [plistDict setValue:writedata forKey:tagname];
    }
    else if([writedata isKindOfClass:[NSArray class]])
    {
        for (int i =0; i<[writedata count]; i++) {
            [[plistDict objectForKey:tagname] addObject:[(NSArray *) writedata objectAtIndex:i]];
        }
    }
	else if([writedata isKindOfClass:[NSDictionary class]])
    {
        // to do
        [plistDict setValue:self.writedata forKey:tagname];
    }
	
	[plistDict writeToFile:path atomically: YES];
    
    [plistDict release], plistDict = nil;

}


-(NSString *) encodedata:(NSString *) plaintxt
{
    NSString *keyvalue =[[[self read] objectForKey:tagname] objectForKey:@"Key"];
    
    NSLog(@"encrypting string = %@",plaintxt);
	
	NSData *data = [plaintxt dataUsingEncoding: NSASCIIStringEncoding];
	NSData *encryptedData = [data AESEncryptWithPassphrase:keyvalue];
	
	
	[Base64 initialize];
	NSString *b64EncStr = [Base64 encode:encryptedData];
	
	NSLog(@"Base 64 encoded = %@",b64EncStr);
    
    
    return b64EncStr;
}

-(NSString *) decode:(NSString *) chipertxt
{
    
    NSString *keyvalue =[[[self read] objectForKey:tagname] objectForKey:@"Key"];
    NSData	*b64DecData = [Base64 decode:chipertxt];
	

	NSData *decryptedData = [b64DecData AESDecryptWithPassphrase:keyvalue];
	
	NSString* decryptedStr = [[NSString alloc] initWithData:decryptedData encoding:NSASCIIStringEncoding];
	
	NSLog(@"decrypted string = %@",decryptedStr);
    
    return [decryptedStr autorelease];
}

-(void) releaseMemory
{
    [filename release];
    [tagname release];
    [writedata release];
    [tagnames release];
}

@end
