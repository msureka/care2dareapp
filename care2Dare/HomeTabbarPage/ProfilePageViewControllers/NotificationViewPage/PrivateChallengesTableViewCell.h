//
//  PrivateChallengesTableViewCell.h
//  care2Dare
//
//  Created by Spiel's Macmini on 3/8/17.
//  Copyright © 2017 Spiel's Macmini. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PrivateChallengesTableViewCell : UITableViewCell
@property(nonatomic,weak)IBOutlet UIImageView * image_profile;

@property(nonatomic,weak)IBOutlet UIImageView * image_profile2;

@property(nonatomic,weak)IBOutlet UILabel * Label_Name;

@property(nonatomic,weak)IBOutlet UIImageView * image_Redmsg;

@property(nonatomic,weak)IBOutlet UIImageView * image_Playbutton1;
@property(nonatomic,weak)IBOutlet UIImageView * image_Playbutton2;

@property(nonatomic,weak)IBOutlet UILabel * Lable_ActionDate;

@end
