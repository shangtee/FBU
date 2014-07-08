//
//  INLChatViewController.m
//  Inlink
//
//  Created by Zhichun Li on 7/8/14.
//  Copyright (c) 2014 Inlink. All rights reserved.
//

#import "INLChatViewController.h"

@interface INLChatViewController () <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *textField;

@end

@implementation INLChatViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
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

//animations for when a message disappears

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
    
    [self.view setFrame:CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y - keyboardFrame.size.height, self.view.frame.size.width, self.view.frame.size.height)];
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
    
    [self.view setFrame:CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y + keyboardFrame.size.height, self.view.frame.size.width, self.view.frame.size.height)];
    [UIView commitAnimations];
}



//Methods dismissing the keyboard
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    NSLog(@"finished typing %@",textField.text);
    [textField resignFirstResponder];
    
    return YES;
}
- (IBAction)backgroundTouched {
    [self.view endEditing:YES];
}

- (IBAction)sendMessage:(id)sender {
    
    //TODO: send self.textField.text to the chat
    NSLog(@"Sending %@ to the server",self.textField.text);
    self.textField.text = @"";
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
