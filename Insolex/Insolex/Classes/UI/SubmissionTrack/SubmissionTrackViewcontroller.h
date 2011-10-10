//
//  SubmissionTrackViewcontroller.h
//  Insolex
//
//  Created by Almand on 19/08/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FlowLogicDelegate.h"

#import "SubmissionTrackData.h"

#define RowCount  2

@interface SubmissionTrackViewcontroller : UIViewController <UITableViewDelegate, UITableViewDataSource>{
  
    IBOutlet UITableView *table;

    NSIndexPath *selectedindex;
    
    id<FlowLogicDelegate> delegate;
    
    SubmissionTrackData *datastore;
    
    UITableViewCell *trackcell;
    UITableViewCell *track1cell;
    
    
    IBOutlet UILabel *lblname;
    IBOutlet UILabel *lblProgram;
    
    //*****************
    // cell value
    IBOutlet UILabel *scrub1general;
    IBOutlet UILabel *scrub1surgical;
    IBOutlet UILabel *scrub1endoscopy;
    IBOutlet UILabel *scrub1labor;
 
    IBOutlet UILabel *scrub2general;
    IBOutlet UILabel *scrub2surgical;
    IBOutlet UILabel *scrub2endoscopy;
    IBOutlet UILabel *scrub2labor;
    
    //******************
    
    IBOutlet UILabel *assitgeneral;
    IBOutlet UILabel *assitsocial;
    IBOutlet UILabel *assitothers;
    
    //UIButton *btntrackassist;
    
    modules module;
}

@property (nonatomic,retain) IBOutlet UITableView *table;
@property (nonatomic,retain) IBOutlet UITableViewCell *trackcell;
@property (nonatomic,retain) IBOutlet UITableViewCell *track1cell;


@property (nonatomic,assign) id<FlowLogicDelegate> delegate;
@property (nonatomic,assign) modules module;

#pragma mark -
-(IBAction) submitBtnTouched:(id) sender;
-(IBAction) myAccountBtnTouched:(id) sender;

@end
