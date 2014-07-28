//
//  FBLoginViewController.h
//  CommonLib
//
//  Created by Yogesh Kumar on 2013/12/08.
//  Copyright (c) 2013 Yogesh Kumar. All rights reserved.
//

#import <UIKit/UIKit.h>


#import <UIKit/UIKit.h>
#import "FBDialogController.h"

typedef enum {
    LoginStateStartup,
    LoginStateLoggingIn,
    LoginStateLoggedIn,
    LoginStateLoggedOut
} LoginState;

@interface FBLoginViewController : UIViewController <FBLoginDialogDelegate> {
    UILabel *_loginStatusLabel;
    UIButton *_loginButton;
    LoginState _loginState;
    FBDialogController *_loginDialog;
    UIView *_loginDialogView;
}

@property (retain) IBOutlet UILabel *loginStatusLabel;
@property (retain) IBOutlet UIButton *loginButton;
@property (retain) FBDialogController *loginDialog;
@property (retain) IBOutlet UIView *loginDialogView;

- (IBAction)loginButtonTapped:(id)sender;

@end