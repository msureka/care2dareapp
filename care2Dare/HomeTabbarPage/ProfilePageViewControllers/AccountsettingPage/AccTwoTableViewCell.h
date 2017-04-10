//
//  AccTwoTableViewCell.h
//  SprintTags_Pro
//
//  Created by Spiel's Macmini on 8/19/16.
//  Copyright © 2016 Spiel's Macmini. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AccTwoTableViewCell : UITableViewCell
@property(strong,nonatomic)IBOutlet UIImageView * image_View;
@property(strong,nonatomic)IBOutlet UILabel * LabelVal;


@property(nonatomic,strong)IBOutlet UISwitch * switchOutlet;
@end
