//
//  INLAcceptFriendshipTableViewController.m
//  Inlink
//
//  Created by Zhichun Li on 7/8/14.
//  Copyright (c) 2014 Inlink. All rights reserved.
//

#import "INLAcceptFriendshipTableViewController.h"
#import "INLAFTableViewCell.h"
#import "Parse/Parse.h"

@interface INLAcceptFriendshipTableViewController ()<INLAFProtocol>

@property NSMutableArray *friendsRequest;
@property PFUser *user;


@end

@implementation INLAcceptFriendshipTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)reload{
    [self.tableView reloadData];
}

-(void)viewWillAppear:(BOOL)animated{
    PFQuery *query = [PFQuery queryWithClassName:@"Follow"];
    [query whereKey:@"to" equalTo:[PFUser currentUser]];
    _user = [PFUser currentUser];
    NSMutableArray *people = [[query findObjects] mutableCopy];
    if (!self.friendsRequest){
        self.friendsRequest = [NSMutableArray array];
    }
    for (PFObject* o in people){
        PFUser *q = [o objectForKey:@"from"];
        PFUser *j = (PFUser *)[q fetchIfNeeded];
        [self.friendsRequest addObject:j];
    }
    NSLog(@"%@", self.friendsRequest);
    [self.tableView reloadData];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    UINib *nib = [UINib nibWithNibName:@"INLAFTableViewCell" bundle:nil];
    
    [self.tableView registerNib:nib forCellReuseIdentifier:@"INLATableViewCell"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [_friendsRequest count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    INLAFTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"INLATableViewCell" forIndexPath:indexPath];
    PFUser *user = _friendsRequest[indexPath.row];
    NSString *name = user[@"username"];
    cell.fri = user;
    cell.DisplayedName.text = name;
    cell.button.center = CGPointMake(cell.button.center.x, cell.button.center.y + 20);
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
