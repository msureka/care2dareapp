//
//  TwoDetailsTableViewCell.m
//  care2Dare
//
//  Created by Spiel's Macmini on 3/16/17.
//  Copyright © 2017 Spiel's Macmini. All rights reserved.
//

#import "TwoDetailsTableViewCell.h"

@implementation TwoDetailsTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    
    _image_ProfileComment.clipsToBounds=YES;
    _image_ProfileComment.layer.cornerRadius=_image_ProfileComment.frame.size.height/2;
//    
    _ProgressBar_Total.clipsToBounds = YES;
    _ProgressBar_Total.layer.cornerRadius = 2;
    CGAffineTransform transform = CGAffineTransformMakeScale(1.0f, 2.5f);
    _ProgressBar_Total.transform = transform;
 

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
