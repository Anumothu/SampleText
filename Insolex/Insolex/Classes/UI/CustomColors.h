//
//  CustomColors.h
//  Insolex
//
//  Created by Almand on 08/09/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//


#define RGBCOLOR(r,g,b,a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]
#import <Foundation/Foundation.h>


@interface UIColor (CustomColors)



+(UIColor *) bgColor;
+ (UIColor *) navigationColor;
@end
