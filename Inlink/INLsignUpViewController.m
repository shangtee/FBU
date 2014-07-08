//
//  INLsignUpViewController.m
//  Inlink
//
//  Created by Zhichun Li on 7/8/14.
//  Copyright (c) 2014 Inlink. All rights reserved.
//

#import <Parse/Parse.h>
#import "INLsignUpViewController.h"
#import "INLsignUpView.h"


@interface INLsignUpViewController ()
@property (assign, nonatomic) NSString *inputUser;
@property (assign, nonatomic) NSString *inputPassword;
@end

@implementation INLsignUpViewController

- (void)loadView
{
    NSLog(@"Hi");
    UIView *signUpView = [[INLsignUpView alloc]init];
    self.view = signUpView;
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewDidLoad];
    NSLog(@"Will load Sign Up");
    // Create gradient background
    
    UIColor *lighterColor = [UIColor colorWithRed:0.278 green:0.858 blue:1 alpha:1];
    UIColor *darkerColor = [UIColor colorWithRed:0.165 green:0.514 blue:0.698 alpha:1];
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.colors = [NSArray arrayWithObjects:(id)lighterColor.CGColor, (id)darkerColor.CGColor, nil];
    gradient.frame = self.view.bounds;
    [self.view.layer insertSublayer:gradient atIndex:0];

}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)signUp{ //Sign a user up
    PFUser *user = [PFUser user];
    user.username = self.inputUser;
    user.password = self.inputPassword;
    
    [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if(!error){
            NSLog(@"Whoo"); //Enter the app
        } else {
            NSString *errorString = [error userInfo][@"error"];
            NSLog(@"%@", errorString);
        }
    }];
}

@end
