//
//  SelectionViewController.h
//  Insolex
//
//  Created by Hakuna on 8/30/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SelectionDelegate <NSObject>

-(void) Selectiondelegate:(NSString *) selectedVaue;

@end

@interface SelectionViewController : UITableViewController {
    
    NSArray *datarray;
   // NSArray *array1;
    id<SelectionDelegate> delegate;

    
}
@property(nonatomic,retain)NSArray *datarray;

//@property(nonatomic,retain)NSArray *array1;
@property (nonatomic,assign) id <SelectionDelegate> delegate;



@end




