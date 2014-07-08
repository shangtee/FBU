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
@property (weak, nonatomic) IBOutlet UITextField *password;
@property (weak, nonatomic) IBOutlet UITextField *username;
@property (weak, nonatomic) IBOutlet UIButton *signUp;
@property (weak, nonatomic) IBOutlet UIImageView *logo;
@property (assign, nonatomic) NSString *inputUser;
@property (assign, nonatomic) NSString *inputPassword;


@end

@implementation INLsignUpViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (IBAction)signUp:(id)sender {
    PFUser *user = [PFUser user];
    user.username = self.username.text;
    user.password = self.password.text;
    
    [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (!error) {
            NSLog(@"Success! You are %@", user);
        } else {
            NSString *errorString = [error userInfo][@"error"];
            NSLog(@"%@", errorString);
        }
    }];}

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

//Resign keyboard on outside touch




@end
