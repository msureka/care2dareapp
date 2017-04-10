//
//  FriendExpTableViewCell.m
//  care2Dare
//
//  Created by Spiel's Macmini on 3/4/17.
//  Copyright © 2017 Spiel's Macmini. All rights reserved.
//

#import "FriendExpTableViewCell.h"

@implementation FriendExpTableViewCell
@synthesize Image_Profile;
- (void)awakeFromNib {
    [super awakeFromNib];
    Image_Profile.clipsToBounds=YES;
    Image_Profile.layer.cornerRadius=9.0f;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
