//
//  RegistrationViewController.m
//  CommonLib
//
//  Created by Yogesh Kumar on 2013/10/19.
//  Copyright (c) 2013 Yogesh Kumar. All rights reserved.
//

#import "RegistrationViewController.h"
#import "UserCredentials.h"
@interface RegistrationViewController ()

@end


@implementation RegistrationViewController

@synthesize  m_strUsrNm, m_strPsw,m_scrollView, m_strConfPsw,
m_strFirstNm, m_strLastNm, m_GenderSelect, m_strEmailID, m_strContNo, m_lblAuthStatus, m_lblErrDesc;
// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
/*
 - (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
 self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
 if (self) {
 // Custom initialization.
 }
 return self;
 }
 */


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	//m_scrollView.frame = CGRectMake(0, 0, 320, 460);
    //[m_scrollView setContentSize:CGSizeMake(320, 460)];
    [super viewDidLoad];
}


/*
 // Override to allow orientations other than the default portrait orientation.
 - (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
 // Return YES for supported orientations.
 return (interfaceOrientation == UIInterfaceOrientationPortrait);
 }
 */

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

//- (IBAction)done:(id)sender {
//	[self.delegate flipsideViewControllerDidFinish:self];
//}

- (bool) ValidateFieldsHelper {
	int x = 1;
	if (([m_strEmailID.text length] == 0) && ([m_strContNo.text length] == 0)) {
		x = 0;
	}
	
	if([m_strUsrNm.text length] == 0 ||
	   [m_strPsw.text length] == 0 ||
	   [m_strFirstNm.text length] == 0 ||
	   [m_strLastNm.text length] == 0 ||
       x == 0 )
	{
		return false;
	}
	else {
		
		return true;
	}
	
    
}

- (IBAction)AddUser: (id) sender{
	//validate the values first
	if ([self ValidateFieldsHelper] == false) {
		UIAlertView * msgBox = [[UIAlertView alloc]
								initWithTitle:@"oops"
								message:@"Information is not provided for all the fields, please check!"
								//8message:strOP
								delegate:self
								cancelButtonTitle:@"OK"
								otherButtonTitles:nil,nil];
		[msgBox show];
        
		return;
	}
	/////////////////////////////////////
	NSString *szGdr;
	if(m_iGender == 0)
	{
		szGdr = @"0";
	}
	else
	{
		szGdr = @"1";
	}
    
	NSString * postMsg = [NSString stringWithFormat:@"action=AddUser&usrNm=%@&fNm=%@&lNm=%@&gdr=%@&psw=%@&eml=%@&lgSts=%@&cntNum=%@&rlID=%@", m_strUsrNm.text,
						  m_strFirstNm.text,m_strLastNm.text,szGdr, m_strPsw.text, m_strEmailID.text,@"0", m_strContNo.text,@"1"];
	NSLog(@"%@",postMsg);
	NSData * postData = [postMsg dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:NO];
	
    UserCredentials * ptrUsrCred =[UserCredentials getInstance];
    
    
    NSString * HostURL = [NSString stringWithString:ptrUsrCred.strBaseURL];
    
    HostURL = [HostURL  stringByAppendingString: @"/modules/Transaction.php?"];
	NSURL *url = [NSURL URLWithString:HostURL];
	//NSLog(postMsg);
	NSMutableURLRequest * req = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
	
	[req setHTTPMethod:@"POST"];
	[req setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
	[req setHTTPBody:postData ];
	NSURLResponse * resp;
	
	//HostURL = [HostURL stringByAppendingString:postMsg];
	NSData * dataReceived = [NSURLConnection sendSynchronousRequest:req returningResponse:&resp error:nil];
	
	NSString * strOP = [[NSString alloc] initWithData:dataReceived encoding:NSASCIIStringEncoding];
	if([strOP isEqualToString:@"MYSQL_SUCCESS"])
	{
		UIAlertView * msgBox = [[UIAlertView alloc]
								initWithTitle:@"Congrats"
								message:@"You are registerred. Please return and login with your credentials!"
								//8message:strOP
								delegate:self
								cancelButtonTitle:@"OK"
								otherButtonTitles:nil,nil];
		[msgBox show];
		
		
    }
	else
	{
		UIAlertView * msgBox = [[UIAlertView alloc]
								initWithTitle:@"oops"
								message:@"Could not add you to the system. Please try later!"
								delegate:self
								cancelButtonTitle:@"OK"
								otherButtonTitles:nil,nil];
		[msgBox show];
		
		
	}
	
	
}

- (IBAction)SetGender: (id) sender{
	if ([m_GenderSelect selectedSegmentIndex]==0) {
		m_iGender = 0;
	}
	else {
		m_iGender = 1;
	}
}


- (void)dealloc {
	
    
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
