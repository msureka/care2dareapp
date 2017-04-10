//
//  TwoDetailsTableViewCell.h
//  care2Dare
//
//  Created by Spiel's Macmini on 3/16/17.
//  Copyright © 2017 Spiel's Macmini. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TwoDetailsTableViewCell : UITableViewCell

@property(nonatomic,weak)IBOutlet UIImageView * image_FristProfile;
@property(nonatomic,weak)IBOutlet UIImageView * image_SecProfile;
@property(nonatomic,weak)IBOutlet UILabel * Label_Dayleft;
@property(nonatomic,weak)IBOutlet UILabel * label_Desc;
@property(nonatomic,weak)IBOutlet UILabel * label_Mores;
@property(nonatomic,weak)IBOutlet UIProgressView * ProgressBar_Total;
@property(nonatomic,weak)IBOutlet UIImageView * image_ProfileComment;
@property(nonatomic,weak)IBOutlet UILabel * Label_CommentDesc;
@property(nonatomic,weak)IBOutlet UILabel * label_CommentHeader;

@property(nonatomic,weak)IBOutlet UILabel * label_ChallengesTxt;
@property(nonatomic,weak)IBOutlet UILabel * label_Moretxt;
@end
