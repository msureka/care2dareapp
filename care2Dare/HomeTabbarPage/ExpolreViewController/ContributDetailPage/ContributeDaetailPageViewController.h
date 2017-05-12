//
//  ContributeDaetailPageViewController.h
//  care2Dare
//
//  Created by Spiel's Macmini on 3/16/17.
//  Copyright © 2017 Spiel's Macmini. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OneImageVedioTableViewCell.h"
#import "TwoDetailsTableViewCell.h"
#import "CommentsTableViewCell.h"

#import <MobileCoreServices/MobileCoreServices.h>
#import <AssetsLibrary/ALAsset.h>
#import <MediaPlayer/MediaPlayer.h>
#import <MobileCoreServices/UTCoreTypes.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import <AVFoundation/AVFoundation.h>
#import "UIImageView+MHFacebookImageViewer.h"
#import "Base64.h"
#import "RecordedVidTableViewCell.h"
@interface ContributeDaetailPageViewController : UIViewController<UIActionSheetDelegate,UITextViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIScrollViewDelegate,UITextFieldDelegate>
{
    
    UIImage* image;
    
    
}
- (BOOL) startCameraControllerFromViewController: (UIViewController*) controller
                                   usingDelegate: (id <UIImagePickerControllerDelegate,
                                                   UINavigationControllerDelegate>) delegate;
- (void)video: (NSString *) videoPath didFinishSavingWithError: (NSError *) error contextInfo:(void*)contextInfo;


@property (strong, nonatomic) NSURL *videoURL;
@property (strong, nonatomic) MPMoviePlayerController *videoController;



@property(nonatomic,weak)IBOutlet UILabel * Raised_amount;
@property(nonatomic,weak)IBOutlet UIButton * Button_back;

@property(nonatomic,weak)IBOutlet UIButton * Button_TotalPoints;
@property(nonatomic,weak)IBOutlet UIImageView * Image_TotalLikes;



-(IBAction)ButtonBack_Action:(id)sender;
-(IBAction)ButtonTotalPoints_Action:(id)sender;


@property(nonatomic,weak)IBOutlet UITableView * Tableview_ContriBute;
@property(nonatomic,weak)IBOutlet UIView * view_Topheader;
@property(nonatomic,strong)OneImageVedioTableViewCell * cell_OneImageVid;
@property(nonatomic,strong)TwoDetailsTableViewCell* cell_TwoDetails;
@property(nonatomic,strong)CommentsTableViewCell * cell_ThreeComments;
@property(nonatomic,strong)RecordedVidTableViewCell * cell_recordvid;
@property(nonatomic,strong)NSMutableArray * AllArrayData;
//@property(nonatomic,retain)UIImageView * ProfileImgeData;
//@property(nonatomic,retain)UIImage * ProfileImgeData;


@property(weak,nonatomic)IBOutlet UITextView * TextViews;
@property(weak,nonatomic)IBOutlet UIView * BackGround_MainViews;
@property(weak,nonatomic)IBOutlet UIView * BackTextViews;
;
-(IBAction)Send_Comments:(id)sender;

-(IBAction)ImageGalButtonAct:(id)sender;

@property(nonatomic,strong)IBOutlet UITextView * textOne;
@property(nonatomic,strong)IBOutlet UIView * textOneBlue;
@property(nonatomic,strong)IBOutlet UIView * BlackViewOne;
@property(nonatomic,strong)IBOutlet UITableView * tableOne;
@property (nonatomic, strong)IBOutlet UIButton *sendButton;
@property (nonatomic, strong)IBOutlet UIButton *ImageGalButton;
@property (nonatomic, strong)IBOutlet  UILabel *placeholderLabel;
@property(nonatomic,strong)IBOutlet UIView * ViewTextViewOne;

@end
