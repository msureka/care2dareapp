//
//  ListofVedioCommentsTableViewCell.h
//  care2Dare
//
//  Created by Spiel's Macmini on 6/27/17.
//  Copyright © 2017 Spiel's Macmini. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ListofVedioCommentsTableViewCell : UITableViewCell
@property(nonatomic,weak)IBOutlet UILabel * label_reviews;
@property(nonatomic,weak)IBOutlet UILabel * label_Vedio;
@property(nonatomic,weak)IBOutlet UILabel * label_Comments;

@property(nonatomic,weak)IBOutlet UIImageView * Image_comments;
@property(nonatomic,weak)IBOutlet UIImageView * Image_vedio;

@end
