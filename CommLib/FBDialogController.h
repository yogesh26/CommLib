//
//  FBDialogController.h
//  CommonLib
//  Adapted from
///////////////////////////////////////////
//  FBFun
//
//  Created by Ray Wenderlich on 7/13/10.
//  Copyright 2010 Ray Wenderlich. All rights reserved.
////////////////////////////////////////////
//  by Yogesh Kumar on 2013/12/08.
//  Copyright (c) 2013 Yogesh Kumar. All rights reserved.
//

#import <UIKit/UIKit.h>



#import <UIKit/UIKit.h>

@protocol FBLoginDialogDelegate
- (void)accessTokenFound:(NSString *)apiKey;
- (void)displayRequired;
- (void)closeTapped;
@end

@interface FBDialogController : UIViewController <UIWebViewDelegate> {
    UIWebView *_webView;
    NSString *_apiKey;
    NSString *_requestedPermissions;
    id <FBLoginDialogDelegate> _delegate;
}

@property (retain) IBOutlet UIWebView *webView;
@property (copy) NSString *apiKey;
@property (copy) NSString *requestedPermissions;
@property (retain) id <FBLoginDialogDelegate> delegate;

- (id)initWithAppId:(NSString *)apiKey requestedPermissions:(NSString *)requestedPermissions delegate:(id<FBLoginDialogDelegate>)delegate;
- (IBAction)closeTapped:(id)sender;
- (void)login;
- (void)logout;

-(void)checkForAccessToken:(NSString *)urlString;
-(void)checkLoginRequired:(NSString *)urlString;

@end
