//
//  SubmissionTrackViewcontroller.m
//  Insolex
//
//  Created by Almand on 19/08/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "SubmissionTrackViewcontroller.h"


@implementation SubmissionTrackViewcontroller
@synthesize table;

@synthesize delegate;
@synthesize trackcell;
@synthesize track1cell;
//@synthesize btntrackassist;

@synthesize module;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
               //self.navigationItem.hidesBackButton = YES;

            
    }
    return self;
}

- (void)dealloc
{
    if(datastore != nil)
    {
        [datastore releaseMemory];
            [datastore release];
    }
    
    [table release];
    [trackcell release];
    [track1cell  release];
    


    [super dealloc];
}


- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

-(void)viewDidAppear:(BOOL)animated
{
        self.navigationController.navigationBar.topItem.title = @"Submission Track";
}

-(void)viewWillAppear:(BOOL)animated
{
      
    if(![datastore performApi])
    {
        
        NSString *str =[[NSUserDefaults standardUserDefaults] objectForKey:datastore.errorString];
        [delegate showAlertPopup:@"Alert" :str];
    }
    
    [self.table reloadData];

}
- (void)viewDidLoad
{
    UIButton  *btn =[[UIButton alloc] initWithFrame:CGRectMake(0, 0, 45, 32)];
    [btn setBackgroundImage:[UIImage imageNamed:@"logout.png"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(backBarButtonAction) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *logoutbtn =[[[UIBarButtonItem alloc] initWithCustomView:btn] autorelease];
    
      [btn release];
    self.navigationItem.leftBarButtonItem = logoutbtn;
  
   // self.navigationItem.hidesBackButton = YES;
    [super viewDidLoad];
    
   // UIBarButtonItem *btn =[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"logout.png"] style:UIBarButtonSystemItemAdd target:self action:@selector(backBarButtonAction)];
    
   
    
      datastore =[[SubmissionTrackData alloc] init];
       self.navigationController.navigationBar.tintColor =  [UIColor navigationColor];
    table.backgroundColor =[UIColor clearColor];
     self.view.backgroundColor = [UIColor bgColor];
    //self.delegate=lblProgram;
    lblname.text =[datastore userName];
    lblProgram.text =[datastore ProgramName];
    
    //self.navigationController.title = @"Submission Track";
    
    
    // Do any additional setup after loading the view from its nib.
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

-(void) backBarButtonAction
{
    [delegate goBack];
}
-(IBAction) submitBtnTouched:(id) sender
{
    if(module == MODULE_SUBMISSION)
    {
        [delegate showView:VIEW_SUBMITCASE :nil :MODULE_SUBMISSION];
    }
    else
    {
        [delegate showView:VIEW_SUBMITCASE :nil :MODULE_SUBMITASSIST];
    }
}

-(IBAction) myAccountBtnTouched:(id) sender
{
     
    [delegate showView:VIEW_MYACCOUNT :nil :MODULE_SUBMITASSIST];
}


#pragma mark -
#pragma mark table view delegate and Data Structures
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
// return number of row for each section
{
    if(selectedindex && selectedindex.section == section)
    {
        return RowCount;   
    }// need to change while integrate api
    return 1; 
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row ==0)
    {
        return 40;
    }
    return 120;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSString *cellidentifier =[NSString stringWithFormat:@"%d%d",indexPath.section,indexPath.row];
    UITableViewCell *cell =nil;//[tableView dequeueReusableCellWithIdentifier:cellidentifier];
    //if(cell == nil)
    //{
        cell =[[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellidentifier] autorelease];
      
        if(indexPath.row == 0)
        {
            
            UIImageView *bgimgeview =[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"tableheader.png"]];
            cell.backgroundView =bgimgeview;
            [bgimgeview release];
            cell.textLabel.font =[UIFont boldSystemFontOfSize:14.00];
            cell.textLabel.textColor =[UIColor whiteColor];
            [cell.textLabel setBackgroundColor:[UIColor clearColor]];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;

            cell.textLabel.text =[datastore sectiontotal:indexPath.section];

        }
        else
        {
                       
          //  NSLog(@"%@",dic);
            
            
            if(module == MODULE_SUBMISSION)//if api for submission track
            {
            cell = trackcell;
            
                /*       
      
            
            NSDictionary *scrub1dic =[dic objectForKey:SCRUB1];
               
            scrub1general.text =[scrub1dic objectForKey:GENERAL];
            scrub1surgical.text =[scrub1dic objectForKey:SURGICAL];
            scrub1endoscopy.text =[scrub1dic objectForKey:ENDOSCOPY];
            scrub1labor.text =[scrub1dic objectForKey:LABOR];
            
            scrub1dic =[dic objectForKey:SCRUB2];
            scrub2general.text =[scrub1dic objectForKey:GENERAL];
            scrub2surgical.text =[scrub1dic objectForKey:SURGICAL];
            scrub2endoscopy.text =[scrub1dic objectForKey:ENDOSCOPY];
            scrub2labor.text =[scrub1dic objectForKey:LABOR];
*/            
            //======================
                
               // NSDictionary *dic =[datastore trackdata];
                NSDictionary *dic =[datastore detailCell:indexPath.section];
                             
                scrub1general.text=[NSString stringWithFormat:@"%@",[dic objectForKey:SCRUB1_GENERAL]];
                scrub1surgical.text =[NSString stringWithFormat:@"%@",[dic objectForKey:SCRUB1_SURGICAL]];
                scrub1endoscopy.text=[NSString stringWithFormat:@"%@",[dic objectForKey:SCRUB1_ENDOSCOPY]];
                scrub1labor.text=[NSString stringWithFormat:@"%@",[dic objectForKey:SCRUB1_LABOR]];
                scrub2general.text=[NSString stringWithFormat:@"%@",[dic objectForKey:SCRUB2_GENERAL]];
                scrub2surgical.text=[NSString stringWithFormat:@"%@",[dic objectForKey:SCRUB2_SURGICAL]];
                scrub2endoscopy.text=[NSString stringWithFormat:@"%@",[dic objectForKey:SCRUB2_ENDOSCOPY]];
                scrub2labor.text=[NSString stringWithFormat:@"%@",[dic objectForKey:SCRUB2_LABOR]];
                
            //======================
            
            
            }
           else //if api for submission assist
            {
                cell = track1cell;
               
                NSDictionary *scrub1dic =[datastore trackassist:indexPath.section];
                
                
                assitgeneral.text=[NSString stringWithFormat:@"%@",[scrub1dic objectForKey:NON_GENERAL]];
                assitsocial.text=[NSString stringWithFormat:@"%@",[scrub1dic objectForKey:NON_CHOSENSPECIALTY]];
                assitothers.text=[NSString stringWithFormat:@"%@",[scrub1dic objectForKey:NON_OTHERSPECIALTY]];

            }

        }
        
   // }
   
    
  
    
    
    
    return cell;
    
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.view.userInteractionEnabled =NO;
    if(indexPath.row == 0)
    {
            if(selectedindex)
            {
                NSMutableArray *indexarray =[[NSMutableArray alloc] init];
                // change the  background image minus to plus
                [table beginUpdates];
                //NSIndexPath *deleteindexp
                for (int i = 1; i < RowCount; i++)
                {
                    NSIndexPath *deleteIndexPath =[NSIndexPath indexPathForRow:selectedindex.row+i inSection:selectedindex.section];
                    [indexarray addObject:deleteIndexPath];
                    deleteIndexPath = nil;
                }
                
                [table deleteRowsAtIndexPaths:(NSArray *) indexarray withRowAnimation:UITableViewRowAnimationFade];
                UITableViewCell *selectedcell =[tableView cellForRowAtIndexPath:selectedindex];
                selectedcell.selectedBackgroundView =[[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"tableheader.png"]] autorelease];
               // selectedcell.textLabel.textColor=[[PranaCommonViews sharedInstance] getSubtilteColor];
                if(indexPath==selectedindex){
                    selectedindex=nil;
                    [table endUpdates];
                    [indexarray release];
                      self.view.userInteractionEnabled =YES;
                    return;
                }
                else
                {
                    selectedindex=nil;
                    [table endUpdates];
                    [indexarray release];
                }
            }
            // add new row
            
            selectedindex=indexPath;
            [table beginUpdates];
            NSMutableArray *indexarray =[[NSMutableArray alloc] init];
            
            for (int i = 1; i <RowCount; i++)
            {
                NSIndexPath *newIndexPath =[NSIndexPath indexPathForRow:selectedindex.row+i inSection:selectedindex.section];
                [indexarray addObject:newIndexPath];
                newIndexPath = nil;
            }
            
           
            UITableViewCell *selectedCell=[tableView cellForRowAtIndexPath:indexPath];
            
            
            selectedCell.selectedBackgroundView=[[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"tableheaderselected.png"]] autorelease];
            //selectedCell.textLabel.textColor=[[PranaCommonViews sharedInstance] getSubtilteColor];
            
            [table insertRowsAtIndexPaths:(NSArray *)indexarray withRowAnimation:UITableViewRowAnimationFade];
            [table endUpdates];
            [indexarray release];

    }
    
    self.view.userInteractionEnabled =YES;
}


@end
