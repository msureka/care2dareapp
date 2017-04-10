//
//  WatchVedioDescTableViewCell.m
//  care2Dare
//
//  Created by Spiel's Macmini on 4/6/17.
//  Copyright © 2017 Spiel's Macmini. All rights reserved.
//

#import "WatchVedioDescTableViewCell.h"

@implementation WatchVedioDescTableViewCell
@synthesize ImageLeft_LeftProfile;
- (void)awakeFromNib {
    [super awakeFromNib];
    ImageLeft_LeftProfile.clipsToBounds=YES;
    ImageLeft_LeftProfile.layer.cornerRadius=ImageLeft_LeftProfile.frame.size.height/2;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
