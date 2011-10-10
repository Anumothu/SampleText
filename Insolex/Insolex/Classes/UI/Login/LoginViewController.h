//
//  LoginViewController.h
//  Insolex
//
//  Created by Almand on 19/08/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

//*****************************************************************************
// User Enter username and password. Then click the login btn, authenticate user and move the submission track page.
//-------------------------------------------
// user can choose remember username and password.
// while selecting the remember user name and password, we store the user name and password in insolex-properties.plist 
// first username and password encrypted with aes algoritham then base 64 algorithm. this encrypted format only stored in that plist.
// next time user enter the main page, We have show  the username and password.
//---------------------------------------------
// LoginData class is the data model for this view controller.
// every view controll have its own data model for the purpose of data handling
//*****************************************************************************

#import <UIKit/UIKit.h>
#import "LoginData.h"
#import "FlowLogicDelegate.h"

#define VIEWUP   50

@interface LoginViewController : UIViewController <UITextFieldDelegate> {
    
    
    IBOutlet UITextField *txtusername;  
    IBOutlet UITextField *txtpassword;
    
    
    IBOutlet UIButton *btnrember;     // remember usrname and password btn
    
    BOOL isrememberpassword;
    
    
    LoginData *datasource;
    
    id<FlowLogicDelegate> delegate;
    
}
@property (nonatomic,retain) IBOutlet UITextField *txtusername;
@property (nonatomic,retain) IBOutlet UITextField *txtpassword;

@property (nonatomic,assign) id<FlowLogicDelegate> delegate;
#pragma mark -

- (IBAction) loginBtnTouched:(id) sender;
-(BOOL) validation;

// two button intract this same function. 1- forget user name 2- forget password
- (IBAction) forgetBtnTouched:(id) sender;

// change the button image.
- (IBAction) rememberPasswordBtnTouched:(id) sender;

-(void)setViewMovedUp:(BOOL)movedUp;


@end
