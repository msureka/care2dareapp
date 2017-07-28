//
//  AcceptContributeDetailViewController.m
//  care2Dare
//
//  Created by Spiel's Macmini on 4/1/17.
//  Copyright © 2017 Spiel's Macmini. All rights reserved.
//

#import "AcceptContributeDetailViewController.h"
#import "UIImageView+WebCache.h"
#import "ContributeMoneyViewController.h"
#import "RaisedContributeViewController.h"
#import "SBJsonParser.h"
#import "Reachability.h"
#import "Base64.h"
#import "MHFacebookImageViewer.h"
#import "UIImageView+MHFacebookImageViewer.h"
#import "ProfilePageDetailsViewController.h"
#import <MobileCoreServices/MobileCoreServices.h>
#import <AssetsLibrary/ALAsset.h>
#import <MediaPlayer/MediaPlayer.h>
#import <MobileCoreServices/UTCoreTypes.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import <AVFoundation/AVFoundation.h>

#define FONT_SIZE 16.0f
#define CELL_CONTENT_WIDTH self.view.frame.size.width-138
#define CELL_CONTENT_MARGIN 0.0f

@interface AcceptContributeDetailViewController ()
{
    UIView *sectionView,*transparancyTuchView;
    UIImageView *Image_Share;
    UIButton *Button_Deny,*Button_Accept;
    CGRect textRect;
    NSUserDefaults *defaults;
    NSDictionary *urlplist;
    NSString * CheckFavInserted,*chattype,*acceptstatusval;
    UIActivityIndicatorView *indicatorAlert;
    
    NSString * flag1,*String_Comment,*encodedImage,*imageUserheight,*imageUserWidth,*ImageNSdata,*TagId_plist;
    NSMutableArray * Array_Comment1,*Array_Comment;
    NSData *imageData;
  MPMoviePlayerViewController * movieController;
    CALayer *upperBorder;
}
- (void) displayImage:(UIImageView*)imageView withImage:(UIImage*)image;
@end

@implementation AcceptContributeDetailViewController
@synthesize cell_TwoDetails,cell_OneImageVid,Raised_amount,Button_back,Image_TotalLikes,Button_TotalPoints,AllArrayData,view_Topheader,Tableview_ContriBute;

- (void)viewDidLoad {
    [super viewDidLoad];
    defaults=[[NSUserDefaults alloc]init];
  
    upperBorder = [CALayer layer];
    NSString *plistPath = [[NSBundle mainBundle]pathForResource:@"UrlName" ofType:@"plist"];
    urlplist = [NSDictionary dictionaryWithContentsOfFile:plistPath];
    
    CheckFavInserted=[[AllArrayData objectAtIndex:0]valueForKey:@"favourite"];
    CALayer * borderBottom_topheder = [CALayer layer];
    borderBottom_topheder.backgroundColor =[UIColor colorWithRed:186/255.0 green:188/255.0 blue:190/255.0 alpha:1.0].CGColor;
    borderBottom_topheder.frame = CGRectMake(0, view_Topheader.frame.size.height-1, view_Topheader.frame.size.width,1);
    [view_Topheader.layer addSublayer:borderBottom_topheder];
    NSLog(@"AllArrayData=%@",AllArrayData);;
    Raised_amount.text=[NSString stringWithFormat:@"%@%@",@"You will get: $",[[AllArrayData objectAtIndex:0] valueForKey:@"backamount"]];
    
    [Button_TotalPoints setTitle:[NSString stringWithFormat:@"%@",[[AllArrayData objectAtIndex:0] valueForKey:@"backers"]] forState:UIControlStateNormal];
    
    Image_TotalLikes.userInteractionEnabled=YES;
    UITapGestureRecognizer * Image_TotalLikes_Tapped =[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(Image_TotalLikes_Action:)];
    [Image_TotalLikes addGestureRecognizer:Image_TotalLikes_Tapped];
    
    
    acceptstatusval=@"";
    
    flag1=@"yes";
    
    transparancyTuchView=[[UIView alloc]initWithFrame:CGRectMake(0,0, self.view.frame.size.width,self.view.frame.size.height)];
    transparancyTuchView.backgroundColor=[UIColor whiteColor];
    [transparancyTuchView setAlpha:0.5];
    
//    UIView * whiteView1=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 100,100)];
//    whiteView1.center=transparancyTuchView.center;
//    [whiteView1 setBackgroundColor:[UIColor whiteColor]];
//    whiteView1.layer.cornerRadius=9;
//    indicatorAlert = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
//    indicatorAlert.frame=CGRectMake(40, 40, 20, 20);
//    [indicatorAlert startAnimating];
//    [indicatorAlert setColor:[UIColor blackColor]];
//      [whiteView1 addSubview:indicatorAlert];
    
    indicatorAlert = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    indicatorAlert.frame=CGRectMake(transparancyTuchView.frame.size.width/2,transparancyTuchView.frame.size.height/2, 20, 20);
    [indicatorAlert startAnimating];
    [indicatorAlert setColor:[UIColor blackColor]];
  //  indicatorAlert.center=transparancyTuchView.center;
     [transparancyTuchView addSubview:indicatorAlert];
    
    [self.view addSubview:transparancyTuchView];
   
    UITapGestureRecognizer * ViewTap51 =[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(ViewTap51Tapped:)];
    [transparancyTuchView addGestureRecognizer:ViewTap51];
    transparancyTuchView.hidden=YES;
    
}



- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    
    
  
}


-(void)Image_TotalLikes_Action:(UIGestureRecognizer *)reconizer
{
    
    [self ButtonTotalPoints_Action:nil];
}




-(IBAction)ButtonTotalPoints_Action:(id)sender
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Tip" message:@"If you choose to accept this challenge, tap on Accept. You will need to record your video before the time expires." preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *actionOk = [UIAlertAction actionWithTitle:@"Ok"style:UIAlertActionStyleDefault handler:nil];
    [alertController addAction:actionOk];
    [self presentViewController:alertController animated:YES completion:nil];
    
    
//    RaisedContributeViewController * set=[self.storyboard instantiateViewControllerWithIdentifier:@"RaisedContributeViewController"];
//    set.Str_Channel_Id=[NSString stringWithFormat:@"%@",[[AllArrayData objectAtIndex:0]valueForKey:@"challengeid"]];
//    set.Str_Raised_Amount=[NSString stringWithFormat:@"%@",[[AllArrayData objectAtIndex:0]valueForKey:@"backamount"]];
  //  [self.navigationController pushViewController:set animated:YES];
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
    if (section==2)
    {
        return Array_Comment1.count;
    }
    
    return 0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellone=@"CellOne";
    static NSString *celltwo=@"CellTwo";
  
    
    switch (indexPath.section)
    {
            
        case 0:
        {
            cell_OneImageVid = (AccImgVidTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellone forIndexPath:indexPath];
            
            
            
            
            if ([CheckFavInserted isEqualToString:@"TRUE"])
            {
                [cell_OneImageVid.Image_Favourite setImage:[UIImage imageNamed:@"challenge_favourite1.png"]];
            }
            else
            {
                [cell_OneImageVid.Image_Favourite setImage:[UIImage imageNamed:@"challenge_favourite.png"]];
            }
            
            
            UITapGestureRecognizer *FlagTapped =[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(ThreeDotsTapped_Action:)];
            [cell_OneImageVid.Image_ThreeDotsFlag addGestureRecognizer:FlagTapped];
           
            
           
            
            if ([[[AllArrayData objectAtIndex:0]valueForKey:@"mediatype"] isEqualToString:@"IMAGE"])
            {
                NSURL *url=[NSURL URLWithString:[[AllArrayData objectAtIndex:0]valueForKey:@"mediathumbnailurl"]];
                  [cell_OneImageVid.Image_Backround sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"DefaultImg.jpg"]options:SDWebImageRefreshCached];
                cell_OneImageVid.image_playButton.hidden=YES;
                 [self displayImage:cell_OneImageVid.Image_Backround withImage:cell_OneImageVid.Image_Backround.image];
                
               
                
            }
            else
            {
                NSURL *url=[NSURL URLWithString:[[AllArrayData objectAtIndex:0]valueForKey:@"mediathumbnailurl"]];
                
                [cell_OneImageVid.Image_Backround sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"DefaultImg.jpg"]options:SDWebImageRefreshCached];
                
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
            cell_TwoDetails = (AccptTwoTableViewCell *)[tableView dequeueReusableCellWithIdentifier:celltwo forIndexPath:indexPath];
            
            NSURL *urlFirst=[NSURL URLWithString:[[AllArrayData objectAtIndex:0] valueForKey:@"usersprofilepic"]];
            
            cell_TwoDetails.label_name.text=[[AllArrayData objectAtIndex:0] valueForKey:@"usersname"];
            
            cell_TwoDetails.label_challengesday.text=[NSString stringWithFormat:@"%@%@%@",@"in ",[[AllArrayData objectAtIndex:0] valueForKey:@"daysleft"],@" days"];
            
        NSString * challengerdetails1=[NSString stringWithFormat:@"%@",[[AllArrayData objectAtIndex:0]valueForKey:@"challengerdetails1"]];
            NSString *myString ;
        if([challengerdetails1 isEqualToString:@""])
            {
              myString =[ NSString stringWithFormat:@"%@%@",@"challenges",@" You"];
            }
            else
            {
        myString =[ NSString stringWithFormat:@"%@%@%@%@",@"challenges",@" You & ",challengerdetails1,@" more"];
            }
          
            NSMutableAttributedString *attString = [[NSMutableAttributedString alloc] initWithString:myString];
            NSRange range = [myString rangeOfString:@"challenges"];
            [attString addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:67/255.0 green:188/255.0 blue:255/255.0 alpha:1.0] range:range];
            cell_TwoDetails.Label_AddmoreChallenges.attributedText=attString;

                [cell_TwoDetails.image_Profile sd_setImageWithURL:urlFirst placeholderImage:[UIImage imageNamed:@"DefaultImg.jpg"] options:SDWebImageRefreshCached];
            
            
            cell_TwoDetails.image_Profile.userInteractionEnabled=YES;
            UITapGestureRecognizer *FlagTapped1 =[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(ProfileTapped_Action:)];
            [cell_TwoDetails.image_Profile addGestureRecognizer:FlagTapped1];

            
            
    cell_TwoDetails.label_DescTitle.text=[[AllArrayData objectAtIndex:0] valueForKey:@"title"];
            
        
            NSString *text =[[AllArrayData objectAtIndex:0]valueForKey:@"title"];;
            
            
            CGSize constraint = CGSizeMake(CELL_CONTENT_WIDTH - (CELL_CONTENT_MARGIN * 2), 20000.0f);
            
            CGSize size = [text sizeWithFont:[UIFont systemFontOfSize:FONT_SIZE] constrainedToSize:constraint lineBreakMode:UILineBreakModeWordWrap];
            
            CGFloat height = MAX(size.height, 30.0f);
            NSLog(@"Dynamic label height====%f",height);
            cell_TwoDetails.label_DescTitle.numberOfLines=0;
            cell_TwoDetails.label_DescTitle.lineBreakMode=UILineBreakModeWordWrap;
            
            
            NSInteger rHeight = size.height/FONT_SIZE;
            NSLog(@"No of lines: %ld",(long)rHeight);
            if(height <=30)
            {
        [cell_TwoDetails.label_DescTitle setFrame:CGRectMake(cell_TwoDetails.label_DescTitle.frame.origin.x,cell_TwoDetails.label_DescTitle.frame.origin.y, cell_TwoDetails.label_DescTitle.frame.size.width,size.height)];
            }
            else if(height <=39)
            {
              [cell_TwoDetails.label_DescTitle setFrame:CGRectMake(cell_TwoDetails.label_DescTitle.frame.origin.x,cell_TwoDetails.label_DescTitle.frame.origin.y, cell_TwoDetails.label_DescTitle.frame.size.width,size.height*2)];
            }
            else
            {
            [cell_TwoDetails.label_DescTitle setFrame:CGRectMake(cell_TwoDetails.label_DescTitle.frame.origin.x,cell_TwoDetails.label_DescTitle.frame.origin.y, cell_TwoDetails.label_DescTitle.frame.size.width,size.height+70)];
            }
              
            if ([[[AllArrayData objectAtIndex:0] valueForKey:@"challengetype"]isEqualToString:@"PUBLIC"])
            {
                cell_TwoDetails.Label_privatePub.text=@"Public";
                cell_TwoDetails.image_PubPri.image=[UIImage imageNamed:@"blueworld.png"];
            }
            else
            {
                cell_TwoDetails.Label_privatePub.text=@"Private";
                cell_TwoDetails.image_PubPri.image=[UIImage imageNamed:@"blueprivate.png"];
            }
            
            
//            accepted = "";
//            backamount = 0;
//            backers = 0;
//            challengeid = C20170310084424DAXU;
//            challengerdetails = "Dhdhd + 1 more";
//            challengerdetails1 = "+ 1 more";
//            challengersname = Dhdhd;
//            challengersprofilepic = "http://www.care2dareapp.com/app/profileimages/default.jpg";
//            challengersuserid = 20170306090142zNLf;
//            challengetype = PUBLIC;
//            completed = "";
//            createdate = "2017-03-10 08:44:24";
//            createtime = 0s;
//            createtime1 = "Time up!";
//            creatoruserid = 20170306070111mGtl;
//            daysleft = 0;
//            enddate = "2017-03-10 09:55:24";
//            favourite = FALSE;
//            mediathumbnailurl = "";
//            mediatype = IMAGE;
//            mediaurl = "http://www.care2dareapp.com/app/challengemedia/C20170310084424DAXU.jpg";
//            noofchallengers = 3;
//            payperchallenger = 0;
//            recorded = "";
//            title = test1;
//            usersname = "Mohit Sureka";
//            usersprofilepic = "https://graph.facebook.com/10154323404982724/picture?type=large";
            
            return cell_TwoDetails;
            
        }
            
            
            break;
        
            
    }
    return nil;
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return 2;
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section==0)
    {
        return 223;
    }
    if (indexPath.section==1)
    {
        NSString *text =[[AllArrayData objectAtIndex:0]valueForKey:@"title"];;
        
        
        CGSize constraint = CGSizeMake(CELL_CONTENT_WIDTH - (CELL_CONTENT_MARGIN * 2), 20000.0f);
        
        CGSize size = [text sizeWithFont:[UIFont systemFontOfSize:FONT_SIZE] constrainedToSize:constraint lineBreakMode:UILineBreakModeWordWrap];
        
        CGFloat height = MAX(size.height, 30.0f);
        NSLog(@"Dynamic label height====%f",height);
        if(height <=30)
        {
            return 225+size.height+12;
        }
        else
        {
            return 225+size.height+42;
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
       
        
        
        
        Button_Deny=[[UIButton alloc]initWithFrame:CGRectMake(0,0, self.view.frame.size.width/2,38)];
        [Button_Deny setTitle:@"DENY" forState:UIControlStateNormal];
        Button_Deny.backgroundColor=[UIColor colorWithRed:186/255.0 green:188/255.0 blue:190/255.0 alpha:1];
        Button_Deny.tag=section;
        Button_Deny.titleLabel.font=[UIFont fontWithName:@"SanFranciscoDisplay-Bold" size:24.0];
        [Button_Deny addTarget:self action:@selector(Deny_Contribute_MoneyAction:)
                    forControlEvents:UIControlEventTouchUpInside];
        Button_Deny.enabled=NO;
        Button_Deny.enabled=YES;
       
        
        
        Button_Accept=[[UIButton alloc]initWithFrame:CGRectMake(self.view.frame.size.width/2,0,self.view.frame.size.width/2,38)];
        [Button_Accept setTitle:@"ACCEPT" forState:UIControlStateNormal];
        Button_Accept.backgroundColor=[UIColor colorWithRed:67/255.0 green:188/255.0 blue:255/255.0 alpha:1];;
        Button_Accept.tag=section;
        Button_Accept.titleLabel.font=[UIFont fontWithName:@"SanFranciscoDisplay-Bold" size:24.0];
        [Button_Accept addTarget:self action:@selector(Accept_Contribute_MoneyAction:)
                    forControlEvents:UIControlEventTouchUpInside];
        Button_Accept.enabled=NO;
        Button_Accept.enabled=YES;
        
        [sectionView addSubview:Button_Accept];
        [sectionView addSubview:Button_Deny];
        
        
        sectionView.tag=section;
        
        
        
        
        
    }
     return  sectionView;
    
    
    
}
-(void)Deny_Contribute_MoneyAction:(UIButton *)sender
{
    transparancyTuchView.hidden=NO;
    acceptstatusval=@"DENY";
    [self commnication_AcceptDeny];
}
-(void)Accept_Contribute_MoneyAction:(UIButton *)sender
{
    transparancyTuchView.hidden=NO;
    acceptstatusval=@"ACCEPT";
    [self commnication_AcceptDeny];
    
}

-(void)commnication_AcceptDeny
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
        
        NSString *acceptstatus= @"acceptstatus";
       
        
        NSString * reqStringFUll=[NSString stringWithFormat:@"%@=%@&%@=%@&%@=%@",userid,useridVal,challengrid,challengridVal,acceptstatus,acceptstatusval];
        
        
        
#pragma mark - swipe sesion
        
        NSURLSession *session = [NSURLSession sessionWithConfiguration: [NSURLSessionConfiguration defaultSessionConfiguration] delegate: nil delegateQueue: [NSOperationQueue mainQueue]];
        
        NSURL *url;
        NSString *  urlStrLivecount=[urlplist valueForKey:@"challengeaccept"];
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
                                            transparancyTuchView.hidden=YES;
                                                     
            if ([ResultString isEqualToString:@"accepted"] || [ResultString isEqualToString:@"deleted"] )
                                                     {
                                                         
                    [self.navigationController popViewControllerAnimated:YES];
                                                         
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
    
    return 0;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}
-(IBAction)ButtonBack_Action:(id)sender
{
  //   transparancyTuchView.hidden=YES;
    [self.navigationController popViewControllerAnimated:YES];
}




-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    
    [self.view endEditing:YES];
    
    
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
- (void)ViewTap51Tapped:(UITapGestureRecognizer *)recognizer
{
//    transparancyTuchView.hidden=YES;
//    [self.view endEditing:YES];
}
- (void)ProfileTapped_Action:(UITapGestureRecognizer *)recognizer
{
    ProfilePageDetailsViewController * set=[self.storyboard instantiateViewControllerWithIdentifier:@"ProfilePageDetailsViewController"];
    set.userId_prof=[NSString stringWithFormat:@"%@",[[AllArrayData objectAtIndex:0]valueForKey:@"userid1"]];
    
    set.user_name=[NSString stringWithFormat:@"%@",[[AllArrayData objectAtIndex:0]valueForKey:@"usersname"]];
    
    set.user_imageUrl=[NSString stringWithFormat:@"%@",[[AllArrayData objectAtIndex:0]valueForKey:@"usersprofilepic"]];
    
   // set.Images_data=cell_TwoDetails.image_Profile;
    [self.navigationController pushViewController:set animated:YES];
  
    
}
-(void)ImageTap_playButtonAction:(UIGestureRecognizer *)reconizer
{
    NSURL *urlVedio = [NSURL URLWithString:[NSString stringWithFormat:@"%@",[[AllArrayData objectAtIndex:0] valueForKey:@"mediaurl"]]];
    movieController = [[MPMoviePlayerViewController alloc] initWithContentURL:urlVedio];
[self presentMoviePlayerViewControllerAnimated:movieController];
    [movieController.moviePlayer prepareToPlay];
    [movieController.moviePlayer play];
}
-(void)ThreeDotsTapped_Action:(UIGestureRecognizer *)reconizer
{
    
    
        
        UIActionSheet *popup = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Flag as inappropriate",nil];
        popup.tag = 777;
        [popup showInView:self.view];
    
    
    
}
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
     if ((long)actionSheet.tag == 777)
    {
        NSLog(@"INDEXAcrtionShhet==%ld",(long)buttonIndex);
        
        if (buttonIndex== 1)
        {
            
            
        }
        if (buttonIndex== 0)
        {
            [self FlagVedioCommunication];
        }
    }
    
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
                                                     
                                                     
                                                     
                                                     
                                                   //  SBJsonParser *objSBJsonParser = [[SBJsonParser alloc]init];
                                                     
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



@end
