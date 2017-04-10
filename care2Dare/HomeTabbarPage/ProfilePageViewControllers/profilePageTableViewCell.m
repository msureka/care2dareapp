//
//  profilePageTableViewCell.m
//  SprintTags_Pro
//
//  Created by Spiel's Macmini on 6/20/16.
//  Copyright © 2016 Spiel's Macmini. All rights reserved.
//

#import "profilePageTableViewCell.h"

@implementation profilePageTableViewCell
@synthesize Label_Friends,Label_Challenges,Image_ProfileImg;
- (void)awakeFromNib {
     Image_ProfileImg.clipsToBounds = YES;
    Image_ProfileImg.layer.cornerRadius =Image_ProfileImg.frame.size.width / 2;
   
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
