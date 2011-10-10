//
//  PlistPerfomer.h
//  Insolex
//
//  Created by Almand on 19/08/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Base64.h"
#import "NSData-AES.h"

@interface PlistPerfomer : NSObject {
    
    NSString *filename;
    NSString *tagname;
    id writedata;
    
    
    NSString *path;
    
    
    NSArray *tagnames;
}

@property (nonatomic,copy) NSString *filename;
@property (nonatomic,copy) NSString *tagname;
@property (nonatomic,retain) id writedata;


@property (nonatomic,retain) NSArray *tagnames;


#pragma mark -


-(void) initloader;
-(NSDictionary *) read;
-(void) deletedata;
-(void) write;

-(NSString *) encodedata:(NSString *) str;
-(NSString *) decode:(NSString *) chipertxt;


-(void) releaseMemory;
@end
