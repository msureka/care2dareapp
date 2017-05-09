//
//  WorldExpTableViewCell.m
//  care2Dare
//
//  Created by Spiel's Macmini on 3/4/17.
//  Copyright © 2017 Spiel's Macmini. All rights reserved.
//

#import "WorldExpTableViewCell.h"

@implementation WorldExpTableViewCell
@synthesize Image_Profile,Image_Profile2,Image_Profile3;
- (void)awakeFromNib {
    [super awakeFromNib];
    Image_Profile.clipsToBounds=YES;
     Image_Profile.layer.cornerRadius=9.0f;
    
    Image_Profile2.clipsToBounds=YES;
    Image_Profile2.layer.cornerRadius=9.0f;
    
    Image_Profile3.clipsToBounds=YES;
    Image_Profile3.layer.cornerRadius=9.0f;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
