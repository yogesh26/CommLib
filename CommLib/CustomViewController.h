//
//  CustomViewController.h
//  ScrollTest
//
//  Created by Yogesh Kumar on 2014/01/26.
//  Copyright (c) 2014 Yogesh Kumar. All rights reserved.
//

#import <UIKit/UIKit.h>
@class RegistrationViewController;
@class UserCredentials;

@interface CustomViewController : UIViewController{
    UITextField *m_strUsrNm;
    UITextField *m_strPsw;
    UILabel *m_lblAuthStatus;
    UILabel *m_lblErrDesc;
    UIButton * m_btnAuthButton;
    UIButton * m_btnRegButton;
    //delcare the vaiables to handle keyboard scrolling
    BOOL m_bkbShow;
    int m_iFieldScrollOffset;
    UITextField * currFocusedField;
    UIScrollView * m_scrollView;
    RegistrationViewController * regViewController;
    UserCredentials * m_usrCred;
    CGRect  rctCurrentFocussedField;
    
}
@property (nonatomic, strong) UITextField *m_strUsrNm;
@property (nonatomic, retain) UITextField *m_strPsw;
@property (nonatomic, retain) UILabel *m_lblAuthStatus;
@property (nonatomic, retain) UILabel *m_lblErrDesc;
@property (nonatomic, retain) UIScrollView * m_scrollView;
@property (nonatomic, retain) RegistrationViewController * regViewController;
@property (retain, nonatomic) UserCredentials * m_usrCred;
@property (nonatomic, readwrite) int m_bFieldScrollOffset;
@property (nonatomic, retain) UIButton * m_btnAuthButton;
@property (nonatomic, retain) UIButton * m_btnRegButton;
//check if the user is authorised
- (void)AuthoriseUser: (id) sender;
- (void)RegisterUser: (id) sender;

@end
