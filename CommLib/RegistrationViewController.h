//
//  RegistrationViewController.h
//  CommonLib
//
//  Created by Yogesh Kumar on 2013/10/19.
//  Copyright (c) 2013 Yogesh Kumar. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RegistrationViewController : UIViewController{
	IBOutlet UITextField *m_strUsrNm;
	IBOutlet UITextField *m_strPsw;
	IBOutlet UITextField *m_strConfPsw;
	IBOutlet UITextField *m_strFirstNm;
	IBOutlet UITextField *m_strLastNm;
	int						m_iGender;
	IBOutlet UITextField *m_strEmailID;
	IBOutlet UITextField *m_strContNo;
	IBOutlet UILabel *m_lblAuthStatus;
	IBOutlet UILabel *m_lblErrDesc;
	//delcare the vaiables to handle keyboard scrolling
	BOOL m_bkbShow;
	UITextField * currFocusedField;
	IBOutlet UIScrollView * m_scrollView;
	IBOutlet UISegmentedControl * m_GenderSelect;
}
//@property (nonatomic, assign) id <FlipsideViewControllerDelegate> delegate;
@property (nonatomic, retain) UITextField *m_strUsrNm;
@property (nonatomic, retain) UITextField *m_strPsw;
@property (nonatomic, retain) UITextField *m_strConfPsw;
@property (nonatomic, retain) UITextField *m_strFirstNm;
@property (nonatomic, retain) UITextField *m_strLastNm;
@property (nonatomic, retain) UISegmentedControl * m_GenderSelect;;
@property (nonatomic, retain) UITextField *m_strEmailID;
@property (nonatomic, retain) UITextField *m_strContNo;
@property (nonatomic, retain) UILabel *m_lblAuthStatus;
@property (nonatomic, retain) UILabel *m_lblErrDesc;
@property (nonatomic, retain) UIScrollView * m_scrollView;

//- (IBAction)done:(id)sender;
//check if the user is authorised
- (IBAction)AddUser: (id) sender;
//set gender
- (IBAction)SetGender: (id) sender;
//validate the values
- (bool) ValidateFieldsHelper;





@end

