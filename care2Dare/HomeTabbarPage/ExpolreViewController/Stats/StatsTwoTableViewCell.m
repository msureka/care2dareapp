//
//  StatsTwoTableViewCell.m
//  care2Dare
//
//  Created by Spiel's Macmini on 4/17/17.
//  Copyright © 2017 Spiel's Macmini. All rights reserved.
//

#import "StatsTwoTableViewCell.h"

@implementation StatsTwoTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    _image_profile.clipsToBounds=YES;
    _image_profile.layer.cornerRadius=_image_profile.frame.size.height/2;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
