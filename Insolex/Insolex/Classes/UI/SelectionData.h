//
//  SelectionData.h
//  Insolex
//
//  Created by Hakuna on 8/30/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PlistPerfomer.h"



@interface SelectionData : NSObject {
    
    NSArray *array;
    
}
@property (nonatomic,retain)NSArray *array;


//get the total number of array
-(NSInteger)numberofrows;


//-(void) loadSelectionData:(selectiontype) type;

@end
