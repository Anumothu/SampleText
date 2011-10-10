//
//  MyAccountViewController.m
//  Insolex
//
//  Created by Hakuna on 8/19/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MyAccountViewController.h"


@implementation MyAccountViewController

//@synthesize tblearray;
@synthesize txtcrtpass;
@synthesize txtnewpass;
@synthesize txtre_enterpass;
@synthesize txtenter_newno;
@synthesize tblevalues;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
        self.view.backgroundColor = [UIColor bgColor];
        
        
        
    }
    return self;
}

- (void)dealloc
{
    [super dealloc];
    
    if(datamodel != nil)
    {
        [datamodel releaseMemory];
        [datamodel release];
    }
    
    [txtcrtpass release];
    [txtnewpass release];
    [txtre_enterpass release];
    
    [txtenter_newno release];
    
    if(tblearray != nil)
    {
        [tblearray release], tblearray = nil;
    }
    
    [tblevalues release];
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
   datamodel =[[MyAccountData alloc] init];
    
   // fill the static values name ,institution, email , user id , mobile device and mobile number
    tblearray = [[datamodel myAccountStaticData] retain];
    
    // table values get from the api
    tblevalues =[[datamodel structueData] mutableCopy];
    
    NSLog(@"%@",tblearray);
    self.tableView.separatorStyle=UITableViewCellEditingStyleNone;
    
    
  
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return 7;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell=nil;// = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
//    if (cell == nil) {
       cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    
        
        if(indexPath.row != 4)
        {
            UILabel *lblname =[[UILabel alloc] initWithFrame:CGRectMake(10, 0, 160, 50)];
            lblname.backgroundColor =[UIColor clearColor];
            lblname.text =[tblearray objectAtIndex:indexPath.row];
            lblname.font =[UIFont systemFontOfSize:14.00];
            [cell.contentView addSubview:lblname];
            [lblname release];
            
            UILabel *lblcomma =[[UILabel alloc] initWithFrame:CGRectMake(130, 0, 10, 50)];
            lblcomma.backgroundColor =[UIColor clearColor];
            lblcomma.text = @":";
            lblcomma.font =[UIFont systemFontOfSize:17.00];
            [cell.contentView addSubview:lblcomma];
            [lblcomma release];
            
            UILabel *lbldescription =[[UILabel alloc] initWithFrame:CGRectMake(140, 0, 150, 50)];
            lbldescription.backgroundColor =[UIColor clearColor];
            lbldescription.font =[UIFont systemFontOfSize:14.00];
            
            if(indexPath.row == 6)
            {
                lbldescription.textColor = [UIColor navigationColor];
            }
            lbldescription.text =[tblevalues objectAtIndex:indexPath.row];
            [cell.contentView addSubview:lbldescription];
            [lbldescription release];
            
            
        

        }
        else
        {
            
            UIImage *img =[UIImage imageNamed:@"btn.png"];
            
            UIImage *newimg =[img stretchableImageWithLeftCapWidth:10 topCapHeight:0];
            
            UIButton *btn=[UIButton  buttonWithType:UIButtonTypeCustom];
            btn.frame=CGRectMake(10,0,284,42);
            [btn setBackgroundImage:newimg forState:UIControlStateNormal];
            [btn setTitle:@"Change Password" forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [btn addTarget:self action:@selector(clickon_change_password) forControlEvents:UIControlEventTouchUpInside];
            //[btn addTarget:self action:@selector(clickon_enter_new_number) forControlEvents:UIControlEventTouchUpInside];
            [cell.contentView addSubview:btn];

        }
    
    
       
       
    
    
    // Configure the cell...
    
    
               
  // }
    
    
    cell.selectionStyle=UITableViewCellEditingStyleNone;
    
    
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}


#pragma mark -
#pragma mark alert view funcitons
- (void)willPresentAlertView:(UIAlertView *)alertView {
    
    NSLog(@"%@",[alertView subviews]);
    if(alertView.tag == 1)
    {
        [alertView setFrame:CGRectMake(5, 20, 290, 240)];
        alertView.center = CGPointMake(320 / 2, 480 / 2);
        
    }
    else
    {
    
        [alertView setFrame:CGRectMake(5,20,290,150)];
        alertView.center=CGPointMake(320/2, 480/2);
    }
    
}



-(void)clickon_change_password
{
    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"" message:@"\n\n\n\n\n\n" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok", nil];
    alert.tag = 1;
    
    //(password)text field disign
    
    
    txtcrtpass=[[UITextField alloc]initWithFrame:CGRectMake(20, 20, 245, 34)];
    txtnewpass=[[UITextField alloc]initWithFrame:CGRectMake(20, 65, 245, 34)];
    txtre_enterpass=[[UITextField alloc]initWithFrame:CGRectMake(20,110, 245, 34)];
    
    //(password)text field border style disign
    
    txtcrtpass.borderStyle=UITextBorderStyleRoundedRect;
    txtnewpass.borderStyle=UITextBorderStyleRoundedRect;
    txtre_enterpass.borderStyle=UITextBorderStyleRoundedRect;
    
    txtcrtpass.placeholder=@"Current Password";
    txtnewpass.placeholder=@"New Password";
    txtre_enterpass.placeholder=@"Re-Enter Password";
    
    txtcrtpass.secureTextEntry=YES;
    txtnewpass.secureTextEntry=YES;
    txtre_enterpass.secureTextEntry=YES;
    
    
    
    txtcrtpass.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    txtnewpass.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    txtre_enterpass.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    
    UIFont *font =[UIFont systemFontOfSize:14];
    txtcrtpass.font = font;
    txtnewpass.font = font;
    txtre_enterpass.font = font;
    
    
    
    

    [alert addSubview:txtcrtpass];
    [alert addSubview:txtnewpass];
    [alert addSubview:txtre_enterpass];
    
   
    
    [alert show];
    [alert release];
    
    
}


-(void)clickon_enter_new_number
{
    UIAlertView *alert1=[[UIAlertView alloc]initWithTitle:@"" message:@"\n\n" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Save", nil];
    alert1.tag = 2;
    
    NSLog(@"%@",[alert1 subviews]);
    
    txtenter_newno=[[UITextField alloc]initWithFrame:CGRectMake(20, 35, 245, 34)];
    txtenter_newno.borderStyle=UITextBorderStyleRoundedRect;
    txtenter_newno.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    txtenter_newno.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    txtenter_newno.placeholder=@"Enter New Number";
    
    txtenter_newno.delegate = self;
    
    [alert1 addSubview:txtenter_newno];
    //[alert1 addSubview:btnsave];
    
    [alert1 show];
    [alert1 release];
    
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex == 1)
    {
        if(alertView.tag ==1)
        {
            [self performSelector:@selector(paswordUpdate)];
        }
        else
        {
            [self performSelector:@selector(PhNumberChange)];
           
        }
    }
}

-(void) paswordUpdate
{
    // call the api for password
    
    NSData *data=[[NSUserDefaults standardUserDefaults] objectForKey:USERDETAILS];
    
    NSDictionary *dic= [NSKeyedUnarchiver unarchiveObjectWithData:data];
    NSString *password=[[dic objectForKey:@"posts"]objectForKey:@"password"];
    NSLog(@"password=%@",password);
    //NSString *curpass=txtcrtpass.text;
    if([password isEqualToString:txtcrtpass.text])
     {
   
       if([txtnewpass.text isEqualToString:txtre_enterpass.text])
         {
           [datamodel PerformApi:API_CHANGEPASSWORD :txtnewpass.text];
         }
         else
         {
             //=================
             UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"Enter correct password"  delegate:self cancelButtonTitle:@"ok" otherButtonTitles: nil, nil];
             [alert show];
             [alert release];
             
             //=================
         }
    }
    else
    {
        //=================
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"Enter correct password"  delegate:self cancelButtonTitle:@"ok" otherButtonTitles: nil, nil];
		[alert show];
		[alert release];
        
        //=================
        
    }
}

-(void) PhNumberChange
{
    // call phone number api
    
    if([txtenter_newno.text length]!=10)
    {       
        //=================
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"Enter valid phone number"  delegate:self cancelButtonTitle:@"ok" otherButtonTitles: nil, nil];
		[alert show];
		[alert release];
        
        //=================
        
    }
    else
    {
          
        [datamodel PerformApi:API_NEWNUMBER :txtenter_newno.text];
       // [self UpdateData:datamodel.mobno :6];
        [self performSelector:@selector(updateData::) withObject:txtenter_newno.text withObject:6];
               
        
        NSIndexPath  *path =[NSIndexPath indexPathForRow:6 inSection:0];
        
        [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:path] withRowAnimation:UITableViewScrollPositionMiddle];
        //[self.tblevalues reloadRowsAtIndexPaths: withRowAnimation:UITableViewRowAnimationMiddle];
        [self dismissModalViewControllerAnimated:YES];
      
    }
}

-(void) updateData:(NSString *)str :(NSInteger) row
{
    [tblevalues replaceObjectAtIndex:row withObject:str];
}


//***************************************************************************
/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */

/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
 {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
 }   
 else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }   
 }
 */

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
 {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if(indexPath.row == 6)
    {
        [self clickon_enter_new_number];
    }
}


#pragma mark textfield delegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if([string isEqualToString:@""])
    {
        return YES;
    }
    else if(([string characterAtIndex:0]>=48)&&([string characterAtIndex:0]<=57))
    {
        return YES;
    }
    return NO;
    
}

@end
