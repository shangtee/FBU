//
//  INLAddFriendsViewController.m
//  Inlink
//
//  Created by Zhichun Li on 7/8/14.
//  Copyright (c) 2014 Inlink. All rights reserved.
//

#import "INLAddFriendsViewController.h"
#import "Parse/parse.h"

@interface INLAddFriendsViewController ()
@property IBOutlet UITextField *textF;
@property (weak, nonatomic) IBOutlet UIButton *sear;
@property (nonatomic) NSString *userName;

@end

@implementation INLAddFriendsViewController


-(instancetype)initWithUserName:(NSString *)username{
    self = [super init];
    if (self){
        _sear.layer.cornerRadius = 2;
        _sear.layer.borderColor = [UIColor blueColor].CGColor;
        _userName = username;
    }
    return self;
    
}


//- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
//{
//    return [self initWithUserName:@"hi"];
//}



-(IBAction)search:(id)sender{
    PFQuery *query = [PFUser query];
    NSString *currentString = self.textF.text;
    if (currentString){
        [query whereKey:@"name" equalTo:currentString];
        NSArray* currentStrings = [query findObjects];
        PFUser* currentString = currentStrings[0];
        PFUser *currentUser = [PFUser currentUser];
        if (!currentUser){
            NSLog(@"There is an error");
            return;
        }
        NSMutableArray *friendsRequested = currentUser[@"friendRequests"];
        [friendsRequested addObject:currentString];
        currentUser[@"friendRequests"] = friendsRequested;
        [currentUser saveInBackground];
        NSMutableArray *friendsReceived = currentString[@"friendsRequestsR"];
        currentString[@"friendsRequestsR"] = friendsReceived;
        [friendsReceived addObject:currentUser];
        
    }
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(backgroundTouched)];
    
    [self.view addGestureRecognizer:tap];

}

//Methods dismissing the keyboard

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    NSLog(@"finished typing %@ to add friends",textField.text);
    [textField resignFirstResponder];
    
    return YES;
}

- (IBAction)backgroundTouched {
    [self.view endEditing:YES];
}


//Push button up when keyboard shows up

-(void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(moveUp:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(moveDown:) name:UIKeyboardWillHideNotification object:nil];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}



//Animations to move up/down view when keyboard appears/disappears
-(void)moveUp:(NSNotification *)aNotification
{
    //Get user info
    NSDictionary *userInfo = [aNotification userInfo];
    
    NSTimeInterval animationDuration;
    UIViewAnimationCurve animationCurve;
    CGRect keyboardFrame;
    [[userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey] getValue:&animationCurve];
    [[userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] getValue:&animationDuration];
    
    //TODO: alter the function when orientation changes
    [[userInfo objectForKey:UIKeyboardFrameBeginUserInfoKey] getValue:&keyboardFrame];
    
    //animate
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationCurve:animationCurve];
    [UIView setAnimationDuration:animationDuration];
    
    [self.sear setFrame:CGRectMake(self.sear.frame.origin.x, self.sear.frame.origin.y - 60, self.sear.frame.size.width, self.sear.frame.size.height)];
    [UIView commitAnimations];
}

-(void)moveDown:(NSNotification *)aNotification
{
    //Get user info
    NSDictionary *userInfo = [aNotification userInfo];
    
    NSTimeInterval animationDuration;
    UIViewAnimationCurve animationCurve;
    CGRect keyboardFrame;
    [[userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey] getValue:&animationCurve];
    [[userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] getValue:&animationDuration];
    
    //TODO: alter the function when orientation changes
    [[userInfo objectForKey:UIKeyboardFrameBeginUserInfoKey] getValue:&keyboardFrame];
    
    //animate
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationCurve:animationCurve];
    [UIView setAnimationDuration:animationDuration];
    
    [self.sear setFrame:CGRectMake(self.sear.frame.origin.x, self.sear.frame.origin.y + 60, self.sear.frame.size.width, self.sear.frame.size.height)];
    [UIView commitAnimations];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
