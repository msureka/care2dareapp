//
//  CreateNewChallengesViewController.m
//  care2Dare
//
//  Created by Spiel's Macmini on 3/8/17.
//  Copyright © 2017 Spiel's Macmini. All rights reserved.
//c

#import "CreateNewChallengesViewController.h"
#import "Base64.h"
#import <AVFoundation/AVFoundation.h>
#import "Reachability.h"
#import "SBJsonParser.h"
#import "UIView+RNActivityView.h"
#import "SDAVAssetExportSession.h"
#import "AppDelegate.h"
@interface CreateNewChallengesViewController ()<UITextViewDelegate,UIAlertViewDelegate,UITextFieldDelegate,NSURLSessionDelegate>
{
    NSURLSessionDataTask *dataTaskupload;
    
    NSUserDefaults *defaults;
    float pixelsPerValue;
    float leftAdjust;
    NSString * viewCheck,*String_Cont_Name,*MoneyString,*_String_Cont_UserId,*challengetypeVal,*mediatypeVal,* CheckDivMul,*Strin_Pay_Req_Type,*Str_paiduserid,*assettype,*StrCommaCount,*encodedImage,*encodedImageThumb,*strInvite_users,*strCameraVedio,*SelectGallery,* ImageNSdata,*ImageNSdataThumb,*strinRetake,* GalStr,*CameraStr,*RecordStr,*challengetypeValDonate;;
    
    NSMutableArray * array_CreateChallenges;
    
    MHFacebookImageViewer * Controller;
    UIImage *FrameImage;
    NSDictionary *urlplist;
    
    UIGestureRecognizer * TabGestureDetailView, *tapGestureText,*BackImageGesture,*RecordVedioTabGesture;
    NSNumber *Vedio_Height,*Vedio_Width,*BitrateValue;
    UIImage *chosenImage;
    NSData *imageData,*imageDataThumb;
    UILabel * Label_confirm1;
     UILabel * Label_confirm11;
     UILabel * Label_confirm;
    UIView * transperentViewIndicator,*whiteView1,* transperentViewIndicator11,*whiteView111;
    CGFloat keyboardheight;
    UIActivityIndicatorView * indicatorAlert;
    float sum;
    int count;
    MPMoviePlayerViewController * movieController;
    
    UIView *headerView2,*headerView1;
    UIButton *headerLabel1,* headerLabel2;
    UIImagePickerController * pcker1;
    UIImagePickerController *cameraUI;
    UIButton *Button_close;
    int remainingCounts;
    //NSTimer *videoTimer;
}
//@property (nonatomic, retain) NSTimer *videoTimer;
@end

@implementation CreateNewChallengesViewController
@synthesize Array_Names,Array_UserId,BackroundImg,Image_Play,Image_Donate,Image_Raised,Label_Donate,Label_Raised,Label_Raise_DonateTextheading;
@synthesize slider_Days,Label_Currentsdays;
- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    
    
    NSString *plistPath = [[NSBundle mainBundle]pathForResource:@"UrlName" ofType:@"plist"];
    urlplist = [NSDictionary dictionaryWithContentsOfFile:plistPath];
    
    
    defaults=[[NSUserDefaults alloc]init];
    
    BackroundImg.clipsToBounds=YES;
    BackroundImg.layer.cornerRadius=9.0f;
    BackroundImg.userInteractionEnabled=YES;
    BackroundImg.hidden=YES;
    
    BackImageGesture =[[UITapGestureRecognizer alloc] initWithTarget:self
                                                              action:@selector(BackImageViewTap:)];
    [BackroundImg addGestureRecognizer:BackImageGesture];
    
    challengetypeVal=@"PUBLIC";
    challengetypeValDonate=@"RAISE";
    Label_Raise_DonateTextheading.text=@"How much do you want to raise? (Optional)";
    
    
    Image_Play.hidden=YES;
    
    
    

    
    _Label_totalAmount.hidden=YES;
    
    
   
    
    
    // Do any additional setup after loading the view.
    defaults=[[NSUserDefaults alloc]init];
    Label_Currentsdays.text=[NSString stringWithFormat:@"%.f%@%@",slider_Days.value,@" ",@"day"];
    float width = slider_Days.frame.size.width;
    pixelsPerValue = width / (slider_Days.maximumValue - slider_Days.minimumValue);
    leftAdjust = slider_Days.frame.origin.x-Label_Currentsdays.frame.size.width;
    NSLog(@"changedLabel_Curreviedid==%f",Label_Currentsdays.frame.origin.x);
    //    CGAffineTransform transform = CGAffineTransformMakeScale(1.0f, 1.5f);
    //    slider_Days.transform = transform;
    
    
    
    //    [slider setMaximumTrackImage:[[UIImage imageNamed:@"max.png"]
    //                                  resizableImageWithCapInsets:UIEdgeInsetsMake(0, 20, 0, 20)]
    //                        forState:UIControlStateNormal];
    //    [slider setMinimumTrackImage:[[UIImage imageNamed:@"min.png"]
    //                                  resizableImageWithCapInsets:UIEdgeInsetsMake(0, 20, 0, 20)]
    //                        forState:UIControlStateNormal];
    //   [slider_Days setThumbImage:[UIImage imageNamed:@"greenslider.png"]                forState:UIControlStateNormal];
    
//    CALayer*  borderBottom_topheder = [CALayer layer];
//    borderBottom_topheder.backgroundColor =[UIColor colorWithRed:241/255.0 green:241/255.0 blue:241/255.0 alpha:1.0].CGColor;
//    borderBottom_topheder.frame = CGRectMake(0, _view_SliderTimes.frame.size.height-1, _view_SliderTimes.frame.size.width,1);
//    [_view_SliderTimes.layer addSublayer:borderBottom_topheder];
    CALayer *borderTop = [CALayer layer];
    borderTop.backgroundColor = [UIColor colorWithRed:241/255.0 green:241/255.0 blue:241/255.0 alpha:1.0].CGColor;
    
    borderTop.frame = CGRectMake(0, 0, _view_SliderTimes.frame.size.width, 1);
    [_view_SliderTimes.layer addSublayer:borderTop];
    _Label_Public.userInteractionEnabled=YES;
    _Label_Private.userInteractionEnabled=YES;
    _Image_Public.userInteractionEnabled=YES;
    _Image_Private.userInteractionEnabled=YES;
    
    
    
    Label_Raised.userInteractionEnabled=YES;
    Label_Donate.userInteractionEnabled=YES;
    Image_Raised.userInteractionEnabled=YES;
    Image_Donate.userInteractionEnabled=YES;
    
    
    UITapGestureRecognizer *LabelTap_public =[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(LabelTap_publicTapped:)];
    [_Label_Public addGestureRecognizer:LabelTap_public];
    
    UITapGestureRecognizer *LabelTap_private =[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(LabelTap_privateTapped:)];
    [_Label_Private addGestureRecognizer:LabelTap_private];
    
    UITapGestureRecognizer *ImageTap_public =[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(LabelTap_publicTapped:)];
    [_Image_Public addGestureRecognizer:ImageTap_public];
    
    UITapGestureRecognizer *ImageTap_private =[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(LabelTap_privateTapped:)];
    [_Image_Private addGestureRecognizer:ImageTap_private];
    
    _Label_Public.textColor=[UIColor colorWithRed:67/255.0 green:188/255.0 blue:255/255.0 alpha:1];
    _Label_Private.textColor=[UIColor colorWithRed:186/255.0 green:188/255.0 blue:190/255.0 alpha:1];
    [_Image_Public setImage:[UIImage imageNamed:@"blueworld.png"]];
    [_Image_Private setImage:[UIImage imageNamed:@"private.png"]];
    
    
    
    UITapGestureRecognizer *LabelTap_raised =[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(LabelTap_RaisedTapped:)];
    [Label_Raised addGestureRecognizer:LabelTap_raised];
    
    UITapGestureRecognizer *LabelTap_Donate =[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(LabelTap_DonateTapped:)];
    [Label_Donate addGestureRecognizer:LabelTap_Donate];
    
    UITapGestureRecognizer *ImageTap_Donate =[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(LabelTap_DonateTapped:)];
    [Image_Donate addGestureRecognizer:ImageTap_Donate];
    
    UITapGestureRecognizer *ImageTap_Raised =[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(LabelTap_RaisedTapped:)];
    [Image_Raised addGestureRecognizer:ImageTap_Raised];
    
    Label_Raised.textColor=[UIColor colorWithRed:67/255.0 green:188/255.0 blue:255/255.0 alpha:1];
    Label_Donate.textColor=[UIColor colorWithRed:186/255.0 green:188/255.0 blue:190/255.0 alpha:1];
    [Image_Raised setImage:[UIImage imageNamed:@"raiseblue.png"]];
    [Image_Donate setImage:[UIImage imageNamed:@"donategrey.png"]];
    
    //donateblue
    //donategrey
    //raiseblue
    //raisegrey.png
    
    _Label_ChallengesName.userInteractionEnabled=YES;
    
    NSLog(@"flaaaaag==%@",[defaults valueForKey:@"flag"]);
  
    if ( ![[defaults valueForKey:@"flag"]isEqualToString:@"yes"])
    {
         _Label_ChallengesName.text=@"add friends";
        
    }
    else
    {
        
        NSLog(@"defaults valueForKey:username==%@",[defaults valueForKey:@"usernames"]);
        NSString * Str_ArrayUsernames=[defaults valueForKey:@"usernames"];
        
        _Label_ChallengesName.text=[defaults valueForKey:@"usernames"];
        
        if (![Str_ArrayUsernames isEqualToString:@""])
        {
            
        
        Array_Names=[[NSMutableArray arrayWithObjects:[defaults valueForKey:@"usernames"], nil]mutableCopy];
        
        Array_UserId=[[NSMutableArray arrayWithObjects:[defaults valueForKey:@"userids"], nil]mutableCopy];
        }

//        [defaults setObject:userId_prof forKey:@"userids"];
    }
   
    _Label_ChallengesName.font=[UIFont fontWithName:@"SanFranciscoDisplay-Bold" size:24];
    
    _Label_ChallengesName.textColor=[UIColor colorWithRed:186/255.0 green:188/255.0 blue:190/255.0 alpha:1];
    
    
    UITapGestureRecognizer *LabelTap_Label_ChallengesName =[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(_Label_ChallengesName_Tapped:)];
    [_Label_ChallengesName addGestureRecognizer:LabelTap_Label_ChallengesName];
    _startScreenScrollView.userInteractionEnabled=YES;
    UITapGestureRecognizer *startScreenScrollView_Tapp =[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startScreenScrollViewTapped:)];
    [_startScreenScrollView addGestureRecognizer:startScreenScrollView_Tapp];

    
    
    
    _Label_ChallengesName.textColor = [UIColor lightGrayColor];
    _Button_Create.enabled=NO;
     [_Button_Create setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    _Button_Create.backgroundColor=[UIColor colorWithRed:241/255.0 green:241/255.0 blue:241/255.0 alpha:1];
    
    _Textview_Desc.delegate=self;
    _Textview_Desc.text =@"Challenge description";//@"title goes here";
    self.startScreenScrollView.scrollEnabled=NO;
    _Textview_Desc.textColor = [UIColor colorWithRed:65/255.0 green:65/255.0 blue:65/255.0 alpha:1];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(dataReceived:) name:@"PassDataArray" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(dataReceivedId:) name:@"PassDataArrayUserId" object:nil];
    
 
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
    
 
    
    
    transperentViewIndicator11=[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    transperentViewIndicator11.backgroundColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.5];
    
    whiteView111=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 150,150)];
    whiteView111.center=transperentViewIndicator11.center;
    [whiteView111 setBackgroundColor:[UIColor blackColor]];
    whiteView111.layer.cornerRadius=9;
    //   indicatorAlert = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    //    indicatorAlert.frame=CGRectMake(40, 40, 20, 20);
    //    [indicatorAlert startAnimating];
    //    [indicatorAlert setColor:[UIColor whiteColor]];
    
    Label_confirm11=[[UILabel alloc]initWithFrame:CGRectMake(0, 50, 150, 40)];
    
    [Label_confirm11 setFont:[UIFont systemFontOfSize:12]];
    Label_confirm11.text=@"0 %";
    Label_confirm11.font=[UIFont fontWithName:@"SanFranciscoDisplay-Bold" size:40.0];
    Label_confirm11.textColor=[UIColor whiteColor];
    Label_confirm11.textAlignment=NSTextAlignmentCenter;
    
    Label_confirm=[[UILabel alloc]initWithFrame:CGRectMake(0, 110, 150, 28)];
    
    [Label_confirm setFont:[UIFont systemFontOfSize:12]];
    Label_confirm.text=@"Creating...";
    Label_confirm.font=[UIFont fontWithName:@"SanFranciscoDisplay-Bold" size:20.0];
    Label_confirm.textColor=[UIColor whiteColor];
    Label_confirm.textAlignment=NSTextAlignmentCenter;
    
    Button_close=[[UIButton alloc]initWithFrame:CGRectMake(whiteView111.frame.size.width-23, -4, 28,28)];
    Button_close.layer.cornerRadius=Button_close.frame.size.height/2;
    
    Button_close.backgroundColor=[UIColor whiteColor];
    [Button_close setTitle:@"X" forState:UIControlStateNormal];
    [Button_close setTitleColor:[UIColor redColor]forState:UIControlStateNormal];
    Button_close.titleLabel.font=[UIFont fontWithName:@"SanFranciscoDisplay-Bold" size:14.0];
    [Button_close addTarget:self action:@selector(UploadinView_Close:) forControlEvents:UIControlEventTouchUpInside];
    [whiteView111 addSubview:Button_close];
    [whiteView111 addSubview:Label_confirm];
    [whiteView111 addSubview:Label_confirm11];
    
    [transperentViewIndicator11 addSubview:whiteView111];
    
    [self.view addSubview:transperentViewIndicator11];
    
    transperentViewIndicator11.hidden=YES;
   
 BitrateValue=@750000;
    
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
                                    transperentViewIndicator11.hidden=NO;
                                    
                                }];
    UIAlertAction* noButton = [UIAlertAction
                               actionWithTitle:@"Cancel"
                               style:UIAlertActionStyleDefault
                               handler:^(UIAlertAction * action)
                               {
                                   
                                   [dataTaskupload cancel];
                                   transperentViewIndicator11.hidden=YES;
                               }];
    
    [alert addAction:yesButton];
    [alert addAction:noButton];
    
    [self presentViewController:alert animated:YES completion:nil];
    
    
    
}


- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task
   didSendBodyData:(int64_t)bytesSent
    totalBytesSent:(int64_t)totalBytesSent
totalBytesExpectedToSend:(int64_t)totalBytesExpectedToSend
{
    float progress = ((double)totalBytesSent / (double)totalBytesExpectedToSend)*100;
    NSLog(@"percentage  of dattataa==%f",progress);
    Label_confirm11.text=[NSString stringWithFormat:@"%.f%@",progress,@" %"];
}
- (void)_Label_ChallengesName_Tapped:(UITapGestureRecognizer *)recognizer
{
    InviteSprintTagUserViewController * set=[self.storyboard instantiateViewControllerWithIdentifier:@"InviteSprintTagUserViewController"];
    if (Array_Names.count!=0)
    {
        
          NSDictionary *theInfo = [NSDictionary dictionaryWithObjectsAndKeys:Array_Names,@"descBack", nil];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"PassDataArrayBack" object:self
                                                              userInfo:theInfo];
            set.Names=Array_Names;
            set.Names_UserId=Array_UserId;

       
               [self.navigationController pushViewController:set animated:YES];
    }
    else
    {
        [self.navigationController pushViewController:set animated:YES];
    }
    
    
    //[self performSegueWithIdentifier:@"next" sender:self];
}



- (void)LabelTap_RaisedTapped:(UITapGestureRecognizer *)recognizer
{

    challengetypeValDonate=@"RAISE";
    Label_Raise_DonateTextheading.text=@"How much do you want to raise?(Optional)";
    
    
    [Image_Raised setImage:[UIImage imageNamed:@"raiseblue.png"]];
    [Image_Donate setImage:[UIImage imageNamed:@"donategrey.png"]];
    Label_Raised.textColor=[UIColor colorWithRed:67/255.0 green:188/255.0 blue:255/255.0 alpha:1];
    Label_Donate.textColor=[UIColor colorWithRed:186/255.0 green:188/255.0 blue:190/255.0 alpha:1];
    
       _Label_totalAmount.text=[NSString stringWithFormat:@"%@%@",@"total: $ ",_Textfield_Amount.text];
     _Label_totalAmount.hidden=YES;
}
- (void)LabelTap_DonateTapped:(UITapGestureRecognizer *)recognizer
{
    
    
    
    
    challengetypeValDonate=@"DONATE";
    Label_Raise_DonateTextheading.text=@"Donation to each challenger";
    
    [Image_Raised setImage:[UIImage imageNamed:@"raisegrey.png"]];
    [Image_Donate setImage:[UIImage imageNamed:@"donateblue.png"]];
    Label_Donate.textColor=[UIColor colorWithRed:67/255.0 green:188/255.0 blue:255/255.0 alpha:1];
    Label_Raised.textColor=[UIColor colorWithRed:186/255.0 green:188/255.0 blue:190/255.0 alpha:1];
    
    //CGFloat calculate=[_Textfield_Amount.text floatValue]*(Array_Names.count);
    
//    if ([_Textfield_Amount.text isEqualToString:@""] || calculate<=0)
//    {
//        _Label_totalAmount.hidden=YES;
//    }
//    else
//    {
        _Label_totalAmount.text=[NSString stringWithFormat:@"%@%.f",@"total: $ ",[_Textfield_Amount.text floatValue]*(Array_Names.count)];
        
        _Label_totalAmount.hidden=NO;
        
  //  }
   

    
}

- (void)LabelTap_publicTapped:(UITapGestureRecognizer *)recognizer
{
    [self.view endEditing:YES];
    challengetypeVal=@"PUBLIC";
    [_Image_Public setImage:[UIImage imageNamed:@"blueworld.png"]];
    [_Image_Private setImage:[UIImage imageNamed:@"private.png"]];
    _Label_Public.textColor=[UIColor colorWithRed:67/255.0 green:188/255.0 blue:255/255.0 alpha:1];
    _Label_Private.textColor=[UIColor colorWithRed:186/255.0 green:188/255.0 blue:190/255.0 alpha:1];
}
- (void)LabelTap_privateTapped:(UITapGestureRecognizer *)recognizer
{
    [self.view endEditing:YES];
    challengetypeVal=@"PRIVATE";
    [_Image_Public setImage:[UIImage imageNamed:@"profile_world.png"]];
    [_Image_Private setImage:[UIImage imageNamed:@"blueprivate.png"]];
    _Label_Private.textColor=[UIColor colorWithRed:67/255.0 green:188/255.0 blue:255/255.0 alpha:1];
    _Label_Public.textColor=[UIColor colorWithRed:186/255.0 green:188/255.0 blue:190/255.0 alpha:1];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(IBAction)ButtonBack_Action:(id)sender
{
    [self.view endEditing:YES];
    [defaults setObject:@"no" forKey:@"ExpView_Update"];
    [defaults setObject:@"no" forKey:@"falg"];
    [defaults setObject:@"" forKey:@"usernames"];
    [defaults setObject:@"" forKey:@"userids"];
    [defaults synchronize];
    
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
    // [self dismissViewControllerAnimated:YES completion:nil];
    
    // [self.navigationController popViewControllerAnimated:YES];
    //   [self.tabBarController setSelectedIndex:4];
    //    NSInteger tabindex=[[defaults valueForKey:@"tabchk"] integerValue];
    //     [(UITabBarController*)self.navigationController.topViewController setSelectedIndex:tabindex];
    //    NSLog(@"tabindexxxxx=%ld",(long)tabindex);
}

- (IBAction)progressSliderSlides:(id)sender
{
    NSInteger sliderVal=[[NSString stringWithFormat:@"%.f",slider_Days.value]integerValue];
    if (sliderVal<2)
    {
        Label_Currentsdays.text=[NSString stringWithFormat:@"%.f%@%@",slider_Days.value,@" ",@"day"];
    }
    else
    {
        Label_Currentsdays.text=[NSString stringWithFormat:@"%.f%@%@",slider_Days.value,@" ",@"days"];
    }
    NSLog(@"changed==%f",slider_Days.value);
//    
//    CGRect frame = Label_Currentsdays.frame;
//    frame.origin.x = leftAdjust + (5 * slider_Days.value)+33;
//    Label_Currentsdays.frame = frame;
    CGRect trackRect = [slider_Days trackRectForBounds:slider_Days.bounds];
    
    CGRect thumbRect = [slider_Days thumbRectForBounds:slider_Days.bounds
                                             trackRect:trackRect
                                                 value:slider_Days.value];
    
    Label_Currentsdays.center = CGPointMake(15+thumbRect.origin.x + slider_Days.frame.origin.x, slider_Days.frame.origin.y-10);
    NSLog(@"changedLabel_Currentsdays==%f",Label_Currentsdays.frame.origin.x);
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [_Textview_Desc resignFirstResponder];
    
    [_Textfield_Amount resignFirstResponder];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self subscribeToKeyboard];
    if (Array_Names.count !=0)
    {
        
        //_Label_totalAmount.hidden=NO;
       // _Label_totalAmount.text=[NSString stringWithFormat:@"%@%.f",@"total: $ ",[_Textfield_Amount.text floatValue]*(Array_Names.count)];
        _Label_ChallengesName.font=[UIFont fontWithName:@"SanFranciscoDisplay-Medium" size:20];
        _Label_ChallengesName.textColor=[UIColor colorWithRed:65/255.0 green:65/255.0 blue:65/255.0 alpha:1];
        
        if (Array_Names.count==1)
        {
            
            
            _Label_ChallengesName.text=[NSString stringWithFormat:@"%@",[Array_Names objectAtIndex:0]];
        }
        else
        {
            
            _Label_ChallengesName.text=[NSString stringWithFormat:@"%@%@%lu%@",[Array_Names objectAtIndex:0],@" & ",(unsigned long)Array_Names.count-1,@" more"];
        }
        if ([challengetypeValDonate isEqualToString:@"DONATE"])
        {
            
            _Label_totalAmount.text=[NSString stringWithFormat:@"%@%.f",@"total: $ ",[_Textfield_Amount.text floatValue]*(Array_Names.count)];
            _Label_totalAmount.hidden=NO;
        }
        else
        {
            _Label_totalAmount.text=[NSString stringWithFormat:@"%@%.f",@"total: $ ",[_Textfield_Amount.text floatValue]];
            
            _Label_totalAmount.hidden=YES;
        }
    }
    else
    {
//        if ( ![[defaults valueForKey:@"flag"]isEqualToString:@"yes"])
//        {
//            _Label_ChallengesName.text=@"add friends";
//            
//        }
//        else
//        {
//            _Label_ChallengesName.text=[defaults valueForKey:@"usernames"];
//            //        [defaults setObject:userId_prof forKey:@"userids"];
//        }
       
       _Label_ChallengesName.text=@"add friends";
        _Label_ChallengesName.font=[UIFont fontWithName:@"SanFranciscoDisplay-Bold" size:24];
        
        _Label_ChallengesName.textColor=[UIColor colorWithRed:186/255.0 green:188/255.0 blue:190/255.0 alpha:1];
        
        if ([challengetypeValDonate isEqualToString:@"DONATE"])
        {

            _Label_totalAmount.text=[NSString stringWithFormat:@"%@%.f",@"total: $ ",[_Textfield_Amount.text floatValue]*(Array_Names.count)];
            _Label_totalAmount.hidden=NO;
        }
        else
        {
            _Label_totalAmount.text=[NSString stringWithFormat:@"%@%.f",@"total: $ ",[_Textfield_Amount.text floatValue]];

            _Label_totalAmount.hidden=YES;
        }
    }
    
}
- (void)subscribeToKeyboard
{
    [self an_subscribeKeyboardWithAnimations:^(CGRect keyboardRect, NSTimeInterval duration, BOOL isShowing) {
        if (isShowing) {
            self.tabBarBottomSpace.constant = CGRectGetHeight(keyboardRect);
            keyboardheight= CGRectGetHeight(keyboardRect);
            [self.startScreenScrollView setContentSize:CGSizeMake(self.startScreenScrollView.frame.size.width,30+self.startScreenScrollView.frame.size.height+keyboardheight)];
            self.startScreenScrollView.scrollEnabled=YES;
            
            NSLog(@"Scroll view height11==%f",self.startScreenScrollView.frame.size.height);
            NSLog(@"Scroll view xxx11==%f",self.startScreenScrollView.frame.origin.x);
            NSLog(@"Scroll view yyy11==%f",self.startScreenScrollView.frame.origin.y);
            
        } else
        {
            self.startScreenScrollView.scrollEnabled=YES;
            [self.startScreenScrollView setContentSize:CGSizeMake(self.startScreenScrollView.frame.size.width,self.startScreenScrollView.frame.size.height-keyboardheight)];
            self.tabBarBottomSpace.constant = 0.0f;
            NSLog(@"Scroll view height22==%f",self.startScreenScrollView.frame.size.height);
            NSLog(@"Scroll view xxx22==%f",self.startScreenScrollView.frame.origin.x);
            NSLog(@"Scroll view yyy22==%f",self.startScreenScrollView.frame.origin.y);
        }
        [self.view layoutIfNeeded];
    } completion:nil];
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self an_unsubscribeKeyboard];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    
    return YES;
}
-(IBAction)ButtonHelp_Action:(id)sender
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Tip" message:@"Dare the World or your friends by creating a challenge!" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *actionOk = [UIAlertAction actionWithTitle:@"Ok"style:UIAlertActionStyleDefault handler:nil];
    [alertController addAction:actionOk];
    [self presentViewController:alertController animated:YES completion:nil];
}
-(IBAction)ButtonGallery_Action:(id)sender
{
    SelectGallery=@"Gal";
    
    
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary])
    {
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        //[picker setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
        picker.sourceType =  UIImagePickerControllerSourceTypePhotoLibrary;
        picker.allowsEditing = NO;
        
        [self presentViewController:picker animated:true completion:nil];
    }
    
}
-(IBAction)ButtonCammera_Action:(id)sender
{
    SelectGallery=@"Cam";
    strCameraVedio=@"cam";
    self.Button_Gallery.hidden=YES;
    self.Button_Videos.hidden=YES;
    self.Button_Cammera.hidden=YES;
    
    
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = NO;
    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    
    [self presentViewController:picker animated:true completion:nil];
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
-(void)createChallengesComm
{
    
    [self.view endEditing:YES];
    
    if ([challengetypeVal isEqualToString:@"PRIVATE"])
    {
        if (Array_Names.count==0)
        {
            
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Add friends" message:@"Please add your friends who you would like to challenge. In Private Challenge, it is mandatory to add a friend." preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction *actionOk = [UIAlertAction actionWithTitle:@"Ok"style:UIAlertActionStyleDefault handler:^(UIAlertAction *action)
                                       {
                                           InviteSprintTagUserViewController * set=[self.storyboard instantiateViewControllerWithIdentifier:@"InviteSprintTagUserViewController"];
                                           
                                           [self.navigationController pushViewController:set animated:YES];
                                           
                                       }];
            [alertController addAction:actionOk];
            [self presentViewController:alertController animated:YES completion:nil];
            
        }
        else
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
                // [self.view showActivityViewWithLabel:@"Loading"];
                transperentViewIndicator11.hidden=NO;
                Label_confirm11.text=@"0 %";
                NSString *userid= @"userid";
                NSString *useridVal =[defaults valueForKey:@"userid"];
                
                
                NSString *title= @"title";
                NSString *titleVal =(NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(NULL,(CFStringRef)_Textview_Desc.text,NULL,(CFStringRef)@"!*\"();:@&=+$,/?%#[]% ",CFStringConvertNSStringEncodingToEncoding(NSUTF8StringEncoding)));;
                
                NSString *challengetype= @"challengetype";
                NSString *contributiontype= @"contributiontype";
                
                NSString *mediatype= @"mediatype";
                
                
                NSString *enddays= @"enddays";
                NSString *enddaysVal =[NSString stringWithFormat:@"%.f",slider_Days.value];
                
                NSString *payperchallenger= @"payperchallenger";
                NSString *payperchallengerVal =_Textfield_Amount.text;
                
                
                
                
                NSString *noofchallengers= @"noofchallengers";
                NSString *noofchallengersVal;
                
                noofchallengersVal=[NSString stringWithFormat:@"%lu",(unsigned long)Array_Names.count];
                
                
                NSString *challengerslist= @"challengerslist";
                //
                
                NSString *media= @"media";
                
                NSString *mediaimagethumb=@"mediathumbnail";
                
                
                NSString *reqStringFUll=[NSString stringWithFormat:@"%@=%@&%@=%@&%@=%@&%@=%@&%@=%@&%@=%@&%@=%@&%@=%@&%@=%@&%@=%@&%@=%@",userid,useridVal,title,titleVal,challengetype,challengetypeVal,contributiontype,challengetypeValDonate,mediatype,mediatypeVal,enddays,enddaysVal,payperchallenger,payperchallengerVal,noofchallengers,noofchallengersVal,challengerslist,_String_Cont_UserId,media,encodedImage,mediaimagethumb,encodedImageThumb];
                
                
                
#pragma mark - swipe sesion
                
                NSURLSession *session = [NSURLSession sessionWithConfiguration: [NSURLSessionConfiguration defaultSessionConfiguration] delegate:self delegateQueue: [NSOperationQueue mainQueue]];
                
                NSURL *url;
                NSString *  urlStrLivecount=[urlplist valueForKey:@"createchallenge"];;
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
                                             
                                             array_CreateChallenges=[[NSMutableArray alloc]init];
                                             SBJsonParser *objSBJsonParser = [[SBJsonParser alloc]init];
                                             array_CreateChallenges=[objSBJsonParser objectWithData:data];
                                             NSString * ResultString=[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
                                             //        Array_LodingPro=[NSJSONSerialization JSONObjectWithData:webData_Swipe options:kNilOptions error:nil];
                                             
                                             ResultString = [ResultString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
                                             ResultString = [ResultString stringByReplacingOccurrencesOfString:@"\t" withString:@""];
                                             
                                             NSLog(@"array_CreateChallenges %@",array_CreateChallenges);
                                             
                                             
                                             NSLog(@"array_CreateChallenges ResultString %@",ResultString);
                                             if ([ResultString isEqualToString:@"nouserid"])
                                             {
                                                 transperentViewIndicator11.hidden=YES;;
                                                 UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Oops" message:@"Your account does not exist or seems to have been suspended. Please contact admin." preferredStyle:UIAlertControllerStyleAlert];
                                                 
                                                 UIAlertAction *actionOk = [UIAlertAction actionWithTitle:@"Ok"
                                                                                                    style:UIAlertActionStyleDefault
                                                                                                  handler:nil];
                                                 [alertController addAction:actionOk];
                                                 [self presentViewController:alertController animated:YES completion:nil];
                                                 
                                                 
                                             }
                                             if ([ResultString isEqualToString:@"nomedia"])
                                             {
                                                 transperentViewIndicator11.hidden=YES;;
                                                 UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Oops" message:@"Please insert an image or video and try again." preferredStyle:UIAlertControllerStyleAlert];
                                                 
                                                 UIAlertAction *actionOk = [UIAlertAction actionWithTitle:@"Ok"
                                                                                                    style:UIAlertActionStyleDefault
                                                                                                  handler:nil];
                                                 [alertController addAction:actionOk];
                                                 [self presentViewController:alertController animated:YES completion:nil];
                                                 
                                                 
                                             }
                                             
                                             if ([ResultString isEqualToString:@"nullerror"])
                                             {
                                                 transperentViewIndicator11.hidden=YES;
                                                 UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Oops" message:@"Please enter all details and try again." preferredStyle:UIAlertControllerStyleAlert];
                                                 
                                                 UIAlertAction *actionOk = [UIAlertAction actionWithTitle:@"Ok"
                                                                                                    style:UIAlertActionStyleDefault
                                                                                                  handler:nil];
                                                 [alertController addAction:actionOk];
                                                 [self presentViewController:alertController animated:YES completion:nil];
                                                 
                                                 
                                                 
                                                 
                                             }
                                             if ([ResultString isEqualToString:@"imageerror"])
                                             {
                                                 transperentViewIndicator11.hidden=YES;
                                                 UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Oops" message:@"There was an error in uploading your media. Please try again." preferredStyle:UIAlertControllerStyleAlert];
                                                 
                                                 UIAlertAction *actionOk = [UIAlertAction actionWithTitle:@"Ok"
                                                                                                    style:UIAlertActionStyleDefault
                                                                                                  handler:nil];
                                                 [alertController addAction:actionOk];
                                                 [self presentViewController:alertController animated:YES completion:nil];
                                                 
                                                 
                                                 
                                                 
                                             }
                                             if ([ResultString isEqualToString:@"inserterror"])
                                             {
                                                 transperentViewIndicator11.hidden=YES;
                                                 UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Oops" message:@"There was an error in creating your challenge. Please try again." preferredStyle:UIAlertControllerStyleAlert];
                                                 
                                                 UIAlertAction *actionOk = [UIAlertAction actionWithTitle:@"Ok"
                                                                                                    style:UIAlertActionStyleDefault
                                                                                                  handler:nil];
                                                 [alertController addAction:actionOk];
                                                 [self presentViewController:alertController animated:YES completion:nil];
                                                 
                                                 
                                                 
                                                 
                                             }
                                             
                                             if ([ResultString isEqualToString:@"done"])
                                             {
                                                 transperentViewIndicator11.hidden=YES;
                                                 //                                                     UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Challege Created!" message:@"Your challenge has been successfully created. You may see it in your profile." preferredStyle:UIAlertControllerStyleAlert];
                                                 //
                                                 //                                                     UIAlertAction *actionOk = [UIAlertAction actionWithTitle:@"Ok"
                                                 //                                                                                                        style:UIAlertActionStyleDefault
                                                 //                                                                                                      handler:nil];
                                                 //                                                     [alertController addAction:actionOk];
                                                 //                                                     [self presentViewController:alertController animated:YES completion:nil];
                                                 [defaults setObject:@"yes" forKey:@"ExpView_Update"];
                                                 [defaults setObject:@"no" forKey:@"falg"];
                                                 [defaults setObject:@"" forKey:@"usernames"];
                                                 [defaults setObject:@"" forKey:@"userids"];
                                                 [defaults synchronize];
                                                 
                                                 [self dismissViewControllerAnimated:YES completion:nil];
                                                 
                                                 
                                             }
                                             
                                             
                                             
                                         }
                                         
                                         else
                                         {
                                             NSLog(@" error login1 ---%ld",(long)statusCode);
                                             transperentViewIndicator11.hidden=YES;
                                         }
                                         
                                         
                                     }
                                     else if(error)
                                     {
                                         
                                         UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Error" message:@"server connection timeout." preferredStyle:UIAlertControllerStyleAlert];
                                         
                                         UIAlertAction *actionOk = [UIAlertAction actionWithTitle:@"Ok"
                                                                                            style:UIAlertActionStyleDefault handler:nil];
                                         [alertController addAction:actionOk];
                                         [self presentViewController:alertController animated:YES completion:nil];
                                         
                                         transperentViewIndicator11.hidden=YES;
                                         
                                         NSLog(@"error login2.......%@",error.description);
                                     }
                                     
                                     
                                 }];
                [dataTaskupload resume];
            }
            
            
        }
        
    }
    else
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
            transperentViewIndicator11.hidden=NO;
            Label_confirm11.text=@"0 %";
            NSString *userid= @"userid";
            NSString *useridVal =[defaults valueForKey:@"userid"];
            
            
            NSString *title= @"title";
            NSString *titleVal =_Textview_Desc.text;
            
            NSString *challengetype= @"challengetype";
            NSString *contributiontype= @"contributiontype";
            
            
            NSString *mediatype= @"mediatype";
            
            
            NSString *enddays= @"enddays";
            NSString *enddaysVal =[NSString stringWithFormat:@"%.f",slider_Days.value];
            
            NSString *payperchallenger= @"payperchallenger";
            NSString *payperchallengerVal =_Textfield_Amount.text;
            
            NSString *noofchallengers= @"noofchallengers";
            NSString *noofchallengersVal;
            
            noofchallengersVal=[NSString stringWithFormat:@"%lu",(unsigned long)Array_Names.count];
            
            
            NSString *challengerslist= @"challengerslist";
            //
            
            NSString *media= @"media";
            
            NSString *mediaimagethumb=@"mediathumbnail";
            
            
            NSString *reqStringFUll=[NSString stringWithFormat:@"%@=%@&%@=%@&%@=%@&%@=%@&%@=%@&%@=%@&%@=%@&%@=%@&%@=%@&%@=%@&%@=%@",userid,useridVal,title,titleVal,challengetype,challengetypeVal,contributiontype,challengetypeValDonate,mediatype,mediatypeVal,enddays,enddaysVal,payperchallenger,payperchallengerVal,noofchallengers,noofchallengersVal,challengerslist,_String_Cont_UserId,media,encodedImage,mediaimagethumb,encodedImageThumb];
            
            
            
#pragma mark - swipe sesion
            
            NSURLSession *session = [NSURLSession sessionWithConfiguration: [NSURLSessionConfiguration defaultSessionConfiguration] delegate:self delegateQueue: [NSOperationQueue mainQueue]];
            
            NSURL *url;
            NSString *  urlStrLivecount=[urlplist valueForKey:@"createchallenge"];;
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
                                         
                                         array_CreateChallenges=[[NSMutableArray alloc]init];
                                         SBJsonParser *objSBJsonParser = [[SBJsonParser alloc]init];
                                         array_CreateChallenges=[objSBJsonParser objectWithData:data];
                                         NSString * ResultString=[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
                                         //        Array_LodingPro=[NSJSONSerialization JSONObjectWithData:webData_Swipe options:kNilOptions error:nil];
                                         
                                         ResultString = [ResultString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
                                         ResultString = [ResultString stringByReplacingOccurrencesOfString:@"\t" withString:@""];
                                         
                                         NSLog(@"array_CreateChallenges %@",array_CreateChallenges);
                                         
                                         
                                         NSLog(@"array_CreateChallenges ResultString %@",ResultString);
                                         if ([ResultString isEqualToString:@"nouserid"])
                                         {
                                             transperentViewIndicator11.hidden=YES;
                                             UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Oops" message:@"Your account does not exist or seems to have been suspended. Please contact admin." preferredStyle:UIAlertControllerStyleAlert];
                                             
                                             UIAlertAction *actionOk = [UIAlertAction actionWithTitle:@"Ok"
                                                                                                style:UIAlertActionStyleDefault
                                                                                              handler:nil];
                                             [alertController addAction:actionOk];
                                             [self presentViewController:alertController animated:YES completion:nil];
                                             
                                             
                                         }
                                         if ([ResultString isEqualToString:@"nomedia"])
                                         {
                                             transperentViewIndicator11.hidden=YES;
                                             UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Oops" message:@"Please insert an image or video and try again." preferredStyle:UIAlertControllerStyleAlert];
                                             
                                             UIAlertAction *actionOk = [UIAlertAction actionWithTitle:@"Ok"
                                                                                                style:UIAlertActionStyleDefault
                                                                                              handler:nil];
                                             [alertController addAction:actionOk];
                                             [self presentViewController:alertController animated:YES completion:nil];
                                             
                                             
                                         }
                                         
                                         if ([ResultString isEqualToString:@"nullerror"])
                                         {
                                             transperentViewIndicator11.hidden=YES;
                                             UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Oops" message:@"Please enter all details and try again." preferredStyle:UIAlertControllerStyleAlert];
                                             
                                             UIAlertAction *actionOk = [UIAlertAction actionWithTitle:@"Ok"
                                                                                                style:UIAlertActionStyleDefault
                                                                                              handler:nil];
                                             [alertController addAction:actionOk];
                                             [self presentViewController:alertController animated:YES completion:nil];
                                             
                                             
                                             
                                             
                                         }
                                         if ([ResultString isEqualToString:@"imageerror"])
                                         {
                                             transperentViewIndicator11.hidden=YES;
                                             UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Oops" message:@"There was an error in uploading your media. Please try again." preferredStyle:UIAlertControllerStyleAlert];
                                             
                                             UIAlertAction *actionOk = [UIAlertAction actionWithTitle:@"Ok"
                                                                                                style:UIAlertActionStyleDefault
                                                                                              handler:nil];
                                             [alertController addAction:actionOk];
                                             [self presentViewController:alertController animated:YES completion:nil];
                                             
                                             
                                             
                                             
                                         }
                                         if ([ResultString isEqualToString:@"inserterror"])
                                         {
                                             transperentViewIndicator11.hidden=YES;
                                             UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Oops" message:@"There was an error in creating your challenge. Please try again." preferredStyle:UIAlertControllerStyleAlert];
                                             
                                             UIAlertAction *actionOk = [UIAlertAction actionWithTitle:@"Ok"
                                                                                                style:UIAlertActionStyleDefault
                                                                                              handler:nil];
                                             [alertController addAction:actionOk];
                                             [self presentViewController:alertController animated:YES completion:nil];
                                             
                                             
                                             
                                             
                                         }
                                         
                                         if ([ResultString isEqualToString:@"done"])
                                         {
                                             transperentViewIndicator11.hidden=YES;
                                             //                                                     UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Challege Created!" message:@"Your challenge has been successfully created. You may see it in your profile." preferredStyle:UIAlertControllerStyleAlert];
                                             //
                                             //                                                     UIAlertAction *actionOk = [UIAlertAction actionWithTitle:@"Ok"
                                             //                                                                                                        style:UIAlertActionStyleDefault
                                             //                                                                                                      handler:nil];
                                             //                                                     [alertController addAction:actionOk];
                                             //                                                     [self presentViewController:alertController animated:YES completion:nil];
                                             
                                              [defaults setObject:@"yes" forKey:@"ExpView_Update"];
                                             [defaults setObject:@"no" forKey:@"falg"];
                                             [defaults setObject:@"" forKey:@"usernames"];
                                             [defaults setObject:@"" forKey:@"userids"];
                                             [defaults synchronize];
                                             
                                             [self dismissViewControllerAnimated:YES completion:nil];
                                             
                                             
                                         }
                                         
                                         
                                         
                                     }
                                     
                                     else
                                     {
                                         NSLog(@" error login1 ---%ld",(long)statusCode);
                                         transperentViewIndicator11.hidden=YES;
                                     }
                                     
                                     
                                 }
                                 else if(error)
                                 {
                                     transperentViewIndicator11.hidden=YES;
                                     
                                     UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Error" message:@"server connection timeout." preferredStyle:UIAlertControllerStyleAlert];
                                     
                                     UIAlertAction *actionOk = [UIAlertAction actionWithTitle:@"Ok"
                                                                                        style:UIAlertActionStyleDefault handler:nil];
                                     [alertController addAction:actionOk];
                                     [self presentViewController:alertController animated:YES completion:nil];
                                     
                                     transperentViewIndicator11.hidden=YES;
                                     NSLog(@"error login2.......%@",error.description);
                                 }
                                 
                                 
                             }];
            [dataTaskupload resume];
        }
        
        
    }
    
}
-(IBAction)ButtonCreateChallenges_Action:(id)sender
{
    //challengetypeValDonate=@"DONATE";
    
   // challengetypeValDonate=@"RAISE";
    if([challengetypeValDonate isEqualToString:@"RAISE"])
    {
     
       [self ButtonCreateChallengesActions];
      
    }
    else
    {
        if (Array_Names.count ==0)
        {
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Oops" message:@"If you choose to \"Donate\", you need to challenge and add atleast one other friend in order to create this challenge." preferredStyle:UIAlertControllerStyleAlert ];
            
            UIAlertAction *actionOk = [UIAlertAction actionWithTitle:@"Add friends"
                    style:UIAlertActionStyleDefault handler:^(UIAlertAction *action)
                                {
                        InviteSprintTagUserViewController * set=[self.storyboard instantiateViewControllerWithIdentifier:@"InviteSprintTagUserViewController"];
                        [self.navigationController pushViewController:set animated:YES];
                            }];
            

            
            [alertController addAction:actionOk];
            [self presentViewController:alertController animated:YES completion:nil];
        }
        else
        {
          [self ButtonCreateChallengesActions];
        }
    }
    
}
-(void)ButtonCreateChallengesActions
{
    //NSString * Str_message;

    if ([challengetypeValDonate isEqualToString:@"DONATE"])
    {
//        Str_message=[NSString stringWithFormat:@"%@%@%.f",@"Here's how your Challenge campaign works: \n\n1. Supporters donate using a PayPal account or a credit/debit card. Donations are made to a Fund, who delivers these funds to your chosen charities on a monthly basis. \n\n2. To earn the donations made to your challenge campaign, you will have to perform the challenge set by uploading a relevant video response within the time limit or up to 48 hours later.\n\n3. Donations will be split 25/75 between you and your chosen charities. \n\n By continuing, you agree to deductions of 7.9% +US$0.30 from each donation to Payment Gateway fee's and Care2dare processing policies.",@"\n\nAre you sure you wish to donate $",[_Textfield_Amount.text floatValue]*(Array_Names.count)];
      
        
        
        
        
        NSString * messeageRed=[NSString stringWithFormat:@"%@",@"\n\nHere's how your Challenge campaign works: \n\n1. Supporters donate using a PayPal account or a credit/debit card. Donations are made to a Fund, who delivers these funds to your chosen charities on a monthly basis. \n\n2. To earn the donations made to your challenge campaign, you will have to perform the challenge set by uploading a relevant video response within the time limit or up to 48 hours later.\n\n3. Donations will be split 25/75 between you and your chosen charities. \n\n By continuing, you agree to deductions of 7.9% +US$0.30 from each donation to Payment Gateway fee's and Care2dare processing policies."];
        NSString * messagePayVal=[NSString stringWithFormat:@"%@%.f%@",@"\n\nAre you sure you wish to donate $",[_Textfield_Amount.text floatValue]*(Array_Names.count),@"?"];
        
        UIFont *name1 = [UIFont fontWithName:@"SanFranciscoDisplay-Bold" size:14.0];
        NSDictionary *arialDict = [NSDictionary dictionaryWithObject:name1 forKey:NSFontAttributeName];
        NSMutableAttributedString *aAttrString = [[NSMutableAttributedString alloc] initWithString:@"Challenge for Charity campaign details" attributes: arialDict];
        
        UIFont *name2 = [UIFont fontWithName:@"SanFranciscoDisplay-Medium" size:14.0];
        NSDictionary *verdanaDict = [NSDictionary dictionaryWithObject:name2 forKey:NSFontAttributeName];
        NSMutableAttributedString *vAttrString = [[NSMutableAttributedString alloc]initWithString:messeageRed attributes:verdanaDict];
        
        UIFont *name3 = [UIFont fontWithName:@"SanFranciscoDisplay-Bold" size:14.0];
        NSDictionary *verdanaDict2 = [NSDictionary dictionaryWithObject:name3 forKey:NSFontAttributeName];
        NSMutableAttributedString *vAttrString2 = [[NSMutableAttributedString alloc]initWithString:messagePayVal attributes:verdanaDict2];
        
        [aAttrString appendAttributedString:vAttrString];
        [aAttrString appendAttributedString:vAttrString2];
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"" message:@"" preferredStyle:UIAlertControllerStyleAlert];
        
        [alert setValue:aAttrString forKey:@"attributedTitle"];
        
        NSArray *viewArray = [[[[[[[[[[[[alert view] subviews] firstObject] subviews] firstObject] subviews] firstObject] subviews] firstObject] subviews] firstObject] subviews];
        
        UILabel *alertTitle = viewArray[0];
        alertTitle.textAlignment = NSTextAlignmentCenter;
        
        
        UILabel *alertMessage = viewArray[1];
        alertMessage.textAlignment = NSTextAlignmentLeft;
        
        viewArray=nil;
        alertMessage=nil;
        
        
        UIAlertAction *actionOk = [UIAlertAction actionWithTitle:@"Go Back"
                                                           style:UIAlertActionStyleDefault handler:^(UIAlertAction *action)
                                   {
                                       
                                   }];
        
        UIAlertAction *actionOk1 = [UIAlertAction actionWithTitle:@"Continue"
                                                            style:UIAlertActionStyleDefault handler:^(UIAlertAction *action)
                                    {
                                        [self createChallengesComm];
                                    }];
        
        [alert addAction:actionOk];
        
        [alert addAction:actionOk1];
        
        
        
        
        [self presentViewController:alert animated:YES completion:nil];
        
        
        
        
    }
    else
    {
//     Str_message=@"Here's how your Challenge campaign works: \n\n1. Supporters donate using a PayPal account or a credit/debit card. Donations are made to a Fund, who delivers these funds to your chosen charities on a monthly basis. \n\n2. To earn the donations made to your challenge campaign, you will have to perform the challenge set by uploading a relevant video response within the time limit or up to 48 hours later.\n\n3. Donations will be split 25/75 between you and your chosen charities. \n\n By continuing, you agree to deductions of 7.9% +US$0.30 from each donation to Payment Gateway fee's and Care2dare processing policies.";
        
        
        
        
        NSString * messeageRed=[NSString stringWithFormat:@"%@",@"\n\nHere's how your Challenge campaign works: \n\n1. Supporters donate using a PayPal account or a credit/debit card. Donations are made to a Fund, who delivers these funds to your chosen charities on a monthly basis. \n\n2. To earn the donations made to your challenge campaign, you will have to perform the challenge set by uploading a relevant video response within the time limit or up to 48 hours later.\n\n3. Donations will be split 25/75 between you and your chosen charities. \n\n By continuing, you agree to deductions of 7.9% +US$0.30 from each donation to Payment Gateway fee's and Care2dare processing policies."];
        
        
        UIFont *name1 = [UIFont fontWithName:@"SanFranciscoDisplay-Bold" size:14.0];
        NSDictionary *arialDict = [NSDictionary dictionaryWithObject:name1 forKey:NSFontAttributeName];
        NSMutableAttributedString *aAttrString = [[NSMutableAttributedString alloc] initWithString:@"Challenge for Charity campaign details" attributes: arialDict];
        
        UIFont *name2 = [UIFont fontWithName:@"SanFranciscoDisplay-Medium" size:14.0];
        NSDictionary *verdanaDict = [NSDictionary dictionaryWithObject:name2 forKey:NSFontAttributeName];
        NSMutableAttributedString *vAttrString = [[NSMutableAttributedString alloc]initWithString:messeageRed attributes:verdanaDict];
        
        
        
        [aAttrString appendAttributedString:vAttrString];
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"" message:@"" preferredStyle:UIAlertControllerStyleAlert];
        
        [alert setValue:aAttrString forKey:@"attributedTitle"];
        
        NSArray *viewArray = [[[[[[[[[[[[alert view] subviews] firstObject] subviews] firstObject] subviews] firstObject] subviews] firstObject] subviews] firstObject] subviews];
        
        UILabel *alertTitle = viewArray[0];
        alertTitle.textAlignment = NSTextAlignmentCenter;
        
        
        UILabel *alertMessage = viewArray[1];
        alertMessage.textAlignment = NSTextAlignmentLeft;
        
        viewArray=nil;
        alertMessage=nil;
        
        
        UIAlertAction *actionOk = [UIAlertAction actionWithTitle:@"Go Back"
                                                           style:UIAlertActionStyleDefault handler:^(UIAlertAction *action)
                                   {
                                       
                                   }];
        
        UIAlertAction *actionOk1 = [UIAlertAction actionWithTitle:@"Continue"
                                                            style:UIAlertActionStyleDefault handler:^(UIAlertAction *action)
                                    {
                                        [self createChallengesComm];
                                    }];
        
        [alert addAction:actionOk];
        
        [alert addAction:actionOk1];
        
        
        
        
        [self presentViewController:alert animated:YES completion:nil];
        
    }
    
//    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Challenge for Charity campaign details" message:Str_message preferredStyle:UIAlertControllerStyleAlert];
//    
//    
//    
//     NSArray *viewArray = [[[[[[[[[[[[alert view] subviews] firstObject] subviews] firstObject] subviews] firstObject] subviews] firstObject] subviews] firstObject] subviews];
//    
//    UILabel *alertTitle = viewArray[0];
//    alertTitle.textAlignment = NSTextAlignmentCenter;
//  
//    
//    UILabel *alertMessage = viewArray[1];
//    alertMessage.textAlignment = NSTextAlignmentLeft;
//    
//    viewArray=nil;
//    alertMessage=nil;
//    
//   
//        UIAlertAction *actionOk = [UIAlertAction actionWithTitle:@"Go Back"
//                                                           style:UIAlertActionStyleDefault handler:^(UIAlertAction *action)
//                                   {
//    
//                                   }];
//    
//        UIAlertAction *actionOk1 = [UIAlertAction actionWithTitle:@"Continue"
//                                                            style:UIAlertActionStyleDefault handler:^(UIAlertAction *action)
//                                    {
//                                        [self createChallengesComm];
//                                    }];
//    
//        [alert addAction:actionOk];
//    
//        [alert addAction:actionOk1];
//    
//    
//  
//    
//        [self presentViewController:alert animated:YES completion:nil];
}

- (void)textFieldDidBeginEditing:(UITextField *)textField;
{
    
    if ([challengetypeValDonate isEqualToString:@"DONATE"])
    {
        
        [self.startScreenScrollView setContentOffset:CGPointMake(0,(_Textfield_Amount.frame.origin.y-215)-(_Textfield_Amount.frame.size.height)) animated:YES];
    }
    else
    {
     [self.startScreenScrollView setContentOffset:CGPointMake(0,(textField.frame.origin.y-225)-(textField.frame.size.height)) animated:YES];
    }
   
}
- (IBAction)Textfield_Amount_Action:(id)sender
{
   
   
    
    if ([challengetypeValDonate isEqualToString:@"DONATE"])
    {
        
     [self.startScreenScrollView setContentOffset:CGPointMake(0,(_Textfield_Amount.frame.origin.y-215)-(_Textfield_Amount.frame.size.height)) animated:YES];
        
    _Label_totalAmount.text=[NSString stringWithFormat:@"%@%.f",@"total: $ ",[_Textfield_Amount.text floatValue]*(Array_Names.count)];
//    CGFloat calculate=[_Textfield_Amount.text floatValue]*(Array_Names.count+1);
    
//    if ([_Textfield_Amount.text isEqualToString:@""] || calculate<=0)
//    {
//        _Label_totalAmount.hidden=YES;
//    }
//    else
//    {
        _Label_totalAmount.hidden=NO;
   
   // }
    }
    else
    {
        
       [self.startScreenScrollView setContentOffset:CGPointMake(0,(_Textfield_Amount.frame.origin.y-225)-(_Textfield_Amount.frame.size.height)) animated:YES];
        
        _Label_totalAmount.text=[NSString stringWithFormat:@"%@%@",@"total: $ ",_Textfield_Amount.text];
       
            _Label_totalAmount.hidden=YES;
        
    }
    
}
- (void)textViewDidChange:(UITextView *)textView
{
    if (textView.text.length !=0 && encodedImage.length !=0 && ![textView.text isEqualToString:@"Challenge description"])
    {
        
        _Button_Create.enabled=YES;
         [_Button_Create setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _Button_Create.backgroundColor=[UIColor colorWithRed:67/255.0 green:188/255.0 blue:255/255.0 alpha:1];
    }
    else
    {
        
        _Button_Create.enabled=NO;
         [_Button_Create setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        _Button_Create.backgroundColor=[UIColor colorWithRed:241/255.0 green:241/255.0 blue:241/255.0 alpha:1];
    }
}
- (void)textViewDidBeginEditing:(UITextView *)textView
{
    
    
    
    if ([textView.text isEqualToString:@"Challenge description"])
    {
        textView.text = @"";
        textView.textColor = [UIColor blackColor]; //optional
        _Button_Create.enabled=NO;
         [_Button_Create setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        _Button_Create.backgroundColor=[UIColor colorWithRed:241/255.0 green:241/255.0 blue:241/255.0 alpha:1];
    }
    else
    {
        if (textView.text.length !=0 && encodedImage.length !=0 && ![textView.text isEqualToString:@"Challenge description"])
        {
          
            _Button_Create.enabled=YES;
             [_Button_Create setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            _Button_Create.backgroundColor=[UIColor colorWithRed:67/255.0 green:188/255.0 blue:255/255.0 alpha:1];
        }
        else
        {
            _Button_Create.enabled=NO;
             [_Button_Create setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
            _Button_Create.backgroundColor=[UIColor colorWithRed:241/255.0 green:241/255.0 blue:241/255.0 alpha:1];
        }

    }
    [textView becomeFirstResponder];
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
    
    if ([textView.text isEqualToString:@""]) {
        textView.text = @"Challenge description";
        textView.textColor = [UIColor colorWithRed:65/255.0 green:65/255.0 blue:65/255.0 alpha:1];
    }
    [textView resignFirstResponder];
}
-(void)dataReceived:(NSNotification *)noti
{
    
    Array_Names= [[noti userInfo] objectForKey:@"desc"];
    
    NSLog(@"days1111=%@",noti.object);
    NSLog(@"theArraytheArray=%@",Array_Names);
    String_Cont_Name=[Array_Names componentsJoinedByString:@","];
    NSLog(@"strInvite_usersstrInvite_users=%@",String_Cont_Name);
}
-(void)dataReceivedId:(NSNotification *)notif
{
    
    Array_UserId= [[notif userInfo] objectForKey:@"descId"];
    NSLog(@"theArraytheArray222222=%@",Array_UserId);
    _String_Cont_UserId=[Array_UserId componentsJoinedByString:@","];
    NSLog(@"_String_Cont_UserId=%@",_String_Cont_UserId);
}

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
-(IBAction)GalleryButton:(id)sender
{
    SelectGallery=@"Gal";
    
    
    //    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"Select your option"
    //                                                             delegate:self
    //                                                    cancelButtonTitle:@"Cancel"
    //                                               destructiveButtonTitle:nil
    //                                                    otherButtonTitles:@"Choose Photo", @"Choose Video",nil];
    //
    //    [actionSheet showInView:self.view];
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary])
    {
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        //[picker setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
        picker.sourceType =  UIImagePickerControllerSourceTypePhotoLibrary;
        picker.allowsEditing = NO;
        
        [self presentViewController:picker animated:true completion:nil];
    }
    
    
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
             if (videoSize >=5)
             {
                 if (videoSize<=7)
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
    [_Textview_Desc resignFirstResponder];
    if ([strCameraVedio isEqualToString:@"Record"])
    {
        ;
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
        if (_Textview_Desc.text.length !=0 && FrameImage !=0 && ![_Textview_Desc.text isEqualToString:@"Challenge description"])
        {
            
            _Button_Create.enabled=YES;
            
            
            [_Button_Create setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            
            _Button_Create.backgroundColor=[UIColor colorWithRed:67/255.0 green:188/255.0 blue:255/255.0 alpha:1];
        }
        else
        {
            _Button_Create.enabled=NO;
            [_Button_Create setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
            _Button_Create.backgroundColor=[UIColor colorWithRed:241/255.0 green:241/255.0 blue:241/255.0 alpha:1];
        }
        
        
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
        
        [self dataimage];
   

        
        
        [[self navigationController] dismissViewControllerAnimated:YES completion:nil];
        [picker dismissViewControllerAnimated:YES completion:NULL];
        
        if (_Textview_Desc.text.length !=0 && encodedImage.length !=0 && ![_Textview_Desc.text isEqualToString:@"Challenge description"])
        {
            
            _Button_Create.enabled=YES;
            [_Button_Create setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            _Button_Create.backgroundColor=[UIColor colorWithRed:67/255.0 green:188/255.0 blue:255/255.0 alpha:1];
        }
        else
        {
            _Button_Create.enabled=NO;
            [_Button_Create setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
            _Button_Create.backgroundColor=[UIColor colorWithRed:241/255.0 green:241/255.0 blue:241/255.0 alpha:1];
        }
        //[self viewImgCrop];
        // [[self navigationController] dismissViewControllerAnimated:YES completion:nil];
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
    NSLog(@"buttonIndex: %ld, cancelButtonIndex: %ld, firstOtherButtonIndex: %ld",
          (long)buttonIndex,
          (long)actionSheet.cancelButtonIndex,
          (long)actionSheet.destructiveButtonIndex);
    NSLog(@"INDEXAction Tag==%ld",(long)actionSheet.tag);
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
        NSLog(@"INDEXAcrtionShhet==%ld",(long)buttonIndex);
        //        if ([GalStr isEqualToString:@"GalStr"])
        //        {
        //
        //        }
        //        else
        //        {
        if (buttonIndex== 0)
        {
            strinRetake=@"";
            encodedImage=@"";
            BackroundImg.image=nil;
            BackroundImg.hidden=YES;
            self.Button_Gallery.hidden=NO;
            self.Button_Videos.hidden=NO;
            self.Button_Cammera.hidden=NO;
        }
        else  if (buttonIndex== 1)
        {
            [self displayImage:BackroundImg withImage:chosenImage];
            //    [delegate performSelector:@selector(setupImageViewer1:)];
            //            [BackroundImg setImage:chosenImage];
            //            BackroundImg.contentMode = UIViewContentModeScaleAspectFill;
            //            BackroundImg.clipsToBounds = YES;
            //            [BackroundImg setupImageViewer1];
            //
            
            
            
            
        }
        else  if (buttonIndex== 2)
        {
            
            strinRetake=@"Image";
           // encodedImage=@"";
            [self GalleryButton:self];
        }
        //}
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
        }
        else  if (buttonIndex== 1)
        {
            // [self BackroundImg];
            [BackroundImg setImage:chosenImage];
            BackroundImg.contentMode = UIViewContentModeScaleAspectFill;
            BackroundImg.clipsToBounds = YES;
            [BackroundImg setupImageViewer1];
            
        }
        else  if (buttonIndex== 2)
        {
            strinRetake=@"Image";
          // encodedImage=@"";
            
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
        }
        else  if (buttonIndex== 1)
        {
            movieController = [[MPMoviePlayerViewController alloc] initWithContentURL:self.videoURL];
            
            
            [self presentMoviePlayerViewControllerAnimated:movieController];
            [movieController.moviePlayer prepareToPlay];
            [movieController.moviePlayer play];
            //             UserImageProfileViewController * set=[self.storyboard instantiateViewControllerWithIdentifier:@"UserImageProfileViewController"];
            //
            //             [self.navigationController pushViewController:set animated:YES];
        }
        else  if (buttonIndex== 2)
        {
            strinRetake=@"Image";
            //encodedImage=@"";
            [self ButtonVideo_Action:self];
        }
    }
    
    
    if (_Textview_Desc.text.length !=0 && encodedImage.length !=0 && ![_Textview_Desc.text isEqualToString:@"Challenge description"])
    {
   _Button_Create.enabled=YES;
         [_Button_Create setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _Button_Create.backgroundColor=[UIColor colorWithRed:67/255.0 green:188/255.0 blue:255/255.0 alpha:1];
    }
    else
    {
        _Button_Create.enabled=NO;
         [_Button_Create setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        _Button_Create.backgroundColor=[UIColor colorWithRed:241/255.0 green:241/255.0 blue:241/255.0 alpha:1];
    }
 
    
    
}
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    return YES;
}
// this enables you to handle multiple recognizers on single view
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return YES;
}
-(void)startScreenScrollViewTapped:(UIGestureRecognizer *)gestureRecognizer
{
    [self.view endEditing:YES];
}
-(void) onPlayerTapped:(UIGestureRecognizer *)gestureRecognizer
{
    UIActionSheet *popup = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:@"Remove" otherButtonTitles:@"Play",@"Retake",nil];
    popup.tag = 3;
    [popup showInView:self.view];
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





- (void) displayImage:(UIImageView*)imageView withImage:(UIImage*)image  {
    [BackroundImg setImage:image];
    BackroundImg.contentMode = UIViewContentModeScaleAspectFill;
    [BackroundImg setupImageViewer1];
    BackroundImg.clipsToBounds = YES;
}
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    return textView.text.length + (text.length - range.length) <= 250;
}


    

// Getting the path of outPut file
//- (NSString *)outputFilePath{
//    
//    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//    
//    
//    NSString *documentsDirectory = [paths objectAtIndex:0];
//    NSString *path = [documentsDirectory stringByAppendingPathComponent:@"compressed.MOV"]; NSFileManager *fileManager = [NSFileManager defaultManager];
//    
//    //    return path;
//    
//    if ([fileManager fileExistsAtPath: path])
//    {
//        [fileManager removeItemAtPath:path error:nil];
//    }
//    
//    path = [documentsDirectory stringByAppendingPathComponent: [NSString stringWithFormat: @"compressed.MOV"] ];
//    
//    NSLog(@"path is== %@", path);
//    NSData* videoData = [NSData dataWithContentsOfFile:path];
//    int videoSize = [videoData length]/1024/1024;
//    
//    
//    NSLog(@"data size path==%d",videoSize);
//    
//    return path;
//    
//}
//
//
//// Actual compression is here.
//
//- (void)convertVideoToLowQuailtyWithInputURL:(NSURL*)inputURL
//                                   outputURL:(NSURL*)outputURL
//                                     handler:(void (^)(AVAssetExportSession*))handler
//{
//    
//    
//    //    [self startCompressingTheVideo:outputURL];
//    //
//    //
//    //    return;
//    [[NSFileManager defaultManager] removeItemAtURL:outputURL error:nil];
//    
//    //    AVAssetWriter
//    
//    AVURLAsset *asset = [AVURLAsset URLAssetWithURL:inputURL options:nil];
//    
//    AVAssetExportSession *exportSession = [[AVAssetExportSession alloc] initWithAsset:asset presetName:AVAssetExportPresetLowQuality];
//    
//    
//    //    exportSession.fileLengthLimit = 30*1024;
//    
//    exportSession.outputURL = outputURL;
//    exportSession.outputFileType = AVFileTypeQuickTimeMovie;
//    [exportSession exportAsynchronouslyWithCompletionHandler:^(void)
//     {
//         handler(exportSession);
//         //         [exportSession release];
//     }];
//}
//-(void)changeValue{
//    
//  
//    NSLog(@"Timer vediorecording timeremainingCounts==%d",remainingCounts);
//    if (--remainingCounts == 0)
//    {
//        NSLog(@"Timer vediorecording timeremainingCounts==%d",remainingCounts);
//        [cameraUI stopVideoCapture];
//        [self.videoTimer invalidate];
//    }
//}
//- (void)stopCamera:(id)sender{
//    NSLog(@"stop camera");
//    [self.videoTimer invalidate];
//    
//    [pcker1 stopVideoCapture];
//}
//
//- (void)windowDidBecomeVisible:(NSNotification *)notification
//{
//
//     NSLog(@"windowDidBecomeVisiblewindowDidBecomeVisible==%@",[notification object]);
//     ;
// 
//    
//     }

-(void)dataimage
{
    NSLog(@"MainiMage height : %f and Width : %f",BackroundImg.image.size.height,BackroundImg.image.size.width);
    
}
@end
