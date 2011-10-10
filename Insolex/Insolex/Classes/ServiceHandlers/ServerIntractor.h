//
//  ServerIntractor.h
//  Insolex
//
//  Created by Almand on 19/08/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface ServerIntractor : NSObject {
    
    NSString *apiname;
    NSString *url;
    NSDictionary *reqdic;
    NSDictionary *resdic;
    
    NSString *errorcode;

    
    
}

@property (nonatomic,retain) NSString *apiname;
@property (nonatomic,retain) NSString *url;
@property (nonatomic,retain) NSDictionary *reqdic;
@property (nonatomic,retain) NSDictionary *resdic;

@property (nonatomic,retain) NSString *errorcode;

@property (nonatomic,assign)  BOOL isrealapi;



-(void) GetMethod;
-(void) PostMethod;


-(NSString *) urlFetcher;

-(NSString *) DictionaryToJsonConverter:(NSDictionary *) dic;

-(void) releaseMemory;
@end
