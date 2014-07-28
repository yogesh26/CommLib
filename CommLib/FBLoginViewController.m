//
//  FBLoginViewController.m
//  CommonLib
//
//  Created by Yogesh Kumar on 2013/12/08.
//  Copyright (c) 2013 Yogesh Kumar. All rights reserved.
//

#import "FBLoginViewController.h"

@implementation FBLoginViewController
@synthesize loginStatusLabel = _loginStatusLabel;
@synthesize loginButton = _loginButton;
@synthesize loginDialog = _loginDialog;
@synthesize loginDialogView = _loginDialogView;

#pragma mark Main

- (void)dealloc {
    self.loginStatusLabel = nil;
    self.loginButton = nil;
    self.loginDialog = nil;
    self.loginDialogView = nil;
 
}

- (void)refresh {
    if (_loginState == LoginStateStartup || _loginState == LoginStateLoggedOut) {
        _loginStatusLabel.text = @"Not connected to Facebook";
        [_loginButton setTitle:@"Login" forState:UIControlStateNormal];
        _loginButton.hidden = NO;
    } else if (_loginState == LoginStateLoggingIn) {
        _loginStatusLabel.text = @"Connecting to Facebook...";
        _loginButton.hidden = YES;
    } else if (_loginState == LoginStateLoggedIn) {
        _loginStatusLabel.text = @"Connected to Facebook";
        [_loginButton setTitle:@"Logout" forState:UIControlStateNormal];
        _loginButton.hidden = NO;
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [self refresh];
}

#pragma mark Login Button

- (IBAction)loginButtonTapped:(id)sender {
    
    //NSString *appId = @"8fa673a06891cac667e55d690e27ecbb";
    NSString *appId = @"205432426144852";
    NSString *permissions = @"basic_info";
    
    if (_loginDialog == nil) {
        self.loginDialog = [[FBDialogController alloc] initWithAppId:appId requestedPermissions:permissions delegate:self ];
        self.loginDialogView = _loginDialog.view;
    }
    
    if (_loginState == LoginStateStartup || _loginState == LoginStateLoggedOut) {
        _loginState = LoginStateLoggingIn;
        [_loginDialog login];
    } else if (_loginState == LoginStateLoggedIn) {
        _loginState = LoginStateLoggedOut;
        [_loginDialog logout];
    }
    
    [self refresh];
    
}

#pragma mark FBFunLoginDialogDelegate

- (void)accessTokenFound:(NSString *)apiKey {
    NSLog(@"Access token found: %@", apiKey);
    _loginState = LoginStateLoggedIn;
    [self dismissModalViewControllerAnimated:YES];
    [self refresh];
}

- (void)displayRequired {
    [self presentModalViewController:_loginDialog animated:YES];
}

- (void)closeTapped {
    [self dismissModalViewControllerAnimated:YES];
    _loginState = LoginStateLoggedOut;
    [_loginDialog logout];
    [self refresh];
}

@end
