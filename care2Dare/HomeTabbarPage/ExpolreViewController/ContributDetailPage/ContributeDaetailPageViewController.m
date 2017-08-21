//
//  ContributeDaetailPageViewController.m
//  care2Dare
//
//  Created by Spiel's Macmini on 3/16/17.
//  Copyright © 2017 Spiel's Macmini. All rights reserved.
//

#import "ContributeDaetailPageViewController.h"

#import "AFNetworking.h"

#import "ContributeMoneyViewController.h"
#import "RaisedContributeViewController.h"
#import "SBJsonParser.h"
#import "Reachability.h"
#import "Base64.h"
#import "MHFacebookImageViewer.h"
#import "UIImageView+MHFacebookImageViewer.h"
#import "ProfilePageDetailsViewController.h"

#import "SDAVAssetExportSession.h"
#import "WatchVedioScrollViewController.h"

#define FONT_SIZE 16.0f
#define CELL_CONTENT_WIDTH self.view.frame.size.width-138

#define CELL_CONTENT_MARGIN 0.0f

@interface ContributeDaetailPageViewController ()<NSURLSessionDelegate>
{
    UIView *sectionView,*transperentViewIndicator,*whiteView1,*transperentViewIndicatorcc,*whiteView1cc;
;
    CALayer *Bottomborder_Cell2;
    UIButton *Button_Contribute,*Button_FavouriteTap,*Image_Share;;
    CGRect textRect;
    NSUserDefaults *defaults;
    NSDictionary *urlplist;
    NSString * CheckFavInserted,*chattype,*Str_Tapped_Comments_Vedio,*str_Userid2val;
    UIImage *chosenImage;
    CGFloat HeightText0;
    CGRect TextViewCord,BackTextViewCord;
    CGFloat lastScale;
    CGFloat hh,ww,xx,yy,th,tw,xt,yt,bty,btw,bth,btx,Bluesch,Bluescw,Bluescy,Bluescx,textBluex,textBluey,textBluew,textBlueh,hhone,wwone,xxone,yyone;
    NSURLSessionDataTask *dataTaskupload;
       NSString * flag1,*String_Comment,*encodedImage,*imageUserheight,*imageUserWidth,*ImageNSdata,*TagId_plist,*strCameraVedio,*mediatypeVal,*ImageNSdataThumb,*encodedImageThumb,*str_TappedLabel,*str_LabelCoordinates,*str_falgUiprogressView;
    NSMutableArray * Array_Comment1,*Array_Comment,*Array_RecodVid,*Array_showrecordvid,*Array_likes;
    NSData *imageData;
    NSArray *previousArray;
    CALayer *upperBorder,*upperBorder1;
    NSData *imageDataThumb;
    UIButton * Button_close;
    UIActivityIndicatorView *indicatorAlert,*indicatorAlertcc;
    UILabel * Label_confirm,*Label_confirm1,*Label_confirm1cc;
   
    
    UIScrollView * scrollView;
    CGFloat Xpostion, Ypostion, Xwidth, Yheight, ScrollContentSize,Xpostion_label, Ypostion_label, Xwidth_label, Yheight_label,Cell_DescLabelX,Cell_DescLabelY,Cell_DescLabelW,Cell_DescLabelH,TextView_ViewX,TextView_ViewY,TextView_ViewW,TextView_ViewH,keyboradHeight;
    CGRect scrollFrame;
    
    NSNumber *Vedio_Height,*Vedio_Width;
    UIImage *FrameImage;
    UIImagePickerController * picker1;
    NSString *index_friendReq,*str_ChallengeidVal,*videoid1,*str_Userid2val1;;
    MPMoviePlayerViewController * movieController;
    
    CGFloat XpostionNewSymbol,YpostionNewSymbol,WpostionNewSymbol,HpostionNewSymbol;
}
- (void) displayImage:(UIImageView*)imageView withImage:(UIImage*)image;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tabBarBottomSpace;
@end


#define kBackgroundColorShowed [UIColor colorWithRed:0.27f green:0.85f blue:0.46f alpha:1.0f];
#define kBackgroundColorHided [UIColor colorWithRed:0.18f green:0.67f blue:0.84f alpha:1.0f];



@implementation ContributeDaetailPageViewController
@synthesize cell_TwoDetails,Raised_amount,Button_back,Image_TotalLikes,Button_TotalPoints,AllArrayData,view_Topheader;
@synthesize TextViews,BackTextViews;
@synthesize textOne,ViewTextViewOne,Tableview_ContriBute,cell_Vediolist;


- (void)viewDidLoad
{
    [super viewDidLoad];

    defaults=[[NSUserDefaults alloc]init];
     previousArray  = [[NSArray alloc]init];
    upperBorder = [CALayer layer];
      upperBorder1 = [CALayer layer];
   [defaults setObject:@"no" forKey:@"ExpView_Update"];
    NSString *plistPath = [[NSBundle mainBundle]pathForResource:@"UrlName" ofType:@"plist"];
    urlplist = [NSDictionary dictionaryWithContentsOfFile:plistPath];

    
    Tableview_ContriBute.userInteractionEnabled=YES;
    UITapGestureRecognizer *TabGestureTablviewTuch =[[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                            action:@selector(Tablview_Tuched:)];
    
    
    [Tableview_ContriBute addGestureRecognizer:TabGestureTablviewTuch];

    CheckFavInserted=[[AllArrayData objectAtIndex:0]valueForKey:@"favourite"];
   CALayer * borderBottom_topheder = [CALayer layer];
    borderBottom_topheder.backgroundColor =[UIColor colorWithRed:186/255.0 green:188/255.0 blue:190/255.0 alpha:1.0].CGColor;
    borderBottom_topheder.frame = CGRectMake(0, view_Topheader.frame.size.height-1, view_Topheader.frame.size.width,1);
    [view_Topheader.layer addSublayer:borderBottom_topheder];
     NSLog(@"AllArrayData=%@",AllArrayData);;
    
    if ([[[AllArrayData objectAtIndex:0] valueForKey:@"contributiontype"] isEqualToString:@"RAISE"])
    {
        if ([[[AllArrayData objectAtIndex:0] valueForKey:@"payperchallenger"] isEqualToString:@"0"])
        {
             Raised_amount.text=[NSString stringWithFormat:@"%@%@",@"Raised: $",[[AllArrayData objectAtIndex:0] valueForKey:@"backamount"]];
        }
        else
        {
          Raised_amount.text=[NSString stringWithFormat:@"%@%@%@%@",@"Raised: $",[[AllArrayData objectAtIndex:0] valueForKey:@"backamount"],@" / $",[[AllArrayData objectAtIndex:0] valueForKey:@"payperchallenger"]];
        }
     
    }
    else
    {
       Raised_amount.text=[NSString stringWithFormat:@"%@%@",@"Raised: $",[[AllArrayData objectAtIndex:0] valueForKey:@"backamount"]];
    }
    
   
    
      [Button_TotalPoints setTitle:[NSString stringWithFormat:@"%@",[[AllArrayData objectAtIndex:0] valueForKey:@"backers"]] forState:UIControlStateNormal];
    
    Image_TotalLikes.userInteractionEnabled=YES;
    UITapGestureRecognizer * Image_TotalLikes_Tapped =[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(Image_TotalLikes_Action:)];
    [Image_TotalLikes addGestureRecognizer:Image_TotalLikes_Tapped];
    

//    CGRect tableViewFrame = self.Tableview_ContriBute.frame;
//    tableViewFrame.size.height = self.Tableview_ContriBute.frame.size.height-8;
//    self.Tableview_ContriBute.frame = tableViewFrame;

Str_Tapped_Comments_Vedio=@"Vedio";
    
    
    textOne.clipsToBounds=YES;
    textOne.layer.cornerRadius=7.0f;
    
    ViewTextViewOne.clipsToBounds=YES;
    ViewTextViewOne.layer.cornerRadius=9.0f;
    
    str_falgUiprogressView=@"yes";
     flag1=@"yes";
    
    
    hh=textOne.frame.size.height+5;
    ww=textOne.frame.size.width;
    xx=textOne.frame.origin.x;
    yy=textOne.frame.origin.y;
    
    th=Tableview_ContriBute.frame.size.height;
    tw=Tableview_ContriBute.frame.size.width;
    xt=Tableview_ContriBute.frame.origin.x;
    yt=Tableview_ContriBute.frame.origin.y;
    
    bth=_BlackViewOne.frame.size.height;
    btw=_BlackViewOne.frame.size.width;
    btx=_BlackViewOne.frame.origin.x;
    bty=_BlackViewOne.frame.origin.y;
    
    Bluesch=_BlackViewOne.frame.size.height;
    Bluescw=_BlackViewOne.frame.size.width;
    Bluescx=_BlackViewOne.frame.origin.x;
    Bluescy=_BlackViewOne.frame.origin.y;
     _textOneBlue.hidden=YES;
    [Tableview_ContriBute setFrame:CGRectMake(0,yt, tw, th+_BlackViewOne.frame.size.height)];
    
    if ([[UIScreen mainScreen]bounds].size.width==320 && [[UIScreen mainScreen]bounds].size.height==568)
    {
        
        ww=194.0;
        
    }
    else if ([[UIScreen mainScreen]bounds].size.width==375 && [[UIScreen mainScreen]bounds].size.height==667)
    {
        
        ww=249.0;
    }
    
    else  if ([[UIScreen mainScreen]bounds].size.width==414 && [[UIScreen mainScreen]bounds].size.height==736)
    {
        
        ww=288.0;
        
        
    }
    
    
    
   
    
    
    //    CGRect previousRect = CGRectZero;
    self.BlackViewOne.frame = CGRectMake(0, 55, self.view.frame.size.width,87);
    self.textOne.frame = CGRectMake(xx, yy,ww,36);
    ViewTextViewOne.frame = CGRectMake(xx, yy, ww,36);
    
    
    
    //  Table_Friend_chat.frame = CGRectMake(0,-1, tw, th);
    //     Table_Friend_chat.frame = CGRectMake(0,yt, tw, th-10);
    // Table_Friend_chat.backgroundColor=[UIColor greenColor];
    
    
    
    
    
    
    //   [self.view addSubview:self.ewenTextView];
    //     _ewenTextView.backgroundColor = [UIColor clearColor];
    
    
    
    [TextViews becomeFirstResponder];
    
    TextViewCord=TextViews.frame;
    BackTextViewCord=BackTextViews.frame;
    HeightText0=TextViews.frame.size.height;
    TextViews.layer.cornerRadius=8.0f;
    self.sendButton.userInteractionEnabled = NO;
    self.sendButton.hidden=NO;
    self.sendButton.enabled=NO;
    self.placeholderLabel.hidden=NO;
    [self.sendButton setBackgroundColor:[UIColor colorWithRed:180/255.0 green:186/255.0 blue:190/255.0 alpha:1]];
    self.sendButton.layer.cornerRadius=self.sendButton.frame.size.height/2;
    self.sendButton.frame=CGRectMake((self.view.frame.size.width-self.sendButton.frame.size.width)-4, self.sendButton.frame.origin.y,self.sendButton.frame.size.width, self.sendButton.frame.size.height);
    
    self.ImageGalButton.userInteractionEnabled = YES;
    _ImageGalButton.hidden=NO;
    _ImageGalButton.enabled=YES;
    [self.ImageGalButton setBackgroundColor:[UIColor clearColor]];
    
    
    NSString * documnetPath1=[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    
    NSLog(@"%@",NSHomeDirectory());
    
    NSString * path = [documnetPath1 stringByAppendingPathComponent:@"ChatText.plist"];
    
    NSString * bundlePath = [[NSBundle mainBundle]pathForResource:@"ChatText" ofType:@"plist"];
    
    if([[NSFileManager defaultManager]fileExistsAtPath:path])
    {
        NSLog(@"File alredy exists");
    }
    else
    {
        [[NSFileManager defaultManager]copyItemAtPath:bundlePath toPath:path error:nil];
    }
    
    NSMutableDictionary *dictionary = [[NSMutableDictionary alloc] initWithContentsOfFile:path];
    
    
    NSLog(@"dictionary setValue:=%@",dictionary );
    
        TagId_plist=[[AllArrayData valueForKey:@"challengeid"]objectAtIndex:0];
        
    
    
    
    BOOL contains = [[dictionary allKeys] containsObject:TagId_plist];
    if(contains==YES)
    {
        NSLog(@"YEsssssssssssss");
        Array_Comment1=[dictionary valueForKey:TagId_plist];
        [Tableview_ContriBute reloadData];
    }
    
//    Array_Comment1 = [[NSMutableArray alloc] initWithContentsOfFile:path];
//    NSLog(@"dictionary setValue:=%@",Array_Comment1 );
//
//    
//      TagId_plist=[defaults valueForKey:@"userid"];
//        //TagId_plist=[[AllArrayData valueForKey:@"useridsender"]objectAtIndex:0];
//      
//    
//           if(Array_Comment1.count>=1)
//        {
//          [Tableview_ContriBute reloadData];
//          
////         [Tableview_ContriBute scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:Array_Comment1.count-1 inSection:2] atScrollPosition:UITableViewScrollPositionBottom animated:NO];
//            
//        }
//        NSLog(@"data plist path array==%@",Array_Comment1);
    

    
    
    
    strCameraVedio=@"";
    
    
    
    transperentViewIndicator=[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    transperentViewIndicator.backgroundColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.5];
    
    whiteView1=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 150,150)];
    whiteView1.center=transperentViewIndicator.center;
    [whiteView1 setBackgroundColor:[UIColor blackColor]];
    whiteView1.layer.cornerRadius=9;
//   indicatorAlert = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
//    indicatorAlert.frame=CGRectMake(40, 40, 20, 20);
//    [indicatorAlert startAnimating];
//    [indicatorAlert setColor:[UIColor whiteColor]];
    
    Label_confirm1=[[UILabel alloc]initWithFrame:CGRectMake(0, 50, 150, 40)];
    
    [Label_confirm1 setFont:[UIFont systemFontOfSize:12]];
    Label_confirm1.text=@"0 %";
    Label_confirm1.font=[UIFont fontWithName:@"SanFranciscoDisplay-Bold" size:40.0];
    Label_confirm1.textColor=[UIColor whiteColor];
    Label_confirm1.textAlignment=NSTextAlignmentCenter;
    
    Label_confirm=[[UILabel alloc]initWithFrame:CGRectMake(0, 110, 150, 28)];
    
    [Label_confirm setFont:[UIFont systemFontOfSize:12]];
    Label_confirm.text=@"Uploading...";
    Label_confirm.font=[UIFont fontWithName:@"SanFranciscoDisplay-Bold" size:20.0];
    Label_confirm.textColor=[UIColor whiteColor];
    Label_confirm.textAlignment=NSTextAlignmentCenter;
    
    Button_close=[[UIButton alloc]initWithFrame:CGRectMake(whiteView1.frame.size.width-23, -4, 28,28)];
    Button_close.layer.cornerRadius=Button_close.frame.size.height/2;
    
    Button_close.backgroundColor=[UIColor whiteColor];
    [Button_close setTitle:@"X" forState:UIControlStateNormal];
     [Button_close setTitleColor:[UIColor redColor]forState:UIControlStateNormal];
    Button_close.titleLabel.font=[UIFont fontWithName:@"SanFranciscoDisplay-Bold" size:14.0];
    [Button_close addTarget:self action:@selector(UploadinView_Close:) forControlEvents:UIControlEventTouchUpInside];
      [whiteView1 addSubview:Button_close];
    [whiteView1 addSubview:Label_confirm];
    [whiteView1 addSubview:Label_confirm1];
    
    [transperentViewIndicator addSubview:whiteView1];
    
    [self.view addSubview:transperentViewIndicator];
    
    transperentViewIndicator.hidden=YES;
    
    
    ///////compress...////////////////
    
    
    transperentViewIndicatorcc=[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    transperentViewIndicatorcc.backgroundColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.5];
    
    whiteView1cc=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 110,110)];
    whiteView1cc.center=transperentViewIndicatorcc.center;
    [whiteView1cc setBackgroundColor:[UIColor blackColor]];
    whiteView1cc.layer.cornerRadius=9;
    indicatorAlertcc = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    indicatorAlertcc.frame=CGRectMake((whiteView1cc.frame.size.width/2)-10, (whiteView1cc.frame.size.height/2)-15, 20, 20);
    [indicatorAlertcc startAnimating];
    [indicatorAlertcc setColor:[UIColor whiteColor]];
    
    Label_confirm1cc=[[UILabel alloc]initWithFrame:CGRectMake(0,(indicatorAlertcc.frame.size.height+indicatorAlertcc.frame.origin.y)+5, whiteView1cc.frame.size.width, 40)];
    
    
    Label_confirm1cc.text=@"Preparing...";
    Label_confirm1cc.font=[UIFont fontWithName:@"SanFranciscoDisplay-Bold" size:16.0];
    Label_confirm1cc.textColor=[UIColor whiteColor];
    Label_confirm1cc.textAlignment=NSTextAlignmentCenter;
    
    
    [whiteView1cc addSubview:indicatorAlertcc];
    
    [whiteView1cc addSubview:Label_confirm1cc];
    
    [transperentViewIndicatorcc addSubview:whiteView1cc];
    
    
    ////////////////////////////////////
    
    
    XpostionNewSymbol=40;
    YpostionNewSymbol=0;
    WpostionNewSymbol=20;
    HpostionNewSymbol=20;
    
    Xpostion=12;
    Ypostion=8;
    Xwidth=60;
    Yheight=60;
    ScrollContentSize=0;
    Xpostion_label=12;
    Ypostion_label=67;
    Xwidth_label=60;
    Yheight_label=20;
    
    
    
        str_TappedLabel=@"no";
    str_LabelCoordinates=@"no";
    
    [self Communication_showrecordVid];
    [self chatCommunication];
    
    
    
    
    
   
   
    
    
}

-(void)UploadinView_Close:(UIButton *)sender
{
  
    
    UIAlertController * alert=[UIAlertController
                               
                               alertControllerWithTitle:@"Cancel?" message:@"Are you sure you want to cancel your upload?"preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* yesButton = [UIAlertAction
                                actionWithTitle:@"Resume"
                                style:UIAlertActionStyleDefault
                                handler:^(UIAlertAction * action)
                                {
                                   
                                    [dataTaskupload resume];
                                    transperentViewIndicator.hidden=NO;
                                    
                                }];
    UIAlertAction* noButton = [UIAlertAction
                               actionWithTitle:@"Cancel"
                               style:UIAlertActionStyleDefault
                               handler:^(UIAlertAction * action)
                               {
                                 
                                   [dataTaskupload cancel];
                                   transperentViewIndicator.hidden=YES;
                               }];
    
    [alert addAction:yesButton];
    [alert addAction:noButton];
    
    [self presentViewController:alert animated:YES completion:nil];
    
    
   
}



-(void)Communication_showrecordVid
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
        
        
        NSString *userid= @"userid";
        NSString *useridVal =[defaults valueForKey:@"userid"];
        
        NSString *challengeid= @"challengeid";
        NSString *challengeidval =[[AllArrayData objectAtIndex:0] valueForKey:@"challengeid"];
        
        
        NSString *reqStringFUll=[NSString stringWithFormat:@"%@=%@&%@=%@",userid,useridVal,challengeid,challengeidval];
        
        
#pragma mark - swipe sesion
        
        NSURLSession *session = [NSURLSession sessionWithConfiguration: [NSURLSessionConfiguration defaultSessionConfiguration] delegate: nil delegateQueue: [NSOperationQueue mainQueue]];
        
        NSURL *url;
        NSString *  urlStrLivecount=[urlplist valueForKey:@"showvideos"];;
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
                                                     
                Array_showrecordvid=[[NSMutableArray alloc]init];
            SBJsonParser *objSBJsonParser = [[SBJsonParser alloc]init];
        Array_showrecordvid=[objSBJsonParser objectWithData:data];
                                                     
                                                     
                                                     
        NSString * ResultString=[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
                                                   
                                                     
 ResultString = [ResultString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    ResultString = [ResultString stringByReplacingOccurrencesOfString:@"\t" withString:@""];
                                                     
    if(Array_showrecordvid.count !=0)
                {
                  str_falgUiprogressView=@"no";
                    NSLog(@"showsVedio===%@",Array_showrecordvid);
                                                    
        [Tableview_ContriBute reloadData];
                                                         
                                                         
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



//showvideos.php

-(void)chatCommunication
{
    //[self.view endEditing:YES];
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
        
        
        NSString *userid= @"userid";
        NSString *useridVal =[defaults valueForKey:@"userid"];
        
        NSString *challengeid= @"challengeid";
        NSString *challengeidval =[[AllArrayData objectAtIndex:0] valueForKey:@"challengeid"];
        
        
        NSString *reqStringFUll=[NSString stringWithFormat:@"%@=%@&%@=%@",userid,useridVal,challengeid,challengeidval];
        
        
#pragma mark - swipe sesion
        
        NSURLSession *session = [NSURLSession sessionWithConfiguration: [NSURLSessionConfiguration defaultSessionConfiguration] delegate: nil delegateQueue: [NSOperationQueue mainQueue]];
        
        NSURL *url;
        NSString *  urlStrLivecount=[urlplist valueForKey:@"chat"];;
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
                                                     
                                                     Array_Comment=[[NSMutableArray alloc]init];
                                                     SBJsonParser *objSBJsonParser = [[SBJsonParser alloc]init];
                                                     Array_Comment=[objSBJsonParser objectWithData:data];
                                                     
                                                     
                                                     
                                                     NSString * ResultString=[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
                                                     //        Array_LodingPro=[NSJSONSerialization JSONObjectWithData:webData_Swipe options:kNilOptions error:nil];
                                                     
                                                     ResultString = [ResultString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
                                                     ResultString = [ResultString stringByReplacingOccurrencesOfString:@"\t" withString:@""];
                                                     
              
                                                     
       if(Array_Comment.count !=0)
      {
                                                         
          NSString * documnetPath1=[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
          
          NSLog(@"%@",NSHomeDirectory());
          
          NSString * path = [documnetPath1 stringByAppendingPathComponent:@"ChatText.plist"];
              
              NSMutableDictionary *savedValue1 = [[[NSMutableDictionary alloc] initWithContentsOfFile: path]mutableCopy];
              
              NSMutableDictionary *dictionary = [[[NSMutableDictionary alloc] initWithContentsOfFile:path]mutableCopy];
              
              
              
              if(Array_Comment1.count==0 || savedValue1==nil)
              {
                  if (savedValue1==nil)
                  {
                      NSMutableDictionary *data;
                      
                      data = [[NSMutableDictionary alloc] init];
                      
                      [data setObject:Array_Comment forKey:TagId_plist];
                      [data writeToFile:path atomically:YES];
                  }
                  
              }
              
              
              NSLog(@"NSHomeDirectory=%@",NSHomeDirectory());
              
              NSLog(@"dictionary setValue:=%@",dictionary );
              
              if (Array_Comment.count!=0)
              {
                  Array_Comment1=Array_Comment;
                  [dictionary setObject:Array_Comment forKey:TagId_plist];
                  [dictionary writeToFile:path atomically:YES];
              }
              
              
              
              if (previousArray.count == Array_Comment.count)
              {
                  
              }
              else
              {
                  [Tableview_ContriBute reloadData];
              }
              
              
              
              
              
              
              
              if(Array_Comment.count>=1 && previousArray.count != Array_Comment.count )
              {
                  
                  
//                  [Table_Friend_chat scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:Array_Comment.count inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:NO];
                  
              }
              
              previousArray = Array_Comment;
              
          
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
//                                                         
//                                                         NSString * documnetPath1=[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
//                                                         
//                                                         NSLog(@"%@",NSHomeDirectory());
//                                                         
//                                                         NSString * path = [documnetPath1 stringByAppendingPathComponent:@"ChatText.plist"];
//                                                         
//                                                         
//                                                        
//                                                             
//                                                       
//                                                 
//                                                                     [Array_Comment writeToFile:path atomically:YES];
//                                                                 
//                                                         
//                                                             
//                                                             if (previousArray.count == Array_Comment.count)
//                                    {
//                                                                 
//                                        }
//       else
//                                                             {
//        [Tableview_ContriBute reloadData];
//                                                             }
//       if(Array_Comment.count>=1 && previousArray.count != Array_Comment.count )
//                                                             {
//                                                                 
////          [Tableview_ContriBute scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:Array_Comment.count-1 inSection:2] atScrollPosition:UITableViewScrollPositionBottom animated:NO];
//                                                                 
//                                                        }
//                                                             
//                                                             previousArray = Array_Comment;
//                                                             
//                                                             
                                                         
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

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[NSURLCache sharedURLCache] removeAllCachedResponses];
    XpostionNewSymbol=40;
    YpostionNewSymbol=0;
    WpostionNewSymbol=20;
    HpostionNewSymbol=20;
    
    Xpostion=12;
    Ypostion=8;
    Xwidth=60;
    Yheight=60;
    ScrollContentSize=0;
    Xpostion_label=12;
    Ypostion_label=67;
    Xwidth_label=60;
    Yheight_label=20;
    [self Communication_showrecordVid];
    [self subscribeToKeyboard];
}
- (void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
 
    [self an_unsubscribeKeyboard];
}


- (void)subscribeToKeyboard {
    [self an_subscribeKeyboardWithAnimations:^(CGRect keyboardRect, NSTimeInterval duration, BOOL isShowing) {
        if (isShowing)
        {
            
            self.tabBarBottomSpace.constant = CGRectGetHeight(keyboardRect);
            Tableview_ContriBute.frame = CGRectMake(0,yt, tw, th-(textBlueh+CGRectGetHeight(keyboardRect)));
            keyboradHeight=(textBlueh+CGRectGetHeight(keyboardRect));
            if(Array_Comment1.count>=1)
            {

                [Tableview_ContriBute scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:Array_Comment1.count-1 inSection:3] atScrollPosition:UITableViewScrollPositionBottom animated:NO];
//

            }
            
            
            
            
        } else
        {
            
            self.tabBarBottomSpace.constant = 0.0f;
            keyboradHeight=0.0f;
            if ([Str_Tapped_Comments_Vedio isEqualToString:@"Vedio"])
            {
                 [Tableview_ContriBute setFrame:CGRectMake(0,yt, tw, th+_BlackViewOne.frame.size.height-30)];
            }
            else
            {
              Tableview_ContriBute.frame = CGRectMake(0,yt, tw, th);
            }
           
           
            
           
            
        }
        [self.view layoutIfNeeded];
    } completion:nil];}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    
    [textField resignFirstResponder];
    return YES;
}
-(void)Image_TotalLikes_Action:(UIGestureRecognizer *)reconizer
{
    [self ButtonTotalPoints_Action:nil];
}
-(IBAction)Send_Comments:(id)sender
{
    String_Comment=textOne.text;
    [self sendComment];
    textOne.text=nil;
    _ImageGalButton.enabled=YES;
    _placeholderLabel.hidden=NO;
    self.BlackViewOne.frame = CGRectMake(0, 55, self.view.frame.size.width,87);
    self.textOne.frame = CGRectMake(xx, yy, ww,36);
    ViewTextViewOne.frame = CGRectMake(xx, yy, ww,36);
    self.sendButton.enabled=NO;
    self.sendButton.backgroundColor=[UIColor colorWithRed:186/255.0 green:188/255.0 blue:190/255.0 alpha:1];
   
    self.ImageGalButton.userInteractionEnabled = YES;
//    Tableview_ContriBute.frame = CGRectMake(0,yt, tw, th-_BlackViewOne.frame.size.height+90);
    self.ImageGalButton.userInteractionEnabled = YES;
     Tableview_ContriBute.frame = CGRectMake(0,yt, tw, th-keyboradHeight);
}


-(void)sendComment
{
    
  //  [self.view endEditing:YES];
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
        
        
        NSString *userid= @"userid";
        NSString *useridVal =[defaults valueForKey:@"userid"];
        
        NSString *challengeid= @"challengeid";
        NSString *challengeidval =[[AllArrayData objectAtIndex:0] valueForKey:@"challengeid"];
        
        NSString *messege= @"message";
        NSString *messegeval =(NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(NULL,(CFStringRef)textOne.text,NULL,(CFStringRef)@"!*\"();:@&=+$,/?%#[]% ",CFStringConvertNSStringEncodingToEncoding(NSUTF8StringEncoding)));;;
        
        NSString *chattypes= @"chattype";
        

        
        NSString *chatimage= @"chatimage";
        
        
        NSString *imageheights= @"imageheight";
        
        NSString *imagewidths= @"imagewidth";
       

        
        
        NSString *reqStringFUll=[NSString stringWithFormat:@"%@=%@&%@=%@&%@=%@&%@=%@&%@=%@&%@=%@&%@=%@",userid,useridVal,challengeid,challengeidval,messege,messegeval,chattypes,chattype,chatimage,encodedImage,imagewidths,imageUserWidth,imageheights,imageUserheight];
        
        
        
#pragma mark - swipe sesion
        
        NSURLSession *session = [NSURLSession sessionWithConfiguration: [NSURLSessionConfiguration defaultSessionConfiguration] delegate: nil delegateQueue: [NSOperationQueue mainQueue]];
        
        NSURL *url;
        NSString *  urlStrLivecount=[urlplist valueForKey:@"addchat"];;
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
                                                     
                                                    Array_Comment=[[NSMutableArray alloc]init];
                                                     SBJsonParser *objSBJsonParser = [[SBJsonParser alloc]init];
                                                     Array_Comment=[objSBJsonParser objectWithData:data];
                                                     
                                                     
                                                     
                                                     NSString * ResultString=[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
                                                     //        Array_LodingPro=[NSJSONSerialization JSONObjectWithData:webData_Swipe options:kNilOptions error:nil];
                                                     
                                                     ResultString = [ResultString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
                                                     ResultString = [ResultString stringByReplacingOccurrencesOfString:@"\t" withString:@""];
                                                     
                                                   
                                                     
                                                     
                                                     
                                                     
                                                     
                                                     if ([ResultString isEqualToString:@"nullerror"])
                                                     {
                                                      
                                                         
                                                         UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Oops" message:@"Could not retrieve your Account Id. Please login and try again." preferredStyle:UIAlertControllerStyleAlert];
                                                         
                                                         UIAlertAction *actionOk = [UIAlertAction actionWithTitle:@"Ok"
                                                                                                            style:UIAlertActionStyleDefault
                                                                                                          handler:nil];
                                                         [alertController addAction:actionOk];
                                                         [self presentViewController:alertController animated:YES completion:nil];
                                                         
                                                         
                                                     }
                                                     if ([ResultString isEqualToString:@"nouserid"])
                                                     {
                                                                                                                 UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Oops" message:@"Your account does not exist or it has been de-activated by the administrator. Please contact us for further details." preferredStyle:UIAlertControllerStyleAlert];
                                                         
                                                         UIAlertAction *actionOk = [UIAlertAction actionWithTitle:@"Ok"
                                                                                                            style:UIAlertActionStyleDefault
                                                                                                          handler:nil];
                                                         [alertController addAction:actionOk];
                                                         [self presentViewController:alertController animated:YES completion:nil];
                                                         
                                                         
                                                         
                                                     }
                                                     if ([ResultString isEqualToString:@"inserterror"])
                                                     {
                                                     
                                                         UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Oops" message:@"Error in sending message. Please try again." preferredStyle:UIAlertControllerStyleAlert];
                                                         
                                                         UIAlertAction *actionOk = [UIAlertAction actionWithTitle:@"Ok"
                                                                                                            style:UIAlertActionStyleDefault
                                                                                                          handler:nil];
                                                         [alertController addAction:actionOk];
                                                         [self presentViewController:alertController animated:YES completion:nil];
                                                         
                                                     }
                                                     
                                                     if ([ResultString isEqualToString:@"messagenull"])
                                                     {
                                                        
                                                         UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Oops" message:@"Your message text seems to be empty. Please try again." preferredStyle:UIAlertControllerStyleAlert];
                                                         
                                                         UIAlertAction *actionOk = [UIAlertAction actionWithTitle:@"Ok"
                                                                                                            style:UIAlertActionStyleDefault
                                                                                                          handler:nil];
                                                         [alertController addAction:actionOk];
                                                         [self presentViewController:alertController animated:YES completion:nil];
                                                         
                                                     }
                                                     
                                                     if ([ResultString isEqualToString:@"imagenull"])
                                                     {
                                                        
                                                         
                                                         UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Oops" message:@"You seem to have not selected an image to send. Please try again." preferredStyle:UIAlertControllerStyleAlert];
                                                         
                                                         UIAlertAction *actionOk = [UIAlertAction actionWithTitle:@"Ok"
                                                                                                            style:UIAlertActionStyleDefault
                                                                                                          handler:nil];
                                                         [alertController addAction:actionOk];
                                                         [self presentViewController:alertController animated:YES completion:nil];
                                                         
                                                     }
                                                     
                                                     if ([ResultString isEqualToString:@"imageerror"])
                                                     {
                                                         
                                                         UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Oops" message:@"Could not upload the image you have selected. Please try again." preferredStyle:UIAlertControllerStyleAlert];
                                                         
                                                         UIAlertAction *actionOk = [UIAlertAction actionWithTitle:@"Ok"
                                                                                                            style:UIAlertActionStyleDefault
                                                                                                          handler:nil];
                                                         [alertController addAction:actionOk];
                                                         [self presentViewController:alertController animated:YES completion:nil];
                                                         
                                                     }
                if(Array_Comment.count !=0)
      {
                                                         
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDirectory = [paths objectAtIndex:0];
    NSLog(@"NSHomeDirectory=%@",NSHomeDirectory());
    NSString *path = [documentsDirectory stringByAppendingPathComponent:@"ChatText.plist"];
        NSMutableDictionary *dictionary = [[[NSMutableDictionary alloc] initWithContentsOfFile:path]mutableCopy];
     NSMutableDictionary *savedValue1 = [[[NSMutableDictionary alloc] initWithContentsOfFile: path]mutableCopy];
                                                         
            if(Array_Comment1.count==0 || savedValue1==nil)
                                        {
                    if (savedValue1==nil)
                {
        NSMutableDictionary *data;
        data = [[NSMutableDictionary alloc] init];
                                                                 
          [data setObject:Array_Comment forKey:TagId_plist];
                [data writeToFile:path atomically:YES];
                     }
            }
 NSLog(@"NSHomeDirectory=%@",NSHomeDirectory());
    NSLog(@"dictionary setValue:=%@",dictionary);
         if(Array_Comment.count !=0)
         {
        Array_Comment1=Array_Comment;
        [dictionary setObject:Array_Comment forKey:TagId_plist];
    [dictionary writeToFile:path atomically:YES];
                            }
[Tableview_ContriBute reloadData];
        if(Array_Comment.count>=1)
        {
 [Tableview_ContriBute scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:Array_Comment.count-1 inSection:3] atScrollPosition:UITableViewScrollPositionBottom animated:NO];
                                                             
                                                         }
                                                         
                                                     }

//                                                     if(Array_Comment.count !=0)
//                                                     {
//                                                         
//                                                         NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//                                                         NSString *documentsDirectory = [paths objectAtIndex:0];
//                                                         NSLog(@"NSHomeDirectory=%@",NSHomeDirectory());
//                                                         
//                                                         
//                                                         
//                                                         NSString *path = [documentsDirectory stringByAppendingPathComponent:@"ChatText.plist"];
//                                                         
//                                                         
//                                                         
//                                                         NSMutableDictionary *dictionary = [[[NSMutableDictionary alloc] initWithContentsOfFile:path]mutableCopy];
//                                                         
//                                                         
//                                                         NSMutableDictionary *savedValue1 = [[[NSMutableDictionary alloc] initWithContentsOfFile: path]mutableCopy];
//                                                         
////if(Array_Comment.count !=0)
////   {
////                                                             
////        [Array_Comment writeToFile:path atomically:YES];
////            Array_Comment1=Array_Comment;
////        [Tableview_ContriBute reloadData];
////           [Tableview_ContriBute scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:Array_Comment.count-1 inSection:2] atScrollPosition:UITableViewScrollPositionBottom animated:NO];
////                                                             
////                                                         }
//                                                         
//                                                        
//                                                     }
                                                     
                                                     
                                                     
                                                     

                                                     
                                                     
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
    


-(IBAction)CameraButtonAct:(id)sender
{
    UIActionSheet *popup = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Take from camera",@"Choose from gallery",nil];
    popup.tag = 888;
    [popup showInView:self.view];
    
    
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if ((long)actionSheet.tag==888)
    {
        
    
    
    if (buttonIndex== 0)
    {
        
        
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        //picker.allowsEditing = NO;
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        [self presentViewController:picker animated:YES completion:nil];
        //  [self.navigationController pushViewController:picker animated:YES];
        // [self.navigationController presentModalViewController:picker animated:YES];
    }
    if (buttonIndex== 1)
    {
        
        
        UIImagePickerController * picker = [[UIImagePickerController alloc]init];
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        picker.delegate = self;
        [self presentViewController:picker animated:YES completion:nil];
        
        
        
    }
        
    }
    else if ((long)actionSheet.tag == 707)
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
                                       
                                       alertControllerWithTitle:@"Delete Challenge?" message:@"Are you sure you want to delete your challenge?"preferredStyle:UIAlertControllerStyleAlert];
            
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

- (BOOL) startCameraControllerFromViewController: (UIViewController*) controller
                                   usingDelegate: (id <UIImagePickerControllerDelegate,
                                                   UINavigationControllerDelegate>) delegate {
    
    if (([UIImagePickerController isSourceTypeAvailable:
          UIImagePickerControllerSourceTypeCamera] == NO)
        || (delegate == nil)
        || (controller == nil))
        return NO;
  

    
    UIImagePickerController *cameraUI = [[UIImagePickerController alloc] init];
    cameraUI.sourceType = UIImagePickerControllerSourceTypeCamera;
//    if ([UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceFront])
//    {
//        cameraUI.cameraDevice = UIImagePickerControllerCameraDeviceFront;
//    }
    //    else
    //    {
    //     cameraUI.cameraDevice = UIImagePickerControllerCameraDeviceRear;
    //    }
    // Displays a control that allows the user to choose movie capture
    cameraUI.mediaTypes = [[NSArray alloc] initWithObjects: (NSString *) kUTTypeMovie, nil];
    cameraUI.videoQuality = UIImagePickerControllerQualityType640x480;
    
    cameraUI.showsCameraControls = YES;
    cameraUI.videoMaximumDuration = 60.0f;
    
    cameraUI.allowsEditing = YES;
    
    cameraUI.delegate = delegate;
   // cameraUI.view.frame=CGRectMake(5, 5, 310, 280);
  //  [self.view addSubview:cameraUI.view];
    [controller presentModalViewController:cameraUI animated: YES];
    
    return YES;
}
-(void)RecordingVediosImagepicker
{
    [picker1.view addSubview:transperentViewIndicatorcc];
        transperentViewIndicator.hidden=NO;
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
        AVVideoAverageBitRateKey: @750000, // Give your bitrate here for lower size give low values
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
             
             
             imageData=[NSData dataWithContentsOfFile:[outputVideoUrl path]];
             // ImageNSdata = [imageData base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
             
             ImageNSdata = [Base64 encode:imageData];
             
             
             encodedImage = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(NULL,(CFStringRef)ImageNSdata,NULL,(CFStringRef)@"!*'\"();:@&=+$,/?%#[]% ",CFStringConvertNSStringEncodingToEncoding(NSUTF8StringEncoding)));
             
             
             
             [picker1 dismissViewControllerAnimated:YES completion:NULL];
             
             self.videoController = [[MPMoviePlayerController alloc] init];
             
             [self.videoController setContentURL:self.videoURL];
             
             
             
             [self.videoController setScalingMode:MPMovieScalingModeAspectFill];
             _videoController.fullscreen=YES;
             _videoController.allowsAirPlay=NO;
             _videoController.shouldAutoplay=YES;
             
             
             
             
             imageDataThumb = UIImageJPEGRepresentation(FrameImage, 1.0);
             
             
             ImageNSdataThumb = [Base64 encode:imageDataThumb];
             
             
             encodedImageThumb = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(NULL,(CFStringRef)ImageNSdataThumb,NULL,(CFStringRef)@"!*'\"();:@&=+$,/?%#[]% ",CFStringConvertNSStringEncodingToEncoding(NSUTF8StringEncoding)));
             
             if (encodedImageThumb !=nil)
             {
                 transperentViewIndicator.hidden=NO;
                 [self Communication_RecordVid];
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
                                [self RecordingVediosImagepicker];
                                             
                                         }];
             UIAlertAction* noButton = [UIAlertAction
                                        actionWithTitle:@"Cancel"
                                        style:UIAlertActionStyleDefault
                                        handler:^(UIAlertAction * action)
                                        {
                                            
                                            [picker1 dismissViewControllerAnimated:YES completion:NULL];
                                            
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
                                             
                        [self RecordingVediosImagepicker];
                                             
                                         }];
             UIAlertAction* noButton = [UIAlertAction
                                        actionWithTitle:@"Cancel"
                                        style:UIAlertActionStyleDefault
                                        handler:^(UIAlertAction * action)
                                        {
                                            
                                            [picker1 dismissViewControllerAnimated:YES completion:NULL];
                                            
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
    
    
    
    if ([strCameraVedio isEqualToString:@"Record"])
    {
        
        
        
        
        _videoController.view.hidden=NO;
        
        
        
        self.videoURL = info[UIImagePickerControllerMediaURL];
        
        
        
        mediatypeVal=@"VIDEO";
        
   
        self.videoURL = info[UIImagePickerControllerMediaURL];
        
        
        NSData* videoData = [NSData dataWithContentsOfFile:[self.videoURL path]];
        int videoSize = [videoData length]/1024/1024;
        
        
        NSLog(@"data size==%d",videoSize);
        
        
        AVURLAsset *asset = [[AVURLAsset alloc] initWithURL:self.videoURL options:nil];
        
        AVAssetImageGenerator *generateImg = [[AVAssetImageGenerator alloc] initWithAsset:asset];
        generateImg.appliesPreferredTrackTransform = YES;
        NSError *error = NULL;
        CMTime time = CMTimeMake(0, 1);
        CGImageRef refImg = [generateImg copyCGImageAtTime:time actualTime:NULL error:&error];
        NSLog(@"error==%@, Refimage==%@", error, refImg);
        
        
        FrameImage= [[UIImage alloc] initWithCGImage:refImg];
        
        NSLog(@"FrameImage height size==%f",FrameImage.size.height);
        NSLog(@"FrameImage width %fze==%f",FrameImage.size.width);
        
        
        
        if (FrameImage.size.height > FrameImage.size.width)
        {
            Vedio_Height=@640;
            Vedio_Width=@480;
        }
        else
        {
            Vedio_Height=@480;
            Vedio_Width=@640;
        }

        picker1=picker;
        [self RecordingVediosImagepicker];
        
        
        
        
        
      
    }
    
    else
    {
    
    
    
    
    chattype=@"IMAGE";
    chosenImage = info[UIImagePickerControllerOriginalImage];
    
    UIImageView *attachmentImageNew = [[UIImageView alloc] initWithFrame:CGRectMake(0,0, self.view.frame.size.width-120, self.view.frame.size.height-127)];
    attachmentImageNew.image = chosenImage;
    attachmentImageNew.backgroundColor = [UIColor redColor];
    attachmentImageNew.contentMode = UIViewContentModeScaleAspectFit;
    
    
    float widthRatio = attachmentImageNew.bounds.size.width / attachmentImageNew.image.size.width;
    float heightRatio = attachmentImageNew.bounds.size.height / attachmentImageNew.image.size.height;
    float scale = MIN(widthRatio, heightRatio);
    float imageWidth = scale * attachmentImageNew.image.size.width;
    float imageHeight = scale * attachmentImageNew.image.size.height;
    
    NSLog(@"Size of pic is %f",imageWidth);
    NSLog(@"Size of pic is %f",imageHeight);
    if (imageWidth>=254)
    {
        imageUserWidth=[NSString stringWithFormat:@"%f",254.0];
    }
    else
    {
        imageUserWidth=[NSString stringWithFormat:@"%f",imageWidth];
    }
    
    imageUserheight=[NSString stringWithFormat:@"%f",imageHeight];
    
    UIImage *image =  [self scaleImage:chosenImage  toSize:CGSizeMake([imageUserWidth floatValue]*2,[imageUserheight floatValue]*2)];
    
    
    imageData = UIImageJPEGRepresentation(image,1.0);
    
    // ImageNSdata = [imageData base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    
    ImageNSdata = [Base64 encode:imageData];
    
    
    encodedImage = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(NULL,(CFStringRef)ImageNSdata,NULL,(CFStringRef)@"!*'\"();:@&=+$,/?%#[]% ",CFStringConvertNSStringEncodingToEncoding(NSUTF8StringEncoding)));
    
    if ([[defaults valueForKey:@"letsChat"] isEqualToString:@"yes"] || [[defaults valueForKey:@"letsChatAd"] isEqualToString:@"yes"])
    {
        [picker dismissViewControllerAnimated:YES completion:NULL];
    }
    else
    {
        [[self navigationController] dismissViewControllerAnimated:YES completion:nil];
    }
    
    [self sendComment];
    }
}



-(void)Communication_RecordVid
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
        
        NSString *userid= @"userid";
        NSString *useridVal =[defaults valueForKey:@"userid"];
        
   
        
        NSString *challengeid= @"challengeid";
        NSString * chslengeidval=[[AllArrayData objectAtIndex:0]valueForKey:@"challengeid"];
        
        NSString *mediatype= @"mediatype";
        
        
        
        NSString *media= @"media";
        
        NSString *mediaimagethumb=@"mediathumbnail";
        
        
        NSString *reqStringFUll=[NSString stringWithFormat:@"%@=%@&%@=%@&%@=%@&%@=%@&%@=%@",userid,useridVal,challengeid,chslengeidval,mediatype,mediatypeVal,media,encodedImage,mediaimagethumb,encodedImageThumb];
        
        
        
#pragma mark - swipe sesion
        
        NSURLSession *session = [NSURLSession sessionWithConfiguration: [NSURLSessionConfiguration defaultSessionConfiguration] delegate:self delegateQueue: [NSOperationQueue mainQueue]];
        
        NSURL *url;
        NSString *  urlStrLivecount=[urlplist valueForKey:@"recordvideo"];;
        url =[NSURL URLWithString:urlStrLivecount];
        
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
        
        [request setHTTPMethod:@"POST"];//Web API Method
        
        [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
        
        request.HTTPBody = [reqStringFUll dataUsingEncoding:NSUTF8StringEncoding];
        
        
        
     dataTaskupload =[session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error)
                                         {
                                             if(data)
                                             {
                                                 NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
                                                 NSInteger statusCode = httpResponse.statusCode;
                                                 if(statusCode == 200)
                                                 {
                                                     
        Array_RecodVid=[[NSMutableArray alloc]init];
        SBJsonParser *objSBJsonParser = [[SBJsonParser alloc]init];
        Array_RecodVid=[objSBJsonParser objectWithData:data];
                NSString * ResultString=[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
                                                     //        Array_LodingPro=[NSJSONSerialization JSONObjectWithData:webData_Swipe options:kNilOptions error:nil];
                                                     
                                                     ResultString = [ResultString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
                                                     ResultString = [ResultString stringByReplacingOccurrencesOfString:@"\t" withString:@""];
                                                     
                                                     NSLog(@"Array_RecodVid %@",Array_RecodVid);
                                                     
                               
                                                     NSLog(@"array_CreateChallenges ResultString %@",ResultString);
        if ([ResultString isEqualToString:@"recorded"])
                    {
                        [self Communication_showrecordVid];
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Success" message:@"Congratulations on recording your challenge. Your video has been successfully uploaded!" preferredStyle:UIAlertControllerStyleAlert];
                                                         
    UIAlertAction *actionOk = [UIAlertAction actionWithTitle:@"Ok"
    style:UIAlertActionStyleDefault
    handler:nil];
    [alertController addAction:actionOk];
            [self presentViewController:alertController animated:YES completion:nil];
                                       transperentViewIndicator.hidden=YES;
                                                         
                                                     }
                if ([ResultString isEqualToString:@"nouserid"] )
                {
                                                         
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Oops" message:@"Your account seems to be missing or has been deactivated. Please contact admin." preferredStyle:UIAlertControllerStyleAlert];
                                                         
        UIAlertAction *actionOk = [UIAlertAction actionWithTitle:@"Ok"
        style:UIAlertActionStyleDefault handler:nil];
    [alertController addAction:actionOk];
        [self presentViewController:alertController animated:YES completion:nil];
                    transperentViewIndicator.hidden=YES;
                                                         
                    }
                if ([ResultString isEqualToString:@"nomedia"])
                {
                                                         
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Oops" message:@"Your video file seems to be missing. Please record and upload again." preferredStyle:UIAlertControllerStyleAlert];
                                                         
        UIAlertAction *actionOk = [UIAlertAction actionWithTitle:@"Ok"
            style:UIAlertActionStyleDefault handler:nil];
        [alertController addAction:actionOk];
            [self presentViewController:alertController animated:YES completion:nil];
            transperentViewIndicator.hidden=YES;
                                                         
                    }
                                                     
                if ([ResultString isEqualToString:@"imageerror"])
                                                    {
                                                         
                            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Oops" message:@"There was an error in uploading your video. Please try again." preferredStyle:UIAlertControllerStyleAlert];
                                                         
                            UIAlertAction *actionOk = [UIAlertAction actionWithTitle:@"Ok"
                            style:UIAlertActionStyleDefault handler:nil];
    [alertController addAction:actionOk];
                        [self presentViewController:alertController animated:YES completion:nil];
                            transperentViewIndicator.hidden=YES;
                                                         
                                                     }
                                                     
                    if ([ResultString isEqualToString:@"updateerror"])
                                {
                                                         
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Oops" message:@"There was an error in updating our records. Please try again." preferredStyle:UIAlertControllerStyleAlert];
                                                         
    UIAlertAction *actionOk = [UIAlertAction actionWithTitle:@"Ok"
        style:UIAlertActionStyleDefault handler:nil];
        [alertController addAction:actionOk];
            [self presentViewController:alertController animated:YES completion:nil];
            transperentViewIndicator.hidden=YES;
                                                         
                        }
                if ([ResultString isEqualToString:@"nullerror"])
                        {
                                                         
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Oops" message:@"Your account id or challenge id seems to be missing. Please try again." preferredStyle:UIAlertControllerStyleAlert];
                                                         
            UIAlertAction *actionOk = [UIAlertAction actionWithTitle:@"Ok"
                style:UIAlertActionStyleDefault handler:nil];
                    [alertController addAction:actionOk];
            [self presentViewController:alertController animated:YES completion:nil];
                    transperentViewIndicator.hidden=YES;
                                                         
                                                     }
                                                     
                                                     
                    if ([ResultString isEqualToString:@"challengeover"])
                            {
                            transperentViewIndicator.hidden=YES;
 UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Oops" message:@"The challenge you wish to record to is now over! Thank-you." preferredStyle:UIAlertControllerStyleAlert];
                                                         
UIAlertAction *actionOk = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action)
            {
            [self.navigationController popToRootViewControllerAnimated:YES];
                
            }];
                                                         
    [alertController addAction:actionOk];
    [self presentViewController:alertController animated:YES completion:nil];
                                                         
                                                     }
                                         
                                                     
                    }
                                                 
                                                 else
                                                 {
                                                     NSLog(@" error login1 ---%ld",(long)statusCode);
                                                  transperentViewIndicator.hidden=YES;
                                                 }
                                                 
                                                 
                                             }
                                             else if(error)
                                             {
                                                 
        NSLog(@"error login2.......%@",error.description);
                                                 
                    NSLog(@"error login2.......%@",error.localizedDescription);
                                                
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Error" message:@"server connection time out" preferredStyle:UIAlertControllerStyleAlert];
                                                 
            UIAlertAction *actionOk = [UIAlertAction actionWithTitle:@"Ok"
             style:UIAlertActionStyleDefault handler:nil];
            [alertController addAction:actionOk];
            [self presentViewController:alertController animated:YES completion:nil];
      
         transperentViewIndicator.hidden=YES;

         
                                                 
                    }
                                             
                                             
            }];
        [dataTaskupload resume];
    }
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    chattype=@"";
    transperentViewIndicator.hidden=YES;
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}

-(IBAction)ButtonTotalPoints_Action:(id)sender
{
    
    
RaisedContributeViewController * set=[self.storyboard instantiateViewControllerWithIdentifier:@"RaisedContributeViewController"];
    set.Str_Channel_Id=[NSString stringWithFormat:@"%@",[[AllArrayData objectAtIndex:0]valueForKey:@"challengeid"]];
    
    set.Str_Raised_Amount=[NSString stringWithFormat:@"%@",[[AllArrayData objectAtIndex:0]valueForKey:@"backamount"]];
    
    set.Str_Raised_StartDateTime=[NSString stringWithFormat:@"%@",[[AllArrayData objectAtIndex:0]valueForKey:@"createdate"]];
    
    set.Str_ChallengecompleteType=[NSString stringWithFormat:@"%@",[[AllArrayData objectAtIndex:0]valueForKey:@"challenge_status"]];
    
    set.Str_DonateRaisedType=[NSString stringWithFormat:@"%@",[[AllArrayData objectAtIndex:0]valueForKey:@"contributiontype"]];
    [self.navigationController pushViewController:set animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==0)
    {
           return 1;
    }
    if (section==1)
    {
        return 1;
    }
    
    if ( section==2)
    {
            
//    if (Array_showrecordvid.count==0)
//    {
//                return 0;
//    }
//        else
//        {
          return 1;
     //   }

    }
    if (section==3)
    {
        if ([Str_Tapped_Comments_Vedio isEqualToString:@"Vedio"])
        {
            return Array_showrecordvid.count;
        }
        if ([Str_Tapped_Comments_Vedio isEqualToString:@"Comment"])
        {
        return Array_Comment1.count;
        }
    }
    
    return 0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellone=@"CellOne";
    static NSString *celltwo=@"CellTwo";
    static NSString *cellthree=@"CellComent";
      static NSString *cellIdR1=@"CellRV";
    
    switch (indexPath.section)
    {
            
        case 0:
        {
            OneImageVedioTableViewCell * cell_OneImageVid = (OneImageVedioTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellone forIndexPath:indexPath];
            
            
            
            
//            if ([CheckFavInserted isEqualToString:@"TRUE"])
//            {
//                [cell_OneImageVid.Image_Favourite setImage:[UIImage imageNamed:@"challenge_favourite1.png"]];
//            }
//            else
//            {
//               [cell_OneImageVid.Image_Favourite setImage:[UIImage imageNamed:@"challenge_favourite.png"]];
//            }
           
       
      
            UITapGestureRecognizer *FavouriteTapped =[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(ThreeDotsTapped_Action:)];
            [cell_OneImageVid.Image_Favourite addGestureRecognizer:FavouriteTapped];

           
     
            if ([[[AllArrayData objectAtIndex:0]valueForKey:@"mediatype"] isEqualToString:@"IMAGE"])
            {
                [self displayImage:cell_OneImageVid.Image_Backround withImage:cell_OneImageVid.Image_Backround.image];
                cell_OneImageVid.image_playButton.hidden=YES;
                NSURL *url=[NSURL URLWithString:[[AllArrayData objectAtIndex:0]valueForKey:@"mediaurl"]];
               
              
                
                
                NSURLRequest *imageRequest = [NSURLRequest requestWithURL:url];
                [cell_OneImageVid.activityIndicator setHidden:NO];
                [cell_OneImageVid.activityIndicator startAnimating];
                
                [cell_OneImageVid.Image_Backround setImageWithURLRequest:imageRequest
                                                        placeholderImage:[UIImage imageNamed:@"DefaultImg.jpg"]
                                                                 success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image)
                 {
                     [cell_OneImageVid.activityIndicator setHidden:YES];
                     [cell_OneImageVid.activityIndicator stopAnimating];
                     
                     cell_OneImageVid.Image_Backround.image = image;
                 }
                                                                 failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error)
                 {
                     [cell_OneImageVid.activityIndicator setHidden:YES];
                     [cell_OneImageVid.activityIndicator stopAnimating];
                 }];

                //[cell_OneImageVid.Image_Backround setImageWithURL:url placeholderImage:[UIImage imageNamed:@"DefaultImg.jpg"]];
            }
            else
            {
                NSURL *url=[NSURL URLWithString:[[AllArrayData objectAtIndex:0]valueForKey:@"mediathumbnailurl"]];
                
                
                NSURLRequest *imageRequest = [NSURLRequest requestWithURL:url];
                [cell_OneImageVid.activityIndicator setHidden:NO];
                [cell_OneImageVid.activityIndicator startAnimating];
                
                [cell_OneImageVid.Image_Backround setImageWithURLRequest:imageRequest
                                                   placeholderImage:[UIImage imageNamed:@"DefaultImg.jpg"]
                                                            success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image)
                 {
                     [cell_OneImageVid.activityIndicator setHidden:YES];
                     [cell_OneImageVid.activityIndicator stopAnimating];
                     
                     cell_OneImageVid.Image_Backround.image = image;
                 }
                                                            failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error)
                 {
                     [cell_OneImageVid.activityIndicator setHidden:YES];
                     [cell_OneImageVid.activityIndicator stopAnimating];
                 }];
                
                
                
                
//                [cell_OneImageVid.Image_Backround setImageWithURL:url placeholderImage:[UIImage imageNamed:@"DefaultImg.jpg"]];
             cell_OneImageVid.image_playButton.hidden=NO;
                cell_OneImageVid.image_playButton.userInteractionEnabled=YES;
    UITapGestureRecognizer * ImageTap_playButton =[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(ImageTap_playButtonAction:)];
                [cell_OneImageVid.image_playButton addGestureRecognizer:ImageTap_playButton];
            }
            
            
            
            
            
//            cell_OneImageVid.Image_Backround.image=ProfileImgeData;
            
         
            return cell_OneImageVid;
            
            
        }
            break;
        case 1:
            
        {
    cell_TwoDetails = (TwoDetailsTableViewCell*)[tableView dequeueReusableCellWithIdentifier:celltwo forIndexPath:indexPath];
            
            
            
            if (indexPath.row==0)
            {
                cell_TwoDetails.Label_CommentDesc.hidden=YES;
                cell_TwoDetails.label_CommentHeader.hidden=YES;
                cell_TwoDetails.image_ProfileComment.hidden=YES;
                
                cell_TwoDetails.Label_Dayleft.hidden=NO;
                cell_TwoDetails.label_Desc.hidden=NO;
                cell_TwoDetails.label_Mores.hidden=NO;
                cell_TwoDetails.image_SecProfile.hidden=NO;
                cell_TwoDetails.image_FristProfile.hidden=NO;
                cell_TwoDetails.ProgressBar_Total.hidden=NO;
                cell_TwoDetails.label_Moretxt.hidden=NO;
                cell_TwoDetails.label_ChallengesTxt.hidden=NO;
                
                
                NSURL *urlFirst=[NSURL URLWithString:[[AllArrayData objectAtIndex:0] valueForKey:@"usersprofilepic"]];
                
                NSURL *urlSec=[NSURL URLWithString:[[AllArrayData objectAtIndex:0] valueForKey:@"challengersprofilepic"]];
                cell_TwoDetails.image_FristProfile.tag=indexPath.row;
                cell_TwoDetails.image_FristProfile.userInteractionEnabled=YES;
            UITapGestureRecognizer *image_FristProfileTapped =[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(image_FirstProfile_ActionDetails:)];
                [cell_TwoDetails.image_FristProfile addGestureRecognizer:image_FristProfileTapped];
                
                
                cell_TwoDetails.label_Moretxt.userInteractionEnabled=YES;
                cell_TwoDetails.label_Mores.userInteractionEnabled=YES;

                
                UITapGestureRecognizer *label_Morestap =[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(ButtonTotalPoints_Action:)];
                [cell_TwoDetails.label_Mores addGestureRecognizer:label_Morestap];
                
                UITapGestureRecognizer *label_Moretxttap =[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(ButtonTotalPoints_Action:)];
                [cell_TwoDetails.label_Moretxt addGestureRecognizer:label_Moretxttap];
                
                
                  cell_TwoDetails.image_SecProfile.userInteractionEnabled=YES;
                cell_TwoDetails.image_SecProfile1.userInteractionEnabled=YES;
                cell_TwoDetails.image_SecProfile2.userInteractionEnabled=YES;
                
                
                cell_TwoDetails.image_SecProfile1.tag=indexPath.row;
                cell_TwoDetails.image_SecProfile2.tag=indexPath.row;
        
                NSInteger countchallengersDetails11=[[[AllArrayData objectAtIndex:0]valueForKey:@"challengerdetails1"]integerValue];
                
                if ([[[AllArrayData objectAtIndex:0]valueForKey:@"challengetype"] isEqualToString:@"PUBLIC"])
                {
                    [cell_TwoDetails.Image_Private_Public setImage:[UIImage imageNamed:@"worldicon_challenge.png"]];
                }
                else
                {
                    [cell_TwoDetails.Image_Private_Public setImage:[UIImage imageNamed:@"privateicon_challenge.png"]];
                }
                
                cell_TwoDetails.ProgressBar_Total.tag =indexPath.row;
//                if ([str_falgUiprogressView isEqualToString:@"yes"])
//                {
//                  
                
    if ([[NSString stringWithFormat:@"%@",[[AllArrayData objectAtIndex:0]valueForKey:@"challengerdetails1"]]isEqualToString:@""] || [[NSString stringWithFormat:@"%@",[[AllArrayData objectAtIndex:0]valueForKey:@"challengerdetails1"]]isEqualToString:@""])
                {
                    
    [cell_TwoDetails.ProgressBar_Total_View setFrame:CGRectMake((self.view.frame.size.width/2)-(cell_TwoDetails.ProgressBar_Total_View.frame.size.width/2), cell_TwoDetails.ProgressBar_Total_View.frame.origin.y, cell_TwoDetails.ProgressBar_Total_View.frame.size.width, cell_TwoDetails.ProgressBar_Total_View.frame.size.height)];
         
                   
                    
       [cell_TwoDetails.Image_Private_Public setFrame:CGRectMake(cell_TwoDetails.ProgressBar_Total_View.frame.origin.x, cell_TwoDetails.Image_Private_Public.frame.origin.y, cell_TwoDetails.Image_Private_Public.frame.size.width, cell_TwoDetails.Image_Private_Public.frame.size.height)];
                    
   
                    
                    
    [cell_TwoDetails.label_ChallengesTxt setFrame:CGRectMake(cell_TwoDetails.Image_Private_Public.frame.origin.x+cell_TwoDetails.Image_Private_Public.frame.size.width, cell_TwoDetails.label_ChallengesTxt.frame.origin.y, cell_TwoDetails.label_ChallengesTxt.frame.size.width, cell_TwoDetails.label_ChallengesTxt.frame.size.height)];
                    
    [cell_TwoDetails.Label_Dayleft setFrame:CGRectMake(cell_TwoDetails.ProgressBar_Total_View.frame.origin.x, cell_TwoDetails.Label_Dayleft.frame.origin.y, cell_TwoDetails.Label_Dayleft.frame.size.width, cell_TwoDetails.Label_Dayleft.frame.size.height)];
                    
    [cell_TwoDetails.image_FristProfile setFrame:CGRectMake((cell_TwoDetails.ProgressBar_Total_View.frame.origin.x-cell_TwoDetails.image_FristProfile.frame.size.width-10), cell_TwoDetails.image_FristProfile.frame.origin.y, cell_TwoDetails.image_FristProfile.frame.size.height, cell_TwoDetails.image_FristProfile.frame.size.height)];
                    
    [cell_TwoDetails.image_SecProfile setFrame:CGRectMake((cell_TwoDetails.ProgressBar_Total_View.frame.origin.x+cell_TwoDetails.ProgressBar_Total_View.frame.size.width+10), cell_TwoDetails.image_SecProfile.frame.origin.y, cell_TwoDetails.image_SecProfile.frame.size.height, cell_TwoDetails.image_SecProfile.frame.size.height)];
                    
    [cell_TwoDetails.label_Mores setFrame:CGRectMake(self.view.frame.size.width-cell_TwoDetails.label_Mores.frame.size.width, cell_TwoDetails.label_Mores.frame.origin.y, cell_TwoDetails.label_Mores.frame.size.width, cell_TwoDetails.label_Mores.frame.size.height)];
                    
    [cell_TwoDetails.label_Moretxt setFrame:CGRectMake(self.view.frame.size.width-cell_TwoDetails.label_Moretxt.frame.size.width, cell_TwoDetails.label_Moretxt.frame.origin.y, cell_TwoDetails.label_Moretxt.frame.size.width, cell_TwoDetails.label_Moretxt.frame.size.height)];

                    cell_TwoDetails.image_SecProfile1.hidden=YES;
                    cell_TwoDetails.image_SecProfile2.hidden=YES;
                    cell_TwoDetails.label_Mores.hidden=YES;
                    cell_TwoDetails.label_Moretxt.hidden=YES;
        }
    else if (countchallengersDetails11==1)
        {
            
        
        [cell_TwoDetails.ProgressBar_Total_View setFrame:CGRectMake((self.view.frame.size.width/2)-(cell_TwoDetails.ProgressBar_Total_View.frame.size.width-25), cell_TwoDetails.ProgressBar_Total_View.frame.origin.y, cell_TwoDetails.ProgressBar_Total_View.frame.size.width, cell_TwoDetails.ProgressBar_Total_View.frame.size.height)];
            
            
               [cell_TwoDetails.Image_Private_Public setFrame:CGRectMake(cell_TwoDetails.ProgressBar_Total_View.frame.origin.x, cell_TwoDetails.Image_Private_Public.frame.origin.y, cell_TwoDetails.Image_Private_Public.frame.size.width, cell_TwoDetails.Image_Private_Public.frame.size.height)];
            
            
            
        [cell_TwoDetails.label_ChallengesTxt setFrame:CGRectMake(cell_TwoDetails.Image_Private_Public.frame.origin.x+cell_TwoDetails.Image_Private_Public.frame.size.width, cell_TwoDetails.label_ChallengesTxt.frame.origin.y, cell_TwoDetails.label_ChallengesTxt.frame.size.width, cell_TwoDetails.label_ChallengesTxt.frame.size.height)];
                    
        [cell_TwoDetails.Label_Dayleft setFrame:CGRectMake(cell_TwoDetails.ProgressBar_Total_View.frame.origin.x, cell_TwoDetails.Label_Dayleft.frame.origin.y, cell_TwoDetails.Label_Dayleft.frame.size.width, cell_TwoDetails.Label_Dayleft.frame.size.height)];
                    
        [cell_TwoDetails.image_FristProfile setFrame:CGRectMake((cell_TwoDetails.ProgressBar_Total_View.frame.origin.x-cell_TwoDetails.image_FristProfile.frame.size.width-10), cell_TwoDetails.image_FristProfile.frame.origin.y, cell_TwoDetails.image_FristProfile.frame.size.height, cell_TwoDetails.image_FristProfile.frame.size.height)];
                    
        [cell_TwoDetails.image_SecProfile setFrame:CGRectMake((cell_TwoDetails.ProgressBar_Total_View.frame.origin.x+cell_TwoDetails.ProgressBar_Total_View.frame.size.width+10), cell_TwoDetails.image_SecProfile.frame.origin.y, cell_TwoDetails.image_SecProfile.frame.size.height, cell_TwoDetails.image_SecProfile.frame.size.height)];
                    
        [cell_TwoDetails.image_SecProfile1 setFrame:CGRectMake((cell_TwoDetails.image_SecProfile.frame.origin.x+cell_TwoDetails.image_SecProfile.frame.size.width/2)+10, cell_TwoDetails.image_SecProfile1.frame.origin.y, cell_TwoDetails.image_SecProfile1.frame.size.height, cell_TwoDetails.image_SecProfile1.frame.size.height)];
                    
        [cell_TwoDetails.label_Mores setFrame:CGRectMake(self.view.frame.size.width-cell_TwoDetails.label_Mores.frame.size.width, cell_TwoDetails.label_Mores.frame.origin.y, cell_TwoDetails.label_Mores.frame.size.width, cell_TwoDetails.label_Mores.frame.size.height)];
                    
        [cell_TwoDetails.label_Moretxt setFrame:CGRectMake(self.view.frame.size.width-cell_TwoDetails.label_Moretxt.frame.size.width, cell_TwoDetails.label_Moretxt.frame.origin.y, cell_TwoDetails.label_Moretxt.frame.size.width, cell_TwoDetails.label_Moretxt.frame.size.height)];
                    
        NSURL *urlSec1=[NSURL URLWithString:[[AllArrayData objectAtIndex:0] valueForKey:@"challengersprofilepic2"]];

                    
        [cell_TwoDetails.image_SecProfile1 setImageWithURL:urlSec1 placeholderImage:[UIImage imageNamed:@"DefaultImg.jpg"] ];
                    
        UITapGestureRecognizer *image_SecProfileTapped1 =[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(image_SecProfile_ActionDetails1:)];
            
        [cell_TwoDetails.image_SecProfile1 addGestureRecognizer:image_SecProfileTapped1];
                    cell_TwoDetails.image_SecProfile1.hidden=NO;
                    cell_TwoDetails.image_SecProfile2.hidden=YES;
            
            cell_TwoDetails.label_Mores.hidden=YES;
            cell_TwoDetails.label_Moretxt.hidden=YES;
                }
                if (countchallengersDetails11>=2)
                {
                    
        
                    
        UITapGestureRecognizer *image_SecProfileTapped1 =[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(image_SecProfile_ActionDetails1:)];
                    
        [cell_TwoDetails.image_SecProfile1 addGestureRecognizer:image_SecProfileTapped1];
                    
        UITapGestureRecognizer *image_SecProfileTapped2 =[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(image_SecProfile_ActionDetails2:)];
        [cell_TwoDetails.image_SecProfile2 addGestureRecognizer:image_SecProfileTapped2];
                    
                    
        NSURL *urlSec1=[NSURL URLWithString:[[AllArrayData objectAtIndex:0] valueForKey:@"challengersprofilepic2"]];
        [cell_TwoDetails.image_SecProfile1 setImageWithURL:urlSec1 placeholderImage:[UIImage imageNamed:@"DefaultImg.jpg"] ];
                    
        NSURL *urlSec2=[NSURL URLWithString:[[AllArrayData objectAtIndex:0] valueForKey:@"challengersprofilepic3"]];
                    
        [cell_TwoDetails.image_SecProfile2 setImageWithURL:urlSec2 placeholderImage:[UIImage imageNamed:@"DefaultImg.jpg"] ];
                    
                    
        cell_TwoDetails.image_SecProfile1.hidden=NO;
        cell_TwoDetails.image_SecProfile2.hidden=NO;
                    
                    
                    if (countchallengersDetails11>=3)
                    {
                        cell_TwoDetails.label_Mores.hidden=NO;
                        cell_TwoDetails.label_Moretxt.hidden=NO;
                        NSInteger totalchallengess=[[[AllArrayData objectAtIndex:0]valueForKey:@"challengerdetails1"]integerValue]-2;
                        cell_TwoDetails.label_Mores.text=[NSString stringWithFormat:@"%@%ld",@"+",(long)totalchallengess];
                        CGFloat Ximagepostion,HegihtImagepostion,XpostionDistance;
                        if (self.view.frame.size.width==320)
                        {
                            Ximagepostion=4;
                            HegihtImagepostion=45;
                            XpostionDistance=7;
                            
                            
                        }
                        else
                        {
                            if (self.view.frame.size.width==375)
                            {
                                Ximagepostion=20;
                                HegihtImagepostion=cell_TwoDetails.image_FristProfile.frame.size.height;
                                XpostionDistance=10;
                            }
                            else
                            {
                                Ximagepostion=40;
                                HegihtImagepostion=cell_TwoDetails.image_FristProfile.frame.size.height;
                                XpostionDistance=15;
                            }
                            
                           
                        }
                        [cell_TwoDetails.image_FristProfile setFrame:CGRectMake(Ximagepostion, cell_TwoDetails.image_FristProfile.frame.origin.y, HegihtImagepostion,HegihtImagepostion)];
                        
                        [cell_TwoDetails.ProgressBar_Total_View setFrame:CGRectMake((cell_TwoDetails.image_FristProfile.frame.origin.x)+(cell_TwoDetails.image_FristProfile.frame.size.width+XpostionDistance), cell_TwoDetails.ProgressBar_Total_View.frame.origin.y, cell_TwoDetails.ProgressBar_Total_View.frame.size.width, cell_TwoDetails.ProgressBar_Total_View.frame.size.height)];
                        
                           [cell_TwoDetails.Image_Private_Public setFrame:CGRectMake(cell_TwoDetails.ProgressBar_Total_View.frame.origin.x, cell_TwoDetails.Image_Private_Public.frame.origin.y, cell_TwoDetails.Image_Private_Public.frame.size.width, cell_TwoDetails.Image_Private_Public.frame.size.height)];
                        
                        
                        [cell_TwoDetails.label_ChallengesTxt setFrame:CGRectMake(cell_TwoDetails.Image_Private_Public.frame.origin.x+cell_TwoDetails.Image_Private_Public.frame.size.width, cell_TwoDetails.label_ChallengesTxt.frame.origin.y, cell_TwoDetails.label_ChallengesTxt.frame.size.width, cell_TwoDetails.label_ChallengesTxt.frame.size.height)];
                        
                        [cell_TwoDetails.Label_Dayleft setFrame:CGRectMake(cell_TwoDetails.ProgressBar_Total_View.frame.origin.x, cell_TwoDetails.Label_Dayleft.frame.origin.y, cell_TwoDetails.Label_Dayleft.frame.size.width, cell_TwoDetails.Label_Dayleft.frame.size.height)];
                        
                        
                        
                        [cell_TwoDetails.image_SecProfile setFrame:CGRectMake((cell_TwoDetails.ProgressBar_Total_View.frame.origin.x+cell_TwoDetails.ProgressBar_Total_View.frame.size.width+10), cell_TwoDetails.image_SecProfile.frame.origin.y, HegihtImagepostion, HegihtImagepostion)];
                        
                        [cell_TwoDetails.image_SecProfile1 setFrame:CGRectMake((cell_TwoDetails.image_SecProfile.frame.origin.x+cell_TwoDetails.image_SecProfile.frame.size.width/2)+XpostionDistance, cell_TwoDetails.image_SecProfile1.frame.origin.y, HegihtImagepostion, HegihtImagepostion)];
                        
                        [cell_TwoDetails.image_SecProfile2 setFrame:CGRectMake((cell_TwoDetails.image_SecProfile1.frame.origin.x+cell_TwoDetails.image_SecProfile1.frame.size.width/2)+XpostionDistance, cell_TwoDetails.image_SecProfile2.frame.origin.y, HegihtImagepostion, HegihtImagepostion)];
                        
                        [cell_TwoDetails.label_Mores setFrame:CGRectMake(self.view.frame.size.width-cell_TwoDetails.label_Mores.frame.size.width, cell_TwoDetails.label_Mores.frame.origin.y, cell_TwoDetails.label_Mores.frame.size.width, cell_TwoDetails.label_Mores.frame.size.height)];
                        
                        [cell_TwoDetails.label_Moretxt setFrame:CGRectMake(self.view.frame.size.width-cell_TwoDetails.label_Moretxt.frame.size.width, cell_TwoDetails.label_Moretxt.frame.origin.y, cell_TwoDetails.label_Moretxt.frame.size.width, cell_TwoDetails.label_Moretxt.frame.size.height)];
                        
                     // jghjhjjjhj

                    }
                    else
                    {
                        CGFloat Ximagepostion;
                        if (self.view.frame.size.width==320)
                        {
                             Ximagepostion=12;
                        }
                        else
                        {
                            Ximagepostion=38;
                        }
                        
                        [cell_TwoDetails.image_FristProfile setFrame:CGRectMake(Ximagepostion, cell_TwoDetails.image_FristProfile.frame.origin.y, cell_TwoDetails.image_FristProfile.frame.size.height, cell_TwoDetails.image_FristProfile.frame.size.height)];
                        
                        [cell_TwoDetails.ProgressBar_Total_View setFrame:CGRectMake((cell_TwoDetails.image_FristProfile.frame.origin.x)+(cell_TwoDetails.image_FristProfile.frame.size.width+10), cell_TwoDetails.ProgressBar_Total_View.frame.origin.y, cell_TwoDetails.ProgressBar_Total_View.frame.size.width, cell_TwoDetails.ProgressBar_Total_View.frame.size.height)];
                        
                           [cell_TwoDetails.Image_Private_Public setFrame:CGRectMake(cell_TwoDetails.ProgressBar_Total_View.frame.origin.x, cell_TwoDetails.Image_Private_Public.frame.origin.y, cell_TwoDetails.Image_Private_Public.frame.size.width, cell_TwoDetails.Image_Private_Public.frame.size.height)];
                        
                        
                        [cell_TwoDetails.label_ChallengesTxt setFrame:CGRectMake(cell_TwoDetails.Image_Private_Public.frame.origin.x+cell_TwoDetails.Image_Private_Public.frame.size.width, cell_TwoDetails.label_ChallengesTxt.frame.origin.y, cell_TwoDetails.label_ChallengesTxt.frame.size.width, cell_TwoDetails.label_ChallengesTxt.frame.size.height)];
                        
                        [cell_TwoDetails.Label_Dayleft setFrame:CGRectMake(cell_TwoDetails.ProgressBar_Total_View.frame.origin.x, cell_TwoDetails.Label_Dayleft.frame.origin.y, cell_TwoDetails.Label_Dayleft.frame.size.width, cell_TwoDetails.Label_Dayleft.frame.size.height)];
                        
                        
                        
                        [cell_TwoDetails.image_SecProfile setFrame:CGRectMake((cell_TwoDetails.ProgressBar_Total_View.frame.origin.x+cell_TwoDetails.ProgressBar_Total_View.frame.size.width+10), cell_TwoDetails.image_SecProfile.frame.origin.y, cell_TwoDetails.image_SecProfile.frame.size.height, cell_TwoDetails.image_SecProfile.frame.size.height)];
                        
                        [cell_TwoDetails.image_SecProfile1 setFrame:CGRectMake((cell_TwoDetails.image_SecProfile.frame.origin.x+cell_TwoDetails.image_SecProfile.frame.size.width/2)+10, cell_TwoDetails.image_SecProfile1.frame.origin.y, cell_TwoDetails.image_SecProfile1.frame.size.height, cell_TwoDetails.image_SecProfile1.frame.size.height)];
                        
                        [cell_TwoDetails.image_SecProfile2 setFrame:CGRectMake((cell_TwoDetails.image_SecProfile1.frame.origin.x+cell_TwoDetails.image_SecProfile1.frame.size.width/2)+10, cell_TwoDetails.image_SecProfile2.frame.origin.y, cell_TwoDetails.image_SecProfile2.frame.size.height, cell_TwoDetails.image_SecProfile2.frame.size.height)];
                        
                        [cell_TwoDetails.label_Mores setFrame:CGRectMake(self.view.frame.size.width-cell_TwoDetails.label_Mores.frame.size.width, cell_TwoDetails.label_Mores.frame.origin.y, cell_TwoDetails.label_Mores.frame.size.width, cell_TwoDetails.label_Mores.frame.size.height)];
                        
                        [cell_TwoDetails.label_Moretxt setFrame:CGRectMake(self.view.frame.size.width-cell_TwoDetails.label_Moretxt.frame.size.width, cell_TwoDetails.label_Moretxt.frame.origin.y, cell_TwoDetails.label_Moretxt.frame.size.width, cell_TwoDetails.label_Moretxt.frame.size.height)];
                        cell_TwoDetails.label_Mores.hidden=YES;
                        cell_TwoDetails.label_Moretxt.hidden=YES;
                    }
                }

                    str_falgUiprogressView=@"no";
             
                
                
                UITapGestureRecognizer *image_SecProfileTapped =[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(image_SecProfile_ActionDetails:)];
                [cell_TwoDetails.image_SecProfile addGestureRecognizer:image_SecProfileTapped];
                
        
                [cell_TwoDetails.image_FristProfile setImageWithURL:urlFirst placeholderImage:[UIImage imageNamed:@"DefaultImg.jpg"] ];
                
                
                
                   [cell_TwoDetails.image_SecProfile setImageWithURL:urlSec placeholderImage:[UIImage imageNamed:@"DefaultImg.jpg"] ];
                
                

              
                 cell_TwoDetails.label_Desc.text=[[AllArrayData objectAtIndex:0]valueForKey:@"title"];
                
                if ([str_LabelCoordinates isEqualToString:@"no"])
                {
                    str_LabelCoordinates=@"yes";
                    
                    
                    TextView_ViewX=cell_TwoDetails.textview_View.frame.origin.x;
                    TextView_ViewY=cell_TwoDetails.textview_View.frame.origin.y;
                    TextView_ViewW=self.view.frame.size.width-((cell_TwoDetails.textview_View.frame.origin.x)*2);
                    TextView_ViewH=cell_TwoDetails.textview_View.frame.size.height;
                    
                    
                    Cell_DescLabelX=cell_TwoDetails.textview.frame.origin.x;
                    Cell_DescLabelY=cell_TwoDetails.textview.frame.origin.y;
                    Cell_DescLabelW=TextView_ViewW;
                    Cell_DescLabelH=cell_TwoDetails.textview.frame.size.height;
                    
                    
                     NSLog(@"Dynamic label heightc====%f",Cell_DescLabelX);
                       NSLog(@"Dynamic label heightc====%f",Cell_DescLabelY);
                       NSLog(@"Dynamic label heightc====%f",Cell_DescLabelW);
                       NSLog(@"Dynamic label heightc====%f",Cell_DescLabelH);
//                    [cell_TwoDetails.textview_View setFrame:CGRectMake(TextView_ViewX, TextView_ViewY, TextView_ViewW, TextView_ViewH)];
//                    
//                    [cell_TwoDetails.textview setFrame:CGRectMake(Cell_DescLabelX, Cell_DescLabelY, Cell_DescLabelW, TextView_ViewH)];
                }
                
                NSString *text =[[AllArrayData objectAtIndex:0]valueForKey:@"title"];;
                
                
                CGSize constraint = CGSizeMake(340 - (CELL_CONTENT_MARGIN * 2), 20000.0f);
                
                CGSize size = [text sizeWithFont:[UIFont fontWithName:@"SanFranciscoDisplay-Bold" size:24] constrainedToSize:constraint lineBreakMode:UILineBreakModeWordWrap];
                
                CGFloat height = MAX(size.height, 30.0f);
                NSLog(@"Dynamic label height====%f",height);
                
                
                float rows = (cell_TwoDetails.textview.contentSize.height - cell_TwoDetails.textview.textContainerInset.top - cell_TwoDetails.textview.textContainerInset.bottom) / cell_TwoDetails.textview.font.lineHeight;
                 NSLog(@"Dynamic label rowsline====%f",rows);
              //  cell_TwoDetails.label_Desc.numberOfLines=0;
    
                [cell_TwoDetails.textview setText:text];
                cell_TwoDetails.textview.tag=indexPath.row;
                cell_TwoDetails.textview_View.tag=indexPath.row;
                CGFloat fixedWidth = self.view.frame.size.width-((cell_TwoDetails.textview_View.frame.origin.x)*2);
                CGSize newSize = [cell_TwoDetails.textview sizeThatFits:CGSizeMake(fixedWidth, MAXFLOAT)];
            //  cell_TwoDetails.label_Desc.backgroundColor=[UIColor clearColor];
        NSInteger rHeight = size.height/24;
                NSLog(@"No of lines: %ld",(long)rHeight);
                cell_TwoDetails.textview_Dummey.hidden=YES;
                  if ([str_TappedLabel isEqualToString:@"no"])
                  {
                      if ((long)rHeight==1)
                      {
                        
                             [cell_TwoDetails.textview_View setFrame:CGRectMake(TextView_ViewX,TextView_ViewY, TextView_ViewW,TextView_ViewH)];
                          
                          [cell_TwoDetails.textview setFrame:CGRectMake(Cell_DescLabelX,Cell_DescLabelY, Cell_DescLabelW,Cell_DescLabelH)];
                          
                          
                      }
                        else if ((long)rHeight==2)
                      {
                         
                         [cell_TwoDetails.textview_View setFrame:CGRectMake(TextView_ViewX,TextView_ViewY, TextView_ViewW,TextView_ViewH*2)];
                          
                       [cell_TwoDetails.textview setFrame:CGRectMake(Cell_DescLabelX,Cell_DescLabelY, Cell_DescLabelW,Cell_DescLabelH*2)];
                      }
                        else if ((long)rHeight>=3)
                        {
                            cell_TwoDetails.textview_View.userInteractionEnabled=YES;
                    cell_TwoDetails.textview.textContainer.maximumNumberOfLines = 0;
      cell_TwoDetails.textview.textContainer.lineBreakMode = NSLineBreakByTruncatingTail;
                            UITapGestureRecognizer *label_Desc_Tapped =[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(label_Desc_Tapped_ActionDetails:)];
                            [cell_TwoDetails.textview_View addGestureRecognizer:label_Desc_Tapped];
                            
                            [cell_TwoDetails.textview_View setFrame:CGRectMake(TextView_ViewX,TextView_ViewY, TextView_ViewW,TextView_ViewH*2)];
                            
                            [cell_TwoDetails.textview setFrame:CGRectMake(Cell_DescLabelX,Cell_DescLabelY, Cell_DescLabelW,Cell_DescLabelH*2)];
                        }

                  }
                else
                {
                    
               
                    CGRect newFrame = cell_TwoDetails.textview.frame;
                    newFrame.size = CGSizeMake(fmaxf(newSize.width, fixedWidth), newSize.height);
                    
                    cell_TwoDetails.textview_View.userInteractionEnabled=YES;
                    
                    UITapGestureRecognizer *label_Desc_Tapped =[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(label_Desc_Tapped_ActionDetails:)];
                    [cell_TwoDetails.textview_View addGestureRecognizer:label_Desc_Tapped];
                  [cell_TwoDetails.textview_View setFrame:CGRectMake(TextView_ViewX,TextView_ViewY, newFrame.size.width,newFrame.size.height)];
                [cell_TwoDetails.textview setFrame:newFrame];
          
                    
                }
                
                NSLog(@"Dynamic label heightccc====%f",Cell_DescLabelX);
                NSLog(@"Dynamic label heightccc====%f",Cell_DescLabelY);
                NSLog(@"Dynamic label heightccc====%f",Cell_DescLabelW);
                NSLog(@"Dynamic label heightccc====%f",Cell_DescLabelH);
                
                
                 cell_TwoDetails.Label_Dayleft.text=[NSString stringWithFormat:@"%@",[[AllArrayData objectAtIndex:0]valueForKey:@"createtime1"]];
                
                NSString * tagreach=[[AllArrayData objectAtIndex:0]valueForKey:@"daysleft"];
                 NSString * Totaldays=[[AllArrayData objectAtIndex:0]valueForKey:@"totaldays"];
                
                CGFloat progrssVal=1-([tagreach floatValue])/[Totaldays floatValue];
                NSString *per= [ NSString stringWithFormat:@"%.3f",progrssVal];
                [cell_TwoDetails.ProgressBar_Total setProgress:[per floatValue]];

                

            }
            else if (indexPath.row==1)
            {
                cell_TwoDetails.Label_CommentDesc.hidden=YES;
                cell_TwoDetails.label_CommentHeader.hidden=NO;
               
                
                cell_TwoDetails.image_ProfileComment.hidden=YES;
                
                cell_TwoDetails.Label_Dayleft.hidden=YES;
                cell_TwoDetails.label_Desc.hidden=YES;
                cell_TwoDetails.label_Mores.hidden=YES;
                cell_TwoDetails.image_SecProfile.hidden=YES;
                cell_TwoDetails.image_SecProfile1.hidden=YES;
                cell_TwoDetails.image_SecProfile2.hidden=YES;
                cell_TwoDetails.image_FristProfile.hidden=YES;
                cell_TwoDetails.ProgressBar_Total.hidden=YES;
                cell_TwoDetails.label_Moretxt.hidden=YES;
                cell_TwoDetails.label_ChallengesTxt.hidden=YES;
                
                
                
         
                
                
            }
            else
                
            {
                cell_TwoDetails.Label_CommentDesc.hidden=NO;
                cell_TwoDetails.label_CommentHeader.hidden=YES;
                cell_TwoDetails.image_ProfileComment.hidden=NO;
                
                cell_TwoDetails.Label_Dayleft.hidden=YES;
                cell_TwoDetails.label_Desc.hidden=YES;
                cell_TwoDetails.label_Mores.hidden=YES;
                cell_TwoDetails.image_SecProfile.hidden=YES;
                cell_TwoDetails.image_SecProfile1.hidden=YES;
                cell_TwoDetails.image_SecProfile2.hidden=YES;
                cell_TwoDetails.image_FristProfile.hidden=YES;
                cell_TwoDetails.ProgressBar_Total.hidden=YES;
                cell_TwoDetails.label_Moretxt.hidden=YES;
                cell_TwoDetails.label_ChallengesTxt.hidden=YES;
                
               
                }
    
            
            cell_TwoDetails.image_FristProfile.clipsToBounds=YES;
            cell_TwoDetails.image_FristProfile.layer.cornerRadius=cell_TwoDetails.image_FristProfile.frame.size.height/2;
            
            cell_TwoDetails.image_SecProfile.clipsToBounds=YES;
            cell_TwoDetails.image_SecProfile.layer.cornerRadius=cell_TwoDetails.image_SecProfile.frame.size.height/2;
            
            cell_TwoDetails.image_SecProfile1.clipsToBounds=YES;
            cell_TwoDetails.image_SecProfile1.layer.cornerRadius=cell_TwoDetails.image_SecProfile1.frame.size.height/2;
            
            cell_TwoDetails.image_SecProfile2.clipsToBounds=YES;
            cell_TwoDetails.image_SecProfile2.layer.cornerRadius=cell_TwoDetails.image_SecProfile2.frame.size.height/2;
            
            
                return cell_TwoDetails;
            
            }
    
    
            break;
        case 2:
        {
            ListofVedioCommentsTableViewCell * Cell_List = (ListofVedioCommentsTableViewCell*)[tableView dequeueReusableCellWithIdentifier:@"CellList" forIndexPath:indexPath];
            
            if ([Str_Tapped_Comments_Vedio isEqualToString:@"Comment"])
            {
                [Cell_List.Image_comments setImage:[UIImage imageNamed:@"commentsblue.png"]];
                [Cell_List.label_Comments setTextColor:[UIColor colorWithRed:67/255.0 green:188/255.0 blue:255/255.0 alpha:1]];
                [Cell_List.Image_vedio setImage:[UIImage imageNamed:@"videosgrey.png"]];
                [Cell_List.label_Vedio setTextColor:[UIColor colorWithRed:186/255.0 green:188/255.0 blue:190/255.0 alpha:1]];
            }
            else
            {
                [Cell_List.Image_comments setImage:[UIImage imageNamed:@"commentsgrey.png"]];
                [Cell_List.label_Comments setTextColor:[UIColor colorWithRed:186/255.0 green:188/255.0 blue:190/255.0 alpha:1]];

                [Cell_List.Image_vedio setImage:[UIImage imageNamed:@"videosblue.png"]];
                [Cell_List.label_Vedio setTextColor:[UIColor colorWithRed:67/255.0 green:188/255.0 blue:255/255.0 alpha:1]];
            }
            
            

            
            
            
            
            UITapGestureRecognizer * Imagecom =[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(Image_tapcomment:)];
            [Cell_List.Image_comments addGestureRecognizer:Imagecom];
            
            UITapGestureRecognizer * Labelcom =[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(Image_tapcomment:)];
            [Cell_List.label_Comments addGestureRecognizer:Labelcom];
            
            
            UITapGestureRecognizer * imagevid =[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(Image_tapvedio:)];
            [Cell_List.Image_vedio addGestureRecognizer:imagevid];
            
            
            UITapGestureRecognizer * LabelVid =[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(Image_tapvedio:)];
            [Cell_List.label_Vedio addGestureRecognizer:LabelVid];

           
            return Cell_List;
        }
            break;
        case 3:
        {
            
            if ([Str_Tapped_Comments_Vedio isEqualToString:@"Comment"])
            {
            
            UILabel *label = nil;
          
            
            UIImageView * desc_Imagepro=nil;
            UIImageView * Chat_ImageRight=nil;
            UIImageView * Chat_UserImage=nil;
            

            
            CommentsTableViewCell * cell_ThreeComments = [Tableview_ContriBute dequeueReusableCellWithIdentifier:@"Cell"];
           
            
            if (cell_ThreeComments == nil)
            {
             
                
                cell_ThreeComments = [[CommentsTableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:cellthree] ;
                
              
                
                
                
                
                label = [[UILabel alloc] initWithFrame:CGRectZero];
                [label setLineBreakMode:UILineBreakModeWordWrap];
                //        [label setMinimumFontSize:FONT_SIZE];
                [label setNumberOfLines:0];
                [label setFont:[UIFont fontWithName:@"SanFranciscoDisplay-Medium" size:FONT_SIZE]];
                [label setTag:5];
                // [[label layer] setBorderWidth:2.0f];
                [label setBackgroundColor:[UIColor clearColor]];
                
                
                [[cell_ThreeComments contentView] addSubview:label];
                
                desc_Imagepro = [[UIImageView alloc] initWithFrame:CGRectZero];
                
                [desc_Imagepro setTag:4];
                
                [desc_Imagepro setBackgroundColor:[UIColor lightGrayColor]];
                
                [[cell_ThreeComments contentView] addSubview:desc_Imagepro];
                
                
                Chat_ImageRight = [[UIImageView alloc] initWithFrame:CGRectZero];
                
                [Chat_ImageRight setTag:4];
                
                [Chat_ImageRight setBackgroundColor:[UIColor lightGrayColor]];
                
                [[cell_ThreeComments contentView] addSubview:Chat_ImageRight];
                
                Chat_UserImage = [[UIImageView alloc] initWithFrame:CGRectZero];
                
                [Chat_UserImage setTag:5];
                
                [Chat_UserImage setBackgroundColor:[UIColor lightGrayColor]];
                
                [[cell_ThreeComments contentView] addSubview:Chat_UserImage];
                
                
                
            }
            
         
             cell_ThreeComments.selectionStyle=UITableViewCellSelectionStyleNone;
        
            
            if (!label)
                label = (UILabel*)[cell_ThreeComments viewWithTag:1];
            
          
            
            //                NSTextAlignmentLeft      = 0,
            //                NSTextAlignmentCenter    = 1,
            //                NSTextAlignmentRight     = 2,
            //                NSTextAlignmentJustified = 3,
            [label setBackgroundColor:[UIColor clearColor]];
            
            //    label.font=[UIFont fontWithName:@"Helvetica" size:16.0f];
            label.textColor=[UIColor blackColor];
            
            
            if ([[[Array_Comment1 objectAtIndex:indexPath.row]valueForKey:@"messagetype"] isEqualToString:@"TEXT"])
            {
                
                NSString *text =[[Array_Comment1 objectAtIndex:indexPath.row]valueForKey:@"message"];
                
                
                CGSize constraint = CGSizeMake(CELL_CONTENT_WIDTH - (CELL_CONTENT_MARGIN * 2), 20000.0f);
                
                CGSize size = [text sizeWithFont:[UIFont fontWithName:@"SanFranciscoDisplay-Medium" size:FONT_SIZE] constrainedToSize:constraint lineBreakMode:NSLineBreakByWordWrapping];
                
                int lines = size.height/16;
                
                NSLog(@"lines count : %i \n\n",lines);
                
                
                
                [label setFont:[UIFont fontWithName:@"SanFranciscoDisplay-Medium" size:FONT_SIZE]];;
                
                NSMutableParagraphStyle *style =  [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
                style.alignment = NSTextAlignmentLeft;
                style.firstLineHeadIndent = 10.0f;
                style.headIndent = 10.0f;
                style.tailIndent = -10.0f;
                
                NSAttributedString *attrText = [[NSAttributedString alloc] initWithString:text attributes:@{ NSParagraphStyleAttributeName : style}];
                
                label.numberOfLines = 0;
                label.attributedText = attrText;
                
                  // [label setText:text];
                 label.textAlignment=NSTextAlignmentLeft;

                label.clipsToBounds=YES;
                label.layer.cornerRadius=9.0f;
               
                
                if ([[defaults valueForKey:@"userid"] isEqualToString:[[Array_Comment1 objectAtIndex:indexPath.row]valueForKey:@"useridsender"]])
                {
                    NSURL * url=[NSURL URLWithString:[[Array_Comment1 objectAtIndex:indexPath.row]valueForKey:@"profileimage"]];
                    [desc_Imagepro setImageWithURL:url placeholderImage:[UIImage imageNamed:@"DefaultImg.jpg"]];
                    
                    
            
                    label.backgroundColor=[UIColor colorWithRed:241/255.0 green:241/255.0 blue:241/255.0 alpha:0.7];

                    label.textColor=[UIColor colorWithRed:65/255.0 green:65/255.0 blue:65/255.0 alpha:1];
                    if (size.width <=self.view.frame.size.width-132)
                    {
                        
                [label setFrame:CGRectMake(50,0, size.width+20, MAX(size.height, 30.0f)+8)];
                        
                        
                    }
                    
                    else
                    {

            [label setFrame:CGRectMake(50,0, self.view.frame.size.width-140,MAX(size.height, 30.0f)+8)];
                        
                        
                    }
                    
                    Chat_ImageRight.backgroundColor=[UIColor clearColor];
                    [Chat_ImageRight setFrame:CGRectMake(label.frame.origin.x-14,label.frame.size.height-27, 16,16)];
                    [Chat_ImageRight setImage:[UIImage imageNamed:@"Chat_arrow_left.png"]];
                    
                    //chat_arrow_right.png
                    [desc_Imagepro setFrame:CGRectMake(8,label.frame.origin.y+(label.frame.size.height-32),32,32)];
                    desc_Imagepro.clipsToBounds=YES;
                    desc_Imagepro.layer.cornerRadius=desc_Imagepro.frame.size.height/2;
                }
                else
                {
                    NSURL * url=[NSURL URLWithString:[[Array_Comment1 objectAtIndex:indexPath.row]valueForKey:@"profileimage"]];
                    [desc_Imagepro setImageWithURL:url placeholderImage:[UIImage imageNamed:@"DefaultImg.jpg"]];
                    

                    label.backgroundColor=[UIColor colorWithRed:67/255.0 green:188/255.0 blue:255/255.0 alpha:0.2];
                  
                    label.textColor=[UIColor colorWithRed:0 green:0 blue:0 alpha:0.9];
                
                    if (size.width <=self.view.frame.size.width-132)
                    {
                        
                        
                        [label setFrame:CGRectMake(self.view.frame.size.width-(size.width+70),0, size.width+20, MAX(size.height, 30.0f)+8)];

                    }
                    
                    else
                    {
                        
             [label setFrame:CGRectMake(self.view.frame.size.width-(size.width+70),0, self.view.frame.size.width-140, MAX(size.height, 30.0f)+8)];

                    }
                    Chat_ImageRight.backgroundColor=[UIColor clearColor];
                    [Chat_ImageRight setFrame:CGRectMake(label.frame.size.width+label.frame.origin.x-2,label.frame.size.height-27, 16,16)];
                    
                    
                    [Chat_ImageRight setImage:[UIImage imageNamed:@"Chat_arrow_right.png"]];
                    
                    [desc_Imagepro setFrame:CGRectMake(self.view.frame.size.width-40,label.frame.origin.y+(label.frame.size.height-32),32,32)];
                    desc_Imagepro.clipsToBounds=YES;
                    desc_Imagepro.layer.cornerRadius=desc_Imagepro.frame.size.height/2;
                }
                
                
                
                
            }
            
            else
            {
                
                
                CGFloat imgwidth=[[[Array_Comment1 objectAtIndex:indexPath.row]valueForKey:@"imagewidth"] floatValue];
                CGFloat imgheight=[[[Array_Comment1 objectAtIndex:indexPath.row]valueForKey:@"imageheight"] floatValue];
                
                //Chat_UserImage.backgroundColor=[UIColor clearColor];
                NSURL * url=[NSURL URLWithString:[[Array_Comment1 objectAtIndex:indexPath.row]valueForKey:@"imageurl"]];
                [Chat_UserImage setImageWithURL:url placeholderImage:[UIImage imageNamed:@"DefaultImg.jpg"]];
                Chat_UserImage.clipsToBounds=YES;
                Chat_UserImage.layer.cornerRadius=9.0f;
                Chat_UserImage.contentMode=UIViewContentModeScaleAspectFit;
                
                
                
                
                
                
                
                if ([[defaults valueForKey:@"userid"] isEqualToString:[[Array_Comment1 objectAtIndex:indexPath.row]valueForKey:@"useridsender"]])
                {
                    
                    NSURL * url=[NSURL URLWithString:[[Array_Comment1 objectAtIndex:indexPath.row]valueForKey:@"profileimage"]];
                    [desc_Imagepro setImageWithURL:url placeholderImage:[UIImage imageNamed:@"DefaultImg.jpg"]];
                    
                    [Chat_UserImage setFrame:CGRectMake(52,4,imgwidth,imgheight)];
                    Chat_UserImage.clipsToBounds=YES;
                    Chat_UserImage.layer.cornerRadius=9.0f;
                    Chat_UserImage.contentMode=UIViewContentModeScaleAspectFit;
                    [self displayImage:Chat_UserImage withImage:Chat_UserImage.image];
                    
                    [desc_Imagepro setFrame:CGRectMake(8,Chat_UserImage.frame.origin.y+(Chat_UserImage.frame.size.height-32),32,32)];
                    desc_Imagepro.clipsToBounds=YES;
                    desc_Imagepro.layer.cornerRadius=desc_Imagepro.frame.size.height/2;
                    
                }
                else
                {
                    
                    
                    NSURL * url=[NSURL URLWithString:[[Array_Comment1 objectAtIndex:indexPath.row]valueForKey:@"profileimage"]];
                    [desc_Imagepro setImageWithURL:url placeholderImage:[UIImage imageNamed:@"DefaultImg.jpg"]];
                    
                    
                    [Chat_UserImage setFrame:CGRectMake((self.view.frame.size.width-64)-imgwidth,4,imgwidth,imgheight)];
                    Chat_UserImage.clipsToBounds=YES;
                    Chat_UserImage.layer.cornerRadius=9.0f;
                    Chat_UserImage.contentMode=UIViewContentModeScaleAspectFit;
                    
                    [self displayImage:Chat_UserImage withImage:Chat_UserImage.image];
                    
                    [desc_Imagepro setFrame:CGRectMake(self.view.frame.size.width-48,Chat_UserImage.frame.origin.y+(Chat_UserImage.frame.size.height-32),32,32)];
                    desc_Imagepro.clipsToBounds=YES;
                    desc_Imagepro.layer.cornerRadius=desc_Imagepro.frame.size.height/2;
                }
                
                
            }
            
            
            
            
            
            return cell_ThreeComments;
            
        }
            
            if ([Str_Tapped_Comments_Vedio isEqualToString:@"Vedio"])
            {
               cell_Vediolist = (VediosListsTableViewCell*)[tableView dequeueReusableCellWithIdentifier:@"CellVidLis" forIndexPath:indexPath];
                
                if (Array_showrecordvid.count-1==indexPath.row)
                {
                    Bottomborder_Cell2 = [CALayer layer];
                    Bottomborder_Cell2.backgroundColor = [UIColor clearColor].CGColor;
                    Bottomborder_Cell2.frame = CGRectMake(0, cell_Vediolist.frame.size.height-1, cell_Vediolist.frame.size.width, 1);
                    [cell_Vediolist.layer addSublayer:Bottomborder_Cell2];
                }
                else
                {
                    Bottomborder_Cell2 = [CALayer layer];
                    Bottomborder_Cell2.backgroundColor = [UIColor colorWithRed:241/255.0 green:241/255.0 blue:241/255.0 alpha:1.0].CGColor;
                    Bottomborder_Cell2.frame = CGRectMake(0, cell_Vediolist.frame.size.height-1, cell_Vediolist.frame.size.width, 1);
                    [cell_Vediolist.layer addSublayer:Bottomborder_Cell2];
                }

                
                
                
        [cell_Vediolist.Imagepro setFrame:CGRectMake(cell_Vediolist.Imagepro.frame.origin.x, cell_Vediolist.Imagepro.frame.origin.y, cell_Vediolist.Imagepro.frame.size.width, cell_Vediolist.Imagepro.frame.size.width)];
                
           [cell_Vediolist.Image_playButton setFrame:CGRectMake(cell_Vediolist.Image_playButton.frame.origin.x, cell_Vediolist.Image_playButton.frame.origin.y, cell_Vediolist.Image_playButton.frame.size.width, cell_Vediolist.Image_playButton.frame.size.width)];
            
                [cell_Vediolist.ImageRight_RightProfile setFrame:CGRectMake(cell_Vediolist.ImageRight_RightProfile.frame.origin.x, cell_Vediolist.ImageRight_RightProfile.frame.origin.y, cell_Vediolist.ImageRight_RightProfile.frame.size.width, cell_Vediolist.ImageRight_RightProfile.frame.size.width)];
                
                
                
                 [cell_Vediolist.ImageRight_Likes setFrame:CGRectMake(cell_Vediolist.ImageRight_Likes.frame.origin.x, cell_Vediolist.ImageRight_Likes.frame.origin.y, cell_Vediolist.ImageRight_Likes.frame.size.width, cell_Vediolist.ImageRight_Likes.frame.size.width)];
                
                
                
                 [cell_Vediolist.ImageRight_FriendStatus setFrame:CGRectMake(cell_Vediolist.ImageRight_FriendStatus.frame.origin.x, cell_Vediolist.ImageRight_FriendStatus.frame.origin.y, cell_Vediolist.ImageRight_FriendStatus.frame.size.width, cell_Vediolist.ImageRight_FriendStatus.frame.size.width)];
                
                
                cell_Vediolist.ImageRight_RightProfile.clipsToBounds=YES;
                cell_Vediolist.ImageRight_RightProfile.layer.cornerRadius=cell_Vediolist.ImageRight_RightProfile.frame.size.height/2;
                
            cell_Vediolist.image_newSymbolstatus.contentMode=UIViewContentModeScaleAspectFill;
                    
            cell_Vediolist.image_newSymbolstatus.userInteractionEnabled=YES;
                    
            [cell_Vediolist.image_newSymbolstatus setTag:indexPath.row];
                
        [cell_Vediolist.image_newSymbolstatus setImage:[UIImage imageNamed:@"new.png"]];
                cell_Vediolist.Imagepro.contentMode=UIViewContentModeScaleAspectFill;
                    
            cell_Vediolist.Imagepro.userInteractionEnabled=YES;
                    
            [cell_Vediolist.Imagepro setTag:indexPath.row];
                    

                cell_Vediolist.Image_playButton.userInteractionEnabled=YES;
                
                [cell_Vediolist.Image_playButton setTag:indexPath.row];
                [cell_Vediolist.Imagepro setTag:indexPath.row];
                
            UITapGestureRecognizer * ImageTap =[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(ImageTapped_profile:)];
                [cell_Vediolist.Imagepro addGestureRecognizer:ImageTap];
                
                UITapGestureRecognizer * ImageTapPlay =[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(ImageTapped_profile:)];
                [cell_Vediolist.Image_playButton addGestureRecognizer:ImageTapPlay];
                
                    
        cell_Vediolist.Imagepro.clipsToBounds=YES;
        cell_Vediolist.Imagepro.layer.cornerRadius=9.0f;
                    
                
                
                
                
                cell_Vediolist.ImageRight_Likes.userInteractionEnabled=YES;
                
                [cell_Vediolist.ImageRight_Likes setTag:indexPath.row];
                
                UITapGestureRecognizer * ImageTapLiuke =[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(ImageTapped_profileLikeVedio:)];
                [cell_Vediolist.ImageRight_Likes addGestureRecognizer:ImageTapLiuke];
                cell_Vediolist.Image_VedioShare.tag=indexPath.row;
                cell_Vediolist.Image_VedioShare.userInteractionEnabled=YES;
                
                UITapGestureRecognizer * ImageTapvedioshare =[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(ImageTapped_Vedioshare:)];
                [cell_Vediolist.Image_VedioShare addGestureRecognizer:ImageTapvedioshare];

              
                    
                NSURL * url=[NSURL URLWithString:[[Array_showrecordvid objectAtIndex:indexPath.row]valueForKey:@"thumbnailurl"]];
                    
                    [cell_Vediolist.Imagepro setImageWithURL:url placeholderImage:[UIImage imageNamed:@"DefaultImg.jpg"]];
                
                
                
                NSDictionary * dic_value=[Array_showrecordvid objectAtIndex:indexPath.row];
                
                cell_Vediolist.Label_DaysAgo.text=[NSString stringWithFormat:@"%@",[dic_value valueForKey:@"posttime"]];
                
                cell_Vediolist.Label_totalreviews.text=[NSString stringWithFormat:@"%@",[dic_value valueForKey:@"totalviews"]];
                
              
                
              
                
                NSURL *urlRight=[NSURL URLWithString:[dic_value valueForKey:@"profileimage"]];
                [cell_Vediolist.ImageRight_RightProfile setImageWithURL:urlRight placeholderImage:[UIImage imageNamed:@"DefaultImg.jpg"] ];
                
                
                
                
                cell_Vediolist.ImageRight_RightProfile.tag=indexPath.row;
                cell_Vediolist.ImageRight_RightProfile.userInteractionEnabled=YES;
                
                UITapGestureRecognizer *image_SecProfileTapped =[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(image_SecProfile_ActionDetails:)];
                [cell_Vediolist.ImageRight_RightProfile addGestureRecognizer:image_SecProfileTapped];
                
                
                
                UIFont *name1 = [UIFont fontWithName:@"SanFranciscoDisplay-Medium" size:15.0];
                NSDictionary *arialDict = [NSDictionary dictionaryWithObject:name1 forKey:NSFontAttributeName];
                NSMutableAttributedString *aAttrString = [[NSMutableAttributedString alloc] initWithString:@"Posted by " attributes: arialDict];
                
                UIFont *name2 = [UIFont fontWithName:@"SanFranciscoDisplay-Bold" size:16.0];
                NSDictionary *verdanaDict = [NSDictionary dictionaryWithObject:name2 forKey:NSFontAttributeName];
                NSMutableAttributedString *vAttrString = [[NSMutableAttributedString alloc]initWithString:[dic_value valueForKey:@"name"]  attributes:verdanaDict];
                
                
                [aAttrString appendAttributedString:vAttrString];
                
                
                cell_Vediolist.Label_ChallengeName.attributedText = aAttrString;
                
                 cell_Vediolist.Label_likes.text=[dic_value valueForKey:@"totallikes"];
                
                if ([[dic_value valueForKey:@"likestatus"] isEqualToString:@"yes"])
                {
                
            [cell_Vediolist.ImageRight_Likes setImage:[UIImage imageNamed:@"filllike.png"]];
                    
                }
                if ([[dic_value valueForKey:@"likestatus"] isEqualToString:@"no"])
                {
            [cell_Vediolist.ImageRight_Likes setImage:[UIImage imageNamed:@"emptylike.png"]];
                }
                
               
                
                
        if ([[[Array_showrecordvid objectAtIndex:indexPath.row]valueForKey:@"newstatus"] isEqualToString:@"yes"])
                                        {
                                            cell_Vediolist.image_newSymbolstatus.hidden=NO;
                                        }
                                        else
                                        {
                                           cell_Vediolist.image_newSymbolstatus.hidden=YES;
                                        }
                
                cell_Vediolist.ImageRight_FriendStatus.userInteractionEnabled=YES;
                [cell_Vediolist.ImageRight_FriendStatus setTag:indexPath.row];
                cell_Vediolist.Label_subscribe.userInteractionEnabled=YES;
                [cell_Vediolist.Label_subscribe setTag:indexPath.row];
   
              
                if ([[defaults valueForKey:@"userid"] isEqualToString:[dic_value valueForKey:@"useridvideo"]])
                {
                    cell_Vediolist.ImageRight_FriendStatus.hidden=YES;
                    cell_Vediolist.Label_subscribe.hidden=YES;
                }
                else
                {
                    
                    if ([[dic_value valueForKey:@"friendstatus"] isEqualToString:@"no"])
                    {
                        cell_Vediolist.ImageRight_FriendStatus.hidden=NO;
                         cell_Vediolist.Label_subscribe.hidden=NO;
                        [cell_Vediolist.ImageRight_FriendStatus setImage:[UIImage imageNamed:@"addfriend.png"]];
                        
                        
                        
                        UITapGestureRecognizer * ImageTapFriendstatus =[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(ImageTapped_profileFriendStatus:)];
                        [cell_Vediolist.ImageRight_FriendStatus addGestureRecognizer:ImageTapFriendstatus];
                        
                UITapGestureRecognizer * ImageTapFriendsubscribe =[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(ImageTapped_profileFriendStatus:)];
                [cell_Vediolist.Label_subscribe addGestureRecognizer:ImageTapFriendsubscribe];
                        
                        
                    }
                    
                    
                    if ([[dic_value valueForKey:@"friendstatus"] isEqualToString:@"yes"])
                    {
                        cell_Vediolist.ImageRight_FriendStatus.hidden=NO;
                        cell_Vediolist.Label_subscribe.hidden=YES;
                        [cell_Vediolist.ImageRight_FriendStatus setImage:[UIImage imageNamed:@"addfriend1.png"]];
                        
                    }
                    if ([[dic_value valueForKey:@"friendstatus"] isEqualToString:@"waiting"])
                    {
                        cell_Vediolist.ImageRight_FriendStatus.hidden=NO;
                         cell_Vediolist.Label_subscribe.hidden=YES;
                        [cell_Vediolist.ImageRight_FriendStatus setImage:[UIImage imageNamed:@"friendrequested.png"]];
                        
                    }
                }
                    
                
                return cell_Vediolist;
            }
    }
            break;

        
    }
    return nil;
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return 4;
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section==0)
    {
        return 233;
    }
    if (indexPath.section==1)
    {
        NSString *text =[[AllArrayData objectAtIndex:0]valueForKey:@"title"];;
        
        
        CGSize constraint = CGSizeMake(345 - (CELL_CONTENT_MARGIN * 2), 20000.0f);
        
        CGSize size = [text sizeWithFont:[UIFont fontWithName:@"SanFranciscoDisplay-Bold" size:24.0] constrainedToSize:constraint lineBreakMode:UILineBreakModeWordWrap];
        
        CGFloat height = MAX(size.height, 30.0f);
        NSLog(@"Dynamic label height====%f",height);
        NSInteger rHeight = size.height/24;
        [cell_TwoDetails.textview_Dummey setText:text];
        
        
        CGFloat fixedWidth =self.view.frame.size.width-((cell_TwoDetails.textview_View.frame.origin.x)*2); //cell_TwoDetails.textview_Dummey.frame.size.width;
        CGSize newSize = [cell_TwoDetails.textview_Dummey sizeThatFits:CGSizeMake(fixedWidth, MAXFLOAT)];
        CGRect newFrame = cell_TwoDetails.textview_Dummey.frame;
        newFrame.size = CGSizeMake(fmaxf(newSize.width, fixedWidth), newSize.height);
        [cell_TwoDetails.textview_Dummey setFrame:(newFrame)];
        if ([str_TappedLabel isEqualToString:@"yes"])
        {
            
            
    return 148+cell_TwoDetails.textview_Dummey.frame.size.height-38;
            
 
        }
        else
        {
          
      if ((long)rHeight==1)
     {
       return 148+cell_TwoDetails.textview_Dummey.frame.size.height-38;
        }
       else
         {
        return 148+26;
           }
            
 

            
        }
//        NSString *text =[[AllArrayData objectAtIndex:0]valueForKey:@"title"];;
//        
//        
//        CGSize constraint = CGSizeMake(CELL_CONTENT_WIDTH - (CELL_CONTENT_MARGIN * 2), 20000.0f);
//        
//        CGSize size = [text sizeWithFont:[UIFont systemFontOfSize:FONT_SIZE] constrainedToSize:constraint lineBreakMode:UILineBreakModeWordWrap];
//        
//        CGFloat height = MAX(size.height, 30.0f);
//        NSLog(@"Dynamic label height====%f",height);
//       if(height <=30)
//       {
//        return 148+size.height+10;
//       }
//        else
//        {
//          return 148+size.height+40;
//        }
        
    }
    if (indexPath.section==2)
    {
//        if (Array_showrecordvid.count==0)
//        {
//            return 0;
//        }
//        else
//        {
          return 70;
     //   }
        
    }

    if (indexPath.section==3)
    {
        if ([Str_Tapped_Comments_Vedio isEqualToString:@"Vedio"])
        {
          return 127;
        }
        if ([Str_Tapped_Comments_Vedio isEqualToString:@"Comment"])
        {
            if ([[[Array_Comment1 objectAtIndex:indexPath.row]valueForKey:@"messagetype"] isEqualToString:@"TEXT"])
            {
                NSString *text = [[Array_Comment1 objectAtIndex:indexPath.row] valueForKey:@"message"];
                
                CGSize constraint = CGSizeMake(CELL_CONTENT_WIDTH - (CELL_CONTENT_MARGIN * 2), 20000.0f);
                
                CGSize size = [text sizeWithFont:[UIFont systemFontOfSize:FONT_SIZE] constrainedToSize:constraint lineBreakMode:UILineBreakModeWordWrap];
                
                CGFloat height = MAX(size.height, 30.0f);
                return height + (CELL_CONTENT_MARGIN * 2)+15;
            }
            else
            {
                CGFloat imgheight=[[[Array_Comment1 objectAtIndex:indexPath.row]valueForKey:@"imageheight"] floatValue];
                return imgheight+14;
            }
        }
    
    }
        return 0;
    
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{

if (section==0)
{
    sectionView=[[UIView alloc]initWithFrame:CGRectMake(0, 0,0,0)];
    [sectionView setBackgroundColor:[UIColor whiteColor]];
    
    
    sectionView.tag=section;
    
    
}
if (section==1)
{
    
    sectionView=[[UIView alloc]initWithFrame:CGRectMake(0, 0,self.view.frame.size.width,38)];
    [sectionView setBackgroundColor:[UIColor colorWithRed:67/255.0 green:188/255.0 blue:255/255.0 alpha:1]];
   
    
    
    
    
    Button_FavouriteTap=[[UIButton alloc]initWithFrame:CGRectMake(0,0,50,38)];
    
    Button_FavouriteTap.tag=section;
    Button_FavouriteTap.backgroundColor=[UIColor grayColor];
    
    [Button_FavouriteTap addTarget:self action:@selector(FavouriteTapped_Action:)
                forControlEvents:UIControlEventTouchUpInside];
    Button_FavouriteTap.backgroundColor=[UIColor clearColor];
    
    
    Button_Contribute=[[UIButton alloc]initWithFrame:CGRectMake(50,0, self.view.frame.size.width-100,38)];
    
    
    Button_Contribute.titleLabel.numberOfLines = 1;
    Button_Contribute.titleLabel.minimumFontSize = 16;
    Button_Contribute.titleLabel.adjustsFontSizeToFitWidth = YES;
    
    if ([[[AllArrayData objectAtIndex:0]valueForKey:@"contributiontype"] isEqualToString:@"RAISE"])
    {
        
        if ([[[AllArrayData objectAtIndex:0]valueForKey:@"accepted"] isEqualToString:@"yes"] || [[[AllArrayData objectAtIndex:0]valueForKey:@"accepted"] isEqualToString:@"no"])
        {
            [Button_Contribute setTitle:@"RECORD CHALLENGE" forState:UIControlStateNormal];
            //        Button_Contribute.backgroundColor=[UIColor colorWithRed:234/255.0 green:36/255.0 blue:39/255.0 alpha:1];
            
            [Button_Contribute addTarget:self action:@selector(Contribute_RecordedChallenge:)
                        forControlEvents:UIControlEventTouchUpInside];
        }
        else
        {
            
            [Button_Contribute setTitle:@"DONATE" forState:UIControlStateNormal];
            Button_Contribute.backgroundColor=[UIColor clearColor];
            
            [Button_Contribute addTarget:self action:@selector(Contribute_MoneyAction:)
                        forControlEvents:UIControlEventTouchUpInside];
            
            
            
        }
        
//        if ([[defaults valueForKey:@"userid"] isEqualToString:[[AllArrayData objectAtIndex:0]valueForKey:@"userid1"]])
//        {
//            [Button_Contribute setTitle:@"RECORD CHALLENGE" forState:UIControlStateNormal];
//            //        Button_Contribute.backgroundColor=[UIColor colorWithRed:234/255.0 green:36/255.0 blue:39/255.0 alpha:1];
//            
//            [Button_Contribute addTarget:self action:@selector(Contribute_RecordedChallenge:)
//                        forControlEvents:UIControlEventTouchUpInside];
//        }
//        else
//        {
//        [Button_Contribute setTitle:@"DONATE" forState:UIControlStateNormal];
//        Button_Contribute.backgroundColor=[UIColor clearColor];
//        
//        [Button_Contribute addTarget:self action:@selector(Contribute_MoneyAction:)
//                    forControlEvents:UIControlEventTouchUpInside];
//        }
    }
    else
    {
    if ([[[AllArrayData objectAtIndex:0]valueForKey:@"accepted"] isEqualToString:@"yes"] || [[[AllArrayData objectAtIndex:0]valueForKey:@"accepted"] isEqualToString:@"no"])
    {
        if ([[defaults valueForKey:@"userid"] isEqualToString:[[AllArrayData objectAtIndex:0]valueForKey:@"userid1"]])
        {
            
            [Button_Contribute setTitle:@"DONATE" forState:UIControlStateNormal];
            Button_Contribute.backgroundColor=[UIColor clearColor];
            
            [Button_Contribute addTarget:self action:@selector(Contribute_MoneyAction:)
                        forControlEvents:UIControlEventTouchUpInside];
        }
        else
        {
        [Button_Contribute setTitle:@"RECORD CHALLENGE" forState:UIControlStateNormal];
//        Button_Contribute.backgroundColor=[UIColor colorWithRed:234/255.0 green:36/255.0 blue:39/255.0 alpha:1];
        
        [Button_Contribute addTarget:self action:@selector(Contribute_RecordedChallenge:)
                    forControlEvents:UIControlEventTouchUpInside];
        }
    }
    else
    {
        
        [Button_Contribute setTitle:@"DONATE" forState:UIControlStateNormal];
        Button_Contribute.backgroundColor=[UIColor clearColor];
        
        [Button_Contribute addTarget:self action:@selector(Contribute_MoneyAction:)
                    forControlEvents:UIControlEventTouchUpInside];
        
       
    
    }
    }
    Button_Contribute.tag=section;
    Button_Contribute.titleLabel.font=[UIFont fontWithName:@"SanFranciscoDisplay-Bold" size:24.0];
   
    
   
    
    
    
    
    Image_Share=[[UIButton alloc]initWithFrame:CGRectMake((Button_Contribute.frame.origin.x+Button_Contribute.frame.size.width),0,50,38)];
     Image_Share.backgroundColor=[UIColor colorWithRed:20/255.0 green:245/255.0 blue:115/255.0 alpha:1];
    [Image_Share setImage:[UIImage imageNamed:@"sharebutton.png"]forState:UIControlStateNormal];;
//    Image_Share.contentMode=UIViewContentModeScaleAspectFit;
     Image_Share.tag=section;
    Image_Share.backgroundColor=[UIColor clearColor];
    Image_Share.userInteractionEnabled=YES;
    
    [Image_Share addTarget:self action:@selector(Share_Action:)
                forControlEvents:UIControlEventTouchUpInside];

    
    [sectionView addSubview:Button_Contribute];
    [sectionView addSubview:Image_Share];
    [sectionView addSubview:Button_FavouriteTap];
    
    
    
            if ([CheckFavInserted isEqualToString:@"TRUE"])
                {
                    [Button_FavouriteTap setImage:[UIImage imageNamed:@"favouritebutton1.png"] forState:UIControlStateNormal];
                }
                else
                {
                   [Button_FavouriteTap setImage:[UIImage imageNamed:@"favouritebutton.png"] forState:UIControlStateNormal];
                }
    
    
    sectionView.tag=section;

    if ([[[AllArrayData objectAtIndex:0]valueForKey:@"challenge_status"] isEqualToString:@"COMPLETE"] )
    
    {
          Button_Contribute.enabled=NO;
        Button_Contribute.alpha=0.8f;
        Button_FavouriteTap.hidden=YES;
        Image_Share.hidden=YES;
       [Button_Contribute setTitle:@"CHALLENGE OVER" forState:UIControlStateNormal];
    }
    
    
    
    }
    if (section==2)
    {
        
        sectionView=[[UIView alloc]initWithFrame:CGRectMake(0, 0,self.view.frame.size.width,44)];
        [sectionView setBackgroundColor:[UIColor whiteColor]];
        
        
        upperBorder1.backgroundColor = [UIColor colorWithRed:241/255.0 green:241/255.0 blue:241/255.0 alpha:1.0].CGColor;
        upperBorder1.frame = CGRectMake(0, 0, sectionView.frame.size.width, 1.0f);
        [sectionView.layer addSublayer:upperBorder1];
        
        
        UILabel * label_Comment=[[UILabel alloc]initWithFrame:CGRectMake(16,0, self.view.frame.size.width-32,30)];
        label_Comment.text=@"Recorded Videos";
        label_Comment.textColor=[UIColor lightGrayColor];
        label_Comment.tag=section;
        label_Comment.font=[UIFont fontWithName:@"SanFranciscoDisplay-Medium" size:16.0];
        
        
        
        [sectionView addSubview:label_Comment];
        
        
        sectionView.tag=section;
        
    }
    if (section==3)
    {
        
        sectionView=[[UIView alloc]initWithFrame:CGRectMake(0, 0,self.view.frame.size.width,40)];
        [sectionView setBackgroundColor:[UIColor whiteColor]];
        
 
    upperBorder.backgroundColor = [UIColor colorWithRed:241/255.0 green:241/255.0 blue:241/255.0 alpha:1.0].CGColor;
    upperBorder.frame = CGRectMake(0, 0, sectionView.frame.size.width, 1.0f);
    [sectionView.layer addSublayer:upperBorder];
        
        
      UILabel * label_Comment=[[UILabel alloc]initWithFrame:CGRectMake(16,0, self.view.frame.size.width-32,40)];
        
        if ([Str_Tapped_Comments_Vedio isEqualToString:@"Vedio"])
        {
            label_Comment.text=@"Challenger Videos";;
        }
        if ([Str_Tapped_Comments_Vedio isEqualToString:@"Comment"])
        {
        label_Comment.text=@"Comments";
        }
        label_Comment.textColor=[UIColor lightGrayColor];
              label_Comment.tag=section;
        label_Comment.font=[UIFont fontWithName:@"SanFranciscoDisplay-Medium" size:16.0];
        
        label_Comment.backgroundColor=[UIColor clearColor];
        
        [sectionView addSubview:label_Comment];
      
        
        sectionView.tag=section;
        
    }
return  sectionView;



}
-(IBAction)Share_Action:(id)sender
{
    NSString * texttoshare=[NSString stringWithFormat:@"%@%@",[[AllArrayData objectAtIndex:0] valueForKey:@"usersname"],@" has posted a new challenge. Download the app now - http://www.care2dareapp.com or View the challenge here: "];
   
    NSURL * urltoshare=[NSURL URLWithString:[NSString stringWithFormat:@"%@",[[AllArrayData objectAtIndex:0] valueForKey:@"mediaurl"]]];
    NSArray *activityItems1=@[texttoshare,urltoshare];
    NSArray *activityItems =@[UIActivityTypePrint,UIActivityTypeAirDrop,UIActivityTypeAssignToContact,UIActivityTypeAddToReadingList,UIActivityTypeOpenInIBooks];
    UIActivityViewController *activityViewControntroller = [[UIActivityViewController alloc] initWithActivityItems:activityItems1 applicationActivities:nil];
    activityViewControntroller.excludedActivityTypes = activityItems;
    //  [self.view addSubview:activityViewControntroller];
    [self presentViewController:activityViewControntroller animated:YES completion:nil];
}
-(void)Contribute_RecordedChallenge:(UIButton *)sender
{

    
 Label_confirm1.text=@"0 %";
    strCameraVedio=@"Record";
    [self startCameraControllerFromViewController: self
                                    usingDelegate: self];
}

- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task
   didSendBodyData:(int64_t)bytesSent
    totalBytesSent:(int64_t)totalBytesSent
totalBytesExpectedToSend:(int64_t)totalBytesExpectedToSend
{
    float progress = ((double)totalBytesSent / (double)totalBytesExpectedToSend)*100;
    NSLog(@"percentage  of dattataa==%f",progress);
    Label_confirm1.text=[NSString stringWithFormat:@"%.f%@",progress,@" %"];
}
-(void)Contribute_MoneyAction:(UIButton *)sender
{
ContributeMoneyViewController * set=[self.storyboard instantiateViewControllerWithIdentifier:@"ContributeMoneyViewController"];
    set.total_players=[[AllArrayData objectAtIndex:0]valueForKey:@"noofchallengers"];
    set.Str_DonateRaisedTypePlayer=[NSString stringWithFormat:@"%@",[[AllArrayData objectAtIndex:0]valueForKey:@"contributiontype"]];
    set.challengerID=[[AllArrayData objectAtIndex:0]valueForKey:@"challengeid"];
    [self.navigationController pushViewController:set animated:YES];
}




- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{

    if (section==0)
    {
        return 0;
    }
    if (section==1)
    {
        
            return 38;
       
    }
    if (section==2 )
    {
        
//    if (Array_showrecordvid.count==0)
//    {
        return 0;
//    }
//    else
//    {
//          return 38;
//    }
    }
    
    if (section==3)
    {
        
        return 40;
        
    }
    return 0;
  
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}
-(IBAction)ButtonBack_Action:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(IBAction)FavouriteTapped_Action:(id)sender
{
    
    Reachability *networkReachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus networkStatus = [networkReachability currentReachabilityStatus];
    if (networkStatus == NotReachable)
    {
        
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"No Internet" message:@"Please make sure you have internet connectivity in order to access Care2dare." preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *actionOk = [UIAlertAction actionWithTitle:@"Ok"
                                                           style:UIAlertActionStyleDefault handler:^(UIAlertAction *action)
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
      
        
        NSString *userid= @"userid";
        NSString *useridVal =[defaults valueForKey:@"userid"];
        
        NSString *challengrid= @"challengeid";
        NSString *challengridVal=[[AllArrayData objectAtIndex:0]valueForKey:@"challengeid"];;
        
        
        
        NSString * reqStringFUll=[NSString stringWithFormat:@"%@=%@&%@=%@",userid,useridVal,challengrid,challengridVal];
        
        
        
#pragma mark - swipe sesion
        
        NSURLSession *session = [NSURLSession sessionWithConfiguration: [NSURLSessionConfiguration defaultSessionConfiguration] delegate: nil delegateQueue: [NSOperationQueue mainQueue]];
        
        NSURL *url;
        NSString *  urlStrLivecount=[urlplist valueForKey:@"favourite-add"];
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
                                                     
//                                                     SBJsonParser *objSBJsonParser = [[SBJsonParser alloc]init];
                                                     
                                                     NSString * ResultString=[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
                                                     ResultString = [ResultString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
                                                     ResultString = [ResultString stringByReplacingOccurrencesOfString:@"\t" withString:@""];
                                                     NSLog(@"Array_WorldExp ResultString %@",ResultString);
                                                    
//                                                     if ([ResultString isEqualToString:@"nouserid"])
//                                                     {
//                                                         
//                                                         UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Oops" message:@"Your account does not exist or seems to have been suspended. Please contact admin." preferredStyle:UIAlertControllerStyleAlert];
//                                                         
//                                                         UIAlertAction *actionOk = [UIAlertAction actionWithTitle:@"Ok"
//                                                                                                            style:UIAlertActionStyleDefault handler:nil];
//                                                         [alertController addAction:actionOk];
//                                                         [self presentViewController:alertController animated:YES completion:nil];
//                                                         
//                                                     }
                                                     if ([ResultString isEqualToString:@"inserted"])
                                                     {
                                    CheckFavInserted=@"TRUE";
                                    [self.Tableview_ContriBute reloadData];
                                                         
                                                     }
                        if ([ResultString isEqualToString:@"deleted"])
                                                     {
                                                         
                                    CheckFavInserted=@"FALSE";
                                    [self.Tableview_ContriBute reloadData];
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
-(void)ThreeDotsTapped_Action:(UIGestureRecognizer *)reconizer
{
    
//    if([[[AllArrayData objectAtIndex:0] valueForKey:@"challengersuserid"]isEqualToString:@"0"] ||[[defaults valueForKey:@"userid"] isEqualToString:[[AllArrayData objectAtIndex:0] valueForKey:@"challengersuserid"]])
//    {
//        
//    
    
    if([[defaults valueForKey:@"userid"] isEqualToString:[[AllArrayData objectAtIndex:0] valueForKey:@"userid1"]])
    {
    
    
        
        UIActionSheet *popup = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:@"Delete Challenge" otherButtonTitles:@"Flag as inappropriate",nil];
        popup.tag = 777;
        [popup showInView:self.view];
    }
    else
    {
        
        UIActionSheet *popup = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Flag as inappropriate",nil];
        popup.tag = 707;
        [popup showInView:self.view];
    }
    
    
}

- (void)textViewDidChange:(UITextView *)textView
{
    
    
    if(Array_Comment1.count>=1)
    {
        
        
[Tableview_ContriBute scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:Array_Comment1.count-1 inSection:3] atScrollPosition:UITableViewScrollPositionBottom animated:NO];
        
    }
    
    if (textView.text.length == 0)
    {
        self.sendButton.hidden=NO;
        self.sendButton.enabled=NO;
        self.placeholderLabel.hidden=NO;
        [self.sendButton setBackgroundColor:[UIColor colorWithRed:186/255.0 green:188/255.0 blue:190/255.0 alpha:1]];
        self.sendButton.userInteractionEnabled = NO;
        [self.sendButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _ImageGalButton.hidden=NO;
        _ImageGalButton.enabled=YES;
        [self.ImageGalButton setBackgroundColor:[UIColor clearColor]];
        self.ImageGalButton.userInteractionEnabled = YES;
        
        
        
        
    }
    else
    {
        
        chattype=@"TEXT";
        
        
        self.placeholderLabel.hidden=YES;
        self.sendButton.hidden=NO;
        self.sendButton.enabled=YES;
        [self.sendButton setBackgroundColor:[UIColor colorWithRed:67/255.0 green:188/255.0 blue:255/255.0 alpha:1]];
        self.sendButton.userInteractionEnabled = YES;
        [self.sendButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        
        _ImageGalButton.userInteractionEnabled = NO;
        _ImageGalButton.hidden=NO;
        _ImageGalButton.enabled=NO;
        
    }
    
    
   // CGFloat y = CGRectGetMaxY(self.textOne.frame);
    
    UITextPosition* pos = textOne.endOfDocument;
    
    CGRect currentRect = [textOne caretRectForPosition:pos];
    
    NSLog(@"dsdssdfds %f",currentRect.origin.y);
    
    if (currentRect.origin.y >65)
    {
        if ( [flag1 isEqualToString:@"yes" ])
        {
            
            self.BlackViewOne.frame = CGRectMake(0, bty - textView.contentSize.height+26, self.view.frame.size.width,bth+textView.contentSize.height);
            ViewTextViewOne.frame = CGRectMake(xx, yy, ww,textOne.frame.size.height+2);
          
           // Tableview_ContriBute.frame = CGRectMake(0,yt, tw, th-(textView.contentSize.height+182));
            Tableview_ContriBute.frame = CGRectMake(0,yt, tw, th-(textView.contentSize.height+(keyboradHeight-hh)));
            flag1=@"no";
        }
        else
        {
            flag1=@"no";
        }
        
    }
    else
    {
        self.automaticallyAdjustsScrollViewInsets = NO;
        if(currentRect.origin.y <=64)
        {
            flag1=@"yes";
        }
        
        
        
        self.BlackViewOne.frame = CGRectMake(0, bty - textView.contentSize.height+33, self.view.frame.size.width,bth+textView.contentSize.height);
        
        self.textOne.frame = CGRectMake(xx, yy, ww,textView.contentSize.height+10);
        ViewTextViewOne.frame = CGRectMake(xx, yy, ww,textView.contentSize.height);
      //  Tableview_ContriBute.frame = CGRectMake(0,yt, tw, th-(textView.contentSize.height+184));
            Tableview_ContriBute.frame = CGRectMake(0,yt, tw, th-(textView.contentSize.height+(keyboradHeight-hh)));
        [self.textOne layoutIfNeeded];
        NSLog(@"BlueView==%f",_textOneBlue.frame.size.height);
        NSLog(@"BlueView==%f",_textOneBlue.frame.size.width);
        NSLog(@"BlueViewx==%f",_textOneBlue.frame.origin.x);
        NSLog(@"BlueViewy==%f",_textOneBlue.frame.origin.y);
        
        
        
        NSLog(@"tableView_Pay==%f",Tableview_ContriBute.frame.size.height);
        NSLog(@"tableView_Payyy==%f",Tableview_ContriBute.frame.origin.y);
        
        NSLog(@"ViewTextViewOne==%f",ViewTextViewOne.frame.size.height);
        
        NSLog(@"self.textOne.frame==%f",self.textOne.frame.size.height);
        
        NSLog(@"BlackViewOne==%f",_BlackViewOne.frame.size.height);
        NSLog(@"BlackViewOne==%f",_BlackViewOne.frame.size.width);
        NSLog(@"BlackViewOne==%f",_BlackViewOne.frame.origin.y);
        
        NSLog(@"tableOne==%f",Tableview_ContriBute.frame.size.height);
        NSLog(@"tableOne==%f",Tableview_ContriBute.frame.size.width);
        NSLog(@"tableOne==%f",Tableview_ContriBute.frame.origin.y);
        NSLog(@"tableOne==%f",Tableview_ContriBute.frame.origin.x);
    }
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
//    if (_BlackViewOne.frame.size.height > bth)
//    {
//        Tableview_ContriBute.frame = CGRectMake(0,yt, tw, th-_BlackViewOne.frame.size.height+90);
//    }
//    else
//    {
//        Tableview_ContriBute.frame = CGRectMake(0,yt, tw, th);
//        
//    }
    [self.view endEditing:YES];
    
    
}
-(void)textViewDidBeginEditing:(UITextView *)textView
{
    
    [textOne becomeFirstResponder];
    
//    if (textView.text.length!=0)
//    {
//        Tableview_ContriBute.frame = CGRectMake(0,yt, self.view.frame.size.width, th-_BlackViewOne.frame.size.height-125);
//        
//    }
//    else
//    {
//        
//        Tableview_ContriBute.frame = CGRectMake(0,yt, tw, th-(textView.contentSize.height+190));
//    }
    
    if(Array_Comment1.count>=1)
    {
        
        
    [Tableview_ContriBute scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:Array_Comment1.count-1 inSection:3] atScrollPosition:UITableViewScrollPositionBottom animated:NO];
        
        
        
    }
    else
    {
        if (Array_showrecordvid.count==0)
        {
             [Tableview_ContriBute scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:1] atScrollPosition:UITableViewScrollPositionBottom animated:NO];        }
        else
        {
      [Tableview_ContriBute scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:2] atScrollPosition:UITableViewScrollPositionBottom animated:NO];
        }
        
    }
    
}
- (void) displayImage:(UIImageView*)imageView withImage:(UIImage*)image  {
    
    
    [imageView setImage:image];
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    [imageView setupImageViewer];
    imageView.clipsToBounds = YES;
}
-(UIImage *)scaleImage:(UIImage *)image toSize:(CGSize)newSize
{
    UIGraphicsBeginImageContext(newSize);
    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}
-(void)Image_tapcomment:(UIGestureRecognizer *)reconizer
{
   
//    Tableview_ContriBute.frame = CGRectMake(0,yt, tw, th);
    [Tableview_ContriBute setFrame: CGRectMake(0,yt, tw, th)];
     _textOneBlue.hidden=NO;
 Str_Tapped_Comments_Vedio=@"Comment";
  
    [Tableview_ContriBute reloadData];
//     [Tableview_ContriBute scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:Array_Comment1.count-1 inSection:3] atScrollPosition:UITableViewScrollPositionBottom animated:NO];
    [textOne becomeFirstResponder];
      [self chatCommunication];
    
}
-(void)Image_tapvedio:(UIGestureRecognizer *)reconizer
{

//Tableview_ContriBute.frame = CGRectMake(0,yt, tw, th+_BlackViewOne.frame.size.height);
    [Tableview_ContriBute setFrame:CGRectMake(0,yt, tw, th+_BlackViewOne.frame.size.height-30)];
    _textOneBlue.hidden=YES;
 Str_Tapped_Comments_Vedio=@"Vedio";
   
    [Tableview_ContriBute reloadData];
      [self Communication_showrecordVid];
}
-(void)label_Desc_Tapped_ActionDetails:(UIGestureRecognizer *)reconizer
{
   
    if ([str_TappedLabel isEqualToString:@"yes"])
    {
         str_TappedLabel=@"no";
       
    }
    else
    {
       str_TappedLabel=@"yes";
        
    }
    
    
    
    [Tableview_ContriBute beginUpdates];
    [Tableview_ContriBute reloadSections:[NSIndexSet indexSetWithIndex:1] withRowAnimation:UITableViewRowAnimationNone];
    [Tableview_ContriBute endUpdates];
    
    
}
-(void)image_SecProfile_ActionDetails1:(UIGestureRecognizer *)reconizer
{
    NSLog(@"Useridd11==%@",[defaults valueForKey:@"userid"]);
    
    NSLog(@"Useridd11==%@",[[AllArrayData objectAtIndex:0] valueForKey:@"challengersuserid3"]);
    
    
    if([[[AllArrayData objectAtIndex:0] valueForKey:@"challengersuserid2"]isEqualToString:@"0"] ||[[defaults valueForKey:@"userid"] isEqualToString:[[AllArrayData objectAtIndex:0] valueForKey:@"challengersuserid2"]])
    {
        
    }
    else
    {
        ProfilePageDetailsViewController * set=[self.storyboard instantiateViewControllerWithIdentifier:@"ProfilePageDetailsViewController"];
        set.userId_prof=[NSString stringWithFormat:@"%@",[[AllArrayData objectAtIndex:0]valueForKey:@"challengersuserid2"]];
        
        set.user_name=[NSString stringWithFormat:@"%@",[[AllArrayData objectAtIndex:0]valueForKey:@"challengersname2"]];
        
        set.user_imageUrl=[NSString stringWithFormat:@"%@",[[AllArrayData objectAtIndex:0]valueForKey:@"challengersprofilepic2"]];
        
       // set.Images_data=cell_TwoDetails.image_SecProfile1;
        [self.navigationController pushViewController:set animated:YES];
    }

}
-(void)image_SecProfile_ActionDetails2:(UIGestureRecognizer *)reconizer
{
    NSLog(@"Useridd11==%@",[defaults valueForKey:@"userid"]);
    
    NSLog(@"Useridd11==%@",[[AllArrayData objectAtIndex:0] valueForKey:@"challengersuserid3"]);
    
    
    if([[[AllArrayData objectAtIndex:0] valueForKey:@"challengersuserid3"]isEqualToString:@"0"] ||[[defaults valueForKey:@"userid"] isEqualToString:[[AllArrayData objectAtIndex:0] valueForKey:@"challengersuserid3"]])
    {
        
    }
    else
    {
        ProfilePageDetailsViewController * set=[self.storyboard instantiateViewControllerWithIdentifier:@"ProfilePageDetailsViewController"];
        set.userId_prof=[NSString stringWithFormat:@"%@",[[AllArrayData objectAtIndex:0]valueForKey:@"challengersuserid3"]];
        
        set.user_name=[NSString stringWithFormat:@"%@",[[AllArrayData objectAtIndex:0]valueForKey:@"challengersname3"]];
        
        set.user_imageUrl=[NSString stringWithFormat:@"%@",[[AllArrayData objectAtIndex:0]valueForKey:@"challengersprofilepic3"]];
        
       // set.Images_data=cell_TwoDetails.image_SecProfile2;
        [self.navigationController pushViewController:set animated:YES];
    }

}
-(void)image_SecProfile_ActionDetails:(UIGestureRecognizer *)reconizer
{
    NSLog(@"Useridd11==%@",[defaults valueForKey:@"userid"]);
    
     NSLog(@"Useridd11==%@",[[AllArrayData objectAtIndex:0] valueForKey:@"challengersuserid"]);
    
    
    if([[[AllArrayData objectAtIndex:0] valueForKey:@"challengersuserid"]isEqualToString:@"0"] ||[[defaults valueForKey:@"userid"] isEqualToString:[[AllArrayData objectAtIndex:0] valueForKey:@"challengersuserid"]])
  {
      
  }
    else
    {
      ProfilePageDetailsViewController * set=[self.storyboard instantiateViewControllerWithIdentifier:@"ProfilePageDetailsViewController"];
      set.userId_prof=[NSString stringWithFormat:@"%@",[[AllArrayData objectAtIndex:0]valueForKey:@"challengersuserid"]];
      
      set.user_name=[NSString stringWithFormat:@"%@",[[AllArrayData objectAtIndex:0]valueForKey:@"challengersname"]];
      
      set.user_imageUrl=[NSString stringWithFormat:@"%@",[[AllArrayData objectAtIndex:0]valueForKey:@"challengersprofilepic"]];
      
     // set.Images_data=cell_TwoDetails.image_SecProfile;
      [self.navigationController pushViewController:set animated:YES];
  }
    
 
    
}
-(void)image_FirstProfile_ActionDetails:(UIGestureRecognizer *)reconizer
{
    NSLog(@"Useridd11==%@",[defaults valueForKey:@"userid"]);
    
    NSLog(@"Useridd11==%@",[[AllArrayData objectAtIndex:0] valueForKey:@"challengersuserid"]);
    
    if([[defaults valueForKey:@"userid"] isEqualToString:[[AllArrayData objectAtIndex:0] valueForKey:@"userid1"]])
    {
       
    }
    else
    {
        ProfilePageDetailsViewController * set=[self.storyboard instantiateViewControllerWithIdentifier:@"ProfilePageDetailsViewController"];
        set.userId_prof=[NSString stringWithFormat:@"%@",[[AllArrayData objectAtIndex:0]valueForKey:@"userid1"]];
        
        set.user_name=[NSString stringWithFormat:@"%@",[[AllArrayData objectAtIndex:0]valueForKey:@"usersname"]];
        
        set.user_imageUrl=[NSString stringWithFormat:@"%@",[[AllArrayData objectAtIndex:0]valueForKey:@"usersprofilepic"]];
        
       // set.Images_data=cell_TwoDetails.image_SecProfile;
        [self.navigationController pushViewController:set animated:YES];
    }
    
    
    
}
-(void)ImageTapped_Vedioshare:(UIGestureRecognizer *)reconizer
{
    UIImageView *imageView = (UIImageView *)reconizer.view;
   
    
    NSString * texttoshare=[NSString stringWithFormat:@"%@%@",[[Array_showrecordvid objectAtIndex:(long)imageView.tag] valueForKey:@"name"],@" has posted a new challenge video. Download the app now - http://www.care2dareapp.com or View the challenge video here: "];
    
    NSURL * urltoshare=[NSURL URLWithString:[NSString stringWithFormat:@"%@",[[Array_showrecordvid objectAtIndex:(long)imageView.tag] valueForKey:@"videourl"]]];
    NSArray *activityItems1=@[texttoshare,urltoshare];
    NSArray *activityItems =@[UIActivityTypePrint,UIActivityTypeAirDrop,UIActivityTypeAssignToContact,UIActivityTypeAddToReadingList,UIActivityTypeOpenInIBooks];
    UIActivityViewController *activityViewControntroller = [[UIActivityViewController alloc] initWithActivityItems:activityItems1 applicationActivities:nil];
    activityViewControntroller.excludedActivityTypes = activityItems;
    //  [self.view addSubview:activityViewControntroller];
    [self presentViewController:activityViewControntroller animated:YES completion:nil];
}

-(void)ImageTapped_profileLikeVedio:(UIGestureRecognizer *)reconizer
{
    
    UIImageView *imageView = (UIImageView *)reconizer.view;
    str_Userid2val=[NSString stringWithFormat:@"%@",[[Array_showrecordvid objectAtIndex:(long)imageView.tag] valueForKey:@"useridvideo"]];
    
    
    
    
    
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
        
        
         NSString *vedioid= @"videoid";
        
        NSString *vedioidval=[NSString stringWithFormat:@"%@",[[Array_showrecordvid objectAtIndex:(long)imageView.tag] valueForKey:@"videoid"]];
        
        
        NSString *challengeid= @"challengeid";
        
        NSString *challengeidval=[NSString stringWithFormat:@"%@",[[Array_showrecordvid objectAtIndex:(long)imageView.tag] valueForKey:@"challengeid"]];
        
        NSString *reqStringFUll=[NSString stringWithFormat:@"%@=%@&%@=%@&%@=%@&%@=%@",userid1,useridval1,userid2,str_Userid2val,vedioid,vedioidval,challengeid,challengeidval];
        
        
        
#pragma mark - swipe sesion
        
        NSURLSession *session = [NSURLSession sessionWithConfiguration: [NSURLSessionConfiguration defaultSessionConfiguration] delegate: nil delegateQueue: [NSOperationQueue mainQueue]];
        
        NSURL *url;
        NSString *  urlStrLivecount=[urlplist valueForKey:@"like"];;
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
                                                     
                                                        Array_likes=[[NSMutableArray alloc]init];
                                                     SBJsonParser *objSBJsonParser = [[SBJsonParser alloc]init];
                                                Array_likes=[objSBJsonParser objectWithData:data];
                                                     
                                                     NSString * ResultString=[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
                                                     ResultString = [ResultString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
                                                     ResultString = [ResultString stringByReplacingOccurrencesOfString:@"\t" withString:@""];
                                                     
                                                     
                                                     NSLog(@"Array_AllData ResultString %@",ResultString);
                                                     
                                                   
                                                     
                                                     if (Array_likes.count !=0)
                                                     {
                                                         
                NSMutableDictionary *newDict = [[NSMutableDictionary alloc] init];
                NSDictionary *oldDict = (NSDictionary *)[Array_showrecordvid objectAtIndex:(long)imageView.tag];
                        [newDict addEntriesFromDictionary:oldDict];
            [newDict setObject:[[Array_likes objectAtIndex:0]valueForKey:@"totallikes"] forKey:@"totallikes"];
         [newDict setObject:[[Array_likes objectAtIndex:0]valueForKey:@"status"] forKey:@"likestatus"];
            [Array_showrecordvid replaceObjectAtIndex:(long)imageView.tag withObject:newDict];
                                                         
                                                         
// NSArray *indexPathArray = [NSArray arrayWithObject:[NSIndexPath indexPathForRow:1 inSection:0]];
// [tblview reloadRowsAtIndexPaths:indexPathArray withRowAnimation:UITableViewRowAnimationFade];
                                                         
                NSIndexPath* rowToReload = [NSIndexPath indexPathForRow:(long)imageView.tag inSection:3];
                NSArray* rowsToReload = [NSArray arrayWithObjects:rowToReload, nil];
    [Tableview_ContriBute reloadRowsAtIndexPaths:rowsToReload withRowAnimation:UITableViewRowAnimationNone];
                          //  [Tableview_ContriBute reloadData];
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
-(void)ImageTapped_profileFriendStatus:(UIGestureRecognizer *)reconizer
{
    
    UIImageView *imageView = (UIImageView *)reconizer.view;
     str_Userid2val=[NSString stringWithFormat:@"%@",[[Array_showrecordvid objectAtIndex:(long)imageView.tag] valueForKey:@"useridvideo"]];
 
    
   
    
    
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
        
        
        
        NSString *reqStringFUll=[NSString stringWithFormat:@"%@=%@&%@=%@",userid1,useridval1,userid2,str_Userid2val];
       
        
        
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
                                                     
                                                 //    Array_VediosData=[[NSMutableArray alloc]init];
                                                     SBJsonParser *objSBJsonParser = [[SBJsonParser alloc]init];
                                                    // Array_VediosData=[objSBJsonParser objectWithData:data];
                                                     
                                                     NSString * ResultString=[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
                                                     ResultString = [ResultString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
                                                     ResultString = [ResultString stringByReplacingOccurrencesOfString:@"\t" withString:@""];
                                                     
  
                                                     NSLog(@"Array_AllData ResultString %@",ResultString);
                                                     
                                        if ([ResultString isEqualToString:@"requested"])
                                            {
                                                        // [self Communication_showrecordVid];

                                                
            for (int i=0; i<Array_showrecordvid.count; i++)
            {
            if([[[Array_showrecordvid objectAtIndex:i] valueForKey:@"useridvideo"] isEqualToString:str_Userid2val])
            {
                                        
                    NSMutableDictionary *newDict = [[NSMutableDictionary alloc] init];
                    NSDictionary *oldDict = (NSDictionary *)[Array_showrecordvid objectAtIndex:i];
                        [newDict addEntriesFromDictionary:oldDict];
                    [newDict setObject:@"waiting" forKey:@"friendstatus"];
            [Array_showrecordvid replaceObjectAtIndex:i withObject:newDict];
                }
            }
                                                         
                            [Tableview_ContriBute reloadData];
                                                     }
                                                     if ([ResultString isEqualToString:@"alredyrequested"])
                                                     {
                                                        // Str_friendReq=@"";
                                                        //[Tableview_ContriBute reloadData];
                                                        // [self Communication_showrecordVid];
                                                         
                                                         
                                                         
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




-(void)ImageTapped_profile:(UIGestureRecognizer *)reconizer
{


    UIGestureRecognizer *recognizer = (UIGestureRecognizer*)reconizer;
    UIImageView *imageView = (UIImageView *)recognizer.view;
    
   str_ChallengeidVal=[NSString stringWithFormat:@"%@",[[Array_showrecordvid objectAtIndex:(long)imageView.tag] valueForKey:@"challengeid"]];
str_Userid2val1=[NSString stringWithFormat:@"%@",[[Array_showrecordvid objectAtIndex:(long)imageView.tag]valueForKey:@"useridvideo"]];
videoid1=[NSString stringWithFormat:@"%@",[[Array_showrecordvid objectAtIndex:(long)imageView.tag] valueForKey:@"videoid"]];

    
    NSURL *urlVedio = [NSURL URLWithString:[NSString stringWithFormat:@"%@",[[Array_showrecordvid objectAtIndex:(long)imageView.tag] valueForKey:@"videourl"]]];
    movieController = [[MPMoviePlayerViewController alloc] initWithContentURL:urlVedio];
    [self presentMoviePlayerViewControllerAnimated:movieController];
    [movieController.moviePlayer prepareToPlay];
    [movieController.moviePlayer play];
   // movieController.moviePlayer.shouldAutoplay =YES;
     [self ClienserverComm_watchView];
  
}
-(void)ImageTap_playButtonAction:(UIGestureRecognizer *)reconizer
{
NSURL *urlVedio = [NSURL URLWithString:[NSString stringWithFormat:@"%@",[[AllArrayData objectAtIndex:0] valueForKey:@"mediaurl"]]];
    movieController = [[MPMoviePlayerViewController alloc] initWithContentURL:urlVedio];
[self presentMoviePlayerViewControllerAnimated:movieController];
[movieController.moviePlayer prepareToPlay];
[movieController.moviePlayer play];
}
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    return textView.text.length + (text.length - range.length) <= 250;
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
        NSString *deletetypeval=@"CHALLENGE";
        
        NSString *VedioIds= @"deleteid";
        NSString *videoid1=[[AllArrayData valueForKey:@"challengeid"]objectAtIndex:0];
        
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
                                                     
                                                     
                                                     
                                                     
//                                                     SBJsonParser *objSBJsonParser = [[SBJsonParser alloc]init];
                                                     
                                                     NSString * ResultString=[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
                                                     
                                                     
                                                     ResultString = [ResultString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
                                                     
                                                     ResultString = [ResultString stringByReplacingOccurrencesOfString:@"\t" withString:@""];
                        if ([ResultString isEqualToString:@"done"])
                                                     {
                            UIAlertController * alert=[UIAlertController alertControllerWithTitle:@"Deleted" message:@"Your challenge has been successfully deleted!"preferredStyle:UIAlertControllerStyleAlert];
                        UIAlertAction* yesButton = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action)
                                    {
                                        
                        [defaults setObject:@"yes" forKey:@"ExpView_Update"];
                                [defaults synchronize];
                                        [self ButtonBack_Action:nil];
                                        
                                        
                                                                                     }];
                                                         
                                                         [alert addAction:yesButton];
                                                         
                                                         [self presentViewController:alert animated:YES completion:nil];
                                                         
                                                         
                                                     }
                                                     if ([ResultString isEqualToString:@"deleteerror"])
                                                     {
                                                         UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Oops" message:@"The challenge could not be deleted. Please try again." preferredStyle:UIAlertControllerStyleAlert];
                                                         
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
        NSString *FlagTypeval=@"CHALLENGE";
        
        NSString *VedioIds= @"flagid";
        NSString *videoid1=[[AllArrayData valueForKey:@"challengeid"]objectAtIndex:0];
        
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
                                                     
                                                     
                                                     
                                                     
//                                                     SBJsonParser *objSBJsonParser = [[SBJsonParser alloc]init];
                                                     
                                                     NSString * ResultString=[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
                                                     
                                                     
                                                     ResultString = [ResultString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
                                                     ResultString = [ResultString stringByReplacingOccurrencesOfString:@"\t" withString:@""];
                                                     
                                                     if ([ResultString isEqualToString:@"done"])
                                                     {
                                                         
                                                         UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Flagged" message:@"The concerned challenge has been flagged and the team will review it and take appropriate action. Thank-you for the heads up!" preferredStyle:UIAlertControllerStyleAlert];
                                                         
                                                         UIAlertAction *actionOk = [UIAlertAction actionWithTitle:@"Ok"
                                                                                                            style:UIAlertActionStyleDefault
                                                                                                          handler:nil];
                                                         [alertController addAction:actionOk];
                                                         [self presentViewController:alertController animated:YES completion:nil];
                                                     }
                                                     if ([ResultString isEqualToString:@"deleteerror"])
                                                     {
                                                         UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Oops" message:@"The challenge could not be flagged. Please try again." preferredStyle:UIAlertControllerStyleAlert];
                                                         
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
        
        NSString *reqStringFUll=[NSString stringWithFormat:@"%@=%@&%@=%@&%@=%@&%@=%@",userid1,useridVal1,userid2,str_Userid2val1,challengeid,str_ChallengeidVal,vedioids,videoid1];
        
        
        
        
        
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
-(void)Tablview_Tuched:(UIGestureRecognizer *)reconizer
{
    [self.view endEditing:YES];
}
@end
