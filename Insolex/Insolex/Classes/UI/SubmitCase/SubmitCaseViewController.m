//
//  SubmitCaseViewController.m
//  Insolex
//
//  Created by Almand on 19/08/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "SubmitCaseViewController.h"


@implementation SubmitCaseViewController
@synthesize module;
@synthesize datepickerview;

@synthesize delegate;

//@synthesize btn;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
        reloadTable = YES;
       
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
    
    if(tablearray != nil)
    {
        [tablearray release];
    }
    [lblarry release];
    

    [datepickerview release];
   
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
    
    selectedcategory = nil;
    dateSring = @"";
    tempIndexpath = nil;
    datamodel =[[SubmitCaseData alloc] init];
    
   // self.module = MODULE_SUBMITASSIST;
    
    if(self.module == MODULE_SUBMISSION)
    {
            totalcomborow = 4;

        lblarry =(NSArray *)[[datamodel getSubmissionTrackData] retain];
      
    }
    else
    {
        totalcomborow = 3;
        //tablearray =;
        lblarry =(NSArray *)[[datamodel getSurgicalAssistData] retain];
        
    }
    
      tablearray =[datamodel.rowdata copy];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
  
    
   // datepickerview.frame = CGRectMake(0, 480, 320, 260);
    
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if(textField.tag == [tablearray count]-2)
    {
        datamodel.title = textField.text;
    }
    else
    {
        datamodel.preceptor= textField.text;
    }
    [textField resignFirstResponder];
    return YES;
}


-(BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    textView.text = @"";
    textView.textColor = [UIColor blackColor];
    return YES;
}

-(BOOL)textViewShouldEndEditing:(UITextView *)textView
{
    if([textView.text isEqualToString:@""])
    {
        textView.textColor =[UIColor grayColor];
        textView.text =@"Procedure";
    }
    
    return YES;
}
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    
    if([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        
        datamodel.procedure = textView.text;
        return NO;
    }
    
    return YES;
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

#pragma mark class method
-(void) submitAction
{
    // to do
    // check validation;
    if([datamodel Validation:self.module])
    {
        if ([datamodel performAPI]) 
        {
            // success msg
          //  NSLog(@"SUBMIT CASS SEND SUCCDSSFULLY");
            
            if(tablearray != nil)
            {
                [tablearray release];
            }
   
    if(self.module == MODULE_SUBMISSION)
     //===============================             
            {
                totalcomborow = 4;
                
                tablearray =[[datamodel getSubmissionTrackData] retain];
            }
            else
            {
                totalcomborow = 3;
                tablearray =[[datamodel getSurgicalAssistData] retain];
            }
            
           // [self.tableView reload];
            reloadTable = NO;
            [self.tableView reloadData];
        }
        else
        {
            // alert server error
            [delegate showAlertPopup:@"Alert" :[[NSUserDefaults standardUserDefaults] objectForKey:@"404"]];
            
        }
    }
    else
    {
        // alert validation
        [delegate showAlertPopup:@"Alert" :[[NSUserDefaults standardUserDefaults] objectForKey:@"104"]];
    
    }
    
 
    
}

-(void) loadSelectionControler:(NSArray *) arr :(NSString*) title
{
    
   
    SelectionViewController *select =[[SelectionViewController alloc] init];
    select.delegate = self;
    select.datarray = arr;
    
    UINavigationController *nav =[[UINavigationController alloc] initWithRootViewController:select];
    nav.navigationBar.tintColor = [UIColor navigationColor]; 
    nav.navigationBar.topItem.title = title;
    [self presentModalViewController:nav animated:YES];
    [select release];
    
    [nav release];
}


-(void)Selectiondelegate:(NSString *)selectedVaue
{
    
    [datamodel UpdateData:selectedVaue :tempIndexpath.section];
    
    NSInteger rownumber = tempIndexpath.section;
    
    if(module == MODULE_SUBMISSION)
    {
      if(rownumber == 1)
      {
          datamodel.rolename = selectedVaue;
      }
      else  if(rownumber == 2)
      {
          datamodel.category = selectedVaue;
          selectedcategory = selectedVaue;
          
          
      }
      else  if(rownumber == 3)
      {
          datamodel.specialty = selectedVaue;
      }

    }
    else
    {
        if(rownumber == 1)
        {
            datamodel.category = selectedVaue;
            selectedcategory  = selectedVaue;
        }
        else  if(rownumber == 2)
        {
            datamodel.specialty = selectedVaue;
        }

    }

    if(tablearray != nil)
        [tablearray release];
    
    tablearray =(NSArray *) [datamodel.rowdata retain];
    
    
    [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:tempIndexpath] withRowAnimation:UITableViewRowAnimationMiddle];
    
    //[self.tableView reload
    [self dismissModalViewControllerAnimated:YES];
    
    
    if((module == MODULE_SUBMISSION && rownumber == 2) || (module == MODULE_SUBMITASSIST && rownumber ==1))
    {
        [datamodel UpdateData:@"Speciality" :rownumber+1];
        datamodel.specialty = nil;
        
        if(tablearray != nil)
            [tablearray release];
        
        tablearray =(NSArray *) [datamodel.rowdata retain];

        NSIndexPath *path =[NSIndexPath indexPathForRow:0 inSection:rownumber+1];
        [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:path] withRowAnimation:UITableViewRowAnimationMiddle];
        [self dismissModalViewControllerAnimated:YES];
    }
    
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
//#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return [tablearray count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

     NSString *CellIdentifier =[lblarry objectAtIndex:indexPath.section];
    //UILabel *lblcombo = nil;
    UITableViewCell *cell = nil;
    
    if(indexPath.section >= totalcomborow)
    {
        cell =[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        
        if(!reloadTable)
        {
            cell =nil;
        }
        if (cell == nil)
        {
            cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
            
            
            if(indexPath.section <= [tablearray count]-2)
            {
                NSInteger rowheight=50;
                if(indexPath.section == totalcomborow)
                    rowheight = 100;
                UIView *lineView = [[[UIView alloc] initWithFrame:CGRectMake(115, 0,1, rowheight)] autorelease];
                lineView.backgroundColor = [UIColor lightGrayColor];
                // lineView.autoresizingMask = 0x3f;
                [cell.contentView addSubview:lineView];
                
                
                UILabel *lbltitle=[[UILabel alloc]initWithFrame:CGRectMake(10,0,95,rowheight)];
                lbltitle.backgroundColor=[UIColor clearColor];
                lbltitle.font =[UIFont boldSystemFontOfSize:12];
                lbltitle.textColor = [UIColor darkGrayColor];
                lbltitle.lineBreakMode = UILineBreakModeWordWrap;
                lbltitle.numberOfLines  = 5;
                lbltitle.adjustsFontSizeToFitWidth=YES;
                lbltitle.text =[lblarry objectAtIndex:indexPath.section];
                lbltitle.textAlignment=UITextAlignmentRight;
                lbltitle.textColor=[UIColor blackColor]; 
                [cell.contentView addSubview:lbltitle];
                [lbltitle release];
            }

            
            if(indexPath.section == totalcomborow)
            {
                
                UITextView *txtview=[[UITextView alloc]initWithFrame:CGRectMake(120,2,180,80)];
                txtview.backgroundColor=[UIColor clearColor];
                txtview.text=[tablearray objectAtIndex:indexPath.section];
                txtview.font=[UIFont fontWithName:@"Helvetica" size:14];
                txtview.textColor=[UIColor grayColor];
                txtview.delegate=self;
                // [imgView addSubview:txtview];
                [cell.contentView addSubview:txtview];
                [txtview release];
                
                
                cell.accessoryType = UITableViewCellAccessoryNone;
            }
            
            
            else if(indexPath.section <totalcomborow+3)
            {
                // text field
                //  CGFloat leftInset = 10.0f;
                
                UITextField *txtfield =[[UITextField alloc] initWithFrame:CGRectMake(120, 5, 180, 40)];
                // txtfield.background =[UIImage imageNamed:@"textbox.png"];
                txtfield.placeholder=[tablearray objectAtIndex:indexPath.section];
                txtfield.contentVerticalAlignment=UIControlContentVerticalAlignmentCenter;
                //txtfield.textAlignment=UITextAlignmentCenter;
                //   UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, leftInset, txtfield.bounds.size.height)];
                
                txtfield.font =[UIFont systemFontOfSize:14];
                //   txtfield.leftView = leftView;
                txtfield.leftViewMode = UITextFieldViewModeAlways;
                txtfield.delegate=self;
                txtfield.tag= indexPath.section;
                [cell.contentView addSubview:txtfield];
                [txtfield release];
                
                //   [leftView release];
                cell.accessoryType = UITableViewCellAccessoryNone;
            }
            else
            {
                // button
                cell.backgroundView =[[[UIView alloc] initWithFrame:CGRectZero] autorelease];
                
                UIButton *btnsubmit=[[UIButton alloc]initWithFrame:CGRectMake(100,10,100,40)];
                [btnsubmit setBackgroundImage:[UIImage imageNamed:@"btn.png"] forState:UIControlStateNormal];
                btnsubmit.titleLabel.textColor=[UIColor whiteColor];
                [btnsubmit setTitle:[lblarry objectAtIndex:indexPath.section] forState:UIControlStateNormal];
                [btnsubmit addTarget:self action:@selector(submitAction) forControlEvents:UIControlEventTouchUpInside];
                [cell.contentView addSubview:btnsubmit];
                [btnsubmit release];
                
                cell.accessoryType = UITableViewCellAccessoryNone;
            }
            


        }
    }
    else
    {
       cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    // Configure the cell...
    //button design
    
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        if(indexPath.section <= [tablearray count]-2)
        {
            NSInteger rowheight=50;
            if(indexPath.section == totalcomborow)
                rowheight = 100;
            UIView *lineView = [[[UIView alloc] initWithFrame:CGRectMake(115, 0,1, rowheight)] autorelease];
            lineView.backgroundColor = [UIColor lightGrayColor];
           // lineView.autoresizingMask = 0x3f;
            [cell.contentView addSubview:lineView];
            
            
            UILabel *lbltitle=[[UILabel alloc]initWithFrame:CGRectMake(10,0,95,rowheight)];
            lbltitle.backgroundColor=[UIColor clearColor];
            lbltitle.font =[UIFont boldSystemFontOfSize:12];
            lbltitle.textColor = [UIColor darkGrayColor];
            lbltitle.lineBreakMode = UILineBreakModeWordWrap;
            lbltitle.numberOfLines  = 5;
            lbltitle.adjustsFontSizeToFitWidth=YES;
            lbltitle.text =[lblarry objectAtIndex:indexPath.section];
            lbltitle.textAlignment=UITextAlignmentRight;
            lbltitle.textColor=[UIColor blackColor]; 
            [cell.contentView addSubview:lbltitle];
            [lbltitle release];
        }

        if(indexPath.section <totalcomborow)
        {
                         
           // UIScrollView *scroll =[[UIScrollView alloc] initWithFrame:CGRectMake(120, 0, 180, 50)];
            //scroll.backgroundColor =[UIColor clearColor];
        
            UIButton *btn=[[UIButton alloc]initWithFrame:CGRectMake(125,5,190,40)];
            btn.backgroundColor =[UIColor clearColor];
            // [btn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
            [btn setTag:indexPath.section];
            [btn addTarget:self action:@selector(btnRowAction:) forControlEvents:UIControlEventTouchUpInside];
            //     [btn setBackgroundImage:newimge forState:UIControlStateNormal];
            [cell.contentView addSubview:btn];
            
            [btn release];

            
            UILabel  *lblcombo=[[UILabel alloc]initWithFrame:CGRectMake(125,0,280,50)];
            lblcombo.backgroundColor=[UIColor clearColor];
            lblcombo.font =[UIFont systemFontOfSize:14];
           // lblcombo.adjustsFontSizeToFitWidth=YES;
            lblcombo.tag = indexPath.section+10;
     
            lblcombo.text = [tablearray objectAtIndex:indexPath.section];
            lblcombo.textAlignment=UITextAlignmentLeft;
            
            
            
            
            [cell.contentView addSubview:lblcombo];
         
            
            if([lblcombo.text isEqualToString:@"Specialty"] || [lblcombo.text isEqualToString:@"Case Date"] || [lblcombo.text isEqualToString:@"Surgical Role"] || [lblcombo.text isEqualToString:@"Surgical Category"])
            {
                lblcombo.textColor=[UIColor lightGrayColor];
            }
            else if(tempIndexpath != nil && tempIndexpath.section == indexPath.section)
            {
                
                lblcombo.textColor =[UIColor blackColor];
            }
            [lblcombo release];
        
            
            
        }
    
    }
   // }
       // Configure the cell...
   
    if(indexPath.section == [tablearray count]-1)
    {
        reloadTable = YES;
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    if(indexPath.section==totalcomborow)
    {
        return 100;
    }
    else
        
        return 50;
}
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
    if(indexPath.section == 0)
    {
        // to do
        [self performSelector:@selector(ShowDatepickerView)];
    }
}


-(void) btnRowAction:(UIButton *)btn
//-(void) btnRowAction
{
    if(tempIndexpath != nil)
    {
        [tempIndexpath release];
    }
    tempIndexpath =[[NSIndexPath indexPathForRow:0 inSection:btn.tag] retain];

   if(btn.tag == 0)
    {
        [self performSelector:@selector(pickerShowAciton)];
    }
             
    else if(btn.tag == 1)
    {
           
        if(module == MODULE_SUBMISSION)
        {
          
            [self performSelector:@selector(loadSelectionControler::) withObject:[datamodel getRole] withObject:@"Role"];
        }
        else
        {
            NSArray *arr =[[datamodel getCaterory:MODULE_SUBMITASSIST] retain];
            [self performSelector:@selector(loadSelectionControler::) withObject:arr withObject:@"Category"];
            [arr release];
        }
    }
          
    else if(btn.tag == 2)
    {
        if(module == MODULE_SUBMISSION)
        {
            NSArray *arr =[[datamodel getCaterory:MODULE_SUBMISSION] retain];
            [self performSelector:@selector(loadSelectionControler::) withObject:arr withObject:@"Category"];
            [arr release];

        }
        else
        {
            
            if(selectedcategory == nil)
            {
                // to do alert
                [delegate showAlertPopup:@"Alert" :@"Please Select Category"];
            }
            else
            {
                NSArray *arr =[[datamodel getSpecialty:MODULE_SUBMITASSIST :selectedcategory] retain];
                if([arr count] >0)
                    [self performSelector:@selector(loadSelectionControler::) withObject:arr withObject:@"Speciality"];
                [arr release];
            }

        }
    }
    else if(btn.tag == 3)
    {
        
        if(selectedcategory == nil)
        {
            // to do alert
            [delegate showAlertPopup:@"Alert" :@"Please Select Category"];
        }
        else
        {

            NSArray *arr =[[datamodel getSpecialty:MODULE_SUBMISSION :selectedcategory] retain];
            
            if([arr count] >0)
                [self performSelector:@selector(loadSelectionControler::) withObject:arr withObject:@"Speciality"];
            [arr release];
        }
    }
}

#pragma mark date picker dalegate

-(void) PickerDoneAction
{
    // to do
    NSDateFormatter *format =[[NSDateFormatter alloc] init];
    [format setDateFormat:@"MM/dd/yyyy"];
    
    dateSring =[format stringFromDate:[datepicker date]];
    [format release];
    [datamodel UpdateData:dateSring :tempIndexpath.row];
    
    datamodel.casedate = dateSring;
    if(tablearray != nil)
        [tablearray release];
    
    tablearray =(NSArray *) [datamodel.rowdata retain];
    
    [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:tempIndexpath] withRowAnimation:UITableViewRowAnimationMiddle];
       
    [sheet dismissWithClickedButtonIndex:0 animated:YES];
    [sheet release];
    
}

-(void) pickerShowAciton
{
    sheet =[[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles: nil];
    //sheet.frame =CGRectMake(0, 260, 320, 240);
   // CGRect rect =sheet.frame;
    
    UIToolbar *toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 50)];
	toolbar.backgroundColor = [UIColor blackColor];
	toolbar.tintColor =[UIColor navigationColor];
	toolbar.barStyle = UIBarStyleBlackTranslucent;
	toolbar.alpha = 0.7;
	[sheet addSubview:toolbar];
	[toolbar release];
	
    
    UIBarButtonItem *spacer =[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    spacer.width = 250;
    UIBarButtonItem *btn =[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(PickerDoneAction)];
    
    [toolbar setItems:[NSArray arrayWithObjects:spacer,btn,nil] animated:YES];
    [btn release];
    [spacer release];
	  

	
	datepicker= [[UIDatePicker alloc] initWithFrame:CGRectMake(0, 50, 320, 200)];
	datepicker.backgroundColor = [UIColor clearColor];
	datepicker.datePickerMode = UIDatePickerModeDate;
	//datepicker.date = date;
	[sheet addSubview:datepicker];
	[datepicker release];
    

    
    [sheet showInView:self.view];
    [sheet setFrame:CGRectMake(0, 180, 320, 240)];
    
}

-(void) ShowDatepickerView
{
    [UIView beginAnimations:nil context:nil];
	[UIView setAnimationDuration:0.4];
	[UIView setAnimationRepeatCount:0];
	[UIView setAnimationDelay:0];
    
    CGRect rect =datepickerview.frame;
    rect.origin.y -= 260;
    
    datepickerview.frame = rect;
    
  	
	[UIView setAnimationDelegate:self];
	[UIView commitAnimations];    
}
@end
