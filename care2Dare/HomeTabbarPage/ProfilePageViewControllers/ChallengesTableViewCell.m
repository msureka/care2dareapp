//
//  ChallengesTableViewCell.m
//  care2Dare
//
//  Created by Spiel's Macmini on 3/8/17.
//  Copyright © 2017 Spiel's Macmini. All rights reserved.
//

#import "ChallengesTableViewCell.h"

@implementation ChallengesTableViewCell
@synthesize image_Profile;
- (void)awakeFromNib {
    [super awakeFromNib];
    image_Profile.clipsToBounds=YES;
    image_Profile.layer.cornerRadius=9.0f;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
