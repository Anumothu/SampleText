//
//  SignatureViewController.m
//  SignatureCapture
//
//  Created by Almand on 09/09/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "SignatureViewController.h"


@implementation SignatureViewController
@synthesize getsigview;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)dealloc
{
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
    self.view.backgroundColor = [UIColor grayColor];
    [super viewDidLoad];
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
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {      
    mouseSwiped = NO;
    UITouch *touch = [touches anyObject];
    
    startpoint =[touch locationInView:self.view];
    
    
    //[signatureImageView.image drawInRect:CGRectMake(0, 0, signatureImageView.frame.size.width, signatureImageView.frame.size.height)];
   // NSLog(@"%f==%f",point.x,point.y);
    
    //Clear Signature on Double Tap
//    if ([touch tapCount] == 2) {
//        //signatureImageView.image = nil;
//        return;
//    }
    
    lastPoint = [touch locationInView:signatureImageView];
    
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    mouseSwiped = YES;
    
    UITouch *touch = [touches anyObject];   
    
    CGPoint currentPoint = [touch locationInView:signatureImageView];
    
    UIGraphicsBeginImageContext(signatureImageView.frame.size);
    
//    [signatureImageView.image drawInRect:CGRectMake(0, 0, signatureImageView.frame.size.width, signatureImageView.frame.size.height)];
//    CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);
//    CGContextSetLineWidth(UIGraphicsGetCurrentContext(), 2.0);
//    CGContextSetRGBStrokeColor(UIGraphicsGetCurrentContext(), 0.0, 0.0, 0.0, 1.0);
//    CGContextBeginPath(UIGraphicsGetCurrentContext());
//    CGContextMoveToPoint(UIGraphicsGetCurrentContext(), lastPoint.x, lastPoint.y);
//    CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), currentPoint.x, currentPoint.y);
//    CGContextStrokePath(UIGraphicsGetCurrentContext());
    
       
 //   signatureImageView.image = UIGraphicsGetImageFromCurrentImageContext();
 //   UIGraphicsEndImageContext();
//    
    
    
    
    CGContextRef currentContext1 = UIGraphicsGetCurrentContext();
    CGContextSetStrokeColorWithColor(currentContext1, [UIColor redColor].CGColor);
    
    // Draw them with a 2.0 stroke width so they are a bit more visible.
    CGContextSetLineWidth(currentContext1, 2.0);
    
    
    CGContextMoveToPoint(currentContext1, startpoint.x,startpoint.y); //start at this point
    
    CGContextAddLineToPoint(currentContext1,currentPoint.x, currentPoint.y); //draw to this point
    
    // and now draw the Path!
    CGContextStrokePath(currentContext1);
    
//    signatureImageView.image = UIGraphicsGetImageFromCurrentImageContext();
    
     UIGraphicsEndImageContext();
    lastPoint = currentPoint;
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    
    UITouch *touch = [touches anyObject];
    
    endpoint =[touch locationInView:self.view];
    //Clear Signature on Double Tap
//    if ([touch tapCount] == 2) {
//        //signatureImageView.image = nil;
//        return;
//    }
    
  //  if(!mouseSwiped) {
        UIGraphicsBeginImageContext(signatureImageView.frame.size);
          [signatureImageView.image drawInRect:CGRectMake(0, 0, signatureImageView.frame.size.width, signatureImageView.frame.size.height)];
//        CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);
//        CGContextSetLineWidth(UIGraphicsGetCurrentContext(), 2.0);
//        CGContextSetRGBStrokeColor(UIGraphicsGetCurrentContext(), 0.0, 0.0, 0.0, 0.0);
//        CGContextMoveToPoint(UIGraphicsGetCurrentContext(), lastPoint.x, lastPoint.y);
//        CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), lastPoint.x, lastPoint.y);
//        CGContextStrokePath(UIGraphicsGetCurrentContext());
//        CGContextFlush(UIGraphicsGetCurrentContext());
//        signatureImageView.image = UIGraphicsGetImageFromCurrentImageContext();
//        UIGraphicsEndImageContext();
 //   }
    
    
    CGContextRef currentContext1 = UIGraphicsGetCurrentContext();
    CGContextSetStrokeColorWithColor(currentContext1, [UIColor redColor].CGColor);
    
    // Draw them with a 2.0 stroke width so they are a bit more visible.
    CGContextSetLineWidth(currentContext1, 2.0);
    
    
    CGContextMoveToPoint(currentContext1, startpoint.x,startpoint.y); //start at this point
    
    CGContextAddLineToPoint(currentContext1,endpoint.x, endpoint.y); //draw to this point
    
    // and now draw the Path!
    CGContextStrokePath(currentContext1);
    
    signatureImageView.image = UIGraphicsGetImageFromCurrentImageContext();
    
    
  
     UIGraphicsEndImageContext();

}

-(IBAction) getSigViewImage:(id)sender
{
    
    UIImage *mg =signatureImageView.image;
    
    NSString* path = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingString:@"/myImage.png"];
    
    BOOL ok = [[NSFileManager defaultManager] createFileAtPath:path 
                                                      contents:nil attributes:nil];
    
    if (!ok) {
        NSLog(@"Error creating file %@", path);
    } else {
        NSFileHandle* myFileHandle = [NSFileHandle fileHandleForWritingAtPath:path];
        [myFileHandle writeData:UIImagePNGRepresentation(mg)];
        [myFileHandle closeFile];
    }
    
    //
    // Loading from documents
    //  
    NSFileHandle* myFileHandle = [NSFileHandle fileHandleForReadingAtPath:path];
    UIImage* loadedImage = [UIImage imageWithData:[myFileHandle readDataToEndOfFile]];
    
    getsigview.image = loadedImage;
}
@end
