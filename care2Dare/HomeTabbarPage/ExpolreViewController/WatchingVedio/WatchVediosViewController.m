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
@interface WatchVediosViewController ()
{
    UIButton *Button_PlayPause;
    NSTimer * timer;
    Float64 dur,progrssVal,CurrentTimes;
    
    AVPlayerItem *item;
    AVPlayer * player;
    AVPlayerViewController *playerViewController;
    NSUserDefaults *defaults;
    NSMutableArray * Array_VediosData;
    NSDictionary *urlplist;
    NSString *str_name,*str_days,*str_friendstatus,*str_profileurl,*Flag_watch,*Str_urlVedio;
    NSInteger indexVedio;
    
    
//    challengetitle = Sachin;
//    friendstatus = no;
//    name = "Er Sachin Mokashi";
//    posttime = "Just now";
//    profileimage = "https://graph.facebook.com/1280357812049167/picture?type=large";
//    recorddate = "2017-04-06 05:30:29";
//    "registration_status" = ACTIVE;
//    status = PLAY;
//    thumbnailurl = "http://www.care2dareapp.com/app/recordedmedia/R20170307091520wFL3C20170404122329IEXZ-thumbnail.jpg";
//    useridvideo = 20170307091520wFL3;
//    videourl = "http://www.care2dareapp.com/app/recordedmedia/R20170307091520wFL3C20170404122329IEXZ.mp4";

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
    
  [Tableview_Explore reloadData];
    [self CommunicationPlayVedio];
   
    
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
                        
        
                        
        str_friendstatus=[NSString stringWithFormat:@"%@",[[Array_VediosData objectAtIndex:i]valueForKey:@"friendstatus" ]];
                        
        str_profileurl=[NSString stringWithFormat:@"%@",[[Array_VediosData objectAtIndex:i]valueForKey:@"profileimage" ]];
                        
        Str_urlVedio=[NSString stringWithFormat:@"%@",[[Array_VediosData objectAtIndex:i]valueForKey:@"videourl" ]];
                       
                    }
                   
       
                }
                    
             }
                    [Tableview_Explore reloadData];
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
            cell_one.image_Thumbnail.hidden=YES;
           // cell_one.indicator_loading.hidden=YES;
            cell_one.progressslider.hidden=NO;
    
   
            
            playerViewController = [[AVPlayerViewController alloc] init];
            NSURL *url = [NSURL URLWithString:Str_urlVedio];
            
            AVURLAsset *asset = [AVURLAsset assetWithURL: url];
            item = [AVPlayerItem playerItemWithAsset: asset];
            
            player = [[AVPlayer alloc] initWithPlayerItem: item];
            playerViewController.player = player;
        [playerViewController.view setFrame:CGRectMake(0, 0,cell_one.PlayerView.frame.size.width,cell_one.PlayerView.frame.size.width)];
            
            playerViewController.showsPlaybackControls = NO;
            
            [cell_one.PlayerView addSubview:playerViewController.view];
            timer =  [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(targetMethod:) userInfo:nil  repeats:YES];
        playerViewController.videoGravity=AVLayerVideoGravityResizeAspectFill;
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
            Button_PlayPause.backgroundColor=[UIColor clearColor];
            [Button_PlayPause setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            Button_PlayPause.center=cell_one.PlayerView.center;
            [cell_one.PlayerView addSubview:Button_PlayPause];
            
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
                if ([[defaults valueForKey:@"userid"] isEqualToString:[[Array_VediosData objectAtIndex:0]valueForKey:@"friendstatus"]])
                {
                    
                }
                else
                {
                
                if ([[[Array_VediosData objectAtIndex:0]valueForKey:@"friendstatus"] isEqualToString:@"no"])
                {
                    cell_two.Button_SetValues.enabled=YES;
                    [cell_two.Button_SetValues setImage:[UIImage imageNamed:@"addfriend.png"] forState:UIControlStateNormal];
                }
               
                
                if ([[[Array_VediosData objectAtIndex:0]valueForKey:@"friendstatus"] isEqualToString:@"yes"])
                {
                    cell_two.Button_SetValues.enabled=NO;
                    [cell_two.Button_SetValues setImage:[UIImage imageNamed:@"addfriend1.png"] forState:UIControlStateNormal];
                    
                }
                if ([[[Array_VediosData objectAtIndex:0]valueForKey:@"friendstatus"] isEqualToString:@"waiting"])
                {
                    cell_two.Button_SetValues.enabled=NO;
                    [cell_two.Button_SetValues setImage:[UIImage imageNamed:@"friendrequested.png"] forState:UIControlStateNormal];
                    
                }
                }
                
  
                
            cell_two.Label_DaysAgo.text=str_days;
                cell_two.Label_DescTitle.text=str_challengeTitle;
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
                
//                friendstatus = no;
//                name = "Mohit Sureka";
//                newstatus = no;
//                posttime = "50m ago";
//                profileimage = "https://graph.facebook.com/10154323404982724/picture?type=large";
//                recorddate = "2017-04-10 09:15:44";
//                "registration_status" = ACTIVE;
//                status = PLAY;
//                thumbnailurl = "http://www.care2dareapp.com/app/recordedmedia/R20170306070111mGtlC20170410090900Z0FR-thumbnail.jpg";
//                totalviews = "1 views";
//                useridvideo = 20170306070111mGtl;
//                videourl = "http://www.care2dareapp.com/app/recordedmedia/R20170306070111mGtlC20170410090900Z0FR.mp4";
               
                cell_three.Label_Reviews.text=[[Array_VediosData objectAtIndex:0]valueForKey:@"totalviews"];
           
                //        cell_Favorite.Label_Backer.text=[NSString stringWithFormat:@"%@",[dic_worldexp valueForKey:@"backers"]];
                //        cell_Favorite.Label_Titile.text=[NSString stringWithFormat:@"%@",[dic_worldexp valueForKey:@"title"]];
                //        NSString *text=[NSString stringWithFormat:@"%@",[dic_worldexp valueForKey:@"title"]];
                //
                //
                //        CGRect textRect = [text boundingRectWithSize:cell_Favorite.Label_Titile.frame.size options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:cell_Favorite.Label_Titile.font} context:nil];
                //
                //        int numberOfLines = textRect.size.height / cell_Favorite.Label_Titile.font.pointSize;;
                //        if (numberOfLines==1)
                //        {
                //            [cell_Favorite.Label_Titile setFrame:CGRectMake(cell_Favorite.Label_Titile.frame.origin.x, cell_Favorite.Label_Titile.frame.origin.y, cell_Favorite.Label_Titile.frame.size.width, cell_Favorite.Label_Titile.frame.size.height/2)];
                //        }
                //
                //
                //
                //        NSLog(@"number of lines=%d",numberOfLines);
                //
                //        cell_Favorite.Label_Time.text=[NSString stringWithFormat:@"%@",[dic_worldexp valueForKey:@"createtime"]];
                
                
                
                //        if ([[dic_worldexp valueForKey:@"mediatype"] isEqualToString:@"IMAGE"])
                //        {
                //            cell_Favorite.Image_PalyBuutton.hidden=YES;
                //
                //            NSURL *url=[NSURL URLWithString:[dic_worldexp valueForKey:@"mediaurl"]];
                //
                //            [cell_Favorite.Image_Profile sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"DefaultImg.jpg"] options:SDWebImageRefreshCached];
                //        }
                //        else
                //        {
                //
                //            NSURL *url=[NSURL URLWithString:[dic_worldexp valueForKey:@"mediathumbnailurl"]];
                //
                //            [cell_Favorite.Image_Profile sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"DefaultImg.jpg"] options:SDWebImageRefreshCached];
                //            cell_Favorite.Image_PalyBuutton.hidden=NO;
                //
                //
                //        }
                
                
                
                //        UIFont *name1 = [UIFont fontWithName:@"SanFranciscoDisplay-Bold" size:14.0];
                //        NSDictionary *arialDict = [NSDictionary dictionaryWithObject:name1 forKey:NSFontAttributeName];
                //        NSMutableAttributedString *aAttrString = [[NSMutableAttributedString alloc] initWithString:[dic_worldexp valueForKey:@"usersname"] attributes: arialDict];
                //
                //        UIFont *name2 = [UIFont fontWithName:@"SanFranciscoDisplay-SemiBold" size:14.0];
                //        NSDictionary *verdanaDict = [NSDictionary dictionaryWithObject:name2 forKey:NSFontAttributeName];
                //        NSMutableAttributedString *vAttrString = [[NSMutableAttributedString alloc]initWithString: @" Challenges " attributes:verdanaDict];
                //        
                //        
                //        UIFont *name3 = [UIFont fontWithName:@"SanFranciscoDisplay-Bold" size:14.0];
                //        NSDictionary *verdanaDict2 = [NSDictionary dictionaryWithObject:name3 forKey:NSFontAttributeName];
                //        NSMutableAttributedString *cAttrString = [[NSMutableAttributedString alloc]initWithString:[dic_worldexp valueForKey:@"challengerdetails"] attributes:verdanaDict2];
                //        
                //        [aAttrString appendAttributedString:vAttrString];
                //        [aAttrString appendAttributedString:cAttrString];
                //        
                //        
                //        cell_Favorite.Label_Changename.attributedText = aAttrString;
                
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
                
               
                
            NSDictionary * dic_value=[Array_VediosData objectAtIndex:indexPath.row];
                
        cell_Four.Label_DaysAgo.text=[NSString stringWithFormat:@"%@",[dic_value valueForKey:@"posttime"]];
           
              
                cell_Four.ImageLeft_LeftProfile.tag=indexPath.row;
                
                
            NSURL *urlLef=[NSURL URLWithString:[dic_value valueForKey:@"thumbnailurl"]];
                
            [cell_Four.ImageLeft_LeftProfile sd_setImageWithURL:urlLef placeholderImage:[UIImage imageNamed:@"DefaultImg.jpg"] options:SDWebImageRefreshCached];
                
             NSURL *urlRight=[NSURL URLWithString:[dic_value valueForKey:@"profileimage"]];
            [cell_Four.ImageRight_RightProfile sd_setImageWithURL:urlRight placeholderImage:[UIImage imageNamed:@"DefaultImg.jpg"] options:SDWebImageRefreshCached];
                
                
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
  return self.view.frame.size.width;
    }
    if(indexPath.section==1)
    {
        return 101;
    }
    if(indexPath.section==2)
    {
        return 108;
    }
    if(indexPath.section==3)
    {
        return 125;
    }
    
    return 0;
    
  
}
-(void)Button_Back_Action:(UIButton *)sender
{
    [player pause];
    player = nil;
    [timer invalidate];
    timer = nil;
    player = nil;
    
    
        for (UIView *view in cell_one.PlayerView.subviews)
        {
            [view removeFromSuperview];
        }
    
        [cell_one.contentView removeFromSuperview];
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section==3)
    {
         Flag_watch=@"yes";
        
     Str_urlVedio=[NSString stringWithFormat:@"%@",[[Array_VediosData objectAtIndex:indexPath.row]valueForKey:@"videourl" ]];
        indexVedio=indexPath.row;
        
        [Tableview_Explore reloadData];
    }
}
-(void)targetMethod:(NSTimer *)timer1
{
//    avPlayer.currentItem!.playbackLikelyToKeepUp
    
        if (item.playbackBufferEmpty)
        {
            cell_one.indicator_loading.hidden=NO;
        }
    else
    {
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
        
        [timer invalidate];
        timer = nil;
       // Str_urlVedio=[NSString stringWithFormat:@"%@",[[Array_VediosData objectAtIndex:indexVedio]valueForKey:@"videourl" ]];
        str_Userid2val=[NSString stringWithFormat:@"%@",[[Array_VediosData objectAtIndex:indexVedio]valueForKey:@"useridvideo" ]];
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
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView.contentOffset.y<=0) {
        scrollView.contentOffset = CGPointZero;
    }
}
@end
