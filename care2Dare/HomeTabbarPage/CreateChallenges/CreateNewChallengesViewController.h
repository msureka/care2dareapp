//
//  CreateNewChallengesViewController.h
//  care2Dare
//
//  Created by Spiel's Macmini on 3/8/17.
//  Copyright © 2017 Spiel's Macmini. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIViewController+KeyboardAnimation.h"
#import "InviteSprintTagUserViewController.h"
#import "MHFacebookImageViewer.h"
#import <MediaPlayer/MediaPlayer.h>
#import <MobileCoreServices/MobileCoreServices.h>
#import <AssetsLibrary/ALAsset.h>
#import <MediaPlayer/MediaPlayer.h>
#import <MobileCoreServices/UTCoreTypes.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import "UIImageView+MHFacebookImageViewer.h"
#import "Base64.h"





@interface CreateNewChallengesViewController : UIViewController<UITextViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIScrollViewDelegate,UITextFieldDelegate>
{

    UIImage* image;
    
    
}
@property(strong,nonatomic)NSMutableArray  * Array_Names,*Array_UserId;

@property(nonatomic,weak)IBOutlet UIView * View_MainBack;

@property(nonatomic,weak)IBOutlet UIButton * Button_Gallery;
@property(nonatomic,weak)IBOutlet UIButton * Button_Cammera;
@property(nonatomic,weak)IBOutlet UIButton * Button_Videos;

@property(nonatomic,weak)IBOutlet UITextView * Textview_Desc;


@property(nonatomic,weak)IBOutlet UILabel * Label_ChallengesName;
@property(nonatomic,weak)IBOutlet UILabel * Label_Public;
@property(nonatomic,weak)IBOutlet UILabel * Label_Private;
@property(nonatomic,weak)IBOutlet UIImageView * Image_Public;
@property(nonatomic,weak)IBOutlet UIImageView * Image_Private;
@property(nonatomic,weak)IBOutlet UIImageView * Image_Play;
@property(nonatomic,weak)IBOutlet UIView * view_SliderTimes;
@property(nonatomic,weak)IBOutlet UILabel * Label_Currentsdays;
@property(nonatomic,weak)IBOutlet UISlider * slider_Days;

@property(nonatomic,weak)IBOutlet UILabel * Label_totalAmount;
@property(nonatomic,weak)IBOutlet UITextField * Textfield_Amount;

@property(nonatomic,weak)IBOutlet UIButton * Button_Create;

@property (nonatomic, strong)IBOutlet UIScrollView *startScreenScrollView;

-(IBAction)ButtonBack_Action:(id)sender;
-(IBAction)ButtonHelp_Action:(id)sender;

-(IBAction)ButtonGallery_Action:(id)sender;
-(IBAction)ButtonCammera_Action:(id)sender;
-(IBAction)ButtonVideo_Action:(id)sender;



-(IBAction)ButtonCreateChallenges_Action:(id)sender;
- (IBAction)progressSliderSlides:(id)sender;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tabBarBottomSpace;
- (IBAction)Textfield_Amount_Action:(id)sender;






- (BOOL) startCameraControllerFromViewController: (UIViewController*) controller
                                   usingDelegate: (id <UIImagePickerControllerDelegate,
                                                   UINavigationControllerDelegate>) delegate;
- (void)video: (NSString *) videoPath didFinishSavingWithError: (NSError *) error contextInfo:(void*)contextInfo;
- (IBAction)TextAction_Total:(id)sender;
@property(weak,nonatomic)IBOutlet UITextField *TotalTextField;
@property (strong, nonatomic) NSURL *videoURL;
@property (strong, nonatomic) MPMoviePlayerController *videoController;



@property(weak,nonatomic)IBOutlet UIImageView * BackroundImg;

@property(strong,nonatomic)NSString  * String_Cont_Name,*String_Cont_UserId;

@property(nonatomic,strong)NSMutableDictionary * All_Dic_Paid;
@property(strong,nonatomic)NSString * String_CheckView;
@property(strong,nonatomic)NSString * MoneyString;









@end
