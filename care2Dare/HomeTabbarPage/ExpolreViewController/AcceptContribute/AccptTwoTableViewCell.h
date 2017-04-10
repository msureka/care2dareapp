//
//  AccptTwoTableViewCell.h
//  care2Dare
//
//  Created by Spiel's Macmini on 4/1/17.
//  Copyright © 2017 Spiel's Macmini. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AccptTwoTableViewCell : UITableViewCell

@property(nonatomic,weak)IBOutlet UIImageView * image_Profile;
@property(nonatomic,weak)IBOutlet UIImageView * image_PubPri;

@property(nonatomic,weak)IBOutlet UILabel * Label_privatePub;
@property(nonatomic,weak)IBOutlet UILabel * label_name;
@property(nonatomic,weak)IBOutlet UILabel * label_challengesday;

@property(nonatomic,weak)IBOutlet UILabel * Label_AddmoreChallenges;

@property(nonatomic,weak)IBOutlet UILabel * label_DescTitle;


@end
