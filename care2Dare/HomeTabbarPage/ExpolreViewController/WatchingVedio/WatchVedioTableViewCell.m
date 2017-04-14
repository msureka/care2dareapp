//
//  WatchVedioTableViewCell.m
//  care2Dare
//
//  Created by Spiel's Macmini on 4/6/17.
//  Copyright © 2017 Spiel's Macmini. All rights reserved.
//

#import "WatchVedioTableViewCell.h"

@implementation WatchVedioTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    CGAffineTransform transform = CGAffineTransformMakeScale(1.0f, 2.5f);
    _progressslider.transform = transform;
 
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
