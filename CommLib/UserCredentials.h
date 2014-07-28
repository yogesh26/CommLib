//
//  UserCredentials.h
//  CommonLib
//
//  Created by Yogesh Kumar on 2013/10/19.
//  Copyright (c) 2013 Yogesh Kumar. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Reachability.h"
#import "ServiceCaller.h"

@interface UserCredentials : NSObject{
    NSMutableString *strUsrNm;
    NSMutableString *strPsw;
    BOOL     bIsUsrOK;
    NSMutableString *strfNm;
    NSMutableString *strlNm;
    NSMutableString *strEmail;
    NSMutableString *strCnum;
    int             m_accID;
    NSDictionary    *m_dictUsrDet;
    NSMutableData * m_mutableData;
    NSMutableString * strOperation;
    int             iOperation;
    BOOL     bBenLoaded;
    BOOL     bIsLoginValidated;
    //
    NSMutableData   *m_ArrIPDataPipe;
    NSDictionary        *m_dictIPDataPipe;

    NSMutableString        *strBaseURL;
    NSMutableString        *strLoginType;
@private
    ServiceCaller *serviceCaller;
    
}
@property (nonatomic, strong) NSMutableString * strBaseURL;
@property (nonatomic, strong) NSMutableString * strLoginType;
@property (nonatomic, strong) NSMutableString *strUsrNm;
@property (nonatomic, strong) NSMutableString *strPsw;
@property (nonatomic, assign) BOOL bIsUsrOK;

@property (nonatomic, assign) BOOL bIsLoginValidated;
@property (nonatomic, strong) NSMutableString *strfNm;
@property (nonatomic, strong) NSMutableString *strlNm;
@property (nonatomic, strong) NSMutableString *strEmail;
@property (nonatomic, strong) NSMutableString *strCnum;
@property (readwrite) int     m_accID;
@property (nonatomic,strong)  NSDictionary * m_dictUsrDet;
@property (nonatomic,strong)  NSMutableData * m_mutableData;
@property (nonatomic, strong) NSMutableString *strOperation;
@property (nonatomic, strong) NSMutableString *strCallStatus;

@property (readwrite) int     iOperation;

///
//caller will need to privide fully qualified path
+ (id)        getInstance: (NSString* ) strPath;
//no path being provided
+ (id)        getInstance;
- (NSString*) doesUserExist;
- (void)      getUserDetailedInfo;
- (BOOL)      isNetwrokAvailable;
- (void)      getDatafromURLDBTable: (NSString *) strOp;
- (void)      showErrorMsg:(NSString*)msg;
- (void)      authUser;
- (void)      resetDefaults;
@end