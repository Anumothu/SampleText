//
//  LoginViewController.m
//  Insolex
//
//  Created by Almand on 19/08/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "LoginViewController.h"
#define kOFFSET_FOR_KEYBOARD 90.0


@implementation LoginViewController
@synthesize txtpassword;
@synthesize txtusername;
@synthesize delegate;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        datasource =[[LoginData alloc] init];
       
    }
    return self;
}

- (void)dealloc
{
    
    if(datasource != nil)
    {
        [datasource releaseMemory];
        [datasource release];
    }
    
    [txtusername release];
    [txtpassword release];
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    //*********************************
    //testing purpose
    // 0 - local 1- real api
    [[NSUserDefaults standardUserDefaults] setValue:@"1" forKey:FROMAPI];
    //************************************************
  
    
    CGFloat leftInset = 10.0f;

    UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, leftInset, txtusername.bounds.size.height)];
    txtusername.leftView = leftView;
    txtusername.leftViewMode = UITextFieldViewModeAlways;
    [leftView release];
    
    leftView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, leftInset, txtusername.bounds.size.height)];
    txtpassword.leftView = leftView;
    txtpassword.leftViewMode = UITextFieldViewModeAlways;
    [leftView release];
    

   
}

-(void)viewWillAppear:(BOOL)animated
{
   	
    self.navigationController.navigationBarHidden = YES;
    
    //*****************************************************
    isrememberpassword = [datasource rememberpasswordon]; // verify user already check remember username and password
    if(isrememberpassword)   // if that feature is enabled, decrpt the user name and password and show apropriate text boxes.
    {
        self.txtusername.text = datasource.txtusername;   // decrpted username
        self.txtpassword.text =datasource.txtpassword;     // decrpted password
        
      [btnrember setBackgroundImage:[UIImage imageNamed:@"Checkmark_selected.png"] forState:UIControlStateNormal];   // initaly rember password button image is deselected. so user enabled that feature, just show the selected rembeber username and password.
    }
    else  // else nothing doing.. simple empty the username and password check boxes.
    {
        self.txtusername.text =@"";
        self.txtpassword.text =@"";
        

        
    }
	
   
      
}
- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


#pragma mark -
#pragma mark class methods


- (IBAction) loginBtnTouched:(id) sender
{
    if([self validation])
    {
                    
        //*****************
        // data model perfrom api fuction call
        
        datasource.txtusername = self.txtusername.text;
        datasource.txtpassword = self.txtpassword.text;
        
        NSLog(@"username is : %@ \n password is :%@",datasource.txtusername,datasource.txtpassword);
        
            ShowNetworkActivityIndicator();
        if([datasource performApiOperation:API_LOGIN])
        {  
            [datasource rememberPassword:isrememberpassword];
            
            BOOL issubmissiontechnology  = [datasource moduleSubmission];
            
            if(issubmissiontechnology)
            {
                [delegate showView:VIEW_SUBMISSION :nil :MODULE_SUBMISSION];
            }
            else
            {
                 [delegate showView:VIEW_SUBMISSION :nil :MODULE_SUBMITASSIST];
            }
        }
        else
        {
            //alert 
          NSDictionary *dic = [datasource responcedata];
            
            NSDictionary *dic1 = [[NSUserDefaults standardUserDefaults] objectForKey:@"Alert"];
            NSString *errstring =[dic1 objectForKey:[dic objectForKey:@"error"]];
        [delegate showAlertPopup:@"Alert" :errstring];
            
            
        }
         HideNetworkActivityIndicator();
    
    }

}

-(BOOL) validation
{
    if([self.txtusername.text isEqualToString:@""])
    {
        // alert
        return NO;
    }
    else if([self.txtpassword.text isEqualToString:@""])
    {
        // alert
        return NO;
    }
    
    return YES;
}


// two button intract this same function. 1- forget user name 2- forget password

- (IBAction) forgetBtnTouched:(id) sender
{
    UIButton *btn =(UIButton *) sender;
    if(btn.tag == 1)
    {
        // to do usr name forgot operation
    }
    else
    {
        // to do password forgot operation
    }
}

// change the button image.

- (IBAction) rememberPasswordBtnTouched:(id) sender
{
    UIButton *btn =(UIButton *) sender;
   if(isrememberpassword)
   {
       [btn setBackgroundImage:[UIImage imageNamed:@"Checkmark_unselected.png"] forState:UIControlStateNormal];
        isrememberpassword = NO;
   }
    else
    {
        [btn setBackgroundImage:[UIImage imageNamed:@"Checkmark_selected.png"] forState:UIControlStateNormal];
        isrememberpassword = YES;
    }
    
    
}

#pragma mark -
#pragma mark text field delegate
/*
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    if(textField == txtpassword)
    {
        [self performSelector:@selector(downView)];
    }
    return YES;
}
 */

//=================================

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if([textField isEqual:txtusername])
    {
        
        [txtpassword becomeFirstResponder];
    }
    else if([textField isEqual:txtpassword])
    {
        [txtpassword resignFirstResponder];
        
        // if you want to slide down the view
        
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.5]; 
        
        CGRect rect = self.view.frame;
        
        rect.origin.y += kOFFSET_FOR_KEYBOARD;
        rect.size.height -= kOFFSET_FOR_KEYBOARD;
        
        self.view.frame = rect;
        
        [UIView commitAnimations];
        
    }
    return YES;
}


//=================================


-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    textField.text = @"";
    if(textField == txtpassword)
    {
        if  (self.view.frame.origin.y >= 0)
        {
            [self setViewMovedUp:YES];
            
            
        }
        
    }
    return YES;
}

#pragma mark text field view animation

//Slide the view to "up" and "Down"

-(void)setViewMovedUp:(BOOL)movedUp
{
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:0.5]; // if you want to slide up the view
	
	CGRect rect = self.view.frame;
	if (movedUp)
	{
		// 1. move the view's origin up so that the text field that will be hidden come above the keyboard 
		// 2. increase the size of the view so that the area behind the keyboard is covered up.
		rect.origin.y -= kOFFSET_FOR_KEYBOARD;
		rect.size.height += kOFFSET_FOR_KEYBOARD;
	}
    //	else
    //	{
    //		// revert back to the normal state.
    //		rect.origin.y += kOFFSET_FOR_KEYBOARD;
    //		rect.size.height -= kOFFSET_FOR_KEYBOARD;
    //	}
	self.view.frame = rect;
	
	[UIView commitAnimations];
}



@end
