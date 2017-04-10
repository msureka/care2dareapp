//
//  WatchVediolistTableViewCell.m
//  care2Dare
//
//  Created by Spiel's Macmini on 4/6/17.
//  Copyright © 2017 Spiel's Macmini. All rights reserved.
//

#import "WatchVediolistTableViewCell.h"

@implementation WatchVediolistTableViewCell
@synthesize ImageLeft_LeftProfile,ImageRight_RightProfile;
- (void)awakeFromNib {
    [super awakeFromNib];
    
    
    ImageLeft_LeftProfile.clipsToBounds=YES;
    ImageLeft_LeftProfile.layer.cornerRadius=9.0f;
    
    ImageRight_RightProfile.clipsToBounds=YES;
    ImageRight_RightProfile.layer.cornerRadius=ImageRight_RightProfile.frame.size.height/2;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

   
}

@end
