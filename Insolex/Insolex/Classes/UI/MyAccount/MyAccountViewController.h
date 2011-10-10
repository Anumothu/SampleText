//
//  MyAccountViewController.h
//  Insolex
//
//  Created by Hakuna on 8/19/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyAccountData.h"

@interface MyAccountViewController : UITableViewController <UIAlertViewDelegate, UITextFieldDelegate>{
        
    NSArray *tblearray;
    NSMutableArray *tblevalues;
    UITextField *txtcrtpass;
    UITextField *txtnewpass;
    UITextField *txtre_enterpass;
    UITextField *txtenter_newno;
    
    
    
    MyAccountData *datamodel;
}
//@property (nonatomic,retain) NSArray *tblearray;
@property (nonatomic,retain) NSMutableArray *tblevalues;
@property (nonatomic,retain) UITextField *txtcrtpass;
@property (nonatomic,retain) UITextField *txtnewpass;
@property (nonatomic,retain) UITextField *txtre_enterpass;
@property (nonatomic,retain) UITextField *txtenter_newno;


@end
