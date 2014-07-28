//
//  HomeViewControlleriPhone.m
//  LoginLib
//
//  Created by Yogesh Kumar on 2013/10/03.
//  Copyright (c) 2013 Yogesh Kumar. All rights reserved.
//

#import "HomeViewControlleriPhone.h"

@interface HomeViewControlleriPhone ()

@end

@implementation HomeViewControlleriPhone

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
            UITabBarItem * tabItem = [self tabBarItem];
            [tabItem setTitle:@"Home"];
        UIImage * img = [UIImage imageNamed:@"53-house.png"];
        if(img){
            [tabItem setImage:img];
        }
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
