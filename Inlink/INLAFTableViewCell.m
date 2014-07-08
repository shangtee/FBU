//
//  INLAFTableViewCell.m
//  Inlink
//
//  Created by Zhichun Li on 7/8/14.
//  Copyright (c) 2014 Inlink. All rights reserved.
//

#import "INLAFTableViewCell.h"

@interface INLAFTableViewCell()

@property (weak, nonatomic) IBOutlet UILabel *DisplayedName;
@property (weak, nonatomic) IBOutlet UIButton *addFriends;

@end

@implementation INLAFTableViewCell

- (void)awakeFromNib
{
    [super awakeFromNib];
}
- (IBAction)addedFriend:(id)sender {
    
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
