//
//  LoginView.m
//  LoginLib
//
//  Created by Yogesh Kumar on 2013/09/28.
//  Copyright (c) 2013 Yogesh Kumar. All rights reserved.
//

#import "LoginView.h"
#import "LoginViewDefines.h"
@implementation LoginView
@synthesize loginViewBackGround,loginViewFont,loginViewFontName,loginViewFontSize,loginViewFontBackGround,loginViewFontForeGround,loginViewTitleLabel,loginViewContainerFrame;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        // Initialization code
    }
    return self;
}

-(void) setFont:(NSString*) fontType fontColor:(UIColor*) thisColor fontSize:(float) thisSize{
    loginViewFontForeGround = thisColor;
    loginViewFontSize=thisSize;
    loginViewFont = [UIFont fontWithName:fontType size:thisSize ];
}

-(void) updateContainerFrame:(CGRect) thisFrame{
    self.frame = thisFrame;
}
-(void) addControls{
    NSLog(@"width=%d height=%d",(int)self.frame.size.width, (int)self.frame.size.height);
    // Do any additional setup after loading the view, typically from a nib.
    int vertPadding = (self.frame.size.height/self.frame.size.width)*FRAME_PADDING;
     UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(FRAME_PADDING, vertPadding, (self.frame.size.width-(FRAME_PADDING*2)) , self.frame.size.height-(2*vertPadding))];
    [label setFont:loginViewFont];
    label.textColor = loginViewFontForeGround;//[UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.75];
    label.backgroundColor = [UIColor grayColor];
    label.text = @"Login View From SPC LoginFrameWork";
    [self addSubview:label];

}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    NSLog(@"draw called");
    [self clearsContextBeforeDrawing];
    [self addControls];
    
}


@end
