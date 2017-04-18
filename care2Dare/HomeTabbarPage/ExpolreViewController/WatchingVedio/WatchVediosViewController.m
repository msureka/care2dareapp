//
//  WatchVediosViewController.m
//  care2Dare
//
//  Created by Spiel's Macmini on 4/6/17.
//  Copyright © 2017 Spiel's Macmini. All rights reserved.
//

#import "WatchVediosViewController.h"
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
#define FONT_SIZE 16.0f
#define CELL_CONTENT_WIDTH self.view.frame.size.width-138
#define CELL_CONTENT_MARGIN 0.0f
@interface WatchVediosViewController ()
{
    UIButton *Button_PlayPause;
    NSTimer * timer;
    Float64 dur,progrssVal,CurrentTimes;
    NSURL *urlVediop;
    AVPlayerItem *item;
    AVPlayer * player;
    AVPlayerViewController *playerViewController;
    NSUserDefaults *defaults;
    NSMutableArray * Array_VediosData;
    NSDictionary *urlplist;
    NSString *str_name,*str_days,*str_friendstatus,*str_profileurl,*Flag_watch,*Str_urlVedio,* userId_Prof1;
    NSInteger indexVedio;
    CALayer *Bottomborder_Cell2;
    CGSize size;
    AVURLAsset *asset;
    float imageHeight;
}
@end

@implementation WatchVediosViewController
@synthesize Tableview_Explore,cell_one,cell_two,cell_three,cell_Four,str_Userid2val,str_ChallengeidVal,str_challengeTitle,str_image_Data;
- (void)viewDidLoad {
    [super viewDidLoad];
    indexVedio=1;
    defaults=[[NSUserDefaults alloc]init];
   
    [[UIApplication sharedApplication] setStatusBarHidden:YES];
    NSString *plistPath = [[NSBundle mainBundle]pathForResource:@"UrlName" ofType:@"plist"];
    urlplist = [NSDictionary dictionaryWithContentsOfFile:plistPath];
     playerViewController = [[AVPlayerViewController alloc] init];
 // [Tableview_Explore reloadData];
    [self CommunicationPlayVedio];
    timer =  [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(targetMethod:) userInfo:nil  repeats:YES];
   
    UIImageView *attachmentImageNew = [[UIImageView alloc] initWithFrame:CGRectMake(0,0, self.view.frame.size.width, self.view.frame.size.height)];
    attachmentImageNew.image = str_image_Data.image;
    attachmentImageNew.backgroundColor = [UIColor redColor];
    attachmentImageNew.contentMode = UIViewContentModeScaleAspectFit;
    
    
    float widthRatio = attachmentImageNew.bounds.size.width / attachmentImageNew.image.size.width;
    float heightRatio = attachmentImageNew.bounds.size.height / attachmentImageNew.image.size.height;
    float scale = MIN(widthRatio, heightRatio);
    float imageWidth = scale * attachmentImageNew.image.size.width;
     imageHeight = scale * attachmentImageNew.image.size.height;
    
    NSLog(@"Size of pic is %f",imageWidth);
    NSLog(@"Size of pic is %f",imageHeight);
    
    
}
-(void)viewWillAppear:(BOOL)animated
{
    //[self CommunicationPlayVedio];
    timer =  [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(targetMethod:) userInfo:nil  repeats:YES];
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
  
    
    
    NSString *reqStringFUll=[NSString stringWithFormat:@"%@=%@&%@=%@&%@=%@",userid1,useridVal1,userid2,str_Userid2val,challengeid,str_ChallengeidVal];
    
    
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
                
                cell_one.indicator_loading.hidden=YES;
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
                        urlVediop = [NSURL URLWithString:Str_urlVedio];
                        
                        asset = [AVURLAsset assetWithURL: urlVediop];
            
                        [self PlayVediosAuto];
                        
                        [Tableview_Explore reloadData];
                    }
                   
       
                }
                    
             }
                   
                    if (size.height !=0)
                    {
                        NSLog(@"heigt vedio===%f",size.height);

                        
                      
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



- (void)viewWillDisappear:(BOOL)animated{
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
    [super viewWillDisappear:animated];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==0)
    {
        return 1;
   
    }
    if (section==1)
    {
        if (Array_VediosData.count !=0)
        {
            return 1;
        }
        else
        {
        return 0;
        }
        
    }
    if (section==2)
    {
        if (Array_VediosData.count !=0)
        {
            return 1;
        }
        else
        {
            return 0;
        }
        
    }
    if (section==3)
    {
        if (Array_VediosData.count !=0)
        {
           return Array_VediosData.count;
        }
        else
        {
            return 0;
        }
        
 
    }
 return 0;

}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    static NSString *cellIdv1=@"CellOneV";
    static NSString *cellIdv2=@"CellTwoV";
    static NSString *cellIdv3=@"CellThreeV";
    static NSString *cellIdv4=@"CellFourV";
    
    switch (indexPath.section)
    {
            
        case 0:
        {
            cell_one = (WatchVedioTableViewCell*)[tableView dequeueReusableCellWithIdentifier:cellIdv1 forIndexPath:indexPath];
            [cell_one.Button_back addTarget:self action:@selector(Button_Back_Action:) forControlEvents:UIControlEventTouchUpInside];
            
            if (Array_VediosData.count==0)
            {
                 cell_one.image_Thumbnail.hidden=NO;
                cell_one.image_Thumbnail.image=str_image_Data.image;
                cell_one.indicator_loading.hidden=NO;
                cell_one.progressslider.hidden=YES;
            }
            else
            {
//            cell_one.image_Thumbnail.hidden=YES;
//           // cell_one.indicator_loading.hidden=YES;
//            cell_one.progressslider.hidden=NO;
//    
//   
//            
//            playerViewController = [[AVPlayerViewController alloc] init];
//            NSURL *url = [NSURL URLWithString:Str_urlVedio];
//            
//            AVURLAsset *asset = [AVURLAsset assetWithURL: url];
//            item = [AVPlayerItem playerItemWithAsset: asset];
//            
//            player = [[AVPlayer alloc] initWithPlayerItem: item];
//            playerViewController.player = player;
//        [playerViewController.view setFrame:CGRectMake(0, 0,cell_one.PlayerView.frame.size.width,cell_one.PlayerView.frame.size.width)];
//            
//            playerViewController.showsPlaybackControls = NO;
//            
//            [cell_one.PlayerView addSubview:playerViewController.view];
//            timer =  [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(targetMethod:) userInfo:nil  repeats:YES];
//        playerViewController.videoGravity=AVLayerVideoGravityResizeAspectFill;
//            [player play];
//            
//            Flag_watch=@"no";
//            item= player.currentItem;
//            
//            
//            CMTime duration = item.duration;
//            CMTime currentTime = item.currentTime;
//            
//            dur = CMTimeGetSeconds(player.currentItem.asset.duration);
//            CurrentTimes=CMTimeGetSeconds(currentTime);
//            NSLog(@"duration: %.2f", dur);
//            Button_PlayPause=[[UIButton alloc]initWithFrame:CGRectMake(0, 0,(cell_one.PlayerView.frame.size.width/2)+(cell_one.PlayerView.frame.size.width/5),(cell_one.PlayerView.frame.size.width/2)+(cell_one.PlayerView.frame.size.width/5))];
//            [Button_PlayPause setTitle:@"" forState:UIControlStateNormal];
//            [Button_PlayPause addTarget:self action:@selector(Play_Action:) forControlEvents:UIControlEventTouchUpInside];
//                
//                 [cell_one.Button_VolumeMute addTarget:self action:@selector(MutePlay_Action:) forControlEvents:UIControlEventTouchUpInside];
//                
//                
//                
//            Button_PlayPause.backgroundColor=[UIColor clearColor];
//            [Button_PlayPause setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//            Button_PlayPause.center=cell_one.PlayerView.center;
//            [cell_one.PlayerView addSubview:Button_PlayPause];
            
            }
            
            
            
            return cell_one;
        }
        
                   break;
        case 1:
            
            {
                cell_two = [[[NSBundle mainBundle]loadNibNamed:@"WatchVedioDescTableViewCell" owner:self options:nil] objectAtIndex:0];
                
                
                if (cell_two == nil)
                {
                    
                    cell_two = [[WatchVedioDescTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdv2];
                }
                if ([[defaults valueForKey:@"userid"] isEqualToString:[[Array_VediosData objectAtIndex:0]valueForKey:@"useridvideo"]]|| [str_friendstatus isEqualToString:@""])
                {
                    cell_two.Button_SetValues.hidden=YES;
                }
                else
                {
                
                if ([[[Array_VediosData objectAtIndex:0]valueForKey:@"friendstatus"] isEqualToString:@"no"] ||[str_friendstatus isEqualToString:@"no"])
                {
                    cell_two.Button_SetValues.hidden=NO;
                    [cell_two.Button_SetValues setImage:[UIImage imageNamed:@"addfriend.png"] forState:UIControlStateNormal];
                    [cell_two.Button_SetValues addTarget:self action:@selector(ButtonAction_friendstatus:) forControlEvents:UIControlEventTouchUpInside];
                }
               
                
                if ([[[Array_VediosData objectAtIndex:0]valueForKey:@"friendstatus"] isEqualToString:@"yes"]||[str_friendstatus isEqualToString:@"yes"])
                {
                       cell_two.Button_SetValues.hidden=NO;
                    [cell_two.Button_SetValues setImage:[UIImage imageNamed:@"addfriend1.png"] forState:UIControlStateNormal];
                    
                }
                if ([[[Array_VediosData objectAtIndex:0]valueForKey:@"friendstatus"] isEqualToString:@"waiting"]||[str_friendstatus isEqualToString:@"waiting"])
                {
                       cell_two.Button_SetValues.hidden=NO;
                    [cell_two.Button_SetValues setImage:[UIImage imageNamed:@"friendrequested.png"] forState:UIControlStateNormal];
                    
                }
                }
                
  
                
            cell_two.Label_DaysAgo.text=str_days;
                cell_two.Label_DescTitle.text=str_challengeTitle;
                
                
             
                
                
                CGSize constraint = CGSizeMake(CELL_CONTENT_WIDTH - (CELL_CONTENT_MARGIN * 2), 20000.0f);
                
                CGSize size = [str_challengeTitle sizeWithFont:[UIFont systemFontOfSize:FONT_SIZE] constrainedToSize:constraint lineBreakMode:UILineBreakModeWordWrap];
                
                CGFloat height = MAX(size.height, 30.0f);
                NSLog(@"Dynamic label height====%f",height);
                cell_two.Label_DescTitle.numberOfLines=0;
               cell_two.Label_DescTitle.lineBreakMode=UILineBreakModeWordWrap;
                
                
                NSInteger rHeight = size.height/FONT_SIZE;
                NSLog(@"No of lines: %ld",(long)rHeight);
                if(height<=30 )
                {
                    [cell_two.Label_DescTitle setFrame:CGRectMake(cell_two.Label_DescTitle.frame.origin.x,cell_two.Label_DescTitle.frame.origin.y, cell_two.Label_DescTitle.frame.size.width,cell_two.Label_DescTitle.frame.size.height)];
                }

                else if(height>=30  && height <=40)
                {
                  [cell_two.Label_DescTitle setFrame:CGRectMake(cell_two.Label_DescTitle.frame.origin.x,cell_two.Label_DescTitle.frame.origin.y-10, cell_two.Label_DescTitle.frame.size.width,cell_two.Label_DescTitle.frame.size.height*2)];
                }
                else
                {
                   [cell_two.Label_DescTitle setFrame:CGRectMake(cell_two.Label_DescTitle.frame.origin.x,cell_two.Label_DescTitle.frame.origin.y, cell_two.Label_DescTitle.frame.size.width,size.height+70)];
                }
    
                
                
                
                
                cell_two.ImageLeft_LeftProfile.userInteractionEnabled=YES;
                UITapGestureRecognizer *image_FristProfileTapped =[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(image_FirstProfile_ActionDetails:)];
                [cell_two.ImageLeft_LeftProfile addGestureRecognizer:image_FristProfileTapped];
                
                
                
                
                
                NSURL *url=[NSURL URLWithString:str_profileurl];
                
        [cell_two.ImageLeft_LeftProfile sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"DefaultImg.jpg"] options:SDWebImageRefreshCached];
                
                
                
        UIFont *name1 = [UIFont fontWithName:@"SanFranciscoDisplay-Medium" size:14.0];
        NSDictionary *arialDict = [NSDictionary dictionaryWithObject:name1 forKey:NSFontAttributeName];
       NSMutableAttributedString *aAttrString = [[NSMutableAttributedString alloc] initWithString:@"Posted by " attributes: arialDict];
                
        UIFont *name2 = [UIFont fontWithName:@"SanFranciscoDisplay-Bold" size:14.0];
        NSDictionary *verdanaDict = [NSDictionary dictionaryWithObject:name2 forKey:NSFontAttributeName];
    NSMutableAttributedString *vAttrString = [[NSMutableAttributedString alloc]initWithString:str_name  attributes:verdanaDict];
                
                
[aAttrString appendAttributedString:vAttrString];

            
                
                cell_two.Label_ChallengeName.attributedText = aAttrString;
                
                return cell_two;

            }
            break;
        case 2:
            
            {
                cell_three = [[[NSBundle mainBundle]loadNibNamed:@"WatchVedioShareTableViewCell" owner:self options:nil] objectAtIndex:0];
                
                
                if (cell_three == nil)
                {
                    
                    cell_three = [[WatchVedioShareTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdv3];
                }
                

               
                cell_three.Label_Reviews.text=[[Array_VediosData objectAtIndex:0]valueForKey:@"totalviews"];
                cell_three.Image_Stats.userInteractionEnabled=YES;
                UITapGestureRecognizer *Image_StatsTapped =[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(Image_Stats_Action:)];
                [cell_three.Image_Stats addGestureRecognizer:Image_StatsTapped];

                cell_three.Image_Comments.userInteractionEnabled=YES;
                UITapGestureRecognizer *Image_CommentsTapped =[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(Image_Comments_Action:)];
                [cell_three.Image_Comments addGestureRecognizer:Image_CommentsTapped];
                
                
                cell_three.Image_Share.userInteractionEnabled=YES;
                UITapGestureRecognizer *Image_ShareTapped =[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(Image_Share_Action:)];
                [cell_three.Image_Share addGestureRecognizer:Image_ShareTapped];
            
                return cell_three;
                
               
            }
            break;
        case 3:
            
            {
                cell_Four = [[[NSBundle mainBundle]loadNibNamed:@"WatchVediolistTableViewCell" owner:self options:nil] objectAtIndex:0];
                
                
                if (cell_Four == nil)
                {
                    
        cell_Four = [[WatchVediolistTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdv4];
                }
                
                if (Array_VediosData.count-1==indexPath.row)
                {
                    Bottomborder_Cell2 = [CALayer layer];
                    Bottomborder_Cell2.backgroundColor = [UIColor clearColor].CGColor;
                    Bottomborder_Cell2.frame = CGRectMake(0, cell_Four.frame.size.height-1, cell_Four.frame.size.width, 1);
                    [cell_Four.layer addSublayer:Bottomborder_Cell2];
                }
                else
                {
                    Bottomborder_Cell2 = [CALayer layer];
                    Bottomborder_Cell2.backgroundColor = [UIColor colorWithRed:65/255.0 green:65/255.0 blue:65/255.0 alpha:1.0].CGColor;
                    Bottomborder_Cell2.frame = CGRectMake(0, cell_Four.frame.size.height-1, cell_Four.frame.size.width, 1);
                    [cell_Four.layer addSublayer:Bottomborder_Cell2];
                }

                
            NSDictionary * dic_value=[Array_VediosData objectAtIndex:indexPath.row];
                
        cell_Four.Label_DaysAgo.text=[NSString stringWithFormat:@"%@",[dic_value valueForKey:@"posttime"]];
           
              
                cell_Four.ImageLeft_LeftProfile.tag=indexPath.row;
                
                
                
                
            NSURL *urlLef=[NSURL URLWithString:[dic_value valueForKey:@"thumbnailurl"]];
                
            [cell_Four.ImageLeft_LeftProfile sd_setImageWithURL:urlLef placeholderImage:[UIImage imageNamed:@"DefaultImg.jpg"] options:SDWebImageRefreshCached];
                
             NSURL *urlRight=[NSURL URLWithString:[dic_value valueForKey:@"profileimage"]];
            [cell_Four.ImageRight_RightProfile sd_setImageWithURL:urlRight placeholderImage:[UIImage imageNamed:@"DefaultImg.jpg"] options:SDWebImageRefreshCached];
                
                
                
                
                cell_Four.ImageRight_RightProfile.tag=indexPath.row;
                cell_Four.ImageRight_RightProfile.userInteractionEnabled=YES;
                
                UITapGestureRecognizer *image_SecProfileTapped =[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(image_SecProfile_ActionDetails:)];
                [cell_Four.ImageRight_RightProfile addGestureRecognizer:image_SecProfileTapped];
                
                
                
        UIFont *name1 = [UIFont fontWithName:@"SanFranciscoDisplay-Medium" size:14.0];
        NSDictionary *arialDict = [NSDictionary dictionaryWithObject:name1 forKey:NSFontAttributeName];
        NSMutableAttributedString *aAttrString = [[NSMutableAttributedString alloc] initWithString:@"Posted by " attributes: arialDict];
                
        UIFont *name2 = [UIFont fontWithName:@"SanFranciscoDisplay-Bold" size:14.0];
        NSDictionary *verdanaDict = [NSDictionary dictionaryWithObject:name2 forKey:NSFontAttributeName];
        NSMutableAttributedString *vAttrString = [[NSMutableAttributedString alloc]initWithString:[dic_value valueForKey:@"name"]  attributes:verdanaDict];
                        
                
                [aAttrString appendAttributedString:vAttrString];
                
                        
                cell_Four.Label_ChallengeName.attributedText = aAttrString;
                
                if ([[dic_value valueForKey:@"newstatus"]isEqualToString:@"yes"])
                {
                    cell_Four.Image_NewFrnd.hidden=NO;
                }
                else
                {
                cell_Four.Image_NewFrnd.hidden=YES;
                }
                
                return cell_Four;

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
    if(indexPath.section==0)
    {
        NSLog(@"Row Vedio height==%f",size.height);
        
        return imageHeight;// self.view.frame.size.width+(self.view.frame.size.width/2);
    }
    if (indexPath.section==1)
    {
       
        
        
        CGSize constraint = CGSizeMake(CELL_CONTENT_WIDTH - (CELL_CONTENT_MARGIN * 2), 20000.0f);
        
        CGSize size = [str_challengeTitle sizeWithFont:[UIFont systemFontOfSize:FONT_SIZE] constrainedToSize:constraint lineBreakMode:UILineBreakModeWordWrap];
        
        CGFloat height = MAX(size.height, 30.0f);
        NSLog(@"Dynamic label height====%f",height);
        if(height <=40)
        {
            return 101+size.height;
        }
        else
        {
            return 101+size.height;
        }
        
    }
    if(indexPath.section==2)
    {
        return 108;
    }
    if(indexPath.section==3)
    {
        return 130;
    }
    
    return 0;
    
  
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
                                                         
                [cell_two.Button_SetValues setImage:[UIImage imageNamed:@"friendrequested.png"] forState:UIControlStateNormal];
                                                         
                                                         
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

-(void)Button_Back_Action:(UIButton *)sender
{
    [cell_one.PlayerView removeFromSuperview];
    [playerViewController.view removeFromSuperview];
    [player pause];
    player = nil;
    [timer invalidate];
    timer = nil;
    player = nil;
    [cell_one.PlayerView removeFromSuperview];
    [playerViewController.view removeFromSuperview];
    [timer invalidate];
    timer = nil;

    [self.navigationController popViewControllerAnimated:YES];
    
    [cell_one.PlayerView removeFromSuperview];
    [playerViewController.view removeFromSuperview];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section==3)
    {
      cell_one.progressslider.hidden=YES;
        cell_one.Button_VolumeMute.hidden=YES;
        [playerViewController.view removeFromSuperview];
        //[cell_one.PlayerView removeFromSuperview];
       // [cell_one.PlayerView addSubview:playerViewController.view
         Flag_watch=@"yes";
        
//     Str_urlVedio=[NSString stringWithFormat:@"%@",[[Array_VediosData objectAtIndex:indexPath.row]valueForKey:@"videourl" ]];
//        indexVedio=indexPath.row;
        
    str_Userid2val=[NSString stringWithFormat:@"%@",[[Array_VediosData objectAtIndex:indexPath.row]valueForKey:@"useridvideo"]];
        
       
        [self CommunicationPlayVedio];
        
    }
}
-(void)targetMethod:(NSTimer *)timer1
{
//    avPlayer.currentItem!.playbackLikelyToKeepUp
    
        if (item.playbackBufferEmpty)
        {
            cell_one.indicator_loading.hidden=NO;
            [cell_one.indicator_loading startAnimating];
        }
    else
    {
        [cell_one.indicator_loading stopAnimating];
     cell_one.indicator_loading.hidden=YES;
    }
    
    
    if (indexVedio==Array_VediosData.count )
    {
        indexVedio=0;
        
    }
    CMTime currentTime = item.currentTime;
    CurrentTimes=CMTimeGetSeconds(currentTime);
    
    [cell_one.progressslider setProgress:CurrentTimes/dur];
    NSLog(@"duration: %.2f", CurrentTimes);
    
    NSLog(@"duration: %.2f", CurrentTimes/dur);
    
    if (CurrentTimes/dur >=0.5)
    {
        NSLog(@"duration: %.2f", CurrentTimes/dur);
        if ([Flag_watch isEqualToString:@"no"])
        {
         [self ClienserverComm_watchView];
            Flag_watch=@"yes";
        }

        
    }
    if (CurrentTimes==dur)
    {
        [playerViewController.view removeFromSuperview];
        [timer invalidate];
        timer = nil;
       // Str_urlVedio=[NSString stringWithFormat:@"%@",[[Array_VediosData objectAtIndex:indexVedio]valueForKey:@"videourl" ]];
        str_Userid2val=[NSString stringWithFormat:@"%@",[[Array_VediosData objectAtIndex:indexVedio]valueForKey:@"useridvideo"]];
       
        [self CommunicationPlayVedio];
        indexVedio++;
         Flag_watch=@"no";
     
       // [Tableview_Explore reloadData];
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
        
        
        
        NSString *reqStringFUll=[NSString stringWithFormat:@"%@=%@&%@=%@&%@=%@",userid1,useridVal1,userid2,str_Userid2val,challengeid,str_ChallengeidVal];
        

        
        
        
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
                                                     
SBJsonParser *objSBJsonParser = [[SBJsonParser alloc]init];
                                                     

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




- (IBAction)PauseButton:(id)sender
{
    
    [player pause];
}
- (IBAction)Play_Action:(id)sender
{
    if (player.rate == 1.0)
    {
      
        [player pause];
        
    } else
    {
        
        [player play];
    }
    
}

- (IBAction)playButton:(id)sender
{
    if (player.rate == 1.0)
    {
       
        [player pause];
        
    } else {
        
        [player play];
    }
    //[player play];
}
- (IBAction)MutePlay_Action:(id)sender
{
    if (cell_one.Button_VolumeMute.isSelected==YES)
    {
        player.muted=NO;
     
        [cell_one.Button_VolumeMute setImage:[UIImage imageNamed:@"High Volume Filled-100.png"] forState:UIControlStateNormal];
      cell_one.Button_VolumeMute.selected=NO;
    }
    else
    {
        player.muted=YES;
        cell_one.Button_VolumeMute.selected=YES;
    [cell_one.Button_VolumeMute setImage:[UIImage imageNamed:@"Mute Filled-100.png"] forState:UIControlStateNormal];
    }
    
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView.contentOffset.y<=0) {
        scrollView.contentOffset = CGPointZero;
    }
}
-(void)PlayVediosAuto
{
     [playerViewController.view removeFromSuperview];
    cell_one.indicator_loading.hidden=NO;
    [cell_one.indicator_loading startAnimating];
    cell_one.image_Thumbnail.hidden=YES;
    // cell_one.indicator_loading.hidden=YES;
    cell_one.progressslider.hidden=NO;
   
    
    
   
    ;
    
    
    NSLog(@"size of Vedio=%f",size.height);
      NSLog(@"size of Vedio=%f",size.height);
    
    
    item = [AVPlayerItem playerItemWithAsset: asset];
    
    player = [[AVPlayer alloc] initWithPlayerItem: item];
    playerViewController.player = player;
    [playerViewController.view setFrame:CGRectMake(0, 0,cell_one.PlayerView.frame.size.width,imageHeight)];
    
    playerViewController.showsPlaybackControls = NO;
    
    

    
    
  [cell_one.PlayerView addSubview:playerViewController.view];
    
    playerViewController.videoGravity=AVLayerVideoGravityResizeAspect;
    [player play];
    
    Flag_watch=@"no";
    item= player.currentItem;
    
    
    CMTime duration = item.duration;
    CMTime currentTime = item.currentTime;
    
    dur = CMTimeGetSeconds(player.currentItem.asset.duration);
    CurrentTimes=CMTimeGetSeconds(currentTime);
    NSLog(@"duration: %.2f", dur);
    Button_PlayPause=[[UIButton alloc]initWithFrame:CGRectMake(0, 0,(cell_one.PlayerView.frame.size.width/2)+(cell_one.PlayerView.frame.size.width/5),(cell_one.PlayerView.frame.size.width/2)+(cell_one.PlayerView.frame.size.width/5))];
    [Button_PlayPause setTitle:@"" forState:UIControlStateNormal];
    [Button_PlayPause addTarget:self action:@selector(Play_Action:) forControlEvents:UIControlEventTouchUpInside];
    
    [cell_one.Button_VolumeMute addTarget:self action:@selector(MutePlay_Action:) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    Button_PlayPause.backgroundColor=[UIColor clearColor];
    [Button_PlayPause setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    Button_PlayPause.center=cell_one.PlayerView.center;
    [cell_one.PlayerView addSubview:Button_PlayPause];
    
    cell_one.Button_VolumeMute.hidden=NO;
    player.muted=NO;
    
    [cell_one.Button_VolumeMute setImage:[UIImage imageNamed:@"High Volume Filled-100.png"] forState:UIControlStateNormal];
    cell_one.Button_VolumeMute.selected=NO;

    
}

-(void)image_FirstProfile_ActionDetails:(UIGestureRecognizer *)reconizer
{
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
        
        set.Images_data=cell_two.ImageLeft_LeftProfile;
        
        
        
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
        
        set.Images_data=cell_Four.ImageRight_RightProfile;
        
        
     
        [player pause];
     
        [timer invalidate];
        timer = nil;
        
     
        [timer invalidate];
        timer = nil;
       
           [player pause];
   

        
        
        [self.navigationController pushViewController:set animated:YES];
    }
    
    
    
}
-(void)Image_Stats_Action:(UIGestureRecognizer *)reconizer
{
    [player pause];
    
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

}



@end
