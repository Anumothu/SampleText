//    File: TiledPDFView.m
//Abstract: This view is backed by a CATiledLayer into which the PDF page is rendered into.
// Version: 1.0
//
//Disclaimer: IMPORTANT:  This Apple software is supplied to you by Apple
//Inc. ("Apple") in consideration of your agreement to the following
//terms, and your use, installation, modification or redistribution of
//this Apple software constitutes acceptance of these terms.  If you do
//not agree with these terms, please do not use, install, modify or
//redistribute this Apple software.
//
//In consideration of your agreement to abide by the following terms, and
//subject to these terms, Apple grants you a personal, non-exclusive
//license, under Apple's copyrights in this original Apple software (the
//"Apple Software"), to use, reproduce, modify and redistribute the Apple
//Software, with or without modifications, in source and/or binary forms;
//provided that if you redistribute the Apple Software in its entirety and
//without modifications, you must retain this notice and the following
//text and disclaimers in all such redistributions of the Apple Software.
//Neither the name, trademarks, service marks or logos of Apple Inc. may
//be used to endorse or promote products derived from the Apple Software
//without specific prior written permission from Apple.  Except as
//expressly stated in this notice, no other rights or licenses, express or
//implied, are granted by Apple herein, including but not limited to any
//patent rights that may be infringed by your derivative works or by other
//works in which the Apple Software may be incorporated.
//
//The Apple Software is provided by Apple on an "AS IS" basis.  APPLE
//MAKES NO WARRANTIES, EXPRESS OR IMPLIED, INCLUDING WITHOUT LIMITATION
//THE IMPLIED WARRANTIES OF NON-INFRINGEMENT, MERCHANTABILITY AND FITNESS
//FOR A PARTICULAR PURPOSE, REGARDING THE APPLE SOFTWARE OR ITS USE AND
//OPERATION ALONE OR IN COMBINATION WITH YOUR PRODUCTS.
//
//IN NO EVENT SHALL APPLE BE LIABLE FOR ANY SPECIAL, INDIRECT, INCIDENTAL
//OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
//SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
//INTERRUPTION) ARISING IN ANY WAY OUT OF THE USE, REPRODUCTION,
//MODIFICATION AND/OR DISTRIBUTION OF THE APPLE SOFTWARE, HOWEVER CAUSED
//AND WHETHER UNDER THEORY OF CONTRACT, TORT (INCLUDING NEGLIGENCE),
//STRICT LIABILITY OR OTHERWISE, EVEN IF APPLE HAS BEEN ADVISED OF THE
//POSSIBILITY OF SUCH DAMAGE.
//
//Copyright (C) 2010 Apple Inc. All Rights Reserved.
//


#import "TiledPDFView.h"
#import <QuartzCore/QuartzCore.h>

@implementation TiledPDFView
@synthesize annotation;


// Create a new TiledPDFView with the desired frame and scale.
- (id)initWithFrame:(CGRect)frame andScale:(CGFloat)scale{
    if ((self = [super initWithFrame:frame])) {
		
        setOpen = YES;
		CATiledLayer *tiledLayer = (CATiledLayer *)[self layer];
		// levelsOfDetail and levelsOfDetailBias determine how
		// the layer is rendered at different zoom levels.  This
		// only matters while the view is zooming, since once the 
		// the view is done zooming a new TiledPDFView is created
		// at the correct size and scale.
        tiledLayer.levelsOfDetail = 4;
		tiledLayer.levelsOfDetailBias = 4;
		tiledLayer.tileSize = CGSizeMake(512.0, 512.0);
		
		myScale = scale;
        
        
            }
    return self;
}


-(void) addAnnotation:(CGRect) rect
{
    annotation =[[UIButton alloc] initWithFrame:rect];
    [annotation setBackgroundImage:[UIImage imageNamed:@"note.png"] forState:UIControlStateNormal];
    //annotation.hidden = YES;
    [annotation addTarget:self action:@selector(annotationAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:annotation];
    
    CGRect rect1 =CGRectMake(0, 0, 200, 100);
    rect1.origin.x = (rect.origin.x -(rect1.size.width/2));
    rect1.origin.y = rect.origin.y - rect1.size.height;
    
   
    
    UIView *rectange =[[UIView alloc] initWithFrame:rect1];
    rectange.backgroundColor =[UIColor redColor];
    [annotation addSubview:rectange];
    [rectange release];
}

-(void) annotationAction:(UIButton*) btn
{
    if(setOpen)
    {
        NSLog(@"close  the popup");
        setOpen = NO;
        
        UIView *view =[[btn subviews] lastObject];
        [view removeFromSuperview];
    }
    else
    {
        NSLog(@"open the popup");
        setOpen = YES;
        
        CGRect rect1 =CGRectMake(0, 0, 200, 100);
        rect1.origin.x = (btn.frame.origin.x -(rect1.size.width/2));
        rect1.origin.y = btn.frame.origin.y - rect1.size.height;
        

        UIView *rectange =[[UIView alloc] initWithFrame:rect1];
        rectange.backgroundColor =[UIColor redColor];
        [btn addSubview:rectange];
        [rectange release];

        
    }
    
}

// Set the layer's class to be CATiledLayer.
+ (Class)layerClass {
	return [CATiledLayer class];
}

// Set the CGPDFPageRef for the view.
- (void)setPage:(CGPDFPageRef)newPage
{
    CGPDFPageRelease(self->pdfPage);
    self->pdfPage = CGPDFPageRetain(newPage);
}


-(void)drawRect:(CGRect)r
{
    // UIView uses the existence of -drawRect: to determine if it should allow its CALayer
    // to be invalidated, which would then lead to the layer creating a backing store and
    // -drawLayer:inContext: being called.
    // By implementing an empty -drawRect: method, we allow UIKit to continue to implement
    // this logic, while doing our real drawing work inside of -drawLayer:inContext:
}


// Draw the CGPDFPageRef into the layer at the correct scale.
-(void)drawLayer:(CALayer*)layer inContext:(CGContextRef)context
{
	// First fill the background with white.
	CGContextSetRGBFillColor(context, 1.0,1.0,1.0,1.0);
    CGContextFillRect(context,self.bounds);
	
	CGContextSaveGState(context);
	// Flip the context so that the PDF page is rendered
	// right side up.
	CGContextTranslateCTM(context, 0.0, self.bounds.size.height);
	CGContextScaleCTM(context, 1.0, -1.0);
	
	// Scale the context so that the PDF page is rendered 
	// at the correct size for the zoom level.
	CGContextScaleCTM(context, myScale,myScale);	
	CGContextDrawPDFPage(context, pdfPage);
	CGContextRestoreGState(context);
	
}

// Clean up.
- (void)dealloc {
	CGPDFPageRelease(pdfPage);
	
    [super dealloc];
}


@end
