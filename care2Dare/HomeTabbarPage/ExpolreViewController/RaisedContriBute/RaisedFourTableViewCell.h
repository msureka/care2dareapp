//
//  RaisedFourTableViewCell.h
//  care2Dare
//
//  Created by Spiel's Macmini on 3/17/17.
//  Copyright © 2017 Spiel's Macmini. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RaisedFourTableViewCell : UITableViewCell
@property(weak,nonatomic)IBOutlet UILabel * label_name;
@property(weak,nonatomic)IBOutlet UILabel *label_RaisedAmt;

@property(weak,nonatomic)IBOutlet UIImageView *Image_Profile;
@property(weak,nonatomic)IBOutlet UIImageView *Image_likes;

@property(weak,nonatomic)IBOutlet UIImageView *Image_LikesProf;
@property(weak,nonatomic)IBOutlet UIButton *Button_likesProf;

@end
