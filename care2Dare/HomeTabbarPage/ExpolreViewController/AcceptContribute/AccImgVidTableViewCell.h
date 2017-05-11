//
//  AccImgVidTableViewCell.h
//  care2Dare
//
//  Created by Spiel's Macmini on 4/1/17.
//  Copyright © 2017 Spiel's Macmini. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AccImgVidTableViewCell : UITableViewCell
@property(strong,nonatomic)IBOutlet UIImageView * image_playButton;
@property(strong,nonatomic)IBOutlet UIImageView * Image_Backround;
@property(nonatomic,weak)IBOutlet UIImageView * Image_ThreeDotsFlag;
@property(nonatomic,weak)IBOutlet UIImageView * Image_Favourite;
@end
