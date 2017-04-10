//
//  InviteSprintUserTableViewCell.m
//  SprintTags_Pro
//
//  Created by Spiel's Macmini on 9/1/16.
//  Copyright © 2016 Spiel's Macmini. All rights reserved.
//

#import "InviteSprintUserTableViewCell.h"

@implementation InviteSprintUserTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    _Proimage_View.clipsToBounds = YES;
    _Proimage_View.layer.cornerRadius = _Proimage_View.frame.size.width / 2;
}

@end
