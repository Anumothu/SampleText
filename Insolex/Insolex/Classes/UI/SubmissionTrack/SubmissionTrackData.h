//
//  SubmissionTrackData.h
//  Insolex
//
//  Created by Almand on 19/08/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PlistPerfomer.h"
#import "ServerIntractor.h"



@interface SubmissionTrackData : NSObject {
    

    NSDictionary *trackdata;
    
    NSString *errorString;
}

@property (nonatomic,retain) NSDictionary *trackdata;
@property (nonatomic,copy) NSString *errorString;

//@property(nonatomic,retain)NSDictionary *dictionary;


//name of the user
-(NSString *) userName;

// program name
-(NSString *) ProgramName;


// total number of submited or to be submitted
-(NSString *) sectiontotal:(NSInteger) section;

// detail description
-(NSDictionary *) detailCell:(NSInteger) section;

-(NSDictionary *) trackassist:(NSInteger) section;

-(BOOL) performApi;


-(void) releaseMemory;

@end
