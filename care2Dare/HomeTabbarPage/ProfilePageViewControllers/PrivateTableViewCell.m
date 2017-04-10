//
//  PrivateTableViewCell.m
//  care2Dare
//
//  Created by Spiel's Macmini on 3/6/17.
//  Copyright © 2017 Spiel's Macmini. All rights reserved.
//

#import "PrivateTableViewCell.h"

@implementation PrivateTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    _Image_Profile.clipsToBounds=YES;
    _Image_Profile.layer.cornerRadius=9.0f;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
