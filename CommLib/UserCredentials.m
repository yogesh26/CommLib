//
//  UserCredentials.m
//  CommonLib
//
//  Created by Yogesh Kumar on 2013/10/19.
//  Copyright (c) 2013 Yogesh Kumar. All rights reserved.
//

#import "UserCredentials.h"
#import <UIKit/UIKit.h>

static UserCredentials *sharedCredManager = nil;

@implementation UserCredentials

@synthesize strUsrNm,strPsw, bIsUsrOK, m_dictUsrDet,m_mutableData, strCnum,strEmail,strlNm,strfNm,strOperation,iOperation,bIsLoginValidated,m_accID,strBaseURL,strLoginType, strCallStatus;

#pragma mark Singleton Methods
+ (id) getInstance: (NSString*) strPath {
    @synchronized(self) {
        if (sharedCredManager == nil)
            sharedCredManager = [[self alloc] init:strPath];
    }
    return sharedCredManager;
}

+ (id) getInstance{
    @synchronized(self) {
        if (sharedCredManager == nil)
            sharedCredManager = [[self alloc] init];
    }
    return sharedCredManager;
}

- (id)init {
    if (self = [super init]) {
        NSBundle * thisBundle = [NSBundle mainBundle] ;
        NSString * strBundlePath = [thisBundle bundlePath];
        NSString    * origPath = [[NSBundle mainBundle] pathForResource:@"UserProp" ofType:@"plist"];
        //NSLog(@"%@", origPath);
        NSString * path1 = nil;
        path1 = (NSString *) [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0] ;//]stringByAppendingPathComponent:@"UserProp.plist"];
        NSString * path = [path1 stringByAppendingPathComponent:@"UserProp.plist"];
        //NSLog(@"%@", path);
        
        if([[NSFileManager defaultManager] fileExistsAtPath:path] == NO)
        {
            NSError *error = nil;
            if([[NSFileManager defaultManager] copyItemAtPath:origPath toPath:path error:&error])
            {
                
            } else {
                NSLog(@"Error description-%@ \n", [error localizedDescription]);
                NSLog(@"Error reason-%@", [error localizedFailureReason]);
            }
            
        }
        else if([[NSFileManager defaultManager] fileExistsAtPath:path] == YES)
        {
            /*NSError * error=nil;
             [[NSFileManager defaultManager] removeItemAtPath:path error:&error];
             
             //NSError *error = nil;
             if(nil != error){
             NSLog(@"Error Removing the existing plist file. Description -%@ \n", [error localizedDescription]);
             NSLog(@"Error reason-%@", [error localizedFailureReason]);
             
             }else{
             if([[NSFileManager defaultManager] copyItemAtPath:origPath toPath:path error:&error])
             {
             
             } else {
             NSLog(@"Error description-%@ \n", [error localizedDescription]);
             NSLog(@"Error reason-%@", [error localizedFailureReason]);
             }
             }*/
        }
        //NSDictionary * userCred1 = [NSDictionary dictionaryWithContentsOfFile:origPath];
        NSDictionary * userCred = [NSDictionary dictionaryWithContentsOfFile:path];
        if(userCred){
            strUsrNm = [NSMutableString stringWithString:[userCred valueForKey:@"usrnm"]];
            strPsw   = [NSMutableString stringWithString:[userCred valueForKey:@"psw"]];
            strfNm   = [NSMutableString stringWithString:[userCred valueForKey:@"fName"]];
            strlNm   = [NSMutableString stringWithString:[userCred valueForKey:@"lName"]];
            strEmail = [NSMutableString stringWithString:[userCred valueForKey:@"email"]];
            strCnum  = [NSMutableString stringWithString:[userCred valueForKey:@"cnum"]];
            strBaseURL = [NSMutableString stringWithString:[userCred valueForKey:@"baseServerURL"]];
            strLoginType = [NSMutableString stringWithString:[userCred valueForKey:@"loginType"]];
        }
        else{
            [self showErrorMsg:@"Property file could not be found. Returning."];
            bBenLoaded = false;
            return self;
        }
        //serviceCaller = [[ServiceCaller alloc] init];
        [self authUser];
        bIsLoginValidated = false;
    }
    return self;
}

- (id)init: (NSString*) strPath {
    if (self = [super init]) {
                //NSDictionary * userCred1 = [NSDictionary dictionaryWithContentsOfFile:origPath];
        NSDictionary * userCred = [NSDictionary dictionaryWithContentsOfFile:strPath];
        if(userCred){
            strUsrNm = [NSMutableString stringWithString:[userCred valueForKey:@"usrnm"]];
            strPsw   = [NSMutableString stringWithString:[userCred valueForKey:@"psw"]];
            strfNm   = [NSMutableString stringWithString:[userCred valueForKey:@"fName"]];
            strlNm   = [NSMutableString stringWithString:[userCred valueForKey:@"lName"]];
            strEmail = [NSMutableString stringWithString:[userCred valueForKey:@"email"]];
            strCnum  = [NSMutableString stringWithString:[userCred valueForKey:@"cnum"]];
            strBaseURL = [NSMutableString stringWithString:[userCred valueForKey:@"baseServerURL"]];
            strLoginType = [NSMutableString stringWithString:[userCred valueForKey:@"loginType"]];
        }
        else{
            [self showErrorMsg:@"Property file could not be found. Returning."];
            bBenLoaded = false;
            return self;
        }
        
        [self authUser];
        bIsLoginValidated = false;
    }
    return self;
}

- (void) resetDefaults{
    strUsrNm =@"";
    strPsw   =@"";
    strCnum  =@"";
    strlNm   =@"";
    strEmail =@"";
    strfNm   =@"";
    m_accID  = -1;
    strLoginType = @"";
    //strBaseURL = @"";
}

- (NSString*) doesUserExist{
    
    NSString * postMsg = [NSString stringWithFormat:@"action=IsUserAuth&username=%@&pwd=%@",strUsrNm, strPsw];
    //NSString * postMsg = [NSString stringWithFormat:@"ios=1&username=%@&password=%@",strUsrNm, strPsw];
	NSData * postData = [postMsg dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:NO];
	NSString * HostURL = [NSString stringWithString:self.strBaseURL];
    HostURL = [HostURL  stringByAppendingString: @"/modules/Transaction.php?"];
	NSURL *url = [NSURL URLWithString:HostURL];
	NSLog(@"DoesUSerExist being tried, msg=%@",postMsg);
    NSLog(@"DoesUSerExist being tried, usrl=%@",HostURL);
	NSMutableURLRequest * req = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
	
	[req setHTTPMethod:@"POST"];
	[req setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
	[req setHTTPBody:postData ];
	NSURLResponse * resp;
	
	//HostURL = [HostURL stringByAppendingString:postMsg];
	NSData * dataReceived = [NSURLConnection sendSynchronousRequest:req returningResponse:&resp error:nil];
	
	NSString * strOP = [[NSString alloc] initWithData:dataReceived encoding:NSASCIIStringEncoding];
    NSLog(@"Data received is = %@",strOP);
    
    if([strOP isEqualToString:@"MYSQL_USER_AUTHORISED"])
	{
		bIsUsrOK    = true;
        [self getDatafromURLDBTable:@"accounts"];
        
	}
	else
    {
		bIsUsrOK    = false;
        [self resetDefaults];
	}
    
    return strOP;
    
}

-(void) authUser{
    serviceCaller = [[ServiceCaller alloc] init];
    
    strCallStatus = @"TRYING_AUTHORIZATION";
    NSString * tmp1 = [NSString stringWithString:[NSString stringWithFormat:@"action=IsUserAuth&username=%@&pwd=%@",self.strUsrNm, self.strPsw]];
    NSLog(@"%@",tmp1);
    NSString * postMsg = [NSString stringWithString:tmp1];
	NSData * postData = [postMsg dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:NO];
	
	NSString * HostURL = [NSString stringWithString:self.strBaseURL];
    HostURL = [HostURL  stringByAppendingString: @"/modules/Transaction.php?"];
	NSLog(@"URL being tried = %@",HostURL);
    [serviceCaller postToUrl:HostURL
                    withBody:postData withCallback:^(NSMutableData *response) {
                        
                        bIsLoginValidated = true;
                        
                        NSString * strOP = [[NSString alloc] initWithData:response encoding:NSASCIIStringEncoding];
                        NSLog(@"Received status = %@",strOP);
                        strCallStatus = strOP;
                        if([strOP isEqualToString:@"MYSQL_USER_AUTHORISED"])
                        {
                            bIsUsrOK    = true;
                            
                        }
                        else
                        {
                            bIsUsrOK    = false;
                            [self resetDefaults];
                        }
                        
                    }];
    
}



-(void) connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse*)response{
    
    
}

-(void) connection:(NSURLConnection *)connection didReceiveData:(NSData*)data{
	
    
	
}

-(void) connectionDidFinishLoading:(NSURLConnection *)connection{
	
}
-(void) connection:(NSURLConnection*) connection didFailWithError:(NSError *) error{
	// inform the user
    UIAlertView *errorView = [[UIAlertView alloc] initWithTitle:@"Failure" message:[error localizedDescription] delegate:nil cancelButtonTitle:@"Dismiss" otherButtonTitles:nil];
    [errorView show];
    
}

- (void) getDatafromURLDBTable:(NSString *)strOp{
    self.iOperation = 0;
    
    SCNetworkReachabilityFlags flags;
    SCNetworkReachabilityRef reachability =
    SCNetworkReachabilityCreateWithName(NULL, [strBaseURL UTF8String]);
    SCNetworkReachabilityGetFlags(reachability, &flags);
    //The reachability flags are a bitwise set of f"lags
    //that contain the information about
    // connection availability
    BOOL reachable = ! (flags & kSCNetworkReachabilityFlagsConnectionRequired);
    //NSURLConnection *conn;
    //NSURL *url = [NSURL URLWithString:strBaseURL];
    
    //NSURLRequest *request = [NSURLRequest
    //                         requestWithURL:url];
    //if ([NSURLConnection canHandleRequest:request] && reachable)
    if (reachable)
    {
        /*       NSString * postMsg = [NSString stringWithFormat:@"first_name="];
         postMsg = [postMsg stringByAppendingString:strOp];//aUsers"];
         strOperation = [NSString    stringWithString:strOp];
         
         NSData * postData = [postMsg dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:NO];
         
         NSString * HostURL = [NSString stringWithString:self.strBaseURL];
         HostURL = [HostURL  stringByAppendingString: @"/GetTableData.php"];
         
         NSURL *url = [NSURL URLWithString:HostURL];
         //NSLog(postMsg);
         NSMutableURLRequest * req = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
         
         [req setHTTPMethod:@"POST"];
         [req setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
         [req setHTTPBody:postData ];
         
         conn = [NSURLConnection connectionWithRequest:req delegate:self];
         if (conn)
         {
         //NSLog(@"Connection to the website has been established. Please wait while contents are being downloaded.");
         self.m_mutableData = [NSMutableData data];
         }
         */
        
        NSString * postMsg = [NSString stringWithFormat:@"first_name="];
        postMsg = [postMsg stringByAppendingString:strOp];//aUsers"];
        strOperation = [NSString    stringWithString:strOp];
        
        NSData * postData = [postMsg dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:NO];
        
        NSString * HostURL = [NSString stringWithString:self.strBaseURL];
        HostURL = [HostURL  stringByAppendingString: @"/GetTableData.php"];
        
        [serviceCaller postToUrl:HostURL
                        withBody:postData withCallback:^(NSMutableData *response) {
                            
                            //self.m_mutableData = [self.m_mutableData copy];
                            NSError* error;
                            self.m_dictUsrDet = [NSJSONSerialization
                                                 JSONObjectWithData:response //1
                                                 options:kNilOptions
                                                 error:&error];
                            NSArray* users = [m_dictUsrDet objectForKey:@"izuks_user"]; //2
                            
                            int x = [users count];
                            if(x < 1)
                                return;
                            NSDictionary * currRecord = (NSDictionary *)[users  objectAtIndex:0];
                            
                            self.strfNm = [currRecord valueForKey:@"FirstNm"];
                            self.strlNm= [currRecord valueForKey:@"LastNm"];
                            self.strEmail= [currRecord valueForKey:@"emailID"];
                            self.strCnum = [currRecord valueForKey:@"contactNum"];
                            
                        }];
    }
}

- (void) getUserDetailedInfo{
    [self getDatafromURLDBTable:@"accounts"];
}

- (void)dealloc {
    // Should never be called, but just here for clarity really.
}

-(void) showErrorMsg:(NSString *)msg  {
	// inform the user
    UIAlertView *errorView = [[UIAlertView alloc] initWithTitle:@"Failure" message:msg delegate:nil cancelButtonTitle:@"Dismiss" otherButtonTitles:nil];
    [errorView show];
    
}


@end