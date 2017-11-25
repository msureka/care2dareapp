//
//  CreateFundriserOneViewController.h
//  care2Dare
//
//  Created by MacMini2 on 21/11/17.
//  Copyright © 2017 Spiel's Macmini. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MHFacebookImageViewer.h"
#import <MediaPlayer/MediaPlayer.h>
#import <MobileCoreServices/MobileCoreServices.h>
#import <AssetsLibrary/ALAsset.h>
#import <MediaPlayer/MediaPlayer.h>
#import <MobileCoreServices/UTCoreTypes.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import "UIImageView+MHFacebookImageViewer.h"
#import "Base64.h"

@interface CreateFundriserOneViewController : UIViewController
- (IBAction)Button_Back_Action:(id)sender;
@property (weak, nonatomic) IBOutlet UITextView *TextView_Description;
@property (weak, nonatomic) IBOutlet UILabel *Label_placeholder;
@property (weak, nonatomic) IBOutlet UIButton *Button_next;
@property (weak, nonatomic) IBOutlet UILabel *Label_Heding;
- (IBAction)Button_Next_Action:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *Button_nexttop;

@property(nonatomic,weak)IBOutlet UIButton * Button_Dot1;
@property(nonatomic,weak)IBOutlet UIButton * Button_Dot2;
@property(nonatomic,weak)IBOutlet UIButton * Button_Dot3;

@property(nonatomic,weak)IBOutlet UIButton * Button_Gallery;
@property(nonatomic,weak)IBOutlet UIButton * Button_Cammera;
@property(nonatomic,weak)IBOutlet UIButton * Button_Videos;

-(IBAction)ButtonGallery_Action:(id)sender;
-(IBAction)ButtonCammera_Action:(id)sender;
-(IBAction)ButtonVideo_Action:(id)sender;

@property(nonatomic,weak)IBOutlet UIImageView * Image_Play;

- (BOOL) startCameraControllerFromViewController: (UIViewController*) controller
                                   usingDelegate: (id <UIImagePickerControllerDelegate,
                                                   UINavigationControllerDelegate>) delegate;
- (void)video: (NSString *) videoPath didFinishSavingWithError: (NSError *) error contextInfo:(void*)contextInfo;

@property (strong, nonatomic) NSURL *videoURL;
@property (strong, nonatomic) NSURL *finalURL;
@property (strong, nonatomic) NSMutableDictionary *Dict_values1;
@property (strong, nonatomic) MPMoviePlayerController *videoController;



@property(weak,nonatomic)IBOutlet UIImageView * BackroundImg;

@end
