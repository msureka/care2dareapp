//
//  CommentsTableViewCell.h
//  care2Dare
//
//  Created by Spiel's Macmini on 3/16/17.
//  Copyright © 2017 Spiel's Macmini. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CommentsTableViewCell : UITableViewCell

@property(nonatomic,weak)IBOutlet UIImageView * image_ProfileComment;
@property(nonatomic,weak)IBOutlet UILabel * Label_CommentDesc;
@property(nonatomic,weak)IBOutlet UILabel * label_CommentHeader;

@end
