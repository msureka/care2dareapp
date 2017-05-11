//
//  ProfilepageViewController.m
//  care2Dare
//
//  Created by Spiel's Macmini on 3/6/17.
//  Copyright © 2017 Spiel's Macmini. All rights reserved.
//

#import "ProfilepageViewController.h"
#import "AccountSettViewController.h"
#import "UIImageView+WebCache.h"
#import "ProfileFriendsViewController.h"
#import "ProfileChallengesViewController.h"
#import "ProfileNotificationViewController.h"
#import "SBJsonParser.h"
#import "Reachability.h"
#import "ContributeDaetailPageViewController.h"
#import "AcceptContributeDetailViewController.h"
@interface ProfilepageViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    CALayer *borderBottom_topheder,*borderBottom_Public,*borderBottom_Private;
    NSString *cellChecking,*Str_Frends,*str_challenges,*Str_name,*Str_profileurl;
    UIView *sectionView;
      UIView *Button_Public,*Button_Private;
    UIImageView *Image_ButtinPublic,*Image_ButtonPrivate;
    NSUserDefaults * defaults;
    NSMutableArray * Array_AllData,* Array_Public,*Array_Private,*Array_Profile;
    NSDictionary *urlplist;
    CALayer *Bottomborder_Cell2;
    
}
@end

@implementation ProfilepageViewController
@synthesize view_Topheader,cell_Public,cell_Private,cell_Profile,view_CreateChallenges,Button_SetValues;
- (void)viewDidLoad {
    [super viewDidLoad];
    defaults=[[NSUserDefaults alloc]init];
      borderBottom_topheder = [CALayer layer];
    
     self.tabBarController.tabBar.hidden=NO;
      cellChecking=@"public";
    
    
    
    if ( [[defaults valueForKey:@"budge"]isEqualToString:@"0"] )
    {
        [Button_SetValues setBackgroundImage:[UIImage imageNamed:@"profile_circle.png"] forState:UIControlStateNormal];
        
        [Button_SetValues setTitle:@"0" forState:UIControlStateNormal];
        
    }
    else
    {
        [Button_SetValues setBackgroundImage:[UIImage imageNamed:@"redcircle.png"] forState:UIControlStateNormal];
        [Button_SetValues setTitle:[defaults valueForKey:@"budge"] forState:UIControlStateNormal];
    }
    
    
    
   str_challenges=[defaults valueForKey:@"challenges"];
    Str_Frends=[defaults valueForKey:@"friends"];
    Str_name=[defaults valueForKey:@"name"];
    Str_profileurl=[defaults valueForKey:@"profileimage"];
    Str_profileurl=[[Array_Profile objectAtIndex:0]valueForKey:@"profileimage"];
    
    NSString *plistPath = [[NSBundle mainBundle]pathForResource:@"UrlName" ofType:@"plist"];
    urlplist = [NSDictionary dictionaryWithContentsOfFile:plistPath];
    
    view_CreateChallenges.hidden=YES;
    
    UITapGestureRecognizer *ViewTap11 =[[UITapGestureRecognizer alloc] initWithTarget:self
                                                                               action:@selector(ViewTapTapped_Challenges:)];
    [view_CreateChallenges addGestureRecognizer:ViewTap11];
    
    
    
    
    UIColor *bgRefreshColor = [UIColor whiteColor];
    
    // Creating refresh control
    self.refreshControl = [[UIRefreshControl alloc] init];
    
    [self.refreshControl setBackgroundColor:bgRefreshColor];
    self.refreshControl = self.refreshControl;
    
    // Creating view for extending background color
    CGRect frame = _Tableview_Profile.bounds;
    frame.origin.y = -frame.size.height;
    UIView* bgView = [[UIView alloc] initWithFrame:frame];
    bgView.backgroundColor = bgRefreshColor;
    
    // Adding the view below the refresh control
    [_Tableview_Profile insertSubview:bgView atIndex:0];
    self.refreshControl = self.refreshControl;
    
    self.refreshControl.tintColor = [UIColor blackColor];
    [self.refreshControl addTarget:self
                            action:@selector(PulltoRefershtable)
                  forControlEvents:UIControlEventValueChanged];
    
    [_Tableview_Profile addSubview:self.refreshControl];
    
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(Refresh_UpdatedBudge) name:@"UpdatedBudge" object:nil];
    
    [self ClienserverCommAll];

    [self ClientserverCommprofile];
    
}
- (void)Refresh_UpdatedBudge
{
    if ( [[defaults valueForKey:@"budge"]isEqualToString:@"0"] )
    {
         [Button_SetValues setBackgroundImage:[UIImage imageNamed:@"profile_circle.png"] forState:UIControlStateNormal];
        
       [Button_SetValues setTitle:@"0" forState:UIControlStateNormal];
        
    }
  else
  {
    [Button_SetValues setBackgroundImage:[UIImage imageNamed:@"redcircle.png"] forState:UIControlStateNormal];
    [Button_SetValues setTitle:[defaults valueForKey:@"budge"] forState:UIControlStateNormal];
  }
}
- (void) viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    borderBottom_topheder.backgroundColor =[UIColor colorWithRed:186/255.0 green:188/255.0 blue:190/255.0 alpha:1.0].CGColor;
    borderBottom_topheder.frame = CGRectMake(0, view_Topheader.frame.size.height-1, view_Topheader.frame.size.width,1);
    [view_Topheader.layer addSublayer:borderBottom_topheder];

}
-(void)PulltoRefershtable
{
    
[self ClienserverCommAll];
   [self ClientserverCommprofile];
  
    [_Tableview_Profile reloadData];
    [self.refreshControl endRefreshing];
    
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
   
     self.tabBarController.tabBar.hidden=NO;
    [self ClienserverCommAll];
    [self ClientserverCommprofile];
    
    [_Tableview_Profile reloadData];
}

-(void)ClienserverCommAll
{
    [self.view endEditing:YES];
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
        
        NSString *reqStringFUll=[NSString stringWithFormat:@"%@=%@",userid,useridVal];
        
        
        
#pragma mark - swipe sesion
        
        NSURLSession *session = [NSURLSession sessionWithConfiguration: [NSURLSessionConfiguration defaultSessionConfiguration] delegate: nil delegateQueue: [NSOperationQueue mainQueue]];
        
        NSURL *url;
        NSString *  urlStrLivecount=[urlplist valueForKey:@"profile_explore"];;
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
                                                     
        Array_AllData=[[NSMutableArray alloc]init];
        SBJsonParser *objSBJsonParser = [[SBJsonParser alloc]init];
        Array_AllData=[objSBJsonParser objectWithData:data];
                                                     
      NSString * ResultString=[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
                                                     
 //Array_LodingPro=[NSJSONSerialization JSONObjectWithData:webData_Swipe options:kNilOptions error:nil];
                                                     
     ResultString = [ResultString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
                                                     
    ResultString = [ResultString stringByReplacingOccurrencesOfString:@"\t" withString:@""];
                                                     
    NSLog(@"Array_AllData %@",Array_AllData);
                                                     
                                                     
    NSLog(@"Array_AllData ResultString %@",ResultString);
                                                     
                                                     
        if (Array_AllData.count !=0)
         {
        
             view_CreateChallenges.hidden=YES;
             Array_Public=[[NSMutableArray alloc]init];
             Array_Private=[[NSMutableArray alloc]init];
             
         for (int i=0; i<Array_AllData.count; i++)
             
         {
        if ([[[Array_AllData objectAtIndex:i]valueForKey:@"challengetype"]isEqualToString:@"PUBLIC"])
            {
            [Array_Public addObject:[Array_AllData objectAtIndex:i]];
                
            }
            else
            {
            [Array_Private addObject:[Array_AllData objectAtIndex:i]];
                     }
                    }
             if (Array_Private.count!=0 && Array_Public.count==0)
               {
                  [self ViewTapTapped_Private:nil];
                                                    
                                                }
                   [_Tableview_Profile reloadData];
                                                         
                                    }
                                   else
                                   {
                   view_CreateChallenges.hidden=NO;
                                       
                                    }
                                                     

                    if ([ResultString isEqualToString:@"nouserid"])
                       {
                 view_CreateChallenges.hidden=YES;
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Oops" message:@"Your account does not exist or seems to have been suspended. Please contact admin." preferredStyle:UIAlertControllerStyleAlert];
                                                         
            UIAlertAction *actionOk = [UIAlertAction actionWithTitle:@"Ok"
            style:UIAlertActionStyleDefault handler:nil];
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
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    if(section==0)
    {
        
        
        return 1;
        
    }
    if(section==1)
    {
        
        if ([cellChecking isEqualToString:@"public"])
        {
            return Array_Public.count;
        }
        else if ([cellChecking isEqualToString:@"private"])
        {
            return Array_Private.count;
        }
                return 0;
    }
    
    
    
    return 0;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    static NSString *mycellid2=@"ProfileCell";
    static NSString *cellId2=@"CellPublic";
    static NSString *cellId3=@"CellPrivate";
    
    
    switch (indexPath.section)
    {
            
        case 0:
        {
            cell_Profile = (profilePageTableViewCell*)[tableView dequeueReusableCellWithIdentifier:mycellid2 forIndexPath:indexPath];
     
            
            
            
            
      
            
            
            NSURL *url=[NSURL URLWithString:Str_profileurl];
            
[cell_Profile.Image_ProfileImg sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"DefaultImg.jpg"] options:SDWebImageRefreshCached];
            
            cell_Profile.Label_Friends22.userInteractionEnabled=YES;
             cell_Profile.Label_Challenges11.userInteractionEnabled=YES;
            
    UITapGestureRecognizer *ViewTap11 =[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(ViewTapTapped_Label_Friends22:)];
            [cell_Profile.Label_Friends22 addGestureRecognizer:ViewTap11];
            
            
            UITapGestureRecognizer *ViewTap22 =[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(ViewTapTapped_Label_Challenges11:)];
            [cell_Profile.Label_Challenges11 addGestureRecognizer:ViewTap22];
            
            
                cell_Profile.Name_profile.text=Str_name;
                cell_Profile.Label_Challenges.text=str_challenges;
                cell_Profile.Label_Friends.text=Str_Frends;
 
            
            return cell_Profile;
            
            
        }
            break;
        case 1:
            
        {
            if ([cellChecking isEqualToString:@"public"])
            {
                
                
                cell_Public = [[[NSBundle mainBundle]loadNibNamed:@"PublicTableViewCell" owner:self options:nil] objectAtIndex:0];
                
                
                
                
                if (cell_Public == nil)
                {
                    
                    cell_Public = [[PublicTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellId3];
                    
                    
                }
                
                Bottomborder_Cell2 = [CALayer layer];
                Bottomborder_Cell2.backgroundColor = [UIColor colorWithRed:241/255.0 green:241/255.0 blue:241/255.0 alpha:1.0].CGColor;
                Bottomborder_Cell2.frame = CGRectMake(0, cell_Public.frame.size.height-1, cell_Public.frame.size.width, 1);
                [cell_Public.layer addSublayer:Bottomborder_Cell2];
                
                NSDictionary * dic_worldexp=[Array_Public objectAtIndex:indexPath.row];
                
                
    if ([[dic_worldexp valueForKey:@"accepted"]isEqualToString:@"yes"])
                {
                    cell_Public.Image_NewFrnd.hidden=YES;
                    
                }
                else
                {
                 cell_Public.Image_NewFrnd.hidden=NO;
                }
                
                
                
                
                
                cell_Public.Label_Raised.text=[NSString stringWithFormat:@"%@%@",@"$",[dic_worldexp valueForKey:@"backamount"]];
                cell_Public.Label_Backer.text=[NSString stringWithFormat:@"%@",[dic_worldexp valueForKey:@"backers"]];
                cell_Public.Label_Titile.text=[NSString stringWithFormat:@"%@",[dic_worldexp valueForKey:@"title"]];
                NSString *text=[NSString stringWithFormat:@"%@",[dic_worldexp valueForKey:@"title"]];
                
                
                CGRect textRect = [text boundingRectWithSize:cell_Public.Label_Titile.frame.size options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:cell_Public.Label_Titile.font} context:nil];
                
                int numberOfLines = textRect.size.height / cell_Public.Label_Titile.font.pointSize;;
                if (numberOfLines==1)
                {
                    [cell_Public.Label_Titile setFrame:CGRectMake(cell_Public.Label_Titile.frame.origin.x, cell_Public.Label_Titile.frame.origin.y, cell_Public.Label_Titile.frame.size.width, cell_Public.Label_Titile.frame.size.height/2)];
                }
                
                
                
                NSLog(@"number of lines=%d",numberOfLines);
                
                cell_Public.Label_Time.text=[NSString stringWithFormat:@"%@",[dic_worldexp valueForKey:@"createtime"]];
                // cell_WorldExp.Label_Time.text=[dic_worldexp valueForKey:@"challengeid"];
                // cell_WorldExp.Label_Time.text=[dic_worldexp valueForKey:@"challengerdetails"];
                
                //cell_WorldExp.Label_Time.text=[dic_worldexp valueForKey:@"mediatype"];
                // cell_WorldExp.Label_Time.text=[dic_worldexp valueForKey:@"mediaurl"];
                // cell_WorldExp.Label_Time.text=[dic_worldexp valueForKey:@"noofchallengers"];
                // cell_WorldExp.Label_Time.text=[dic_worldexp valueForKey:@"payperchallenger"];
                
                
                if ([[dic_worldexp valueForKey:@"mediatype"] isEqualToString:@"IMAGE"])
                {
                    cell_Public.Image_PalyBuutton.hidden=YES;
                    
                    NSURL *url=[NSURL URLWithString:[dic_worldexp valueForKey:@"mediaurl"]];
                    
                    [cell_Public.Image_Profile sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"DefaultImg.jpg"] options:SDWebImageRefreshCached];
                }
                else
                {
                    
                    NSURL *url=[NSURL URLWithString:[dic_worldexp valueForKey:@"mediathumbnailurl"]];
                    
                    [cell_Public.Image_Profile sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"DefaultImg.jpg"] options:SDWebImageRefreshCached];
                    cell_Public.Image_PalyBuutton.hidden=NO;
                    
                    
                }
                
                
                
                UIFont *name1 = [UIFont fontWithName:@"SanFranciscoDisplay-Bold" size:14.0];
                NSDictionary *arialDict = [NSDictionary dictionaryWithObject:name1 forKey:NSFontAttributeName];
                NSMutableAttributedString *aAttrString = [[NSMutableAttributedString alloc] initWithString:[dic_worldexp valueForKey:@"usersname"] attributes: arialDict];
                
                UIFont *name2 = [UIFont fontWithName:@"SanFranciscoDisplay-SemiBold" size:14.0];
                NSDictionary *verdanaDict = [NSDictionary dictionaryWithObject:name2 forKey:NSFontAttributeName];
                NSMutableAttributedString *vAttrString = [[NSMutableAttributedString alloc]initWithString: @" Challenges " attributes:verdanaDict];
                
                
                UIFont *name3 = [UIFont fontWithName:@"SanFranciscoDisplay-Bold" size:14.0];
                NSDictionary *verdanaDict2 = [NSDictionary dictionaryWithObject:name3 forKey:NSFontAttributeName];
                NSMutableAttributedString *cAttrString = [[NSMutableAttributedString alloc]initWithString:[dic_worldexp valueForKey:@"challengerdetails"] attributes:verdanaDict2];
                
                [aAttrString appendAttributedString:vAttrString];
                [aAttrString appendAttributedString:cAttrString];
                
                
                cell_Public.Label_Changename.attributedText = aAttrString;

                
                return cell_Public;
                
            }
            if ([cellChecking isEqualToString:@"private"])
            {
            
                
                cell_Private = [[[NSBundle mainBundle]loadNibNamed:@"PrivateTableViewCell" owner:self options:nil] objectAtIndex:0];
               
                
                if (cell_Private == nil)
                {
                    
                    cell_Private = [[PrivateTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellId2];
                }
                
                
                NSDictionary * dic_worldexp=[Array_Private objectAtIndex:indexPath.row];
                
                if ([[dic_worldexp valueForKey:@"accepted"]isEqualToString:@"yes"])
                {
                    cell_Private.Image_NewFrnd.hidden=YES;
                    
                }
                else
                {
                    cell_Private.Image_NewFrnd.hidden=NO;
                }

                
                
                
                
                
                cell_Private.Label_Raised.text=[NSString stringWithFormat:@"%@%@",@"$",[dic_worldexp valueForKey:@"backamount"]];
                cell_Private.Label_Backer.text=[NSString stringWithFormat:@"%@",[dic_worldexp valueForKey:@"backers"]];
                cell_Private.Label_Titile.text=[NSString stringWithFormat:@"%@",[dic_worldexp valueForKey:@"title"]];
                NSString *text=[NSString stringWithFormat:@"%@",[dic_worldexp valueForKey:@"title"]];
                
                
                CGRect textRect = [text boundingRectWithSize:cell_Private.Label_Titile.frame.size options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:cell_Private.Label_Titile.font} context:nil];
                
                int numberOfLines = textRect.size.height / cell_Private.Label_Titile.font.pointSize;;
                if (numberOfLines==1)
                {
                    [cell_Private.Label_Titile setFrame:CGRectMake(cell_Private.Label_Titile.frame.origin.x, cell_Private.Label_Titile.frame.origin.y, cell_Private.Label_Titile.frame.size.width, cell_Private.Label_Titile.frame.size.height/2)];
                }
                
                
                
                NSLog(@"number of lines=%d",numberOfLines);
                
                cell_Private.Label_Time.text=[NSString stringWithFormat:@"%@",[dic_worldexp valueForKey:@"createtime"]];
                // cell_WorldExp.Label_Time.text=[dic_worldexp valueForKey:@"challengeid"];
                // cell_WorldExp.Label_Time.text=[dic_worldexp valueForKey:@"challengerdetails"];
                
                //cell_WorldExp.Label_Time.text=[dic_worldexp valueForKey:@"mediatype"];
                // cell_WorldExp.Label_Time.text=[dic_worldexp valueForKey:@"mediaurl"];
                // cell_WorldExp.Label_Time.text=[dic_worldexp valueForKey:@"noofchallengers"];
                // cell_WorldExp.Label_Time.text=[dic_worldexp valueForKey:@"payperchallenger"];
                
                
                if ([[dic_worldexp valueForKey:@"mediatype"] isEqualToString:@"IMAGE"])
                {
                    cell_Private.Image_PalyBuutton.hidden=YES;
                    
                    NSURL *url=[NSURL URLWithString:[dic_worldexp valueForKey:@"mediaurl"]];
                    
                    [cell_Private.Image_Profile sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"DefaultImg.jpg"] options:SDWebImageRefreshCached];
                }
                else
                {
                    
                    NSURL *url=[NSURL URLWithString:[dic_worldexp valueForKey:@"mediathumbnailurl"]];
                    
                    [cell_Private.Image_Profile sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"DefaultImg.jpg"] options:SDWebImageRefreshCached];
                    cell_Private.Image_PalyBuutton.hidden=NO;
                    
                    
                }
                
                
                
                UIFont *name1 = [UIFont fontWithName:@"SanFranciscoDisplay-Bold" size:14.0];
                NSDictionary *arialDict = [NSDictionary dictionaryWithObject:name1 forKey:NSFontAttributeName];
                NSMutableAttributedString *aAttrString = [[NSMutableAttributedString alloc] initWithString:[dic_worldexp valueForKey:@"usersname"] attributes: arialDict];
                
                UIFont *name2 = [UIFont fontWithName:@"SanFranciscoDisplay-SemiBold" size:14.0];
                NSDictionary *verdanaDict = [NSDictionary dictionaryWithObject:name2 forKey:NSFontAttributeName];
                NSMutableAttributedString *vAttrString = [[NSMutableAttributedString alloc]initWithString: @" Challenges " attributes:verdanaDict];
                
                
                UIFont *name3 = [UIFont fontWithName:@"SanFranciscoDisplay-Bold" size:14.0];
                NSDictionary *verdanaDict2 = [NSDictionary dictionaryWithObject:name3 forKey:NSFontAttributeName];
                NSMutableAttributedString *cAttrString = [[NSMutableAttributedString alloc]initWithString:[dic_worldexp valueForKey:@"challengerdetails"] attributes:verdanaDict2];
                
                [aAttrString appendAttributedString:vAttrString];
                [aAttrString appendAttributedString:cAttrString];
                
                
                cell_Private.Label_Changename.attributedText = aAttrString;
                
          
                
                
                
                
                return cell_Private;
                
            }
        
            
        }
            
            break;
    }
   // return nil;
  abort();  
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return 2;
    
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section==0)
    {
        sectionView=[[UIView alloc]initWithFrame:CGRectMake(0, 0,375,100)];
        [sectionView setBackgroundColor:[UIColor whiteColor]];
        
        
        sectionView.tag=section;
        
        
    }
    if (section==1)
    {
        
        sectionView=[[UIView alloc]initWithFrame:CGRectMake(0, -38,self.view.frame.size.width,38)];
        [sectionView setBackgroundColor:[UIColor whiteColor]];
        //        sectionView.layer.borderWidth=1.0f;
        //        sectionView.layer.borderColor=[UIColor redColor].CGColor;
        /*---------- Borderleft,right,top,bottom for View------------*/
        
        //        sectionView.clipsToBounds = YES;
        //        CALayer *borderBottom = [CALayer layer];
        //      borderBottom.backgroundColor = [UIColor blueColor].CGColor;
        //        borderBottom.frame = CGRectMake(0, sectionView.frame.size.height - 1, sectionView.frame.size.width, 1);
        //        [sectionView.layer addSublayer:borderBottom];
        //
        //        CALayer *borderTop = [CALayer layer];
        //        borderTop.backgroundColor = [UIColor blueColor].CGColor;
        //
        //        borderTop.frame = CGRectMake(0, 0, sectionView.frame.size.width, 1);
        //        [sectionView.layer addSublayer:borderTop];
        
        
        
        /*---------- End color Borders------------*/
        
        
        Button_Public=[[UIView alloc]initWithFrame:CGRectMake(0,0, self.view.frame.size.width/2,sectionView.frame.size.height-2)];
        
        
        Button_Public.tag=section;
        
        
  
        
        Button_Private.tag=section;
 
       
        Button_Private=[[UIView alloc]initWithFrame:CGRectMake((self.view.frame.size.width/2),0, self.view.frame.size.width/2,sectionView.frame.size.height-2)];
        
        
        
        UITapGestureRecognizer *ViewTap11 =[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(ViewTapTapped_Public:)];
        [Button_Public addGestureRecognizer:ViewTap11];
        //[image_ExpWorld addGestureRecognizer:ViewTap11];
        
        UITapGestureRecognizer *ViewTap22 =[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(ViewTapTapped_Private:)];
        [Button_Private addGestureRecognizer:ViewTap22];
        
       
        Image_ButtinPublic=[[UIImageView alloc]initWithFrame:CGRectMake(30,6, 98,24)];
        Image_ButtonPrivate=[[UIImageView alloc]initWithFrame:CGRectMake(30,6, 98,24)];
        
        Image_ButtinPublic.tag=section;
        Image_ButtonPrivate.tag=section;
        
        Image_ButtinPublic.contentMode=UIViewContentModeScaleAspectFit;
        Image_ButtonPrivate.contentMode=UIViewContentModeScaleAspectFit;
        
        
        CALayer *borderBottom = [CALayer layer];
        borderBottom.backgroundColor =[UIColor colorWithRed:241/255.0 green:241/255.0 blue:241/255.0 alpha:1.0].CGColor;
        borderBottom.frame = CGRectMake(0, Button_Public.frame.size.height - 1, Button_Public.frame.size.width,1);
        [Button_Public.layer addSublayer:borderBottom];
        
        
        
       borderBottom_Private = [CALayer layer];
        
        
        borderBottom_Private.backgroundColor = [UIColor colorWithRed:241/255.0 green:241/255.0 blue:241/255.0 alpha:1.0].CGColor;
        borderBottom_Private.frame = CGRectMake(0, Button_Private.frame.size.height-1, Button_Private.frame.size.width, 1);
        [Button_Private.layer addSublayer:borderBottom_Private];
        
        
        
        if ([cellChecking isEqualToString:@"public"])
        {
            Button_Public.backgroundColor=[UIColor whiteColor];
            Button_Private.backgroundColor=[UIColor colorWithRed:241/255.0 green:241/255.0 blue:241/255.0 alpha:1];
            [Image_ButtinPublic setImage:[UIImage imageNamed:@"profile_publictext1.png"]];
            
            [Image_ButtonPrivate setImage:[UIImage imageNamed:@"profile_privatetext.png"]];
            
           
            
            
            
        }
        if ([cellChecking isEqualToString:@"private"])
        {
            Button_Private.backgroundColor=[UIColor whiteColor];
            Button_Public.backgroundColor=[UIColor colorWithRed:241/255.0 green:241/255.0 blue:241/255.0 alpha:1];
           
          
            
            [Image_ButtinPublic setImage:[UIImage imageNamed:@"profile_publictext.png"]];
            
            [Image_ButtonPrivate setImage:[UIImage imageNamed:@"profile_privatetext1.png"]];
            
           
        }
        
        Image_ButtonPrivate.center = Button_Public.center;
         Image_ButtinPublic.center = Button_Public.center;
        
        [Button_Public addSubview:Image_ButtinPublic];
        [Button_Private addSubview:Image_ButtonPrivate];
        
        [sectionView addSubview:Button_Public];
        [sectionView addSubview:Button_Private];
        
       
        NSLog(@"Cordinate sectionButton_Public==%f",Button_Public.frame.origin.x);
         NSLog(@"Cordinate sectionButton_Public==%f",Button_Public.frame.origin.y);
         NSLog(@"Cordinate sectionButton_Private==%f",Button_Private.frame.origin.x);
         NSLog(@"Cordinate sectionButton_Private==%f",Button_Private.frame.origin.y);
       
        
        NSLog(@"Cordinate center==%f",Button_Public.center.x);
        NSLog(@"Cordinate center==%f",Button_Private.center.x);

        
        sectionView.tag=section;
        
    }
  
    
    //         /********** Add a custom Separator with Section view *******************/
    //         UIView* separatorLineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0,375, 2)];
    //         separatorLineView.backgroundColor = [UIColor whiteColor];
    //         [sectionView addSubview:separatorLineView];
    return  sectionView;
    
    
    
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
    //
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section==0)
    {
        return 140;
    }
    if (indexPath.section==1)
    {
        return 140;
    }
    return 0;
    
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==1)
    {
        ContributeDaetailPageViewController * set=[self.storyboard instantiateViewControllerWithIdentifier:@"ContributeDaetailPageViewController"];
        
        AcceptContributeDetailViewController * set2=[self.storyboard instantiateViewControllerWithIdentifier:@"AcceptContributeDetailViewController"];
        
        
        NSDictionary *  didselectDic;
         NSMutableArray * Array_new=[[NSMutableArray alloc]init];
        if ([[NSString stringWithFormat:@"%@",cellChecking] isEqualToString:@"public"])
        {
            didselectDic=[Array_Public  objectAtIndex:indexPath.row];
            cell_Public = [_Tableview_Profile cellForRowAtIndexPath:indexPath];
           
            [Array_new addObject:didselectDic];
            if ([[NSString stringWithFormat:@"%@",[didselectDic valueForKey:@"accepted"] ]isEqualToString:@"yes"])
            {
                 set.ProfileImgeData =cell_Public.Image_Profile.image;
                set.AllArrayData =Array_new;
                  [self.navigationController pushViewController:set animated:YES];
 
            }
            else
            {
               set2.ProfileImgeData =cell_Public.Image_Profile.image;
                set2.AllArrayData =Array_new;
                [self.navigationController pushViewController:set2 animated:YES];
            }
            
            
        }
        if ([cellChecking isEqualToString:@"private"])
        {
            didselectDic=[Array_Private  objectAtIndex:indexPath.row];
            cell_Private = [_Tableview_Profile cellForRowAtIndexPath:indexPath];
           [Array_new addObject:didselectDic];
            
            if ([[didselectDic valueForKey:@"accepted"]isEqualToString:@"yes"])
            {
                
                 set.ProfileImgeData =cell_Private.Image_Profile.image;
                set.AllArrayData =Array_new;
                [self.navigationController pushViewController:set animated:YES];
                
            }
            else
            {
             set2.ProfileImgeData =cell_Private.Image_Profile.image;
                set2.AllArrayData =Array_new;
                [self.navigationController pushViewController:set2 animated:YES];
            }
        }
        
       
              NSLog(@"Array_new11=%@",Array_new);;
        
        
        
        
        NSLog(@"Array_new22=%@",Array_new);;
        NSLog(@"indexPathrow=%ld",(long)indexPath.row);;
        
      
    }
   
}


- (void)ViewTapTapped_Public:(UITapGestureRecognizer *)recognizer
{
    
    Button_Public.tag=100;
    cellChecking=@"public";
    [self ClienserverCommAll];
    [_Tableview_Profile reloadData];
    
}
- (void)ViewTapTapped_Private:(UITapGestureRecognizer *)recognizer
    {
   
    cellChecking=@"private";
    Button_Private.tag=101;
    [self ClienserverCommAll];
        [_Tableview_Profile reloadData];
        
}
- (void)ViewTapTapped_Label_Friends22:(UITapGestureRecognizer *)recognizer
{
    ProfileFriendsViewController * set=[self.storyboard instantiateViewControllerWithIdentifier:@"ProfileFriendsViewController"];
    set.Str_profiletypr=@"SELF";
    [self.navigationController pushViewController:set animated:YES];
    
}
- (void)ViewTapTapped_Label_Challenges11:(UITapGestureRecognizer *)recognizer
{
    
    
    ProfileChallengesViewController * set=[self.storyboard instantiateViewControllerWithIdentifier:@"ProfileChallengesViewController"];
    [self.navigationController pushViewController:set animated:YES];
    
}


-(IBAction)SettingButton_Action:(id)sender
{
AccountSettViewController * set=[self.storyboard instantiateViewControllerWithIdentifier:@"AccountSettViewController"];
  [self.navigationController pushViewController:set animated:YES];
  
 //  [self performSegueWithIdentifier:@"sa" sender:self];
}
-(IBAction)NotificationButton_Action:(id)sender
{
    ProfileNotificationViewController * set=[self.storyboard instantiateViewControllerWithIdentifier:@"ProfileNotificationViewController"];
    [self.navigationController pushViewController:set animated:YES];
    
    //  [self performSegueWithIdentifier:@"sa" sender:self];
}

-(void)ClientserverCommprofile
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
        NSString *useridval1= [defaults valueForKey:@"userid"];
        
        NSString *profiletype= @"profiletype";
        NSString *profiletypeval= @"SELF";
        
        
        NSString *reqStringFUll=[NSString stringWithFormat:@"%@=%@&%@=%@",userid1,useridval1,profiletype,profiletypeval];
        
        
        
#pragma mark - swipe sesion
        
        NSURLSession *session = [NSURLSession sessionWithConfiguration: [NSURLSessionConfiguration defaultSessionConfiguration] delegate: nil delegateQueue: [NSOperationQueue mainQueue]];
        
        NSURL *url;
        NSString *  urlStrLivecount=[urlplist valueForKey:@"profile"];;
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
                                                     
        Array_Profile=[[NSMutableArray alloc]init];
        SBJsonParser *objSBJsonParser = [[SBJsonParser alloc]init];
        Array_Profile=[objSBJsonParser objectWithData:data];
                                                     
        NSString * ResultString=[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        ResultString = [ResultString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
        ResultString = [ResultString stringByReplacingOccurrencesOfString:@"\t" withString:@""];
                                                     
        NSLog(@"Array_AllData %@",Array_Public);
                                                     
    NSLog(@"Array_AllData ResultString %@",ResultString);
        if ([ResultString isEqualToString:@"nouserid"])
                {
                                                         
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Oops" message:@"Your account does not exist or seems to have been suspended. Please contact admin." preferredStyle:UIAlertControllerStyleAlert];
                                                         
        UIAlertAction *actionOk = [UIAlertAction actionWithTitle:@"Ok"
                style:UIAlertActionStyleDefault
            handler:nil];
        [alertController addAction:actionOk];
        [self presentViewController:alertController animated:YES completion:nil];
                }
    if (Array_Profile.count !=0)
            {
        str_challenges=[[Array_Profile objectAtIndex:0]valueForKey:@"challenges"];
        Str_Frends=[[Array_Profile objectAtIndex:0]valueForKey:@"friends"];
                
                Str_name=[[Array_Profile objectAtIndex:0]valueForKey:@"name"];
                
                Str_profileurl=[[Array_Profile objectAtIndex:0]valueForKey:@"profileimage"];

                
                
                [defaults setObject:str_challenges forKey:@"challenges"];
               
                
                [defaults setObject:Str_Frends forKey:@"friends"];
                
                [defaults setObject:Str_name forKey:@"name"];
                
                
                [defaults setObject:Str_profileurl forKey:@"profileimage"];
                
                [defaults synchronize];
                  [_Tableview_Profile reloadData];
                                                     
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
- (void)ViewTapTapped_Challenges:(UITapGestureRecognizer *)recognizer
{
}
@end
