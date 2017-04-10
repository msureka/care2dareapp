//
//  ChallengesTableViewCell.h
//  care2Dare
//
//  Created by Spiel's Macmini on 3/8/17.
//  Copyright © 2017 Spiel's Macmini. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChallengesTableViewCell : UITableViewCell
@property(nonatomic,weak)IBOutlet UIImageView * image_Profile;

@property(nonatomic,weak)IBOutlet UILabel * Label_Raised;
@property(nonatomic,weak)IBOutlet UILabel * Label_Time;
@property(nonatomic,weak)IBOutlet UILabel * Label_Desc;

@end
