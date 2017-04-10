//
//  WatchVediolistTableViewCell.h
//  care2Dare
//
//  Created by Spiel's Macmini on 4/6/17.
//  Copyright © 2017 Spiel's Macmini. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WatchVediolistTableViewCell : UITableViewCell
@property(strong,nonatomic)IBOutlet UIImageView * ImageLeft_LeftProfile;
@property(strong,nonatomic)IBOutlet UIImageView * ImageRight_RightProfile;
@property(strong,nonatomic)IBOutlet UIImageView * Image_NewFrnd;

@property(strong,nonatomic)IBOutlet UIImageView * Image_Button_play;
;

@property(strong,nonatomic)IBOutlet UILabel * Label_ChallengeName;
@property(strong,nonatomic)IBOutlet UILabel * Label_DaysAgo;

@end
