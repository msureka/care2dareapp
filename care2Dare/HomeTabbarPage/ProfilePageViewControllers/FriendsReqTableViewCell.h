//
//  FriendsReqTableViewCell.h
//  care2Dare
//
//  Created by Spiel's Macmini on 3/7/17.
//  Copyright © 2017 Spiel's Macmini. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FriendsReqTableViewCell : UITableViewCell

@property(nonatomic,weak)IBOutlet UIImageView * image_profile;

@property(nonatomic,weak)IBOutlet UIImageView * Image_RedMinus;
@property(nonatomic,weak)IBOutlet UIImageView * Image_BlueMinus;
@property(nonatomic,weak)IBOutlet UILabel * Label_Name;
@end
