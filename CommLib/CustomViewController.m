//
//  CustomViewController.m
//  ScrollTest
//
//  Created by Yogesh Kumar on 2014/01/26.
//  Copyright (c) 2014 Yogesh Kumar. All rights reserved.
//

#import "CustomViewController.h"
#import "RegistrationViewController.h"
#import "UserCredentials.h"

@interface CustomViewController ()

@end

@implementation CustomViewController
@synthesize  m_strUsrNm, m_strPsw,m_lblAuthStatus,m_lblErrDesc,m_scrollView,regViewController,m_usrCred, m_bFieldScrollOffset, m_btnAuthButton,m_btnRegButton;


- (void) loadView
{
//    m_scrollView.frame = CGRectMake(0, 40, 320, 420);
//    [m_scrollView setContentSize:CGSizeMake(320,720)];
//    m_scrollView.delegate = self;
//    m_scrollView.scrollEnabled = YES;
//    //[scroll setContentSize:CGSizeMake(containerViewOfRecurrence.frame.size.width, 1000)];
//    m_scrollView.pagingEnabled = NO;
//    m_scrollView.delegate      = self;
//    m_scrollView.scrollEnabled = YES;
//    m_scrollView.clipsToBounds = YES;
//    
//    [self.m_scrollView setContentInset:UIEdgeInsetsMake(0, 0, 300, 0)];
//    
//    self.m_scrollView.translatesAutoresizingMaskIntoConstraints= NO;
//    
//    
//    m_scrollView.backgroundColor = [UIColor orangeColor];
//    [self.view addSubview:self.m_scrollView];
    
    
    
    if(self.m_scrollView==nil){
        
        self.m_scrollView = [[UIScrollView alloc] initWithFrame: [[UIScreen mainScreen] applicationFrame]];
        self.m_scrollView.backgroundColor = [UIColor whiteColor];
        self.view = self.m_scrollView;
        CGFloat x = self.m_scrollView.bounds.origin.x,y = self.m_scrollView.bounds.origin.y, width = self.m_scrollView.bounds.size.width, height = self.m_scrollView.bounds.size.height, horzSep = width/10, vertSep=height/10;
        
        
        //add user name field
        
        UILabel *lab = [UILabel new];
        lab.text = [NSString stringWithFormat:@"User name"];
        [lab sizeToFit];
        CGRect labelsFrame = lab.frame;
        labelsFrame.origin = CGPointMake(x + horzSep,y + (vertSep * 2));
        lab.frame = labelsFrame;
        [self.m_scrollView addSubview:lab];
        
        m_strUsrNm = [UITextField new];
        CGRect frm = m_strUsrNm.frame;
        frm.origin = CGPointMake(labelsFrame.origin.x + labelsFrame.size.width ,y + (vertSep * 2));
        frm.size.width = width * 0.6;
        frm.size.height = 20;
        m_strUsrNm.frame = frm;
        //m_strUsrNm.backgroundColor = [UIColor redColor];
        m_strUsrNm.borderStyle = UITextBorderStyleRoundedRect;
        CGSize sz=self.m_scrollView.bounds.size;
        sz.height = y;
        self.m_scrollView.contentSize = sz;
        self.m_strUsrNm.delegate = self;
        
        //add psw field
        lab = [UILabel new];
        lab.text = [NSString stringWithFormat:@"Password"];
        [lab sizeToFit];
        labelsFrame = lab.frame;
        labelsFrame.origin = CGPointMake(x + horzSep,y + (vertSep * 2) + vertSep);
        lab.frame = labelsFrame;
        [self.m_scrollView addSubview:lab];
        
        m_strPsw = [UITextField new];
        frm = m_strPsw.frame;
        frm.origin = CGPointMake(self.m_strUsrNm.frame.origin.x,y + (vertSep * 2) + vertSep);
        frm.size.width = width * 0.6;
        frm.size.height = 20;
        m_strPsw.frame = frm;
        //m_strPsw.backgroundColor = [UIColor redColor];
        m_strPsw.borderStyle = UITextBorderStyleRoundedRect;
        sz=self.m_scrollView.bounds.size;
        sz.height = y;
        self.m_scrollView.contentSize = sz;
        self.m_strPsw.delegate = self;
        
        
        //addbuttons now
        m_btnAuthButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        frm = m_btnAuthButton.frame;
        frm.origin = CGPointMake(self.m_strUsrNm.frame.origin.x,self.m_strPsw.frame.origin.y+ self.m_strPsw.frame.size.height+ vertSep);
        frm.size.width = width * 0.6;
        frm.size.height = 20;
        m_btnAuthButton.frame = frm;
        //m_strPsw.backgroundColor = [UIColor redColor];
        //m_btnAuthButton.buttonType = UIButtonTypeRoundedRect;
        sz=self.m_scrollView.bounds.size;
        sz.height = y;
        [self.m_btnAuthButton setTitle:@"Login" forState:UIControlStateNormal];
        //[self.m_btnAuthButton sizeToFit];
        [self.m_scrollView addSubview:self.m_btnAuthButton];
         m_btnAuthButton.backgroundColor = [UIColor grayColor];
        //self.m_btnAuthButton.set = self;
        [self.m_btnAuthButton addTarget:self action:@selector(AuthoriseUser:)
    forControlEvents:UIControlEventTouchUpInside];
        
        //we need to provide the content size in order to make the scrollview scrollable
        [self.m_scrollView setContentSize:CGSizeMake(320,720)];
        
        UITabBarItem * tabItem = [self tabBarItem];
        [tabItem setTitle:@"Login"];
        UIImage * img = [UIImage imageNamed:@"111-user.png"];
        if(img){
            [tabItem setImage:img];
        }
        [self.m_scrollView addSubview:self.m_strPsw];
        [self.m_scrollView addSubview:self.m_strUsrNm];
        
    }
    
}


- (void)viewDidLoad
{
       //self.view = self.m_scrollView;
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    //self.view.backgroundColor = [UIColor orangeColor];
    
    
}

- (void) viewWillAppear
{
    //reduce the view size by the height captured by keyboard
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)RegisterUser:(id)sender{
    NSString * tmp = m_usrCred.strUsrNm;
    if(self.regViewController==nil){
        self.regViewController = [[RegistrationViewController alloc] initWithNibName:@"RegistrationViewController" bundle:NULL];
        [self.navigationController pushViewController:self.regViewController animated:YES];
    }else{
        [self.navigationController pushViewController:self.regViewController animated:YES];
    }
    
}
- (void)AuthoriseUser: (id) sender{
    
    m_usrCred = (UserCredentials*)[UserCredentials getInstance];
    NSLog(@"The user name now is = %@", m_usrCred.strUsrNm);
    if(  [self.m_strUsrNm.text length]==0){
        UIAlertView * msgBox = [[UIAlertView alloc]
								initWithTitle:@"Error"
								message:@"User name can not be blank, please check the input"
								delegate:nil
								cancelButtonTitle:nil
								otherButtonTitles:@"OK",nil];
        [msgBox show];
        return;
    }
    
    if([m_usrCred.strUsrNm isEqualToString:self.m_strUsrNm.text] && [m_usrCred.strPsw isEqualToString:self.m_strPsw.text]){
        UIAlertView * msgBox = [[UIAlertView alloc]
								initWithTitle:@"Congrats"
								message:@"You are authorised"
								delegate:nil
								cancelButtonTitle:nil
								otherButtonTitles:@"OK",nil];
        [msgBox show];
        return;
    }
    m_usrCred.strUsrNm = [NSString stringWithString:self.m_strUsrNm.text];
    m_usrCred.strPsw = [NSString stringWithString:self.m_strPsw.text];
    m_usrCred.bIsUsrOK = false;
    NSString * strOP = [m_usrCred doesUserExist];
    
    //[m_usrCred authUser];
    //NSString * strOP = [m_usrCred strCallStatus];
    NSLog(@"Returned status =%@", strOP);
	if([strOP isEqualToString:@"MYSQL_USER_AUTHORISED"])
	{
		UIAlertView * msgBox = [[UIAlertView alloc]
								initWithTitle:@"Congrats"
								message:@"You are authorised"
								delegate:nil
								cancelButtonTitle:nil
								otherButtonTitles:@"OK",nil];
        [msgBox show];
		
        //[self PersistUser];
        m_usrCred.bIsUsrOK = true;
        //[self performSegueWithIdentifier:@"transaction" sender:self];
        
	}
	else if([strOP isEqualToString:@"MYSQL_USER_NOT_AUTHORISED"])
	{
		UIAlertView * msgBox = [[UIAlertView alloc]
								initWithTitle:@"oops"
								message:@"You are not authorised"
								delegate:self
								cancelButtonTitle:@"OK"
								otherButtonTitles:nil,nil];
		[msgBox show];
        //UsrCredentials * ptrUsrCred =[UsrCredentials sharedCredManager];
        [m_usrCred resetDefaults];
        m_usrCred.bIsUsrOK = false;
        return;
		
	}
	else {
		UIAlertView * msgBox = [[UIAlertView alloc]
								initWithTitle:@"Error"
								message:@"System error, couldnt connect to server!"
								//message:postMsg
								//message:strOP
								delegate:self
								cancelButtonTitle:@"OK"
								otherButtonTitles:nil,nil];
		[msgBox show];
        //		UsrCredentials * ptrUsrCred =[UsrCredentials sharedCredManager];
        //        ptrUsrCred.strUsrNm = @"";
        //        ptrUsrCred.strPsw = @"";
        //        ptrUsrCred.bIsUsrOK = false;
        return;
		
	}
    
    NSLog(@"Authorization called");
    
}


//register the keyboard show and hide functions

- (void) viewWillAppear:(BOOL)animated{
	//notify that there is exists a function for keyboard showing
	[[NSNotificationCenter defaultCenter]
	 addObserver:self
	 selector:@selector(kbDidAppear:)
	 name:UIKeyboardDidShowNotification
	 object:self.view.window];
	
	//notify that there is a functions for keyboard dismiss
	[[NSNotificationCenter defaultCenter]
	 addObserver:self
	 selector:@selector(kbDidHide:)
	 name:UIKeyboardDidHideNotification
	 object:nil];
}

- (void) viewWillDisappear:(BOOL)animated{
	//notify that there is exists a function for keyboard showing
	[[NSNotificationCenter defaultCenter]
	 removeObserver:self
	 name:UIKeyboardWillShowNotification
	 object:nil];
	
	//notify that there is a functions for keyboard dismiss
	[[NSNotificationCenter defaultCenter]
	 removeObserver:self
	 name:UIKeyboardWillHideNotification
	 object:nil];
}


//add the delegates for different text fields editions

//return the keybord
-(BOOL) textFieldShouldReturn:(UITextField *) textFieldView{
	[textFieldView resignFirstResponder];
	return NO;
}
//for editing begin
-(void) textFieldDidBeginEditing:(UITextField *) textFieldView{
	currFocusedField = textFieldView;
}
//for editing end
-(void) textFieldDidEndEditing:(UITextField *) textFieldView{
	currFocusedField = nil;
}

//keyboard handling functions now

-(void) kbDidAppear:(NSNotification *) notification{
	if(m_bkbShow) return;
	
	//find the size that is captured by keyboard height
	NSDictionary * info = [notification userInfo];
	NSValue * val = [info objectForKey:UIKeyboardFrameEndUserInfoKey];
	//CGRect kbRect = [self.view convertRect:[val CGRectValue] fromView:nil];
	CGRect kbRect = [self.m_scrollView convertRect:[val CGRectValue] fromView:self.m_scrollView];
	//reduce the view size by the height captured by keyboard
	CGRect viewFrame = [m_scrollView frame];
	//viewFrame.size.height -= (kbRect.size.height - 40) ;
    //viewFrame.origin.y = viewFrame.origin.y + 40;
	
	//now lastly scroll down to the frame by the postion focused by the user on the screen
	CGRect textFieldRect = [currFocusedField frame];
    
    CGRect txtRect = [self.m_scrollView convertRect:textFieldRect fromView:self.m_scrollView];
    
    //adjust it to accomodate the navigation bar's height
	if(textFieldRect.origin.y  > kbRect.origin.y  ){
        m_iFieldScrollOffset = (textFieldRect.origin.y - kbRect.origin.y) + textFieldRect.size.height;
        viewFrame.origin.y -= m_iFieldScrollOffset;
    }
    rctCurrentFocussedField = txtRect;
    
    m_scrollView.frame = viewFrame;
	
    
	[m_scrollView scrollRectToVisible:textFieldRect animated:YES];
	
	//record that kb is on
	m_bkbShow = YES;
	
}

-(void) kbDidHide:(NSNotification *) notification{
	//record that kb is off
	
	//find the size that is captured by keyboard height
	NSDictionary * info = [notification userInfo];
	NSValue * val = [info objectForKey:UIKeyboardFrameEndUserInfoKey];
	CGRect kbRect = [self.view convertRect:[val CGRectValue] fromView:nil];
	
	//reduce the view size by the height captured by keyboard
	CGRect viewFrame = [m_scrollView frame];
	//viewFrame.size.height += (kbRect.size.height-40);
    
    
   
    
    
    
	m_scrollView.frame = viewFrame;
    
	[m_scrollView scrollRectToVisible:rctCurrentFocussedField animated:YES];
	
    m_iFieldScrollOffset = 0;
    
    m_bkbShow = NO;
	
}


@end
