//
//  CreateFundriserOneViewController.m
//  care2Dare
//
//  Created by MacMini2 on 21/11/17.
//  Copyright © 2017 Spiel's Macmini. All rights reserved.
//

#import "CreateFundriserOneViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "Reachability.h"
#import "UIView+RNActivityView.h"
#import "SDAVAssetExportSession.h"
#import "CreateFundriserTwoViewController.h"
#import "CreateChallengerTwoViewController.h"
@interface CreateFundriserOneViewController ()<UITextViewDelegate>
{
    NSURLSessionDataTask *dataTaskupload;
    
    NSUserDefaults *defaults;
   
    NSString *mediatypeVal,*Str_paiduserid,*assettype,*encodedImage,*encodedImageThumb,*strCameraVedio,*SelectGallery,* ImageNSdata,*ImageNSdataThumb,*strinRetake,* GalStr,*CameraStr,*RecordStr;
    
    
    MHFacebookImageViewer * Controller;
    UIImage *FrameImage;
   
    
    UIGestureRecognizer *BackImageGesture,*fRecordVedioTabGesture;
    NSNumber *Vedio_Height,*Vedio_Width,*BitrateValue;
    UIImage *chosenImage;
    NSData *imageData,*imageDataThumb;
  
    UILabel * Label_confirm1;

    UILabel * Label_confirm;
    UIView * transperentViewIndicator,*whiteView1;
    UIActivityIndicatorView * indicatorAlert;;
    
    MPMoviePlayerViewController * movieController;
    
    UIImagePickerController * pcker1;
    UIImagePickerController *cameraUI;
   
    NSString *mediaTypeCheck;
}
@end

@implementation CreateFundriserOneViewController
@synthesize Button_Dot3,Button_Dot2,Button_Dot1,Button_next,Label_placeholder,TextView_Description,BackroundImg,Button_Videos,Button_Cammera,Button_Gallery,Image_Play,Dict_values1,Label_Heding,Button_nexttop;
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [Button_Dot1 setBackgroundColor:[UIColor colorWithRed:67/255.0 green:188/255.0 blue:255/255.0 alpha:1]];
    Button_Dot1.layer.cornerRadius=Button_Dot1.frame.size.height/2;
    Button_Dot2.layer.cornerRadius=Button_Dot2.frame.size.height/2;
    Button_Dot3.layer.cornerRadius=Button_Dot3.frame.size.height/2;
    Button_next.layer.cornerRadius=Button_next.frame.size.height/2;
    Button_next.layer.borderColor=[UIColor colorWithRed:186/255.0 green:188/255.0 blue:190/255.0 alpha:1].CGColor;
    Button_next.layer.borderWidth=1.0f;
    Button_next.enabled=NO;
    
     Button_nexttop.layer.cornerRadius=Button_nexttop.frame.size.height/2;
    Button_nexttop.hidden=YES;
    TextView_Description.text=@"";
    if ([[Dict_values1 valueForKey:@"challengetype"] isEqualToString:@"RAISE"])
    {
      Label_placeholder.text=@"Tell us your story";
        Label_Heding.text=@"Create a Fundraiser";
    }
    else
    {
       Label_placeholder.text=@"Describe your challenge";
        Label_Heding.text=@"Create a Challenge";
    }
    BackroundImg.clipsToBounds=YES;
    BackroundImg.layer.cornerRadius=9.0f;
    BackroundImg.userInteractionEnabled=YES;
    BackroundImg.hidden=YES;
    
    BackImageGesture =[[UITapGestureRecognizer alloc] initWithTarget:self
                                                              action:@selector(BackImageViewTap:)];
    [BackroundImg addGestureRecognizer:BackImageGesture];

     Image_Play.hidden=YES;
    
    
    
    transperentViewIndicator=[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    transperentViewIndicator.backgroundColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.5];
    
    whiteView1=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 110,110)];
    whiteView1.center=transperentViewIndicator.center;
    [whiteView1 setBackgroundColor:[UIColor blackColor]];
    whiteView1.layer.cornerRadius=9;
    indicatorAlert = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    indicatorAlert.frame=CGRectMake((whiteView1.frame.size.width/2)-10, (whiteView1.frame.size.height/2)-15, 20, 20);
    [indicatorAlert startAnimating];
    [indicatorAlert setColor:[UIColor whiteColor]];
    
    Label_confirm1=[[UILabel alloc]initWithFrame:CGRectMake(0,(indicatorAlert.frame.size.height+indicatorAlert.frame.origin.y)+5, whiteView1.frame.size.width, 40)];
    
    
    Label_confirm1.text=@"Preparing...";
    Label_confirm1.font=[UIFont fontWithName:@"SanFranciscoDisplay-Bold" size:16.0];
    Label_confirm1.textColor=[UIColor whiteColor];
    Label_confirm1.textAlignment=NSTextAlignmentCenter;
    
    
    [whiteView1 addSubview:indicatorAlert];
    
    [whiteView1 addSubview:Label_confirm1];
    
    [transperentViewIndicator addSubview:whiteView1];
    
    
    
    BitrateValue=@750000;

}

- (void)didReceiveMemoryWarning
{
[super didReceiveMemoryWarning];
   
}


#pragma mark-Textview Delegates...

- (void)textViewDidBeginEditing:(UITextView *)textView

{
    if (TextView_Description.text.length==0)
    {
         Label_placeholder.hidden=YES;
    }
    else
    {
      Label_placeholder.hidden=YES;
    }
}
- (void)textViewDidEndEditing:(UITextView *)textView
{
    if (TextView_Description.text.length==0)
    {
        Label_placeholder.hidden=NO;
    }
    else
    {
        Label_placeholder.hidden=YES;
    }
}

- (void)textViewDidChange:(UITextView *)textView
{
    
    if (TextView_Description.text.length==0)
    {
        Label_placeholder.hidden=NO;
       
        
    }
    else
    {
        Label_placeholder.hidden=YES;
        
    }
    
    if (TextView_Description.text.length==0 || encodedImage.length==0)
    {
        Button_next.enabled=NO;
         Button_nexttop.hidden=YES;
        [Button_next setTitleColor:[UIColor colorWithRed:186/255.0 green:188/255.0 blue:190/255.0 alpha:1] forState:UIControlStateNormal];
        Button_next.layer.borderColor=[UIColor colorWithRed:186/255.0 green:188/255.0 blue:190/255.0 alpha:1].CGColor;
    }
    else
    {
         Button_next.enabled=YES;
        Button_nexttop.hidden=NO;
        [Button_next setTitleColor:[UIColor colorWithRed:67/255.0 green:188/255.0 blue:255/255.0 alpha:1] forState:UIControlStateNormal];
        Button_next.layer.borderColor=[UIColor colorWithRed:67/255.0 green:188/255.0 blue:255/255.0 alpha:1].CGColor;
    }
}
#pragma mark-Button_Actions...

- (IBAction)Button_Back_Action:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)Button_Next_Action:(id)sender
{
    
       [Dict_values1 setValue:TextView_Description.text forKey:@"title"];
    [Dict_values1 setValue:mediatypeVal forKey:@"mediatype"];
    [Dict_values1 setValue:encodedImage forKey:@"media"];
    [Dict_values1 setValue:encodedImageThumb forKey:@"mediathumbnail"];
   
    
    if ([[Dict_values1 valueForKey:@"challengetype"] isEqualToString:@"RAISE"])
    {
        CreateFundriserTwoViewController * set=[self.storyboard instantiateViewControllerWithIdentifier:@"CreateFundriserTwoViewController"];
        set.Dict_values2=Dict_values1;
        
        [self.navigationController pushViewController:set animated:YES];
    }
    else
    {
        CreateChallengerTwoViewController * set=[self.storyboard instantiateViewControllerWithIdentifier:@"CreateChallengerTwoViewController"];
         set.Dict_values2=Dict_values1;
        [self.navigationController pushViewController:set animated:YES];
    }
    
   
}
-(IBAction)ButtonGallery_Action:(id)sender
{
    SelectGallery=@"Gal";
    strCameraVedio=@"Gal";
    // pick from image and veio from gallery.............
    
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary])
    {
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        
        picker.sourceType =  UIImagePickerControllerSourceTypePhotoLibrary;
        picker.mediaTypes =[UIImagePickerController availableMediaTypesForSourceType:picker.sourceType];
        picker.allowsEditing = NO;
        
        [self presentViewController:picker animated:true completion:nil];
    }
    
    // only vedio pick from gallery..............
    //
    //    UIImagePickerController *videoPicker = [[UIImagePickerController alloc] init];
    //    videoPicker.delegate = self; // ensure you set the delegate so when a video is chosen the right method can be called
    //
    //    videoPicker.modalPresentationStyle = UIModalPresentationCurrentContext;
    //    // This code ensures only videos are shown to the end user
    //    videoPicker.mediaTypes = @[(NSString*)kUTTypeMovie, (NSString*)kUTTypeAVIMovie, (NSString*)kUTTypeVideo, (NSString*)kUTTypeMPEG4];
    //
    //    videoPicker.videoQuality = UIImagePickerControllerQualityTypeHigh;
    //    [self presentViewController:videoPicker animated:YES completion:nil];
}
-(IBAction)ButtonCammera_Action:(id)sender
{
    SelectGallery=@"Cam";
    strCameraVedio=@"Cam";
    self.Button_Gallery.hidden=YES;
    self.Button_Videos.hidden=YES;
    self.Button_Cammera.hidden=YES;
    
    
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = NO;
    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    
    [self presentViewController:picker animated:true completion:nil];
}
-(IBAction)GalleryButton:(id)sender
{
    SelectGallery=@"Gal";
    
    
    
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary])
    {
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        //[picker setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
        picker.sourceType =  UIImagePickerControllerSourceTypePhotoLibrary;
        picker.mediaTypes =[UIImagePickerController availableMediaTypesForSourceType:picker.sourceType];
        picker.allowsEditing = NO;
        
        [self presentViewController:picker animated:true completion:nil];
    }
    
    
}
-(IBAction)ButtonVideo_Action:(id)sender
{
    SelectGallery=@"Record";
    strCameraVedio=@"Record";
    self.Button_Gallery.hidden=YES;
    self.Button_Videos.hidden=YES;
    self.Button_Cammera.hidden=YES;
    //    BackroundImg.hidden=YES;
    [self startCameraControllerFromViewController: self
                                    usingDelegate: self];
}
#pragma mark-Cammera Delegates...

- (BOOL) startCameraControllerFromViewController: (UIViewController*) controller
                                   usingDelegate: (id <UIImagePickerControllerDelegate,
                                                   UINavigationControllerDelegate>) delegate {
    
    if (([UIImagePickerController isSourceTypeAvailable:
          UIImagePickerControllerSourceTypeCamera] == NO)
        || (delegate == nil)
        || (controller == nil))
        return NO;
    // UIImage *flippedImage = [UIImage imageWithCGImage:picture.CGImage scale:picture.scale orientation:UIImageOrientationLeftMirrored];
    
    cameraUI = [[UIImagePickerController alloc] init];
    cameraUI.sourceType = UIImagePickerControllerSourceTypeCamera;
    
    
    // Displays a control that allows the user to choose movie capture
    cameraUI.mediaTypes = [[NSArray alloc] initWithObjects: (NSString *) kUTTypeMovie, nil];
    cameraUI.videoQuality = UIImagePickerControllerQualityTypeIFrame1280x720;
    
    cameraUI.showsCameraControls = YES;
    cameraUI.videoMaximumDuration = 60.0f;
    
    cameraUI.allowsEditing = NO;
    cameraUI.allowsEditing=false;
    cameraUI.delegate = delegate;
    //    self.videoTimer =  [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(changeValue) userInfo:nil repeats:YES];
    //    remainingCounts = 60;
    
    [controller presentModalViewController: cameraUI animated: YES];
    return YES;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

-(void)RecordingVediosImagepicker
{
    [pcker1.view addSubview:transperentViewIndicator];
    NSString *finalVideoURLString = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    finalVideoURLString = [finalVideoURLString stringByAppendingPathComponent:@"compressedVideo.mp4"];
    NSFileManager *manager = [NSFileManager defaultManager];
    [manager createDirectoryAtPath:finalVideoURLString withIntermediateDirectories:YES attributes:nil error:nil];
    [manager removeItemAtPath:finalVideoURLString error:nil];
    
    NSURL *outputVideoUrl = ([[NSURL URLWithString:finalVideoURLString] isFileURL] == 1)?([NSURL URLWithString:finalVideoURLString]):([NSURL fileURLWithPath:finalVideoURLString]); // Url Should be a file Url, so here we check and convert it into a file Url
    
    
    
    SDAVAssetExportSession *compressionEncoder = [SDAVAssetExportSession.alloc initWithAsset:[AVAsset assetWithURL:_videoURL]]; // provide inputVideo Url Here
    compressionEncoder.outputFileType = AVFileTypeMPEG4;
    compressionEncoder.outputURL = outputVideoUrl;
    compressionEncoder.shouldOptimizeForNetworkUse = YES;//Provide output video Url here
    compressionEncoder.videoSettings = @
    {
    AVVideoCodecKey: AVVideoCodecH264,
    AVVideoWidthKey: Vedio_Width,   //Set your resolution width here
    AVVideoHeightKey: Vedio_Height,  //set your resolution height here
    AVVideoCompressionPropertiesKey: @
        {
        AVVideoAverageBitRateKey:BitrateValue,// @2000000, // Give your bitrate here for lower size give low values
        AVVideoProfileLevelKey: AVVideoProfileLevelH264High40,
        },
    };
    compressionEncoder.audioSettings = @
    {
    AVFormatIDKey: @(kAudioFormatMPEG4AAC),
    AVNumberOfChannelsKey: @2,
    AVSampleRateKey: @44100,
    AVEncoderBitRateKey: @128000,
    };
    
    [compressionEncoder exportAsynchronouslyWithCompletionHandler:^
     {
         if (compressionEncoder.status == AVAssetExportSessionStatusCompleted)
         {
             NSLog(@"Compression Export Completed Successfully");
             
             NSData* videoData = [NSData dataWithContentsOfFile:[outputVideoUrl path]];
             int videoSize = [videoData length]/1024/1024;
             
             // [self.videoURL path]
             NSLog(@"data size path==%d",videoSize);
             if (videoSize >5)
             {
                 if (videoSize < 8)
                 {
                     BitrateValue=@430000;
                 }
                 else
                 {
                     BitrateValue=@300000;
                 }
                 [self RecordingVediosImagepicker];
             }
             else
             {
                 imageData=[NSData dataWithContentsOfFile:[outputVideoUrl path]];
                 // ImageNSdata = [imageData base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
                 
                 ImageNSdata = [Base64 encode:imageData];
                 
                 encodedImage = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(NULL,(CFStringRef)ImageNSdata,NULL,(CFStringRef)@"!*'\"();:@&=+$,/?%#[]% ",CFStringConvertNSStringEncodingToEncoding(NSUTF8StringEncoding)));
                 
                 
                 
                 
                 
                
                 
                 
                 self.videoController = [[MPMoviePlayerController alloc] init];
                 
                 [self.videoController setContentURL:outputVideoUrl];
                 
                 
                 
                 [self.videoController setScalingMode:MPMovieScalingModeAspectFill];
                 _videoController.fullscreen=YES;
                 _videoController.allowsAirPlay=NO;
                 _videoController.shouldAutoplay=YES;
                 
                 
                 BackroundImg.image=FrameImage;
                 
                 
                 imageDataThumb = UIImageJPEGRepresentation(FrameImage, 0.7);
                 
                 
                 ImageNSdataThumb = [Base64 encode:imageDataThumb];
                 
                 
                 encodedImageThumb = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(NULL,(CFStringRef)ImageNSdataThumb,NULL,(CFStringRef)@"!*'\"();:@&=+$,/?%#[]% ",CFStringConvertNSStringEncodingToEncoding(NSUTF8StringEncoding)));
                 
                 
                
                 
                 
                 
                 
                 [pcker1.view hideActivityViewWithAfterDelay:1];
                 dispatch_async(dispatch_get_main_queue(), ^{
                     [self dismissViewControllerAnimated:YES completion:NULL];
                     
                     if (TextView_Description.text.length==0 || encodedImage.length==0)
                     {
                         Button_next.enabled=NO;
                           Button_nexttop.hidden=YES;
                         [Button_next setTitleColor:[UIColor colorWithRed:186/255.0 green:188/255.0 blue:190/255.0 alpha:1] forState:UIControlStateNormal];
                         Button_next.layer.borderColor=[UIColor colorWithRed:186/255.0 green:188/255.0 blue:190/255.0 alpha:1].CGColor;
                     }
                     else
                     {
                         Button_next.enabled=YES;
                           Button_nexttop.hidden=NO;
                         [Button_next setTitleColor:[UIColor colorWithRed:67/255.0 green:188/255.0 blue:255/255.0 alpha:1] forState:UIControlStateNormal];
                         Button_next.layer.borderColor=[UIColor colorWithRed:67/255.0 green:188/255.0 blue:255/255.0 alpha:1].CGColor;
                     }
                     
                     
                     
                 });
                 
             }
             
         }
         else if (compressionEncoder.status == AVAssetExportSessionStatusCancelled)
         {
             NSLog(@"Compression Export Canceled");
             
             NSLog(@"Compression Failed==%@",compressionEncoder.error);
             UIAlertController * alert=[UIAlertController
                                        
                                        alertControllerWithTitle:@"Compression Canceled" message:@"Compression Export Canceled. Please try again." preferredStyle:UIAlertControllerStyleAlert];
             
             UIAlertAction* yesButton = [UIAlertAction
                                         actionWithTitle:@"ReCompress"
                                         style:UIAlertActionStyleDefault
                                         handler:^(UIAlertAction * action)
                                         {
                                             [self.view hideActivityViewWithAfterDelay:0];
                                             [self RecordingVediosImagepicker];
                                             
                                         }];
             UIAlertAction* noButton = [UIAlertAction
                                        actionWithTitle:@"Cancel"
                                        style:UIAlertActionStyleDefault
                                        handler:^(UIAlertAction * action)
                                        {
                                            [self.view hideActivityViewWithAfterDelay:0];
                                            [pcker1 dismissViewControllerAnimated:YES completion:NULL];
                                            
                                        }];
             
             [alert addAction:yesButton];
             [alert addAction:noButton];
             
             [self presentViewController:alert animated:YES completion:nil];
             
         }
         else
         {
             NSLog(@"Compression Failed==%@",compressionEncoder.error);
             UIAlertController * alert=[UIAlertController
                                        
                                        alertControllerWithTitle:@"Compression Error" message:@"Could not compress your video. Please try again." preferredStyle:UIAlertControllerStyleAlert];
             
             UIAlertAction* yesButton = [UIAlertAction
                                         actionWithTitle:@"ReCompress"
                                         style:UIAlertActionStyleDefault
                                         handler:^(UIAlertAction * action)
                                         {
                                             [self.view hideActivityViewWithAfterDelay:0];
                                             [self RecordingVediosImagepicker];
                                             
                                         }];
             UIAlertAction* noButton = [UIAlertAction
                                        actionWithTitle:@"Cancel"
                                        style:UIAlertActionStyleDefault
                                        handler:^(UIAlertAction * action)
                                        {
                                            [self.view hideActivityViewWithAfterDelay:0];
                                            [pcker1 dismissViewControllerAnimated:YES completion:NULL];
                                            
                                        }];
             
             [alert addAction:yesButton];
             [alert addAction:noButton];
             
             [self presentViewController:alert animated:YES completion:nil];
             
         }
     }];
    
    
}
-(void)imagePickerController:(UIImagePickerController *)picker
didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    mediaTypeCheck = [info objectForKey:UIImagePickerControllerMediaType];
    
    

    if ([mediaTypeCheck isEqualToString:@"public.movie"])
    {
        ;
        self.Button_Gallery.hidden=YES;
        self.Button_Videos.hidden=YES;
        self.Button_Cammera.hidden=YES;
        BackroundImg.hidden=NO;
        Image_Play.hidden=NO;
        
        
        _videoController.view.hidden=NO;
        
        
        
        self.videoURL = info[UIImagePickerControllerMediaURL];
        
        
        
        mediatypeVal=@"VIDEO";
        
        assettype=@"Video";
        self.videoURL = info[UIImagePickerControllerMediaURL];
        
        
        NSData* videoData = [NSData dataWithContentsOfFile:[self.videoURL path]];
        int videoSize = [videoData length]/1024/1024;
        
        
        NSLog(@"data size==%d",videoSize);
        if (videoSize <=12)
        {
            
            AVURLAsset *asset = [[AVURLAsset alloc] initWithURL:self.videoURL options:nil];
            
            
            AVAssetImageGenerator *generateImg = [[AVAssetImageGenerator alloc] initWithAsset:asset];
            generateImg.appliesPreferredTrackTransform = YES;
            NSError *error = NULL;
            CMTime time = CMTimeMake(1, 7);
            CGImageRef refImg = [generateImg copyCGImageAtTime:time actualTime:NULL error:&error];
            NSLog(@"error==%@, Refimage==%@", error, refImg);
            
            
            FrameImage= [[UIImage alloc] initWithCGImage:refImg];
            
            NSLog(@"FrameImage height size==%f",FrameImage.size.height);
            NSLog(@"FrameImage width %fze==%f",FrameImage.size.width);
            
            
            
            if (FrameImage.size.height > FrameImage.size.width)
            {
                Vedio_Height=@960;
                Vedio_Width=@540;
            }
            else
            {
                Vedio_Height=@540;
                Vedio_Width=@960;
            }
            //
            //        dispatch_sync(dispatch_get_main_queue(), ^{
            pcker1=[[UIImagePickerController alloc]init];
            pcker1=picker;
            //        });
            
            
            [self RecordingVediosImagepicker];
            
            
            
        }
        else
        {
            
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Over Size" message:@"Please limit your media size to less than 12mb." preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction *actionOk = [UIAlertAction actionWithTitle:@"Ok"
                                                               style:UIAlertActionStyleDefault handler:^(UIAlertAction *action)
                                       {
                                           
                                           
                                           strinRetake=@"";
                                           encodedImage=@"";
                                           strCameraVedio=@"Cam";                                                                                                                                                                                                                                                                                                                                                                                                                                                  self.videoController=nil;
                                           _videoController.view.hidden=YES;
                                           BackroundImg.hidden=YES;
                                           Image_Play.hidden=YES;
                                           self.Button_Gallery.hidden=NO;
                                           self.Button_Videos.hidden=NO;
                                           self.Button_Cammera.hidden=NO;
                                           
                                           
                                           [[self navigationController] dismissViewControllerAnimated:YES completion:nil];
                                           
                                       }];
            
            [alertController addAction:actionOk];
            [picker presentViewController:alertController animated:YES completion:nil];
            
            
            
        }
        
        
        
    }
    else if ([mediaTypeCheck isEqualToString:@"public.image"])
    {
        
        self.Button_Gallery.hidden=YES;
        self.Button_Videos.hidden=YES;
        self.Button_Cammera.hidden=YES;
        Image_Play.hidden=YES;
        BackroundImg.hidden=NO;
        // UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
        assettype=@"Image";
        mediatypeVal=@"IMAGE";
        encodedImageThumb=@"";
        //chosenImage = info[UIImagePickerControllerEditedImage];
        chosenImage = info[UIImagePickerControllerOriginalImage];
        
        
        // NSData *imageData = UIImageJPEGRepresentation(chosenImage, 0.7);
        
        UIImageView * imageBackround=[[UIImageView alloc]initWithImage:chosenImage];
        
        float actualHeight = chosenImage.size.height;
        float actualWidth = chosenImage.size.width;
        float maxHeight = 1000.0;
        float maxWidth = 1000.0;
        float imgRatio = actualWidth/actualHeight;
        float maxRatio = maxWidth/maxHeight;
        float compressionQuality = 0.7;
        
        if (actualHeight > maxHeight || actualWidth > maxWidth){
            if(imgRatio < maxRatio){
                
                imgRatio = maxHeight / actualHeight;
                actualWidth = imgRatio * actualWidth;
                actualHeight = maxHeight;
            }
            else if(imgRatio > maxRatio){
                //adjust height according to maxWidth
                imgRatio = maxWidth / actualWidth;
                actualHeight = imgRatio * actualHeight;
                actualWidth = maxWidth;
            }
            else{
                actualHeight = maxHeight;
                actualWidth = maxWidth;
            }
        }
        NSLog(@"Actual height : %f and Width : %f",actualHeight,actualWidth);
        CGRect rect = CGRectMake(0.0, 0.0, actualWidth, actualHeight);
        UIGraphicsBeginImageContext(rect.size);
        [imageBackround.image drawInRect:rect];
        UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
        NSData *imageDataback = UIImageJPEGRepresentation(img, compressionQuality);
        UIGraphicsEndImageContext();
        
        NSLog(@"size of image in KB: %f ", imageDataback.length/1024.0);
        
        
        
        
        // NSData * imageData1 = UIImageJPEGRepresentation(chosenImage, 0.3);
        
        float maxHeight1 = 400.0;
        float maxWidth1 = 400.0;
        float imgRatio1 = actualWidth/actualHeight;
        float maxRatio1 = maxWidth1/maxHeight1;
        float compressionQuality1 = 0.5;
        
        if (actualHeight > maxHeight1 || actualWidth > maxWidth1){
            if(imgRatio1 < maxRatio1){
                
                imgRatio1 = maxHeight1 / actualHeight;
                actualWidth = imgRatio1 * actualWidth;
                actualHeight = maxHeight1;
            }
            else if(imgRatio1 > maxRatio1){
                //adjust height according to maxWidth
                imgRatio1 = maxWidth1 / actualWidth;
                actualHeight = imgRatio1 * actualHeight;
                actualWidth = maxWidth1;
            }
            else{
                actualHeight = maxHeight1;
                actualWidth = maxWidth1;
            }
        }
        NSLog(@"Actual height : %f and Width : %f",actualHeight,actualWidth);
        CGRect rect1 = CGRectMake(0.0, 0.0, actualWidth, actualHeight);
        UIGraphicsBeginImageContext(rect1.size);
        [imageBackround.image drawInRect:rect1];
        UIImage *img1 = UIGraphicsGetImageFromCurrentImageContext();
        NSData *imageDataback1 = UIImageJPEGRepresentation(img1, compressionQuality1);
        UIGraphicsEndImageContext();
        NSLog(@"size of image in KB: %f ", imageDataback1.length/1024.0);
        BackroundImg.image = [UIImage imageWithData:imageDataback1];
        BackroundImg.contentMode=UIViewContentModeScaleAspectFill;
        
        ImageNSdataThumb = [Base64 encode:imageDataback1];
        
        // ImageNSdata = [imageData base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
        
        ImageNSdata = [Base64 encode:imageDataback];
        
        encodedImageThumb = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(NULL,(CFStringRef)ImageNSdataThumb,NULL,(CFStringRef)@"!*'\"();:@&=+$,/?%#[]% ",CFStringConvertNSStringEncodingToEncoding(NSUTF8StringEncoding)));
        
        encodedImage = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(NULL,(CFStringRef)ImageNSdata,NULL,(CFStringRef)@"!*'\"();:@&=+$,/?%#[]% ",CFStringConvertNSStringEncodingToEncoding(NSUTF8StringEncoding)));
        
      
        
        if (TextView_Description.text.length==0 || encodedImage.length==0)
        {
            Button_next.enabled=NO;
              Button_nexttop.hidden=YES;
            [Button_next setTitleColor:[UIColor colorWithRed:186/255.0 green:188/255.0 blue:190/255.0 alpha:1] forState:UIControlStateNormal];
            Button_next.layer.borderColor=[UIColor colorWithRed:186/255.0 green:188/255.0 blue:190/255.0 alpha:1].CGColor;
        }
        else
        {
            Button_next.enabled=YES;
              Button_nexttop.hidden=NO;
            [Button_next setTitleColor:[UIColor colorWithRed:67/255.0 green:188/255.0 blue:255/255.0 alpha:1] forState:UIControlStateNormal];
            Button_next.layer.borderColor=[UIColor colorWithRed:67/255.0 green:188/255.0 blue:255/255.0 alpha:1].CGColor;
        }
        
        
        [[self navigationController] dismissViewControllerAnimated:YES completion:nil];
        [picker dismissViewControllerAnimated:YES completion:NULL];
        
  
    }
    else
    {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Unknown file type" message:@"You can only upload images or videos. Please check the media type and try again." preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *actionOk = [UIAlertAction actionWithTitle:@"Ok"
                                                           style:UIAlertActionStyleDefault handler:^(UIAlertAction *action)
                                   {
                                       
                                   }];
        
        [alertController addAction:actionOk];
        [self presentViewController:alertController animated:YES completion:nil];
    }
    
    
}



- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    if (![strinRetake isEqualToString:@"Image"])
    {
        self.Button_Gallery.hidden=NO;
        self.Button_Videos.hidden=NO;
        self.Button_Cammera.hidden=NO;
        BackroundImg.hidden=YES;
    }
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    [self.view endEditing:YES];
   
    if ([SelectGallery isEqualToString:@"Back"])
    {
        if (buttonIndex== 0)
        {
            [[NSNotificationCenter defaultCenter] postNotificationName:@"EditTagset" object:[NSDictionary dictionaryWithObject:@"yes" forKey:@"desc"]];
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
    else if ([SelectGallery isEqualToString:@"Gal"])
    {
       
       
        if (buttonIndex== 0)
        {
            strinRetake=@"";
            encodedImage=@"";
            BackroundImg.image=nil;
            BackroundImg.hidden=YES;
            self.Button_Gallery.hidden=NO;
            self.Button_Videos.hidden=NO;
            self.Button_Cammera.hidden=NO;
            self.Image_Play.hidden=YES;
            if (TextView_Description.text.length==0 || encodedImage.length==0)
            {
                Button_next.enabled=NO;
                Button_nexttop.hidden=YES;
                [Button_next setTitleColor:[UIColor colorWithRed:186/255.0 green:188/255.0 blue:190/255.0 alpha:1] forState:UIControlStateNormal];
                Button_next.layer.borderColor=[UIColor colorWithRed:186/255.0 green:188/255.0 blue:190/255.0 alpha:1].CGColor;
            }
            else
            {
                Button_next.enabled=YES;
                Button_nexttop.hidden=NO;
                [Button_next setTitleColor:[UIColor colorWithRed:67/255.0 green:188/255.0 blue:255/255.0 alpha:1] forState:UIControlStateNormal];
                Button_next.layer.borderColor=[UIColor colorWithRed:67/255.0 green:188/255.0 blue:255/255.0 alpha:1].CGColor;
            }
            
        }
        else  if (buttonIndex== 1)
        {
            if ([mediaTypeCheck isEqualToString:@"public.movie"])
            {
                movieController = [[MPMoviePlayerViewController alloc] initWithContentURL:self.videoURL];
                
                
                [self presentMoviePlayerViewControllerAnimated:movieController];
                [movieController.moviePlayer prepareToPlay];
                [movieController.moviePlayer play];
            }
            else
            {
                [self displayImage:BackroundImg withImage:chosenImage];
            }
            
        }
        else  if (buttonIndex== 2)
        {
            
            strinRetake=@"Image";
            
            [self GalleryButton:self];
        }
        
    }
    else if ([SelectGallery isEqualToString:@"Cam"])
    {
        
        if (buttonIndex== 0)
        {
            strinRetake=@"";
            encodedImage=@"";
            BackroundImg.image=nil;
            BackroundImg.hidden=YES;
            self.Button_Gallery.hidden=NO;
            self.Button_Videos.hidden=NO;
            self.Button_Cammera.hidden=NO;
            if (TextView_Description.text.length==0 || encodedImage.length==0)
            {
                Button_next.enabled=NO;
                  Button_nexttop.hidden=YES;
                [Button_next setTitleColor:[UIColor colorWithRed:186/255.0 green:188/255.0 blue:190/255.0 alpha:1] forState:UIControlStateNormal];
                Button_next.layer.borderColor=[UIColor colorWithRed:186/255.0 green:188/255.0 blue:190/255.0 alpha:1].CGColor;
            }
            else
            {
                Button_next.enabled=YES;
                  Button_nexttop.hidden=NO;
                [Button_next setTitleColor:[UIColor colorWithRed:67/255.0 green:188/255.0 blue:255/255.0 alpha:1] forState:UIControlStateNormal];
                Button_next.layer.borderColor=[UIColor colorWithRed:67/255.0 green:188/255.0 blue:255/255.0 alpha:1].CGColor;
            }
            
        }
        else  if (buttonIndex== 1)
        {
           
            [BackroundImg setImage:chosenImage];
            BackroundImg.contentMode = UIViewContentModeScaleAspectFill;
            BackroundImg.clipsToBounds = YES;
            [BackroundImg setupImageViewer1];
            
        }
        else  if (buttonIndex== 2)
        {
            strinRetake=@"Image";
           
            
            [self ButtonCammera_Action:self];
        }
    }
    
    else if ([SelectGallery isEqualToString:@"Record"])
    {
        
        if (buttonIndex== 0)
        {
            strinRetake=@"";
            encodedImage=@"";
            strCameraVedio=@"Cam";                                                                                                                                                                                                                                                                                                                                                                                                                                                  self.videoController=nil;
            _videoController.view.hidden=YES;
            BackroundImg.hidden=YES;
            Image_Play.hidden=YES;
            self.Button_Gallery.hidden=NO;
            self.Button_Videos.hidden=NO;
            self.Button_Cammera.hidden=NO;
            if (TextView_Description.text.length==0 || encodedImage.length==0)
            {
                Button_next.enabled=NO;
                  Button_nexttop.hidden=YES;
                [Button_next setTitleColor:[UIColor colorWithRed:186/255.0 green:188/255.0 blue:190/255.0 alpha:1] forState:UIControlStateNormal];
                Button_next.layer.borderColor=[UIColor colorWithRed:186/255.0 green:188/255.0 blue:190/255.0 alpha:1].CGColor;
            }
            else
            {
                Button_next.enabled=YES;
                  Button_nexttop.hidden=NO;
                [Button_next setTitleColor:[UIColor colorWithRed:67/255.0 green:188/255.0 blue:255/255.0 alpha:1] forState:UIControlStateNormal];
                Button_next.layer.borderColor=[UIColor colorWithRed:67/255.0 green:188/255.0 blue:255/255.0 alpha:1].CGColor;
            }
            
        }
        else  if (buttonIndex== 1)
        {
            movieController = [[MPMoviePlayerViewController alloc] initWithContentURL:self.videoURL];
            
            
            [self presentMoviePlayerViewControllerAnimated:movieController];
            [movieController.moviePlayer prepareToPlay];
            [movieController.moviePlayer play];
           
        }
        else  if (buttonIndex== 2)
        {
            strinRetake=@"Image";
          
            [self ButtonVideo_Action:self];
        }
    }
    
    
    
    
    
    
}
- (void)BackImageViewTap:(UITapGestureRecognizer*)gesture
{
    if ([assettype isEqualToString:@"Image"])
    {
        
        
        UIActionSheet *popup = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:@"Remove" otherButtonTitles:@"View",@"Retake",nil];
        // GalStr=@"GalStr";
        popup.tag = 2;
        [popup showInView:self.view];
    }
    else
        
    {
        UIActionSheet *popup = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:@"Remove" otherButtonTitles:@"Play",@"Retake",nil];
        popup.tag = 3;
        [popup showInView:self.view];
    }
}


- (void) displayImage:(UIImageView*)imageView withImage:(UIImage*)image
{
    [BackroundImg setImage:image];
    BackroundImg.contentMode = UIViewContentModeScaleAspectFill;
    [BackroundImg setupImageViewer1];
    BackroundImg.clipsToBounds = YES;
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}
@end
