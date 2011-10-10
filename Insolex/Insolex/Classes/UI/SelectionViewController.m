//
//  SelectionViewController.m
//  Insolex
//
//  Created by Hakuna on 8/30/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "SelectionViewController.h"


@implementation SelectionViewController
@synthesize delegate;
@synthesize datarray;
//@synthesize array1;

  

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
 
    }
    return self;
}

- (void)dealloc
{
    [super dealloc];
    [datarray release];
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

    self.tableView.frame = CGRectMake(0, 44, 320, 436);
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
       

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
//#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//#warning Incomplete method implementation.
    // Return the number of rows in the section.
    
    return [datarray count];
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
     NSString *CellIdentifier =[datarray objectAtIndex:indexPath.row];
   
    
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];

       
        //cell.textLabel.text =[array objectAtIndex:indexPath.row];
        /*  UIScrollView *scroll =[[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
         scroll.backgroundColor =[UIColor clearColor];
         
         
         
         UILabel *lbltitle=[[UILabel alloc]initWithFrame:CGRectMake(10,0,400,44)];
         lbltitle.backgroundColor=[UIColor clearColor];
         lbltitle.font =[UIFont boldSystemFontOfSize:14];
         lbltitle.textColor = [UIColor darkGrayColor];
         lbltitle.lineBreakMode = UILineBreakModeWordWrap;
         lbltitle.text =[datarray objectAtIndex:indexPath.row];
         lbltitle.textAlignment=UITextAlignmentLeft;
         lbltitle.textColor=[UIColor blackColor]; 
         [scroll addSubview:lbltitle];
         [lbltitle release];
         
         
         scroll.contentSize = CGSizeMake(640, 44);
         [cell.contentView addSubview:scroll];
         [scroll release];
*/
        cell.textLabel.text=[datarray objectAtIndex:indexPath.row];
        //cell.textLabel.numberOfLines = 3;
        //cell.textLabel.lineBreakMode = UILineBreakModeWordWrap;
        cell.textLabel.font =[UIFont systemFontOfSize:14];

        cell.accessoryType = UITableViewCellAccessoryNone;
       
    }
        
 
    // Configure the cell...
    
    return cell;
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
    UITableViewCell *cell =[self.tableView cellForRowAtIndexPath:indexPath];
    
    cell.accessoryType = UITableViewCellAccessoryCheckmark;
    
    [delegate Selectiondelegate:cell.textLabel.text];
}

@end
