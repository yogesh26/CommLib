//
//  LoginViewController.m
//  LoginLib
//
//  Created by Yogesh Kumar on 2013/09/24.
//  Copyright (c) 2013 Yogesh Kumar. All rights reserved.
//

#import "LoginViewController.h"
#import "RegistrationViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController
@synthesize  m_strUsrNm, m_strPsw,m_lblAuthStatus,m_lblErrDesc,m_scrollView,regViewController;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if(self){
        UITabBarItem * tabItem = [self tabBarItem];
        [tabItem setTitle:@"Login"];
        UIImage * img = [UIImage imageNamed:@"111-user.png"];
        if(img){
            [tabItem setImage:img];
        }
        
        
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    //self.view.backgroundColor = [UIColor orangeColor];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)RegisterUser:(id)sender{
    if(self.regViewController==nil){
        self.regViewController = [[RegistrationViewController alloc] initWithNibName:@"RegistrationViewController" bundle:NULL];
        [self.navigationController pushViewController:self.regViewController animated:YES];
    }else{
        [self.navigationController pushViewController:self.regViewController animated:YES];
    }
    
}
- (IBAction)AuthoriseUser: (id) sender{
    
    
//	UsrCredentials * ptrUsrCred =[UsrCredentials sharedCredManager];
//    if([ptrUsrCred.strUsrNm isEqualToString:self.m_strUsrNm.text] && [ptrUsrCred.strPsw isEqualToString:self.m_strPsw.text]){
//        UIAlertView * msgBox = [[UIAlertView alloc]
//								initWithTitle:@"Congrats"
//								message:@"You are authorised"
//								delegate:nil
//								cancelButtonTitle:nil
//								otherButtonTitles:@"OK",nil];
//        [msgBox show];
//        return;
//    }
//    ptrUsrCred.strUsrNm = [NSString stringWithString:self.m_strUsrNm.text];
//    ptrUsrCred.strPsw = [NSString stringWithString:self.m_strPsw.text];
//    ptrUsrCred.bIsUsrOK = false;
//    NSString * strOP = [ptrUsrCred doesUserExist];
//	if([strOP isEqualToString:@"MYSQL_USER_AUTHORISED"])
//	{
//		UIAlertView * msgBox = [[UIAlertView alloc]
//								initWithTitle:@"Congrats"
//								message:@"You are authorised"
//								delegate:nil
//								cancelButtonTitle:nil
//								otherButtonTitles:@"OK",nil];
//        [msgBox show];
//		
//        [self PersistUser];
//        ptrUsrCred.bIsUsrOK = true;
//        //[self performSegueWithIdentifier:@"transaction" sender:self];
//        
//	}
//	else if([strOP isEqualToString:@"MYSQL_USER_NOT_AUTHORISED"])
//	{
//		UIAlertView * msgBox = [[UIAlertView alloc]
//								initWithTitle:@"oops"
//								message:@"You are not authorised"
//								delegate:self
//								cancelButtonTitle:@"OK"
//								otherButtonTitles:nil,nil];
//		[msgBox show];
//        UsrCredentials * ptrUsrCred =[UsrCredentials sharedCredManager];
//        [ptrUsrCred resetDefaults];
//        ptrUsrCred.bIsUsrOK = false;
//        return;
//		
//	}
//	else {
//		UIAlertView * msgBox = [[UIAlertView alloc]
//								initWithTitle:@"Error"
//								message:@"System error, couldnt connect to server!"
//								//message:postMsg
//								//message:strOP
//								delegate:self
//								cancelButtonTitle:@"OK"
//								otherButtonTitles:nil,nil];
//		[msgBox show];
//		UsrCredentials * ptrUsrCred =[UsrCredentials sharedCredManager];
//        ptrUsrCred.strUsrNm = @"";
//        ptrUsrCred.strPsw = @"";
//        ptrUsrCred.bIsUsrOK = false;
//        return;
//		
//	}
    
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
	CGRect kbRect = [self.view convertRect:[val CGRectValue] fromView:nil];
	
	//reduce the view size by the height captured by keyboard
	CGRect viewFrame = [m_scrollView frame];
	viewFrame.size.height -= (kbRect.size.height - 40) ;
    //viewFrame.origin.y = viewFrame.origin.y + 40;
	m_scrollView.frame = viewFrame;
	
	//now lastly scroll down to the frame by the postion focused by the user on the screen
	CGRect textFieldRect = [currFocusedField frame];
    //adjust it to accomodate the navigation bar's height
	textFieldRect.origin.y = textFieldRect.origin.y;
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
	viewFrame.size.height += (kbRect.size.height-40);
    
    //    viewFrame.origin.y = viewFrame.origin.y - 40;
	m_scrollView.frame = viewFrame;
    
	//[m_scrollView scrollRectToVisible:kbRect animated:YES];
	m_bkbShow = NO;
	
}


@end
