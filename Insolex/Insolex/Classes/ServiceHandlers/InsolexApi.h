//
//  InsolexApi.h
//  Insolex
//
//  Created by Almand on 31/08/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//
#ifndef __INSLOEX_COMMAND_DEFS_H__
#define __INSOLEX_COMMAND_DEFS_H__


static NSString* const URLSUBTRACK = @"http://%@/tracksubmissionAPI.php?";//studentd= ? &institutionid=?&casedate=?&surgicalrole=?&specialty=?&preceptor=?&procedure=?&title=?&category=?";
static NSString* const URLLOGIN = @"http://%@/loginAPI.php?";//name= ? &password=?
static NSString* const URLSUBMITCASE = @"http://%@/casesubmitAPI.php?";//studentd= ? &institutionid=?&casedate=?&surgicalrole=?&specialty=?&preceptor=?&procedure=?&title=?&category=?
static NSString* const URLFORGETUSERNAME = @"";
static NSString* const URLFORGETPASSWORD = @"";
static NSString* const URLUPDATEPHONE = @"http://%@/phonenoAPI.php?";//userid= ? &mobile_no=?";
static NSString* const URLUPDATEPASSWORD = @"http://%@/passwordAPI.php?";//userid= ? &password=?";



static NSInteger const APILOGIN    = 1000;
static NSInteger const APISUBTRACK  = 1001;
static NSInteger const APISUBMITCASE  = 1002;
static NSInteger const APIUPDATEPHONE = 1003;
static NSInteger const APIUPDATEPASSWORD = 1004;

#endif