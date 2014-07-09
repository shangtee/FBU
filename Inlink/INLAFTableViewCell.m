//
//  INLAFTableViewCell.m
//  Inlink
//
//  Created by Zhichun Li on 7/8/14.
//  Copyright (c) 2014 Inlink. All rights reserved.
//

#import "INLAFTableViewCell.h"
#import "Parse/Parse.h"

@interface INLAFTableViewCell()

@property (weak, nonatomic) IBOutlet UIButton *friends;

@end

@implementation INLAFTableViewCell

- (void)awakeFromNib
{
    [super awakeFromNib];
}

- (IBAction)addedFriend:(id)sender {
    PFObject *friend = [PFObject objectWithClassName:@"Friends"];
    PFUser *currentUser = [PFUser currentUser];
    NSString *userRe = self.DisplayedName.text;
    if (userRe && self.fri){
        [friend setObject:currentUser forKey:@"to"];
        [friend setObject:self.fri forKey:@"from"];
        [friend setObject:[NSDate date] forKey:@"date"];
        [friend saveInBackground];
    }
    [self.delegate reload];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
