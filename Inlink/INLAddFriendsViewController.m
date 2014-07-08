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


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    return [self initWithUserName:@"hi"];
}



-(IBAction)search:(id)sender{
    PFQuery *query = [PFQuery queryWithClassName:@"Users"];
    NSString *currentString = self.textF.text;
    if (currentString){
        [query whereKey:@"name" equalTo:currentString];
        [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
            if (!error) {
                // The find succeeded.
                NSLog(@"Successfully retrieved %d scores.", objects.count);
                // Do something with the found objects
                for (PFObject *object in objects) {
                    NSLog(@"%@", object.objectId);
                }
            } else {
                // Log details of the failure
                NSLog(@"Error: %@ %@", error, [error userInfo]);
            }
        }];
        PFObject *currentUser = [PFObject objectWithClassName:_userName];
        if (!currentUser){
            NSLog(@"There is an error");
        }
        NSMutableDictionary* friendsRequested = currentUser[@"friends"];
        [friendsRequested addOject:
    }
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

@end
