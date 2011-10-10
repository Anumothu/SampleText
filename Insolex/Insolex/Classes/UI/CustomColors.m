//
//  CustomColors.m
//  Insolex
//
//  Created by Almand on 08/09/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "CustomColors.h"


@implementation UIColor (CustomColors)


+ (UIColor *) navigationColor
{
    static UIColor *customColor = nil;
    
    if (!customColor){
        customColor = RGBCOLOR(93,193,219,1.0);
        [customColor retain];
    }
    return customColor;
}

+(UIColor *) bgColor
{
    static UIColor *bgColor = nil;
    
    if (!bgColor){
 
        bgColor = RGBCOLOR(233,251,254,1.0);
        [bgColor retain];
    }
    return bgColor;

}

@end
