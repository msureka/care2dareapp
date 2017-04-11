//
//  WatchViewTableViewCell.m
//  care2Dare
//
//  Created by Spiel's Macmini on 4/10/17.
//  Copyright © 2017 Spiel's Macmini. All rights reserved.
//

#import "WatchViewTableViewCell.h"

@implementation WatchViewTableViewCell
@synthesize Image_ThumbnailVedio4,Image_ThumbnailVedio3,Image_ThumbnailVedio2,Image_ThumbnailVedio1,Image_Profile;
- (void)awakeFromNib {
    [super awakeFromNib];
    Image_ThumbnailVedio1.clipsToBounds=YES;
    Image_ThumbnailVedio1.layer.cornerRadius=9.0f;
    
    Image_ThumbnailVedio2.clipsToBounds=YES;
    Image_ThumbnailVedio2.layer.cornerRadius=9.0f;
    
    Image_ThumbnailVedio3.clipsToBounds=YES;
    Image_ThumbnailVedio3.layer.cornerRadius=9.0f;
    
    Image_ThumbnailVedio4.clipsToBounds=YES;
    Image_ThumbnailVedio4.layer.cornerRadius=9.0f;
    \
    Image_Profile.clipsToBounds=YES;
    Image_Profile.layer.cornerRadius=Image_Profile.frame.size.height/2;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
