//
//  WatchViewTableViewCell.h
//  care2Dare
//
//  Created by Spiel's Macmini on 4/10/17.
//  Copyright © 2017 Spiel's Macmini. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WatchViewTableViewCell : UITableViewCell

@property(strong,nonatomic)IBOutlet UIImageView * Image_Profile;
@property(strong,nonatomic)IBOutlet UIImageView * Image_Thumbnail;
@property(strong,nonatomic)IBOutlet UIImageView * Image_NewFrndThumbnail;
@property(strong,nonatomic)IBOutlet UIImageView * Image_ThumbnailVedio1;
@property(strong,nonatomic)IBOutlet UIImageView * Image_ThumbnailVedio2;
@property(strong,nonatomic)IBOutlet UIImageView * Image_ThumbnailVedio3;
@property(strong,nonatomic)IBOutlet UIImageView * Image_ThumbnailVedio4;
@property(strong,nonatomic)IBOutlet UIImageView * Image_New_ThumbnailVedio1;
@property(strong,nonatomic)IBOutlet UIImageView * Image_New_ThumbnailVedio2;
@property(strong,nonatomic)IBOutlet UIImageView * Image_New_ThumbnailVedio3;
@property(strong,nonatomic)IBOutlet UIImageView * Image_New_ThumbnailVedio4;

@property(strong,nonatomic)IBOutlet UIButton * Button_playbutton;
@property(strong,nonatomic)IBOutlet UIButton * Button_playbutton1;
@property(strong,nonatomic)IBOutlet UIButton * Button_playbutton2;
@property(strong,nonatomic)IBOutlet UIButton * Button_playbutton3;
@property(strong,nonatomic)IBOutlet UIButton * Button_playbutton4;

@property(strong,nonatomic)IBOutlet UILabel * Label_Changename;
@property(strong,nonatomic)IBOutlet UILabel * Label_days;
@property(strong,nonatomic)IBOutlet UILabel * Label_mores;
@property(strong,nonatomic)IBOutlet UILabel * Label_title;
@property(strong,nonatomic)IBOutlet UILabel * Label_moreVedios;
@end
