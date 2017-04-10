//
//  FriendsReqTableViewCell.m
//  care2Dare
//
//  Created by Spiel's Macmini on 3/7/17.
//  Copyright © 2017 Spiel's Macmini. All rights reserved.
//

#import "FriendsReqTableViewCell.h"

@implementation FriendsReqTableViewCell
@synthesize Label_Name,Image_RedMinus,Image_BlueMinus,image_profile;
- (void)awakeFromNib {
    [super awakeFromNib];
    image_profile.clipsToBounds=YES;
    image_profile.layer.cornerRadius=image_profile.frame.size.height/2;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
