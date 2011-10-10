//
//  SubmitCaseViewController.h
//  Insolex
//
//  Created by Almand on 19/08/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SubmitCaseData.h"
#import "SelectionViewController.h"
//#import "SubmissionTrackViewcontroller.h"

@interface SubmitCaseViewController : UITableViewController <UIActionSheetDelegate, UIPickerViewDelegate,SelectionDelegate,UITextFieldDelegate,UITextViewDelegate>{
   
    
    NSArray *tablearray;
    NSArray *lblarry;
   
    modules module;
    
    SubmitCaseData *datamodel;
    
    NSInteger totalcomborow;
    
    id delegate;
    
    UIView *datepickerview;
    UIDatePicker *datepicker;
    
    UIActionSheet *sheet;
   
    NSString *dateSring;   // convert the date
    NSString *selectedcategory;
    
    NSIndexPath *tempIndexpath;   // store the selected index path;
    
    BOOL reloadTable; // empty the data value of textveiw and text field
  
}
@property (nonatomic,assign) modules module;
@property (nonatomic,retain) UIView *datepickerview;


//@property(nonatomic,retain)UIButton *btn;

@property (nonatomic,assign) id delegate;

-(void) PickerDoneAction;
@end
