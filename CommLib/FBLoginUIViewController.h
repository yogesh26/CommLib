//
//  FBLoginUIViewController.h
//  CommonLib
//
//  Created by Yogesh Kumar on 2013/12/26.
//  Copyright (c) 2013 Yogesh Kumar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FacebookSDK/FacebookSDK.h>
@interface FBLoginUIViewController : UIViewController <FBLoginViewDelegate>{
    IBOutlet FBProfilePictureView *profilePictureView;
    IBOutlet UILabel *nameLabel;
    IBOutlet UILabel *statusLabel;
}

@property (strong, nonatomic) IBOutlet FBProfilePictureView *profilePictureView;
@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) IBOutlet UILabel *statusLabel;
@property BOOL bIsLoggedIn;
@end
