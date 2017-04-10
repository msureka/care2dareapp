//
//  RaisedFourTableViewCell.m
//  care2Dare
//
//  Created by Spiel's Macmini on 3/17/17.
//  Copyright © 2017 Spiel's Macmini. All rights reserved.
//

#import "RaisedFourTableViewCell.h"


@implementation RaisedFourTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    _Image_Profile.clipsToBounds=YES;
    _Image_Profile.layer.cornerRadius=_Image_Profile.frame.size.height/2;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
