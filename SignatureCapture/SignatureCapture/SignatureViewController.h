//
//  SignatureViewController.h
//  SignatureCapture
//
//  Created by Almand on 09/09/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface SignatureViewController : UIViewController {
    
    IBOutlet UIImageView *signatureImageView;
    
    IBOutlet UIImageView *getsigview;
    
    CGPoint lastPoint;
    BOOL mouseSwiped;   
    int mouseMoved;
    
    
    CGPoint startpoint;
    
    CGPoint endpoint;
    
    
    
}

@property (nonatomic,retain) IBOutlet UIImageView *getsigview;

-(IBAction) getSigViewImage:(id)sender;
@end
