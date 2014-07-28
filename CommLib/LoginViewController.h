//
//  LoginViewController.h
//  LoginLib
//
//  Created by Yogesh Kumar on 2013/09/24.
//  Copyright (c) 2013 Yogesh Kumar. All rights reserved.
//

#import <UIKit/UIKit.h>
@class RegistrationViewController;
@interface LoginViewController : UIViewController{
    IBOutlet UITextField *m_strUsrNm;
    IBOutlet UITextField *m_strPsw;
    IBOutlet UILabel *m_lblAuthStatus;
    IBOutlet UILabel *m_lblErrDesc;
    //delcare the vaiables to handle keyboard scrolling
    BOOL m_bkbShow;
    UITextField * currFocusedField;
    IBOutlet UIScrollView * m_scrollView;
    RegistrationViewController * regViewController;
    
}
@property (nonatomic, strong) UITextField *m_strUsrNm;
@property (nonatomic, retain) UITextField *m_strPsw;
@property (nonatomic, retain) UILabel *m_lblAuthStatus;
@property (nonatomic, retain) UILabel *m_lblErrDesc;
@property (nonatomic, retain) UIScrollView * m_scrollView;
@property (nonatomic, retain) RegistrationViewController * regViewController;
//check if the user is authorised
- (IBAction)AuthoriseUser: (id) sender;
- (IBAction)RegisterUser: (id) sender;
@end
