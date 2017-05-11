//
//  WatchVedioScrollViewController.m
//  care2Dare
//
//  Created by Spiel's Macmini on 5/3/17.
//  Copyright © 2017 Spiel's Macmini. All rights reserved.
//

#import "WatchVedioScrollViewController.h"
#import <Foundation/Foundation.h>
#import <CoreMedia/CMTime.h>
#import <AVFoundation/AVAudioPlayer.h>
#import <AVFoundation/AVFoundation.h>
#import <AVKit/AVKit.h>
#import "SBJsonParser.h"
#import "Reachability.h"
#import "UIImageView+WebCache.h"
#import "ContributeDaetailPageViewController.h"
#import "ProfilePageDetailsViewController.h"
#import "StatsViewController.h"
#define CELL_CONTENT_MARGIN 0.0f
@interface WatchVedioScrollViewController ()
{
    UIView * View_PlayerView,*View_PlayerView1,*View_PlayerView2,*playerView_linereviewsVedio,*PlayerView_Backround,*PlayerView3;
    NSTimer * timerFadeout;
    UIButton *Button_PlayPause,*Button_VolumeMute,*Button_ThreeDots,* Button_back;
    NSTimer * timer;
    Float64 dur,progrssVal,CurrentTimes;
    NSURL *urlVediop;
    AVPlayerItem *item;
    AVPlayer * player;
    AVPlayerViewController *playerViewController;
    NSUserDefaults *defaults;
    NSMutableArray * Array_VediosData;
    NSDictionary *urlplist;
    NSString *str_name,*str_days,*str_friendstatus,*Str_newstatus,*str_profileurl,*Flag_watch,*Str_urlVedio,* userId_Prof1,*Str_totalViews,*Falg_FadeInFadeOut,*Str_Flag_Positions,*str_FlagLoadinViewControllerelements,*Str_UserTapPlayVedioindex;
    NSInteger indexVedio;
    CALayer *Bottomborder_Cell2;
    CGSize size;
    AVURLAsset *asset;
    float imageHeight;
    UIProgressView * progressslider;
    UIImageView * Image_Profile_View2,*image_Comments,*image_Share,*Image_stats,  * Image_NewFrnd;
    UIButton *ButtonImage_acceptFrnd_View2;
    UILabel * Label_profilename_view2,*label_days_View2,*Label_stats,*label_comments,*label_share,*label_reviews,*label_reviewvedio;
    UITextView * TextView_Title3;
     CGFloat X_postion_view3, Y_postion_view3, Width_postion_view3, Height_postion_view3;
    UIActivityIndicatorView *indicatorView;
    NSMutableArray *ImageArrayTag;
    UIImageView * imagesTagRow;
}
@end

@implementation WatchVedioScrollViewController
@synthesize table_scrollview;
@synthesize str_Userid2val,str_ChallengeidVal,str_challengeTitle,str_image_Data,videoid1,indexVedioindex;
- (void)viewDidLoad
{
    [super viewDidLoad];
    defaults=[[NSUserDefaults alloc]init];
//    indexVedio=1;
    
    indexVedio=indexVedioindex+1;
    [[UIApplication sharedApplication] setStatusBarHidden:YES];
    NSString *plistPath = [[NSBundle mainBundle]pathForResource:@"UrlName" ofType:@"plist"];
    urlplist = [NSDictionary dictionaryWithContentsOfFile:plistPath];
    table_scrollview.delegate=self;
    
    
    ImageArrayTag=[[NSMutableArray alloc]init];
    
    UIImageView *attachmentImageNew = [[UIImageView alloc] initWithFrame:CGRectMake(0,0, self.view.frame.size.width, self.view.frame.size.height)];
    attachmentImageNew.image = str_image_Data;
    attachmentImageNew.backgroundColor = [UIColor redColor];
    attachmentImageNew.contentMode = UIViewContentModeScaleAspectFit;
    
    
    float widthRatio = attachmentImageNew.bounds.size.width / attachmentImageNew.image.size.width;
    float heightRatio = attachmentImageNew.bounds.size.height / attachmentImageNew.image.size.height;
    float scale = MIN(widthRatio, heightRatio);
    float imageWidth = scale * attachmentImageNew.image.size.width;
    imageHeight = scale * attachmentImageNew.image.size.height;
   // [table_scrollview setFrame:CGRectMake(0, 0, self.view.frame.size.width, imageHeight)];
    NSLog(@"Size of pic is %f",imageWidth);
    NSLog(@"Size of pic is %f",imageHeight);
    table_scrollview.backgroundColor=[UIColor blackColor];
     playerViewController = [[AVPlayerViewController alloc] init];
    View_PlayerView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, (imageHeight)+7.4)];
    View_PlayerView.backgroundColor=[UIColor blackColor];
    
    

    
    
    View_PlayerView1=[[UIView alloc]initWithFrame:CGRectMake(0,View_PlayerView.frame.origin.y+View_PlayerView.frame.size.height, self.view.frame.size.width, imageHeight)];
    
    
    
    ///Player view 1.......................//
    progressslider = [[UIProgressView alloc] init];
    
    progressslider.frame = CGRectMake(0,imageHeight+2.2,self.view.frame.size.width,10);
    
    [progressslider setProgressTintColor:[UIColor colorWithRed:20/255.0 green:245/255.0 blue:115/255.0 alpha:1.0]];
    
    [progressslider setUserInteractionEnabled:NO];
    
    progressslider.progress=0.0f;
    
    CGAffineTransform transform = CGAffineTransformMakeScale(1.0f, 2.0f);
    progressslider.transform = transform;
    [progressslider setProgressViewStyle:UIProgressViewStyleBar];
    
    [progressslider setTrackTintColor:[UIColor whiteColor]];
//    progressslider.clipsToBounds=YES;
//    progressslider.layer.cornerRadius=progressslider.frame.size.height/2;
    //   OR
    // [progressView setTrackImage:[UIImage    imageNamed:@"logo.png"]];
    
   
    
    View_PlayerView1.backgroundColor=[UIColor blackColor];
   
    
     [table_scrollview addSubview:View_PlayerView];
     [View_PlayerView addSubview:progressslider];
    
     [table_scrollview addSubview:View_PlayerView1];
    

    table_scrollview.contentSize=CGSizeMake(self.view.frame.size.width, self.view.frame.size.height);
    
    

    
  
    [playerViewController.view setFrame:CGRectMake(0, 0,View_PlayerView.frame.size.width,imageHeight)];
    
    playerViewController.showsPlaybackControls = NO;
    
    playerViewController.view.hidden = NO;
    
    
    
  [View_PlayerView  addSubview:playerViewController.view];
    
    PlayerView_Backround=[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, (imageHeight)+7.4)];
    PlayerView_Backround.backgroundColor=[UIColor clearColor];
    
    
    PlayerView_Backround.userInteractionEnabled=YES;
    UITapGestureRecognizer *image_PlayerTapped =[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(PlayerTapped_ViewAction:)];
    [PlayerView_Backround addGestureRecognizer:image_PlayerTapped];
   
     [View_PlayerView addSubview:PlayerView_Backround];
    
    Button_back=[[UIButton alloc]initWithFrame:CGRectMake(16,16,30,30)];
    
    [Button_back setImage:[UIImage imageNamed:@"whitebackarrow.png"] forState:UIControlStateNormal];
    [Button_back setTitle:@"" forState:UIControlStateNormal];
    [Button_back addTarget:self action:@selector(Button_Back_Action:) forControlEvents:UIControlEventTouchUpInside];
    
    Button_back.backgroundColor=[UIColor clearColor];
    [Button_back setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
  
    
    
    [View_PlayerView addSubview:Button_back];
    
    
    
    indicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    indicatorView.frame=CGRectMake((View_PlayerView.frame.size.width/2)-10, (indicatorView.frame.size.height/2)-15, 20, 20);
    [indicatorView startAnimating];
    [indicatorView setColor:[UIColor whiteColor]];
    indicatorView.center=playerViewController.view.center;
     [View_PlayerView addSubview:indicatorView];
    
    
    
    
    
    
    
    
    Button_PlayPause=[[UIButton alloc]initWithFrame:CGRectMake(0, 0,50,50)];
    
    [Button_PlayPause setImage:[UIImage imageNamed:@"Pause Filled-100.png"] forState:UIControlStateNormal];
    
    [Button_PlayPause setTitle:@"" forState:UIControlStateNormal];
    [Button_PlayPause addTarget:self action:@selector(Play_Action:) forControlEvents:UIControlEventTouchUpInside];
    
    Button_PlayPause.backgroundColor=[UIColor clearColor];
    [Button_PlayPause setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    Button_PlayPause.center=View_PlayerView.center;
    
    Button_VolumeMute=[[UIButton alloc]initWithFrame:CGRectMake(self.view.frame.size.width-30,imageHeight-30,20,20)];
  
    
    [Button_VolumeMute setTitle:@"" forState:UIControlStateNormal];
    [Button_VolumeMute addTarget:self action:@selector(MutePlay_Action:) forControlEvents:UIControlEventTouchUpInside];
    
    Button_VolumeMute.backgroundColor=[UIColor clearColor];
    [Button_VolumeMute setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [Button_VolumeMute setImage:[UIImage imageNamed:@"High Volume Filled-100.png"] forState:UIControlStateNormal];
    

    
    
    Button_ThreeDots=[[UIButton alloc]initWithFrame:CGRectMake(self.view.frame.size.width-40,20,32,32)];
    
    
    [Button_ThreeDots setTitle:@"" forState:UIControlStateNormal];
    [Button_ThreeDots addTarget:self action:@selector(Threedots_Action:) forControlEvents:UIControlEventTouchUpInside];
    
    Button_ThreeDots.backgroundColor=[UIColor clearColor];
    [Button_ThreeDots setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [Button_ThreeDots setImage:[UIImage imageNamed:@"3dots.png"] forState:UIControlStateNormal];
    Button_ThreeDots.contentMode=UIViewContentModeScaleAspectFit;
    
    [[Button_ThreeDots imageView] setContentMode: UIViewContentModeScaleAspectFit];
    [Button_ThreeDots setImage:[UIImage imageNamed:@"3dots.png"] forState:UIControlStateNormal];
////////////////////////////////////////////////////////////////////////////
    
/////plyerView 2...............///
 
    Image_Profile_View2=[[UIImageView alloc]initWithFrame:CGRectMake(7, 8, 45, 45)];
//    Image_Profile_View2.backgroundColor=[UIColor greenColor];
    Image_Profile_View2.contentMode=UIViewContentModeScaleAspectFill;
    Image_Profile_View2.clipsToBounds=YES;
    Image_Profile_View2.layer.cornerRadius=Image_Profile_View2.frame.size.height/2;
    [View_PlayerView1 addSubview:Image_Profile_View2];
    
    ButtonImage_acceptFrnd_View2=[[UIButton alloc]initWithFrame:CGRectMake((self.view.frame.size.width-60),17, 28, 28)];
    ButtonImage_acceptFrnd_View2.backgroundColor=[UIColor clearColor];
 
    [View_PlayerView1 addSubview:ButtonImage_acceptFrnd_View2];
    
    Label_profilename_view2=[[UILabel alloc]initWithFrame:CGRectMake(61, 8, (self.view.frame.size.width-ButtonImage_acceptFrnd_View2.frame.size.width), 28)];
    Label_profilename_view2.text=@"sachin mokashi";
    Label_profilename_view2.textColor=[UIColor colorWithRed:186/255.0 green:188/255.0 blue:190/255.0 alpha:1];
    [View_PlayerView1 addSubview:Label_profilename_view2];

    
    label_days_View2=[[UILabel alloc]initWithFrame:CGRectMake(61, 32, 273, 18)];
     label_days_View2.text=@"2 day agoas";
    
     label_days_View2.textColor=[UIColor colorWithRed:186/255.0 green:188/255.0 blue:190/255.0 alpha:1];
     label_days_View2.font=[UIFont fontWithName:@"SanFranciscoDisplay-Medium" size:14.0];
    [View_PlayerView1 addSubview:label_days_View2];
    [View_PlayerView1 setFrame:CGRectMake(View_PlayerView1.frame.origin.x, View_PlayerView1.frame.origin.y,View_PlayerView1.frame.size.width,Image_Profile_View2.frame.origin.y+Image_Profile_View2.frame.size.height+8)];
        View_PlayerView1.clipsToBounds=YES;
    CALayer *borderBottom_world = [CALayer layer];
    borderBottom_world.backgroundColor = [UIColor colorWithRed:65/255.0 green:65/255.0 blue:65/255.0 alpha:1.0].CGColor;
    borderBottom_world.frame = CGRectMake(0, View_PlayerView1.frame.size.height-1.5, View_PlayerView1.frame.size.width,1.5);
    [View_PlayerView1.layer addSublayer:borderBottom_world];
    
    
    

    
    
//////////////////////////////////
    
    
    ////////textview 2...3......
    
    TextView_Title3=[[UITextView alloc]initWithFrame:CGRectMake(10,View_PlayerView1.frame.origin.y+View_PlayerView1.frame.size.height, self.view.frame.size.width-20, 20)];
    TextView_Title3.backgroundColor=[UIColor blackColor];
    
    TextView_Title3.textColor=[UIColor whiteColor];
    TextView_Title3.font=[UIFont fontWithName:@"SanFranciscoDisplay-Bold" size:24.0];
    
    [table_scrollview addSubview:TextView_Title3];
    ///////////////////////////////////////
    
    
/////////    player view 3..............
    
     View_PlayerView2=[[UIView alloc]initWithFrame:CGRectMake(0,TextView_Title3.frame.origin.y+TextView_Title3.frame.size.height, self.view.frame.size.width, 108)];
    View_PlayerView2.backgroundColor=[UIColor blackColor];
    
    
    Image_stats=[[UIImageView alloc]initWithFrame:CGRectMake(156, 23, 42, 30)];
    [Image_stats setImage:[UIImage imageNamed:@"stats.png"]];
    Image_stats.contentMode=UIViewContentModeScaleAspectFit;
    [View_PlayerView2 addSubview:Image_stats];

    Image_stats.userInteractionEnabled=YES;
    UITapGestureRecognizer *Image_StatsTapped =[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(Image_Stats_Action:)];
    [Image_stats addGestureRecognizer:Image_StatsTapped];
    
    
    
    
    
    image_Comments=[[UIImageView alloc]initWithFrame:CGRectMake(240, 23, 42, 30)];
     [image_Comments setImage:[UIImage imageNamed:@"comments.png"]];
     image_Comments.contentMode=UIViewContentModeScaleAspectFit;
   image_Comments.userInteractionEnabled=YES;
    UITapGestureRecognizer *Image_CommentsTapped =[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(Image_Comments_Action:)];
    [image_Comments addGestureRecognizer:Image_CommentsTapped];
    [View_PlayerView2 addSubview:image_Comments];


    image_Share=[[UIImageView alloc]initWithFrame:CGRectMake(328, 23, 35, 30)];
     [image_Share setImage:[UIImage imageNamed:@"grayshare.png"]];
      image_Share.contentMode=UIViewContentModeScaleAspectFit;
    image_Share.userInteractionEnabled=YES;
    UITapGestureRecognizer *Image_ShareTapped =[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(Image_Share_Action:)];
    [image_Share addGestureRecognizer:Image_ShareTapped];
    
    [View_PlayerView2 addSubview:image_Share];

//    label_reviews=[[UILabel alloc]initWithFrame:CGRectMake(61, 32, 273, 18)];
//    label_reviews.text=@"2 day agoas";
//    label_reviews.textColor=[UIColor colorWithRed:186/255.0 green:188/255.0 blue:190/255.0 alpha:1];
//    label_reviews.font=[UIFont fontWithName:@"SanFranciscoDisplay-Medium" size:14.0];
    //[View_PlayerView2 addSubview:label_reviews];
    
    label_reviews=[[UILabel alloc]initWithFrame:CGRectMake(8, 53, 122, 21)];
    label_reviews.text=@"4.2k reviews";
    label_reviews.textAlignment=NSTextAlignmentLeft;
    label_reviews.textColor=[UIColor colorWithRed:241/255.0 green:241/255.0 blue:241/255.0 alpha:1];
    label_reviews.font=[UIFont fontWithName:@"SanFranciscoDisplay-Medium" size:14.0];
    [View_PlayerView2 addSubview:label_reviews];
    
    
    Label_stats=[[UILabel alloc]initWithFrame:CGRectMake(146, 53, 65, 21)];
    Label_stats.text=@"Stats";
    Label_stats.textAlignment=NSTextAlignmentCenter;
    Label_stats.textColor=[UIColor colorWithRed:241/255.0 green:241/255.0 blue:241/255.0 alpha:1];
    Label_stats.font=[UIFont fontWithName:@"SanFranciscoDisplay-Medium" size:14.0];
    [View_PlayerView2 addSubview:Label_stats];
    
    label_comments=[[UILabel alloc]initWithFrame:CGRectMake(217, 53, 88, 21)];
    label_comments.text=@"Comments";
    label_comments.textAlignment=NSTextAlignmentCenter;
    label_comments.textColor=[UIColor colorWithRed:241/255.0 green:241/255.0 blue:241/255.0 alpha:1];
    label_comments.font=[UIFont fontWithName:@"SanFranciscoDisplay-Medium" size:14.0];
    [View_PlayerView2 addSubview:label_comments];
    
    label_share=[[UILabel alloc]initWithFrame:CGRectMake(316, 53, 58, 21)];
    label_share.text=@"Share";
    label_share.textAlignment=NSTextAlignmentCenter;
    label_share.textColor=[UIColor colorWithRed:241/255.0 green:241/255.0 blue:241/255.0 alpha:1];
    label_share.font=[UIFont fontWithName:@"SanFranciscoDisplay-Medium" size:14.0];
    
    
    
    [View_PlayerView2 addSubview:label_share];
    
    label_reviewvedio=[[UILabel alloc]initWithFrame:CGRectMake(7, 82, 117, 21)];
    label_reviewvedio.text=@"Challenge videos";
     label_reviewvedio.textAlignment=NSTextAlignmentLeft;
    label_reviewvedio.textColor=[UIColor colorWithRed:241/255.0 green:241/255.0 blue:241/255.0 alpha:1];
    label_reviewvedio.font=[UIFont fontWithName:@"SanFranciscoDisplay-Medium" size:14.0];
    [View_PlayerView2 addSubview:label_reviewvedio];
    
    playerView_linereviewsVedio=[[UIView alloc]initWithFrame:CGRectMake(127, 98, 248, 1)];
   
   playerView_linereviewsVedio.backgroundColor=[UIColor colorWithRed:65/255.0 green:65/255.0 blue:65/255.0 alpha:1];
     [View_PlayerView2 addSubview:playerView_linereviewsVedio];
    
    [table_scrollview addSubview:View_PlayerView2];

    View_PlayerView1.hidden=YES;
    View_PlayerView2.hidden=YES;
    progressslider.hidden=YES;
    //////////////////////////////////////////////////
    Str_Flag_Positions=@"yes";
    str_FlagLoadinViewControllerelements=@"yes";
    Str_UserTapPlayVedioindex=@"no";
    [self CommunicationPlayVedio];
}
-(void)viewWillAppear:(BOOL)animated
{
      [super viewWillAppear:YES];
    [[UIApplication sharedApplication] setStatusBarHidden:YES];
    //[self CommunicationPlayVedio];
    timer =  [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(targetMethod:) userInfo:nil  repeats:YES];
    
    //    dispatch_async(dispatch_get_main_queue(), ^{
    //        if ([UserType isEqualToString:@"Owner"]) {
    //
    //
    //            [self.messageTimer invalidate];
    //            self.messageTimer = nil;
    //
    //        } else {
    //
    //
    //            self.messageTimer = [NSTimer scheduledTimerWithTimeInterval:10.0
    //                                                                 target:self
    //                                                               selector:@selector(checkForMessages)
    //                                                               userInfo:nil
    //                                                                repeats:YES];
    //            
    //            
    //        }
    //    });
}
- (void)viewWillDisappear:(BOOL)animated{
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
    [super viewWillDisappear:animated];
}

-(void)CommunicationPlayVedio
{
    Reachability *networkReachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus networkStatus = [networkReachability currentReachabilityStatus];
    if (networkStatus == NotReachable)
    {
        
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"No Internet" message:@"Please make sure you have internet connectivity in order to access Care2dare." preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *actionOk = [UIAlertAction actionWithTitle:@"Ok"
                                                           style:UIAlertActionStyleDefault
                                                         handler:^(UIAlertAction *action)
                                   {
                                       exit(0);
                                   }];
        
        [alertController addAction:actionOk];
        
        UIWindow *alertWindow = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
        alertWindow.rootViewController = [[UIViewController alloc] init];
        alertWindow.windowLevel = UIWindowLevelAlert + 1;
        [alertWindow makeKeyAndVisible];
        [alertWindow.rootViewController presentViewController:alertController animated:YES completion:nil];
        
        
    }
    else
    {
        
        NSString *userid1= @"userid1";
        NSString *useridVal1 =[defaults valueForKey:@"userid"];
        
        NSString *userid2= @"userid2";
        
        NSString *challengeid= @"challengeid";
        NSString *VedioIds= @"videoid";
        
        
        NSString *reqStringFUll=[NSString stringWithFormat:@"%@=%@&%@=%@&%@=%@&%@=%@",userid1,useridVal1,userid2,str_Userid2val,challengeid,str_ChallengeidVal,VedioIds,videoid1];
        
        
#pragma mark - swipe sesion
        
        NSURLSession *session = [NSURLSession sessionWithConfiguration: [NSURLSessionConfiguration defaultSessionConfiguration] delegate: nil delegateQueue: [NSOperationQueue mainQueue]];
        
        NSURL *url;
        NSString *  urlStrLivecount=[urlplist valueForKey:@"playvideo"];;
        url =[NSURL URLWithString:urlStrLivecount];
        
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
        
        [request setHTTPMethod:@"POST"];//Web API Method
        
        [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
        
        request.HTTPBody = [reqStringFUll dataUsingEncoding:NSUTF8StringEncoding];
        
        
        
        NSURLSessionDataTask *dataTask =[session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error)
                                         {
                                             if(data)
                                             {
                                                 NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
                                                 
                                                 NSInteger statusCode = httpResponse.statusCode;
                                                 if(statusCode == 200)
                                                 {
                                                     
                        Array_VediosData=[[NSMutableArray alloc]init];
                                                     
                                                     
                SBJsonParser *objSBJsonParser = [[SBJsonParser alloc]init];
                                                     
                Array_VediosData=[objSBJsonParser objectWithData:data];
                                                     
                                                     
                                                     
                NSString * ResultString=[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
                                                   
                                                     
        ResultString = [ResultString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
        ResultString = [ResultString stringByReplacingOccurrencesOfString:@"\t" withString:@""];
                                                     
                                                     
                                                     
                        if(Array_VediosData.count !=0)
                            {
                    NSLog(@"Communication Playvedio Data=%@",Array_VediosData);
                        [self.view.layer removeAllAnimations];
                                Str_Flag_Positions=@"yes";
                                                         
                                for(int i=0;i<Array_VediosData.count;i++)
                                    {
                            if ([[[Array_VediosData objectAtIndex:i]valueForKey:@"status"]isEqualToString:@"PLAY"])
                                {
        str_name=[NSString stringWithFormat:@"%@",[[Array_VediosData objectAtIndex:i]valueForKey:@"name" ]];
                                                                 
        str_days=[NSString stringWithFormat:@"%@",[[Array_VediosData objectAtIndex:i]valueForKey:@"posttime" ]];
                                                                 
        userId_Prof1=[NSString stringWithFormat:@"%@",[[Array_VediosData objectAtIndex:i]valueForKey:@"useridvideo" ]];
                                                                 
            str_friendstatus=[NSString stringWithFormat:@"%@",[[Array_VediosData objectAtIndex:i]valueForKey:@"friendstatus" ]];
                                                                 
            str_profileurl=[NSString stringWithFormat:@"%@",[[Array_VediosData objectAtIndex:i]valueForKey:@"profileimage" ]];
                                                                 
            Str_urlVedio=[NSString stringWithFormat:@"%@",[[Array_VediosData objectAtIndex:i]valueForKey:@"videourl" ]];
                                                                 
            Str_totalViews=[NSString stringWithFormat:@"%@",[[Array_VediosData objectAtIndex:i]valueForKey:@"totalviews" ]];
                                    
            Str_newstatus=[NSString stringWithFormat:@"%@",[[Array_VediosData objectAtIndex:i]valueForKey:@"newstatus" ]];
                               
                                                                 
                urlVediop = [NSURL URLWithString:Str_urlVedio];
                                                                 
                asset = [AVURLAsset assetWithURL: urlVediop];
               
                                                        
                [self PlayVediosAuto];
                [self View_OneElementset];

                                                                 
                                                             }
                                                             
                                                             
                                                         }
                                                         
                                                     }
                                                   
                                                     
                                                 }
                                                 else
                                                 {
                                                     NSLog(@" error login1 ---%ld",(long)statusCode);
                                                     [self CommunicationPlayVedio];
                                                 }
                                             
                                             }
                                             else if(error)
                                             {
                                               NSLog(@"error login2.......%@",error.description);
                                                 NSLog(@"error login2.......%@",error.description);
                                                 //[self CommunicationPlayVedio];
                             
                                                 UIAlertController * alert=[UIAlertController
                                                                            
                                                                            alertControllerWithTitle:@"Network Error" message:@"The request timed out." preferredStyle:UIAlertControllerStyleAlert];
                                                 
                                                 UIAlertAction* yesButton = [UIAlertAction
                                                                             actionWithTitle:@"OK"
                                                                             style:UIAlertActionStyleDefault
                                                                             handler:^(UIAlertAction * action)
                                                                             {
                                                                                 
                                                                                 [dataTask cancel];
                                                                                 
                                                                                 [playerViewController.view removeFromSuperview];
                                                                                 [player pause];
                                                                                 
                                                                                 
                                                                                 item = nil;
                                                                                 
                                                                                 player = nil;
                                                                                 [timer invalidate];
                                                                                 timer = nil;
                                                                                 player = nil;
                                                                                 
                                                                                 [playerViewController.view removeFromSuperview];
                                                                                 [timer invalidate];
                                                                                 timer = nil;
                                                                                 
                                                                                 [self.navigationController popViewControllerAnimated:YES];
                                                                                 
                                                                                 
                                                                                 [playerViewController.view removeFromSuperview];
                                                                                 
                                                                             }];
                                                 
                                                 [alert addAction:yesButton];
                                                 
                                                 
                                                 [self presentViewController:alert animated:YES completion:nil];
                                                 
                                                 
                                             }
                                             
                                         }];
        [dataTask resume];
    }
    
    
}
-(void)PlayVediosAuto
{
    
    if (player != nil && [player currentItem] != nil)
    {
        [[NSNotificationCenter defaultCenter] removeObserver:self];
            [item  removeObserver:self forKeyPath:@"playbackBufferEmpty"];
    [item  removeObserver:self forKeyPath:@"playbackLikelyToKeepUp"];
        [item  removeObserver:self forKeyPath:@"status"];
        
        
    }
//         [playerViewController.view removeFromSuperview];
//     ;
//    
//    
//    
//        NSLog(@"size of Vedio=%f",size.height);
//          NSLog(@"size of Vedio=%f",size.height);
    
     [playerViewController.view addSubview:Button_PlayPause];
     [playerViewController.view addSubview:Button_VolumeMute];
    [playerViewController.view addSubview:Button_ThreeDots];
    item = [AVPlayerItem playerItemWithAsset: asset];
    
    player = [[AVPlayer alloc] initWithPlayerItem: item];
    playerViewController.player = player;
    
        playerViewController.videoGravity=AVLayerVideoGravityResizeAspect;
        [player play];
    
        Flag_watch=@"no";
        item= player.currentItem;
    
        [item addObserver:self forKeyPath:@"playbackBufferEmpty" options:NSKeyValueObservingOptionNew context:nil];
        [item addObserver:self forKeyPath:@"playbackLikelyToKeepUp" options:NSKeyValueObservingOptionNew context:nil];
    [item addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew context:nil];
    
        CMTime duration = item.duration;
        CMTime currentTime = item.currentTime;
    
        dur = CMTimeGetSeconds(player.currentItem.asset.duration);
        CurrentTimes=CMTimeGetSeconds(currentTime);
        NSLog(@"durationPlayVedio: %.2f", dur);
    //    Button_PlayPause=[[UIButton alloc]initWithFrame:CGRectMake(0, 0,(cell_one.PlayerView.frame.size.width/2)+(cell_one.PlayerView.frame.size.width/5),(cell_one.PlayerView.frame.size.width/2)+(cell_one.PlayerView.frame.size.width/5))];
     player.muted=NO;
//   [self.view.layer removeAllAnimations];
//    [self fadein];
    
}
- (IBAction)Threedots_Action:(id)sender
{
    if ([[defaults valueForKey:@"userid"] isEqualToString:str_Userid2val])
    {
        [Button_PlayPause setImage:[UIImage imageNamed:@"Play Filled-100.png"] forState:UIControlStateNormal];
        [player pause];
        UIActionSheet *popup = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:@"Delete Video" otherButtonTitles:@"Flag as inappropriate",nil];
        popup.tag = 777;
        [popup showInView:self.view];
    }
    else
    {
        [Button_PlayPause setImage:[UIImage imageNamed:@"Play Filled-100.png"] forState:UIControlStateNormal];
        [player pause];
    UIActionSheet *popup = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Flag as inappropriate",nil];
    popup.tag = 707;
    [popup showInView:self.view];
    }
    
    
}
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSLog(@"actionSheetTaggg==%ld",(long)actionSheet.tag);
    
    if ((long)actionSheet.tag == 707)
    {
        if (buttonIndex== 0)
        {
            [self FlagVedioCommunication];
        }
    }
    else if ((long)actionSheet.tag == 777)
    {
        NSLog(@"INDEXAcrtionShhet==%ld",(long)buttonIndex);
        
        if (buttonIndex== 0)
        {
           
            UIAlertController * alert=[UIAlertController
                                       
                                       alertControllerWithTitle:@"Delete Video?" message:@"Are you sure you want to delete your video?"preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction* yesButton = [UIAlertAction
                                        actionWithTitle:@"Yes"
                                        style:UIAlertActionStyleDefault
                                        handler:^(UIAlertAction * action)
                                        {
                                            
                                    [self DeleteVideoCommunication];
                                            
                                        }];
            UIAlertAction* noButton = [UIAlertAction
                                       actionWithTitle:@"No"
                                       style:UIAlertActionStyleDefault
                                       handler:^(UIAlertAction * action)
                                       {
                                           
                                           
                                       }];
            
            [alert addAction:yesButton];
            [alert addAction:noButton];
            [self presentViewController:alert animated:YES completion:nil];
        }
        else  if (buttonIndex== 1)
        {
               [self FlagVedioCommunication];
        }
    }
}
- (IBAction)MutePlay_Action:(id)sender
{
    
    //    playerViewController.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    //
    //    // Present the movie player view controller
    //    [self dismissViewControllerAnimated:YES completion:nil];
    
    if (Button_VolumeMute.isSelected==YES)
    {
        player.muted=NO;
        [Button_VolumeMute setImage:[UIImage imageNamed:@"High Volume Filled-100.png"] forState:UIControlStateNormal];
        Button_VolumeMute.selected=NO;
    }
    else
    {
        player.muted=YES;
        Button_VolumeMute.selected=YES;
        [Button_VolumeMute setImage:[UIImage imageNamed:@"Mute Filled-100.png"] forState:UIControlStateNormal];
    }
    
}
- (IBAction)Play_Action:(id)sender
{
    if (player.rate == 1.0)
    {
        
        [Button_PlayPause setImage:[UIImage imageNamed:@"Play Filled-100.png"] forState:UIControlStateNormal];
        [player pause];
        
    } else
    {
        
        [self.view.layer removeAllAnimations];
          [Button_PlayPause setImage:[UIImage imageNamed:@"Pause Filled-100.png"] forState:UIControlStateNormal];
        [player play];
         [self.view.layer removeAllAnimations];
        [self fadeout];
        
      
        
    }
    
}
-(void)Button_Back_Action:(UIButton *)sender
{
    //    [self dismissViewControllerAnimated:YES completion:nil];

   
    [player pause];
    
    if (player != nil || [player currentItem] != nil)
    {
        [[NSNotificationCenter defaultCenter] removeObserver:self];
        [item  removeObserver:self forKeyPath:@"playbackBufferEmpty"];
        [item  removeObserver:self forKeyPath:@"playbackLikelyToKeepUp"];
        [item  removeObserver:self forKeyPath:@"status"];
    }
    item = nil;
    
    player = nil;
    [timer invalidate];
    timer = nil;
    player = nil;
    
    [timer invalidate];
    timer = nil;
    
    

    [View_PlayerView removeFromSuperview];
    [playerViewController.view removeFromSuperview];
    [self.navigationController popViewControllerAnimated:YES];
    
    [View_PlayerView removeFromSuperview];
    [playerViewController.view removeFromSuperview];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)targetMethod:(NSTimer *)timer1
{
    //    avPlayer.currentItem!.playbackLikelyToKeepUp
    //    if (player.status == AVPlayerStatusReadyToPlay)
    //    {
    //                [cell_one.indicator_loading stopAnimating];
    //            cell_one.indicator_loading.hidden=YES;
    //    }
    //    else if (player.status == AVPlayerStatusFailed)
    //    {
    //        // something went wrong. player.error should contain some information
    //    }
    //    else
    //    {
    //        cell_one.indicator_loading.hidden=NO;
    //        //           // cell_one.Button_VolumeMute.hidden=YES;
    //        //          //  cell_one.Image_3Dots.hidden=YES;
    //    [cell_one.indicator_loading startAnimating];
    //
    //    }
    //        if (item.playbackBufferEmpty)
    //        {
    //            cell_one.indicator_loading.hidden=NO;
    //           // cell_one.Button_VolumeMute.hidden=YES;
    //          //  cell_one.Image_3Dots.hidden=YES;
    //            [cell_one.indicator_loading startAnimating];
    //        }
    //    else
    //    {
    //        [cell_one.indicator_loading stopAnimating];
    //     cell_one.indicator_loading.hidden=YES;
    //
    //
    //    }
    
    
    if (indexVedio==Array_VediosData.count)
    {
        indexVedio=0;
        
    }
    CMTime currentTime = item.currentTime;
    CurrentTimes=CMTimeGetSeconds(currentTime);
    
    [progressslider setProgress:CurrentTimes/dur];
    NSLog(@"Timer-CurrentTimes duration: %.2f", CurrentTimes);
    
    NSLog(@"Timer-CurrentTimes/dur-duration: %.2f", CurrentTimes/dur);
    
    if (CurrentTimes/dur >=0.5)
    {
        NSLog(@"0.5=Timer-CurrentTimes/dur-duration:: %.2f", CurrentTimes/dur);
        if ([Flag_watch isEqualToString:@"no"])
        {
            [self ClienserverComm_watchView];
            Flag_watch=@"yes";
        }
        
        
    }
    if ([[NSString stringWithFormat:@"%.2f", CurrentTimes/dur] isEqualToString:@"nan"])
    {
        NSLog(@"Value not 0/0 divided");
    }
    else
    {
    if (CurrentTimes==dur)
    {
        indicatorView.hidden=NO;
        [indicatorView startAnimating];
       // [playerViewController.view removeFromSuperview];
        //        [timer invalidate];
        //        timer = nil;
        // Str_urlVedio=[NSString stringWithFormat:@"%@",[[Array_VediosData objectAtIndex:indexVedio]valueForKey:@"videourl" ]];
        str_Userid2val=[NSString stringWithFormat:@"%@",[[Array_VediosData objectAtIndex:indexVedio]valueForKey:@"useridvideo"]];
        videoid1=[NSString stringWithFormat:@"%@",[[Array_VediosData objectAtIndex:indexVedio]valueForKey:@"videoid1"]];
        
        [self CommunicationPlayVedio];
        indexVedio++;
        Flag_watch=@"no";
        
        // [Tableview_Explore reloadData];
    }
    }
}
-(void)ClienserverComm_watchView
{
    [self.view endEditing:YES];
    Reachability *networkReachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus networkStatus = [networkReachability currentReachabilityStatus];
    if (networkStatus == NotReachable)
    {
        
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"No Internet" message:@"Please make sure you have internet connectivity in order to access Care2dare." preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *actionOk = [UIAlertAction actionWithTitle:@"Ok"
                                                           style:UIAlertActionStyleDefault
                                                         handler:^(UIAlertAction *action)
                                   {
                                       exit(0);
                                   }];
        
        [alertController addAction:actionOk];
        
        UIWindow *alertWindow = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
        alertWindow.rootViewController = [[UIViewController alloc] init];
        alertWindow.windowLevel = UIWindowLevelAlert + 1;
        [alertWindow makeKeyAndVisible];
        [alertWindow.rootViewController presentViewController:alertController animated:YES completion:nil];
        
        
    }
    else
    {
        
        
        NSString *userid1= @"userid1";
        NSString *useridVal1 =[defaults valueForKey:@"userid"];
        
        NSString *userid2= @"userid2";
        
        NSString *challengeid= @"challengeid";
        
        NSString *vedioids= @"videoid";
        
        NSString *reqStringFUll=[NSString stringWithFormat:@"%@=%@&%@=%@&%@=%@&%@=%@",userid1,useridVal1,userid2,str_Userid2val,challengeid,str_ChallengeidVal,vedioids,videoid1];
        
        
        
        
        
#pragma mark - swipe sesion
        
        NSURLSession *session = [NSURLSession sessionWithConfiguration: [NSURLSessionConfiguration defaultSessionConfiguration] delegate: nil delegateQueue: [NSOperationQueue mainQueue]];
        
        NSURL *url;
        NSString *  urlStrLivecount=[urlplist valueForKey:@"watchedvideo"];;
        url =[NSURL URLWithString:urlStrLivecount];
        
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
        
        [request setHTTPMethod:@"POST"];//Web API Method
        
        [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
        
        request.HTTPBody = [reqStringFUll dataUsingEncoding:NSUTF8StringEncoding];
        
        
        
        NSURLSessionDataTask *dataTask =[session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error)
                                         {
                                             if(data)
                                             {
                                                 NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
                                                 NSInteger statusCode = httpResponse.statusCode;
                                                 if(statusCode == 200)
                                                 {
                                                     
                                                 //    SBJsonParser *objSBJsonParser = [[SBJsonParser alloc]init];
                                                     
                                                     
                                                     NSString * ResultString=[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
                                                     
                                                     
                                                     ResultString = [ResultString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
                                                     
                                                     ResultString = [ResultString stringByReplacingOccurrencesOfString:@"\t" withString:@""];
                                                     
                                                     
                                                     NSLog(@"Array_WorldExp ResultString %@",ResultString);
                                                     
                                                     if (Array_VediosData.count !=0)
                                                     {
                                                         //[Tableview_Explore reloadData];
                                                     }
                                                     
                                                     
                                                 }
                                                 
                                                 else
                                                 {
                                                     NSLog(@" error login1 ---%ld",(long)statusCode);
                                                     
                                                 }
                                                 
                                                 
                                             }
                                             else if(error)
                                             {
                                                 
                                                 NSLog(@"error login2.......%@",error.description);
                                             }
                                         }];
        [dataTask resume];
    }
    
}
-(void)View_OneElementset
{
    View_PlayerView1.hidden=NO;
    View_PlayerView2.hidden=NO;
    progressslider.hidden=NO;
    
    if ([str_FlagLoadinViewControllerelements isEqualToString:@"yes"])
    {
        
    
    if ([[defaults valueForKey:@"userid"] isEqualToString:userId_Prof1]|| [str_friendstatus isEqualToString:@""])
    {
        ButtonImage_acceptFrnd_View2.hidden=YES;
    }
    else
    {
        
        if ([str_friendstatus isEqualToString:@"no"])
        {
            ButtonImage_acceptFrnd_View2.hidden=NO;
            [ButtonImage_acceptFrnd_View2 setImage:[UIImage imageNamed:@"addfriend.png"] forState:UIControlStateNormal];
            [ButtonImage_acceptFrnd_View2 addTarget:self action:@selector(ButtonAction_friendstatus:) forControlEvents:UIControlEventTouchUpInside];
        }
        
        
        if ([str_friendstatus isEqualToString:@"yes"])
        {
            ButtonImage_acceptFrnd_View2.hidden=NO;
            [ButtonImage_acceptFrnd_View2 setImage:[UIImage imageNamed:@"addfriend1.png"] forState:UIControlStateNormal];
            
        }
        if ([str_friendstatus isEqualToString:@"waiting"])
        {
            ButtonImage_acceptFrnd_View2.hidden=NO;
            [ButtonImage_acceptFrnd_View2 setImage:[UIImage imageNamed:@"friendrequested.png"] forState:UIControlStateNormal];
            
        }
    }
    
    
    
    label_days_View2.text=str_days;
    label_reviews.text=Str_totalViews;//
  
    
    
    
    Image_Profile_View2.userInteractionEnabled=YES;
    UITapGestureRecognizer *image_FristProfileTapped =[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(image_FirstProfile_ActionDetails:)];
    [Image_Profile_View2 addGestureRecognizer:image_FristProfileTapped];
    
    
    
    
    
    NSURL *url=[NSURL URLWithString:str_profileurl];
    
    [Image_Profile_View2 sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"DefaultImg.jpg"] options:SDWebImageRefreshCached];
    
    
    
    UIFont *name1 = [UIFont fontWithName:@"SanFranciscoDisplay-Medium" size:14.0];
    NSDictionary *arialDict = [NSDictionary dictionaryWithObject:name1 forKey:NSFontAttributeName];
    NSMutableAttributedString *aAttrString = [[NSMutableAttributedString alloc] initWithString:@"Posted by " attributes: arialDict];
    
    UIFont *name2 = [UIFont fontWithName:@"SanFranciscoDisplay-Bold" size:14.0];
    NSDictionary *verdanaDict = [NSDictionary dictionaryWithObject:name2 forKey:NSFontAttributeName];
    NSMutableAttributedString *vAttrString = [[NSMutableAttributedString alloc]initWithString:str_name  attributes:verdanaDict];
    
    
    [aAttrString appendAttributedString:vAttrString];
    
    
    
    Label_profilename_view2.attributedText = aAttrString;
        
   // NSString *text =[[AllArrayData objectAtIndex:0]valueForKey:@"title"];;
    
    
    CGSize constraint = CGSizeMake(345 - (CELL_CONTENT_MARGIN * 2), 20000.0f);
    
    CGSize size = [str_challengeTitle sizeWithFont:[UIFont fontWithName:@"SanFranciscoDisplay-Bold" size:24.0] constrainedToSize:constraint lineBreakMode:UILineBreakModeWordWrap];
    
    TextView_Title3.selectable=NO;
    TextView_Title3.editable=NO;
    TextView_Title3.scrollEnabled=NO;
    [TextView_Title3 setText:str_challengeTitle];
    
    CGFloat fixedWidth = TextView_Title3.frame.size.width;
    CGSize newSize = [TextView_Title3 sizeThatFits:CGSizeMake(fixedWidth, MAXFLOAT)];
    CGRect newFrame = TextView_Title3.frame;
    newFrame.size = CGSizeMake(fmaxf(newSize.width, fixedWidth), newSize.height);
    [TextView_Title3 setFrame:(newFrame)];
        NSLog(@"HeightTextView1===%f",(newFrame.size.height));
        NSLog(@"HeightTextView2===%f",(newFrame.size.height/TextView_Title3.frame.size.height));
        
        TextView_Title3.userInteractionEnabled=YES;
        
        UITapGestureRecognizer *label_Desc_Tapped =[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(Textview_Desc_Tapped_ActionDetails:)];
        [TextView_Title3 addGestureRecognizer:label_Desc_Tapped];
      
        
        
        
        
    
    [View_PlayerView2 setFrame:CGRectMake(0,(TextView_Title3.frame.origin.y+TextView_Title3.frame.size.height), self.view.frame.size.width, 108)];
    if ([Str_Flag_Positions isEqualToString:@"yes"])
    {
        X_postion_view3=0.0;
        Y_postion_view3=View_PlayerView2.frame.origin.y+View_PlayerView2.frame.size.height;
        Width_postion_view3=self.view.frame.size.width;
        Height_postion_view3=130.0;
        Str_Flag_Positions=@"no";
    }
    
    for (int i=0; i<Array_VediosData.count; i++)
    {
        
         PlayerView3 = [[UIView alloc] initWithFrame:CGRectMake(X_postion_view3,Y_postion_view3 ,Width_postion_view3, Height_postion_view3)];
        
            UIImageView * ImageLeft_LeftProfile=[[UIImageView alloc]initWithFrame:CGRectMake(5, 15, 100, 100)];
            ImageLeft_LeftProfile.clipsToBounds=YES;
            ImageLeft_LeftProfile.layer.cornerRadius=9.0f;
        ImageLeft_LeftProfile.backgroundColor=[UIColor clearColor];
        ImageLeft_LeftProfile.contentMode=UIViewContentModeScaleAspectFill;
        
        
        ImageLeft_LeftProfile.userInteractionEnabled=YES;
        UITapGestureRecognizer *Image_PlaylistTapped =[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(ImageSelectrowPlayVedio_Action:)];
        [ImageLeft_LeftProfile addGestureRecognizer:Image_PlaylistTapped];
        
        
        
           Image_NewFrnd=[[UIImageView alloc]initWithFrame:CGRectMake(94,1,30,30)];
        Image_NewFrnd.backgroundColor=[UIColor clearColor];
        [Image_NewFrnd setImage:[UIImage imageNamed:@"new.png"]];
        Image_NewFrnd.contentMode=UIViewContentModeScaleAspectFit;
        
         [ImageArrayTag addObject:Image_NewFrnd];
        
    UIImageView * Image_Button_play=[[UIImageView alloc]initWithFrame:CGRectMake(42, 52,26,26)];
          Image_Button_play.backgroundColor=[UIColor clearColor];
        [Image_Button_play setImage:[UIImage imageNamed:@"playbutton.png"]];
         Image_Button_play.contentMode=UIViewContentModeScaleAspectFit;
        
        
        
        
        Image_Button_play.userInteractionEnabled=YES;
    UITapGestureRecognizer *Image_Playlist2Tapped2 =[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(ImageSelectrowPlayVedio_Action:)];
        [Image_Button_play addGestureRecognizer:Image_Playlist2Tapped2];
        
        
        
        
            UIImageView * ImageRight_RightProfile=[[UIImageView alloc]initWithFrame:CGRectMake(320,41,45,45)];
            ImageRight_RightProfile.clipsToBounds=YES;
            ImageRight_RightProfile.layer.cornerRadius=ImageRight_RightProfile.frame.size.height/2;
        ImageRight_RightProfile.backgroundColor=[UIColor clearColor];
         ImageRight_RightProfile.contentMode=UIViewContentModeScaleAspectFill;
            UILabel * Label_ChallengeName1=[[UILabel alloc]initWithFrame:CGRectMake(113,40,201,23)];
        Label_ChallengeName1.textAlignment=NSTextAlignmentLeft;
          Label_ChallengeName1.textColor=[UIColor colorWithRed:186/255.0 green:188/255.0 blue:190/255.0 alpha:1];
            UILabel * Label_DaysAgo=[[UILabel alloc]initWithFrame:CGRectMake(113,58,201,23)];
       
        Label_DaysAgo.textAlignment=NSTextAlignmentLeft;
        Label_DaysAgo.textColor=[UIColor colorWithRed:186/255.0 green:188/255.0 blue:190/255.0 alpha:1];
        Label_DaysAgo.font=[UIFont fontWithName:@"SanFranciscoDisplay-Medium" size:14.0];
        
 
           PlayerView3.backgroundColor=[UIColor blackColor];
       
         [PlayerView3 setTag:i];
        [ImageLeft_LeftProfile setTag:i];
        [Image_NewFrnd setTag:i];
        [Image_NewFrnd viewWithTag:i];
        
        [Image_Button_play setTag:i];
        [ImageRight_RightProfile setTag:i];
        [Label_ChallengeName1 setTag:i];
        [Label_DaysAgo setTag:i];
        
        
        if (Array_VediosData.count-1==i)
        {
            CALayer * Bottomborder_PlayerView3 = [CALayer layer];
            Bottomborder_PlayerView3.backgroundColor = [UIColor clearColor].CGColor;
            Bottomborder_PlayerView3.frame = CGRectMake(0, PlayerView3.frame.size.height-1, PlayerView3.frame.size.width, 1);
            [PlayerView3.layer addSublayer:Bottomborder_PlayerView3];
        }
        else
        {
        
        CALayer * Bottomborder_PlayerView3 = [CALayer layer];
        Bottomborder_PlayerView3.backgroundColor = [UIColor colorWithRed:65/255.0 green:65/255.0 blue:65/255.0 alpha:1.0].CGColor;
        Bottomborder_PlayerView3.frame = CGRectMake(0, PlayerView3.frame.size.height-1, PlayerView3.frame.size.width, 1);
        [PlayerView3.layer addSublayer:Bottomborder_PlayerView3];
        }
        
        [PlayerView3 addSubview:ImageLeft_LeftProfile];
        [PlayerView3 addSubview:Image_NewFrnd];
        [PlayerView3 addSubview:Image_Button_play];
        [PlayerView3 addSubview:ImageRight_RightProfile];
        [PlayerView3 addSubview:Label_ChallengeName1];
        [PlayerView3 addSubview:Label_DaysAgo];
        [table_scrollview addSubview:PlayerView3];
        
        Y_postion_view3+=Height_postion_view3;
        
        
        
        
            NSDictionary * dic_value=[Array_VediosData objectAtIndex:i];
            
         Label_DaysAgo.text=[NSString stringWithFormat:@"%@",[dic_value valueForKey:@"posttime"]];
            
        
            NSURL *urlLef=[NSURL URLWithString:[dic_value valueForKey:@"thumbnailurl"]];
            
            [ImageLeft_LeftProfile sd_setImageWithURL:urlLef placeholderImage:[UIImage imageNamed:@"DefaultImg.jpg"] options:SDWebImageRefreshCached];
            
            NSURL *urlRight=[NSURL URLWithString:[dic_value valueForKey:@"profileimage"]];
            [ImageRight_RightProfile sd_setImageWithURL:urlRight placeholderImage:[UIImage imageNamed:@"DefaultImg.jpg"] options:SDWebImageRefreshCached];
        
            ImageRight_RightProfile.userInteractionEnabled=YES;
            
            UITapGestureRecognizer *image_SecProfileTapped =[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(image_SecProfile_ActionDetails:)];
            [ImageRight_RightProfile addGestureRecognizer:image_SecProfileTapped];
            
            
            
            UIFont *name1 = [UIFont fontWithName:@"SanFranciscoDisplay-Medium" size:14.0];
            NSDictionary *arialDict = [NSDictionary dictionaryWithObject:name1 forKey:NSFontAttributeName];
            NSMutableAttributedString *aAttrString = [[NSMutableAttributedString alloc] initWithString:@"Posted by " attributes: arialDict];
            
            UIFont *name2 = [UIFont fontWithName:@"SanFranciscoDisplay-Bold" size:14.0];
            NSDictionary *verdanaDict = [NSDictionary dictionaryWithObject:name2 forKey:NSFontAttributeName];
            NSMutableAttributedString *vAttrString = [[NSMutableAttributedString alloc]initWithString:[dic_value valueForKey:@"name"]  attributes:verdanaDict];
            
            
            [aAttrString appendAttributedString:vAttrString];
            
            
        Label_ChallengeName1.attributedText = aAttrString;
            
            if ([[dic_value valueForKey:@"newstatus"]isEqualToString:@"yes"])
            {
                Image_NewFrnd.hidden=NO;
            }
            else
            {
               // Image_NewFrnd.hidden=NO;
               Image_NewFrnd.hidden=YES;
            }
    table_scrollview.contentSize=CGSizeMake(table_scrollview.frame.size.width, Y_postion_view3+PlayerView3.frame.size.height);
            
        }
       str_FlagLoadinViewControllerelements=@"no";
        
    }
    else
    {
        if ([[defaults valueForKey:@"userid"] isEqualToString:userId_Prof1]|| [str_friendstatus isEqualToString:@""])
        {
            ButtonImage_acceptFrnd_View2.hidden=YES;
        }
        else
        {
            
            if ([str_friendstatus isEqualToString:@"no"])
            {
                ButtonImage_acceptFrnd_View2.hidden=NO;
                [ButtonImage_acceptFrnd_View2 setImage:[UIImage imageNamed:@"addfriend.png"] forState:UIControlStateNormal];
                [ButtonImage_acceptFrnd_View2 addTarget:self action:@selector(ButtonAction_friendstatus:) forControlEvents:UIControlEventTouchUpInside];
            }
            
            
            if ([str_friendstatus isEqualToString:@"yes"])
            {
                ButtonImage_acceptFrnd_View2.hidden=NO;
                [ButtonImage_acceptFrnd_View2 setImage:[UIImage imageNamed:@"addfriend1.png"] forState:UIControlStateNormal];
                
            }
            if ([str_friendstatus isEqualToString:@"waiting"])
            {
                ButtonImage_acceptFrnd_View2.hidden=NO;
                [ButtonImage_acceptFrnd_View2 setImage:[UIImage imageNamed:@"friendrequested.png"] forState:UIControlStateNormal];
                
            }
        }
        
        
        NSURL *url=[NSURL URLWithString:str_profileurl];
        
        [Image_Profile_View2 sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"DefaultImg.jpg"] options:SDWebImageRefreshCached];
        label_days_View2.text=str_days;
        label_reviews.text=Str_totalViews;
        
        
        UIFont *name1 = [UIFont fontWithName:@"SanFranciscoDisplay-Medium" size:14.0];
        NSDictionary *arialDict = [NSDictionary dictionaryWithObject:name1 forKey:NSFontAttributeName];
        NSMutableAttributedString *aAttrString = [[NSMutableAttributedString alloc] initWithString:@"Posted by " attributes: arialDict];
        
        UIFont *name2 = [UIFont fontWithName:@"SanFranciscoDisplay-Bold" size:14.0];
        NSDictionary *verdanaDict = [NSDictionary dictionaryWithObject:name2 forKey:NSFontAttributeName];
        NSMutableAttributedString *vAttrString = [[NSMutableAttributedString alloc]initWithString:str_name  attributes:verdanaDict];
        
        
        [aAttrString appendAttributedString:vAttrString];
        Label_profilename_view2.attributedText = aAttrString;
        
        
       UIImageView *previousLed;
        
        if ([Str_UserTapPlayVedioindex isEqualToString:@"no"])
        {
            previousLed = [[ImageArrayTag objectAtIndex:indexVedio-1] viewWithTag:indexVedio-1];
        }
        else
        {
           previousLed = [[ImageArrayTag objectAtIndex:(long)imagesTagRow.tag] viewWithTag:(long)imagesTagRow.tag];
            Str_UserTapPlayVedioindex=@"no";
        }
        
        if ([Str_newstatus isEqualToString:@"yes"])
                {
                    previousLed.hidden=NO;
                    
                }
                else
                {

                 previousLed.hidden=YES;
                 
                }
        
            
//        UIImageView *led=[ImageArrayTag objectAtIndex:2];
//        NSLog(@"images Tag===%@",ImageArrayTag);
//        if(led.tag == 2)
//        {
//            
//            UIImageView *previousLed = [led viewWithTag:2];
//            
//            
//            previousLed.hidden=NO;
//            
//        }
        
    }
    
   

    
    
}
-(void)image_FirstProfile_ActionDetails:(UIGestureRecognizer *)reconizer
{
    UIGestureRecognizer * rcz=(UIGestureRecognizer *)reconizer;
    UIImageView * images=(UIImageView *)rcz.view;
    NSLog(@"Useridd11==%@",[defaults valueForKey:@"userid"]);
    
    NSLog(@"Useridd11==%@",[[Array_VediosData objectAtIndex:0] valueForKey:@"challengersuserid"]);
    
    
    if([[defaults valueForKey:@"userid"] isEqualToString:userId_Prof1])
    {
        
        
        
        
        
    }
    else
    {
        ProfilePageDetailsViewController * set=[self.storyboard instantiateViewControllerWithIdentifier:@"ProfilePageDetailsViewController"];
        set.userId_prof=userId_Prof1;
        
        set.user_name=str_name;
        
        set.user_imageUrl=str_profileurl;
        
        set.Images_data=images;
        
        
        
        [player pause];
        
        [timer invalidate];
        timer = nil;
        
        [player pause];
        
        
        
        [timer invalidate];
        timer = nil;
        
        
        
        [self.navigationController pushViewController:set animated:YES];
        
    }
    
    
    
}

-(void)image_SecProfile_ActionDetails:(UIGestureRecognizer *)reconizer
{
    NSLog(@"Useridd11==%@",[defaults valueForKey:@"userid"]);
    
    NSLog(@"Useridd11==%@",[[Array_VediosData objectAtIndex:0] valueForKey:@"challengersuserid"]);
    UIGestureRecognizer * rcz=(UIGestureRecognizer *)reconizer;
    UIImageView * images=(UIImageView *)rcz.view;
    
    if([[[Array_VediosData objectAtIndex:(long)images.tag] valueForKey:@"useridvideo"]isEqualToString:@"0"] ||[[defaults valueForKey:@"userid"] isEqualToString:[[Array_VediosData objectAtIndex:(long)images.tag] valueForKey:@"useridvideo"]])
    {
        
        
        //        friendstatus = "";
        //        name = "Er Sachin Mokashi";
        //        newstatus = no;
        //        posttime = "1d ago";
        //        profileimage = "https://graph.facebook.com/1280357812049167/picture?type=large";
        //        recorddate = "2017-04-13 05:04:30";
        //        "registration_status" = ACTIVE;
        //        status = LIST;
        //        thumbnailurl = "http://www.care2dareapp.com/app/recordedmedia/R20170307091520wFL3C20170404122329IEXZ-thumbnail.jpg";
        //        totalviews = "";
        //        useridvideo = 20170307091520wFL3;
        //        videourl = "http://www.care2dareapp.com/app/recordedmedia/R20170307091520wFL3C20170404122329IEXZ.mp4";
    }
    else
    {
        ProfilePageDetailsViewController * set=[self.storyboard instantiateViewControllerWithIdentifier:@"ProfilePageDetailsViewController"];
        set.userId_prof=[NSString stringWithFormat:@"%@",[[Array_VediosData objectAtIndex:(long)images.tag]valueForKey:@"useridvideo"]];
        
        set.user_name=[NSString stringWithFormat:@"%@",[[Array_VediosData objectAtIndex:(long)images.tag]valueForKey:@"name"]];
        
        set.user_imageUrl=[NSString stringWithFormat:@"%@",[[Array_VediosData objectAtIndex:(long)images.tag]valueForKey:@"profileimage"]];
        
        set.Images_data=images;
        
        
        
        [player pause];
        
        [timer invalidate];
        timer = nil;
        
        
        [timer invalidate];
        timer = nil;
        
        [player pause];
        
        
        
        
        [self.navigationController pushViewController:set animated:YES];
    }
    
    
    
}
-(void)ButtonAction_friendstatus:(UIButton *)sender
{
    Reachability *networkReachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus networkStatus = [networkReachability currentReachabilityStatus];
    if (networkStatus == NotReachable)
    {
        
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"No Internet" message:@"Please make sure you have internet connectivity in order to access Care2dare." preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *actionOk = [UIAlertAction actionWithTitle:@"Ok"
                                                           style:UIAlertActionStyleDefault
                                                         handler:^(UIAlertAction *action)
                                   {
                                       exit(0);
                                   }];
        
        [alertController addAction:actionOk];
        
        UIWindow *alertWindow = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
        alertWindow.rootViewController = [[UIViewController alloc] init];
        alertWindow.windowLevel = UIWindowLevelAlert + 1;
        [alertWindow makeKeyAndVisible];
        [alertWindow.rootViewController presentViewController:alertController animated:YES completion:nil];
        
        
    }
    else
    {
        
        
        NSString *userid1= @"userid1";
        NSString *useridval1= [defaults valueForKey:@"userid"];
        
        NSString *userid2= @"userid2";
        
        
        
        NSString *reqStringFUll=[NSString stringWithFormat:@"%@=%@&%@=%@",userid1,useridval1,userid2,str_ChallengeidVal];
        
        
        
#pragma mark - swipe sesion
        
        NSURLSession *session = [NSURLSession sessionWithConfiguration: [NSURLSessionConfiguration defaultSessionConfiguration] delegate: nil delegateQueue: [NSOperationQueue mainQueue]];
        
        NSURL *url;
        NSString *  urlStrLivecount=[urlplist valueForKey:@"addfriend"];;
        url =[NSURL URLWithString:urlStrLivecount];
        
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
        
        [request setHTTPMethod:@"POST"];//Web API Method
        
        [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
        
        request.HTTPBody = [reqStringFUll dataUsingEncoding:NSUTF8StringEncoding];
        
        
        
        NSURLSessionDataTask *dataTask =[session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error)
                                         {
                                             if(data)
                                             {
                                                 NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
                                                 NSInteger statusCode = httpResponse.statusCode;
                                                 if(statusCode == 200)
                                                 {
                                                     
                                                     Array_VediosData=[[NSMutableArray alloc]init];
                                                     SBJsonParser *objSBJsonParser = [[SBJsonParser alloc]init];
                                                     Array_VediosData=[objSBJsonParser objectWithData:data];
                                                     
                                                     NSString * ResultString=[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
                                                     ResultString = [ResultString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
                                                     ResultString = [ResultString stringByReplacingOccurrencesOfString:@"\t" withString:@""];
                                                     
                                                     NSLog(@"Array_VediosDataFriendsreq %@",Array_VediosData);
                                                     
                                                     NSLog(@"Array_AllData ResultString %@",ResultString);
                                                     
                                                     if ([ResultString isEqualToString:@"requested"])
                                                     {
                                                         
                                                         [ButtonImage_acceptFrnd_View2 setImage:[UIImage imageNamed:@"friendrequested.png"] forState:UIControlStateNormal];
                                                         
                                                         
                                                     }
                                                     
                                                     
                                                 }
                                                 else
                                                 {
                                                     NSLog(@" error login1 ---%ld",(long)statusCode);
                                                     
                                                 }
                                             }
                                             else if(error)
                                             {
                                                 NSLog(@"error login2.......%@",error.description);
                                             }
                                             
                                         }];
        [dataTask resume];
    }
    
}
-(void)Image_Stats_Action:(UIGestureRecognizer *)reconizer
{
    [player pause];
    [Button_PlayPause setImage:[UIImage imageNamed:@"Play Filled-100.png"] forState:UIControlStateNormal];
    
    [timer invalidate];
    timer = nil;
    
    
    [timer invalidate];
    timer = nil;
    
    [player pause];
    
    
    
    StatsViewController * set=[self.storyboard instantiateViewControllerWithIdentifier:@"StatsViewController"];
    set.str_ChallengeidVal1=str_ChallengeidVal;;
    [self.navigationController pushViewController:set animated:YES];
    
}

-(void)Image_Comments_Action:(UIGestureRecognizer *)reconizer
{
    //    UIGestureRecognizer * rec=(UIGestureRecognizer *)reconizer;
    //    UIImageView * img=(UIImageView *)rec.view;
    //    ContributeDaetailPageViewController * set=[self.storyboard instantiateViewControllerWithIdentifier:@"ContributeDaetailPageViewController"];
    //    NSDictionary *  didselectDic;
    //    didselectDic=[Array_VediosData  objectAtIndex:0];
    //
    //        set.ProfileImgeData =str_image_Data;
    //
    //    NSMutableArray * Array_new=[[NSMutableArray alloc]init];
    //    [Array_new addObject:didselectDic];
    //    set.AllArrayData =Array_new;
    //    NSLog(@"Array_new11=%@",Array_new);;
    
    
    
    //
    //    NSLog(@"Array_new22=%@",Array_new);;
    //    NSLog(@"indexPathrow=%ld",(long)indexPath.row);;
    //
    //    [self.navigationController pushViewController:set animated:YES];
    //    NSLog(@"Array_new33=%@",Array_new);;
    
    
}

-(void)Image_Share_Action:(UIGestureRecognizer *)reconizer
{
    [player pause];
    [Button_PlayPause setImage:[UIImage imageNamed:@"Play Filled-100.png"] forState:UIControlStateNormal];
    
    NSString * texttoshare=[NSString stringWithFormat:@"%@%@",str_name,@" has recorded a new challenge video. Download the app now - http://www.care2dareapp.com or Watch the video here: "];
    
    NSURL * urltoshare=[NSURL URLWithString:[NSString stringWithFormat:@"%@",Str_urlVedio]];
    NSArray *activityItems1=@[texttoshare,urltoshare];
    NSArray *activityItems =@[UIActivityTypePrint,UIActivityTypeAirDrop,UIActivityTypeAssignToContact,UIActivityTypeAddToReadingList,UIActivityTypeOpenInIBooks];
    UIActivityViewController *activityViewControntroller = [[UIActivityViewController alloc] initWithActivityItems:activityItems1 applicationActivities:nil];
    activityViewControntroller.excludedActivityTypes = activityItems;
    //  [self.view addSubview:activityViewControntroller];
    [self presentViewController:activityViewControntroller animated:YES completion:nil];
}
-(void)ImageSelectrowPlayVedio_Action:(UIGestureRecognizer *)reconizer
{
table_scrollview.contentOffset = CGPointMake(0,0);
Str_UserTapPlayVedioindex=@"yes";
UIGestureRecognizer * rcz=(UIGestureRecognizer *)reconizer;
    imagesTagRow=(UIImageView *)rcz.view;
  

//    progressslider.hidden=YES;
//    Button_VolumeMute.hidden=YES;
//    cell_one.Image_3Dots.hidden=YES;
//    [playerViewController.view removeFromSuperview];
//    //[cell_one.PlayerView removeFromSuperview];
//    // [cell_one.PlayerView addSubview:playerViewController.view
    Flag_watch=@"yes";
    
//  //       Str_urlVedio=[NSString stringWithFormat:@"%@",[[Array_VediosData objectAtIndex:indexPath.row]valueForKey:@"videourl" ]];
// //           indexVedio=indexPath.row;
    
    str_Userid2val=[NSString stringWithFormat:@"%@",[[Array_VediosData objectAtIndex:(long)imagesTagRow.tag]valueForKey:@"useridvideo"]];
    videoid1=[NSString stringWithFormat:@"%@",[[Array_VediosData objectAtIndex:(long)imagesTagRow.tag]valueForKey:@"videoid1"]];
    indexVedio=((long)imagesTagRow.tag)+1;
    [self CommunicationPlayVedio];
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView.contentOffset.y<=0) {
        scrollView.contentOffset = CGPointZero;
    }
}

-(void) fadein
{
    
    [UIView animateWithDuration:.3 delay:0.0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        
        Button_back.alpha=1;
        Button_VolumeMute.alpha=1;
        Button_ThreeDots.alpha=1;
        Button_PlayPause.alpha=1;
        PlayerView_Backround.hidden=YES;
        
        
    } completion:^(BOOL finished) {
        
        if (finished)
        {
            PlayerView_Backround.hidden=YES;
            
            
            if (player.rate == 1.0)
            {
               
                timerFadeout =  [NSTimer scheduledTimerWithTimeInterval:2.0f target:self selector:@selector(FadeMethod:) userInfo:nil  repeats:NO];
                //            //        [player pause];
                
            }
            else
            {
                //                timerFadeout =  [NSTimer scheduledTimerWithTimeInterval:2.0f target:self selector:@selector(FadeMethod:) userInfo:nil  repeats:YES];
                //        [player play];
            }
            
        }
        
    }];
    
   
}
-(void)fadeout
{
    
    
  
    [UIView animateWithDuration:0.2f animations:^{
        
        Button_back.alpha=0;
        Button_VolumeMute.alpha=0;
        Button_ThreeDots.alpha=0;
        Button_PlayPause.alpha=0;
        PlayerView_Backround.hidden=NO;
        
    } completion:nil];
    PlayerView_Backround.hidden=NO;
    Falg_FadeInFadeOut=@"yes";
    
}
-(void)FadeMethod:(NSTimer *)timer1
{
    
    if (player.rate == 1.0)
    {
         [self.view.layer removeAllAnimations];
        [self fadeout];
        
        [timerFadeout invalidate];
        timerFadeout=nil;
    }
    
    
}
-(void)PlayerTapped_ViewAction:(UIGestureRecognizer *)reconizer
{
    if ([Falg_FadeInFadeOut isEqualToString:@"yes"])
    {
         [self.view.layer removeAllAnimations];
        [self fadein];
        Falg_FadeInFadeOut=@"no";
    }
    else
    {
         [self.view.layer removeAllAnimations];
        [self fadeout];
        Falg_FadeInFadeOut=@"yes";
    }
}
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object
                        change:(NSDictionary *)change context:(void *)context {
    if (!player)
    {
        return;
    }
    if (object == item &&[keyPath isEqualToString:@"status"])
    {
        if (item.status == AVPlayerStatusFailed)
        {
            NSLog(@"Failed Vedio player");
            NSLog(@"%@",player.error);
        }
    }
    
    if (object == player.currentItem && [keyPath isEqualToString:@"status"])
    {
        if (player.currentItem.status == AVPlayerItemStatusFailed) {
            NSLog(@"------player item failed:%@",player.currentItem.error);
        }
    }
    
    else if (object == item && [keyPath isEqualToString:@"playbackBufferEmpty"])
    {
        if (item.playbackBufferEmpty)
        {
            indicatorView.hidden=NO;
            
            [indicatorView startAnimating];
            [self.view.layer removeAllAnimations];
            [self fadeout];
            
            
        }
        
    }
    
    else if (object == item && [keyPath isEqualToString:@"playbackLikelyToKeepUp"])
    {
        if (item.playbackLikelyToKeepUp)
        {
            indicatorView.hidden=YES;
            
            [indicatorView stopAnimating];
            [self.view.layer removeAllAnimations];
            
            [self fadein];
        }
    }
}
-(void)Textview_Desc_Tapped_ActionDetails:(UIGestureRecognizer *)reconizer
{
    
}
-(void)DeleteVideoCommunication
{
    Reachability *networkReachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus networkStatus = [networkReachability currentReachabilityStatus];
    if (networkStatus == NotReachable)
    {
        
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"No Internet" message:@"Please make sure you have internet connectivity in order to access Care2dare." preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *actionOk = [UIAlertAction actionWithTitle:@"Ok"
                                                           style:UIAlertActionStyleDefault
                                                         handler:^(UIAlertAction *action)
                                   {
                                       exit(0);
                                   }];
        
        [alertController addAction:actionOk];
        
        UIWindow *alertWindow = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
        alertWindow.rootViewController = [[UIViewController alloc] init];
        alertWindow.windowLevel = UIWindowLevelAlert + 1;
        [alertWindow makeKeyAndVisible];
        [alertWindow.rootViewController presentViewController:alertController animated:YES completion:nil];
        
        
    }
    else
    {
        
        NSString *userid1= @"userid";
        NSString *useridVal1 =[defaults valueForKey:@"userid"];
        
        NSString *deletetype= @"deletetype";
        NSString *deletetypeval=@"VIDEO";
        
        NSString *VedioIds= @"deleteid";
        
        
        NSString *reqStringFUll=[NSString stringWithFormat:@"%@=%@&%@=%@&%@=%@",userid1,useridVal1,deletetype,deletetypeval,VedioIds,videoid1];
        
        
#pragma mark - swipe sesion
        
        NSURLSession *session = [NSURLSession sessionWithConfiguration: [NSURLSessionConfiguration defaultSessionConfiguration] delegate: nil delegateQueue: [NSOperationQueue mainQueue]];
        
        NSURL *url;
        NSString *  urlStrLivecount=[urlplist valueForKey:@"delete"];;
        url =[NSURL URLWithString:urlStrLivecount];
        
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
        
        [request setHTTPMethod:@"POST"];//Web API Method
        
        [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
        
        request.HTTPBody = [reqStringFUll dataUsingEncoding:NSUTF8StringEncoding];
        
        
        
        NSURLSessionDataTask *dataTask =[session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error)
                                         {
                                             if(data)
                                             {
                                                 NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
                                                 
                                                 NSInteger statusCode = httpResponse.statusCode;
                                                 if(statusCode == 200)
                                                 {
                                                     
                                                     
                                                     
                                                     
                                SBJsonParser *objSBJsonParser = [[SBJsonParser alloc]init];
                                                     
        NSString * ResultString=[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
                                                     
                                                     
            ResultString = [ResultString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
                                                     
            ResultString = [ResultString stringByReplacingOccurrencesOfString:@"\t" withString:@""];
                        if ([ResultString isEqualToString:@"done"])
                        {
                            
                            
                            
            UIAlertController * alert=[UIAlertController alertControllerWithTitle:@"Deleted" message:@"Your video has been successfully deleted!"preferredStyle:UIAlertControllerStyleAlert];
                            
            UIAlertAction* yesButton = [UIAlertAction actionWithTitle:@"Ok"
              style:UIAlertActionStyleDefault handler:^(UIAlertAction * action)
                                {
                                    [self Button_Back_Action:nil];
                                  }];
                            
                            [alert addAction:yesButton];
                            
                            [self presentViewController:alert animated:YES completion:nil];
                            
                            
                        }
                        if ([ResultString isEqualToString:@"deleteerror"])
                                            {
                            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Oops" message:@"The video could not be deleted. Please try again." preferredStyle:UIAlertControllerStyleAlert];
                                                         
                            UIAlertAction *actionOk = [UIAlertAction actionWithTitle:@"Ok"
                                                                                                            style:UIAlertActionStyleDefault
                                                                                                          handler:nil];
                                    [alertController addAction:actionOk];
                                    [self presentViewController:alertController animated:YES completion:nil];
                                                         
                                                     }
                                                     
                                        }
                        else
                            {
                            NSLog(@" error login1 ---%ld",(long)statusCode);
                                                     
                                                 }
                                             }
                                             else if(error)
                                             {
                                                 NSLog(@"error login2.......%@",error.description);
                                                 
                                                 
                                             }
                                             
                                         }];
        [dataTask resume];
    };
    
    
}


-(void)FlagVedioCommunication
{
    Reachability *networkReachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus networkStatus = [networkReachability currentReachabilityStatus];
    if (networkStatus == NotReachable)
    {
        
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"No Internet" message:@"Please make sure you have internet connectivity in order to access Care2dare." preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *actionOk = [UIAlertAction actionWithTitle:@"Ok"
                                                           style:UIAlertActionStyleDefault
                                                         handler:^(UIAlertAction *action)
                                   {
                                       exit(0);
                                   }];
        
        [alertController addAction:actionOk];
        
        UIWindow *alertWindow = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
        alertWindow.rootViewController = [[UIViewController alloc] init];
        alertWindow.windowLevel = UIWindowLevelAlert + 1;
        [alertWindow makeKeyAndVisible];
        [alertWindow.rootViewController presentViewController:alertController animated:YES completion:nil];
        
        
    }
    else
    {
        
        NSString *userid1= @"userid";
        NSString *useridVal1 =[defaults valueForKey:@"userid"];
        
        NSString *FlagType= @"flagtype";
        NSString *FlagTypeval=@"VIDEO";
        
        NSString *VedioIds= @"flagid";
        
        
        NSString *reqStringFUll=[NSString stringWithFormat:@"%@=%@&%@=%@&%@=%@",userid1,useridVal1,FlagType,FlagTypeval,VedioIds,videoid1];
        
        
#pragma mark - swipe sesion
        
        NSURLSession *session = [NSURLSession sessionWithConfiguration: [NSURLSessionConfiguration defaultSessionConfiguration] delegate: nil delegateQueue: [NSOperationQueue mainQueue]];
        
        NSURL *url;
        NSString *  urlStrLivecount=[urlplist valueForKey:@"flag"];;
        url =[NSURL URLWithString:urlStrLivecount];
        
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
        
        [request setHTTPMethod:@"POST"];//Web API Method
        
        [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
        
        request.HTTPBody = [reqStringFUll dataUsingEncoding:NSUTF8StringEncoding];
        
        
        
        NSURLSessionDataTask *dataTask =[session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error)
        {
                if(data)
                        {
            NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
                                                 
            NSInteger statusCode = httpResponse.statusCode;
                if(statusCode == 200)
                {
                                                     
         
                                                     
                                                     
        SBJsonParser *objSBJsonParser = [[SBJsonParser alloc]init];
                                                     
    NSString * ResultString=[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
                                                     
                                                     
        ResultString = [ResultString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
        ResultString = [ResultString stringByReplacingOccurrencesOfString:@"\t" withString:@""];
                                                     
                    if ([ResultString isEqualToString:@"done"])
                    {
                       
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Flagged" message:@"The concerned video has been flagged and the team will review it and take appropriate action. Thank-you for the heads up!" preferredStyle:UIAlertControllerStyleAlert];
                        
                UIAlertAction *actionOk = [UIAlertAction actionWithTitle:@"Ok"
                                                                           style:UIAlertActionStyleDefault
                                                                         handler:nil];
                        [alertController addAction:actionOk];
                        [self presentViewController:alertController animated:YES completion:nil];
                    }
                    if ([ResultString isEqualToString:@"deleteerror"])
                    {
                        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Oops" message:@"The video could not be flagged. Please try again." preferredStyle:UIAlertControllerStyleAlert];
                        
                        UIAlertAction *actionOk = [UIAlertAction actionWithTitle:@"Ok"
                                                                           style:UIAlertActionStyleDefault
                                                                         handler:nil];
                        [alertController addAction:actionOk];
                        [self presentViewController:alertController animated:YES completion:nil];
                        
                    }

               
                    
                                                 }
                                                 else
                                                 {
                                  NSLog(@" error login1 ---%ld",(long)statusCode);
                                                    
                                                 }
                                             }
                                             else if(error)
                                             {
                        NSLog(@"error login2.......%@",error.description);
                    
                                                 
                                             }
                                             
                                         }];
        [dataTask resume];
    };


}
@end
