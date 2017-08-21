//
//  VediosListsTableViewCell.h
//  care2Dare
//
//  Created by Spiel's Macmini on 6/27/17.
//  Copyright © 2017 Spiel's Macmini. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VediosListsTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView * Imagepro;
@property (nonatomic, nonatomic) IBOutlet UIImageView *image_newSymbolstatus;
@property (strong, nonatomic) IBOutlet UIImageView * Image_playButton;
@property(strong,nonatomic)IBOutlet UILabel * Label_ChallengeName;
@property(strong,nonatomic)IBOutlet UILabel * Label_DaysAgo;
@property(strong,nonatomic)IBOutlet UIImageView * ImageRight_RightProfile;

@property (weak, nonatomic) IBOutlet UIImageView * ImageRight_Likes;
@property (weak, nonatomic) IBOutlet UIImageView * ImageRight_FriendStatus;
@property(strong,nonatomic)IBOutlet UIImageView * Image_VedioShare;

@property(strong,nonatomic)IBOutlet UILabel * Label_likes;
@property(strong,nonatomic)IBOutlet UILabel * Label_subscribe;
@property(strong,nonatomic)IBOutlet UILabel * Label_totalreviews;
@end
