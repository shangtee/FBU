//
//  INLloginView.m
//  Inlink
//
//  Created by Lillian Choung on 7/8/14.
//  Copyright (c) 2014 Inlink. All rights reserved.
//

#import "INLloginView.h"
#import <QuartzCore/QuartzCore.h> //Image Framework

@implementation INLloginView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {

        UITextField *username = [[UITextField alloc]initWithFrame:CGRectMake(100, 210, 120, 22)];
        username.text = @"username";
        username.borderStyle = UITextBorderStyleRoundedRect;
        username.clearsOnBeginEditing = YES;
        [self addSubview: username];
        
        UITextField *password= [[UITextField alloc]initWithFrame:CGRectMake(100, 240, 120, 22)];
        password.text = @"password";
        password.borderStyle = UITextBorderStyleRoundedRect;
        password.clearsOnBeginEditing = YES;
        [self addSubview: password];
        
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
