//
//  WatchVedioDescTableViewCell.h
//  care2Dare
//
//  Created by Spiel's Macmini on 4/6/17.
//  Copyright © 2017 Spiel's Macmini. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WatchVedioDescTableViewCell : UITableViewCell
@property(strong,nonatomic)IBOutlet UIImageView * ImageLeft_LeftProfile;
@property(strong,nonatomic)IBOutlet UIImageView * ImageRight_RightProfile;


@property(strong,nonatomic)IBOutlet UIButton  * Button_SetValues;
@property(strong,nonatomic)IBOutlet UILabel * Label_ChallengeName;
@property(strong,nonatomic)IBOutlet UILabel * Label_DaysAgo;
@property(strong,nonatomic)IBOutlet UILabel * Label_Addfriend;
@property(strong,nonatomic)IBOutlet UILabel * Label_DescTitle;
@end
