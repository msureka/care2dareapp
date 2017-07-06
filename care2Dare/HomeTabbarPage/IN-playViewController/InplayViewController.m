//
//  InplayViewController.m
//  care2Dare
//
//  Created by Spiel's Macmini on 6/26/17.
//  Copyright © 2017 Spiel's Macmini. All rights reserved.
//

#import "InplayViewController.h"
#import "SBJsonParser.h"
#import "Reachability.h"
#import "UIImageView+WebCache.h"
#import "ContributeDaetailPageViewController.h"
#import "AcceptContributeDetailViewController.h"
@interface InplayViewController ()
{
    
    CALayer *borderBottom_topheder,*borderBottom_Public,*borderBottom_Private;
    UIImage *chosenImage;
    NSString *cellChecking,*Str_Frends,*str_challenges,*Str_name,*Str_profileurl,*SelectGallery;
    UIView *sectionView;
    UIView *Button_Public,*Button_Private;
    UIImageView *Image_ButtinPublic,*Image_ButtonPrivate;
    NSUserDefaults * defaults;
    NSMutableArray * Array_AllData,* Array_Public,*Array_Private,*Array_Profile;
    NSDictionary *urlplist;
    CALayer *Bottomborder_Cell2;
    NSString * ImageNSdata,*encodedImage;
}
@end

@implementation InplayViewController
@synthesize Button_Public,Button_Private,Image_ButtinPublic,Image_ButtonPrivate,Tableview_inplay,cell_Public,cell_Private,label_public,label_private,view_CreateChallenges;
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tabBarController.tabBar.hidden=NO;
    defaults=[[NSUserDefaults alloc]init];
    NSString *plistPath = [[NSBundle mainBundle]pathForResource:@"UrlName" ofType:@"plist"];
    urlplist = [NSDictionary dictionaryWithContentsOfFile:plistPath];
    
    view_CreateChallenges.hidden=YES;

//    UITapGestureRecognizer *ViewTap111 =[[UITapGestureRecognizer alloc] initWithTarget:self
//                                                                               action:@selector(ViewTapTapped_Challenges:)];
//    [view_CreateChallenges addGestureRecognizer:ViewTap111];
    
    UITapGestureRecognizer *ViewTap11 =[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(ViewTapTapped_Public:)];
    [Button_Public addGestureRecognizer:ViewTap11];
    //[image_ExpWorld addGestureRecognizer:ViewTap11];
    
    UITapGestureRecognizer *ViewTap22 =[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(ViewTapTapped_Private:)];
    [Button_Private addGestureRecognizer:ViewTap22];
    Image_ButtinPublic.contentMode=UIViewContentModeScaleAspectFit;
    Image_ButtonPrivate.contentMode=UIViewContentModeScaleAspectFit;
    
 
    
    borderBottom_Private = [CALayer layer];
    borderBottom_Public= [CALayer layer];
    
   
    
    label_public.textColor=[UIColor colorWithRed:65/255.0 green:65/255.0 blue:65/255.0 alpha:1];
    label_private.textColor=[UIColor colorWithRed:186/255.0 green:188/255.0 blue:190/255.0 alpha:1];
    
    Button_Public.clipsToBounds=YES;
    Button_Private.clipsToBounds=YES;
    
    
    Image_ButtonPrivate.clipsToBounds=YES;
    Image_ButtinPublic.clipsToBounds=YES;
    
    label_public.clipsToBounds=YES;
    label_private.clipsToBounds=YES;
    
    
    
    [Image_ButtinPublic setImage:[UIImage imageNamed:@"exploreworld.png"]];
    [Image_ButtonPrivate setImage:[UIImage imageNamed:@"privateinplay.png"]];
    
    
    
    
    Button_Public.tag=100;
    cellChecking=@"public";
    
    
    
    UIColor *bgRefreshColor = [UIColor whiteColor];
    
    // Creating refresh control
    self.refreshControl = [[UIRefreshControl alloc] init];
    
    [self.refreshControl setBackgroundColor:bgRefreshColor];
    self.refreshControl = self.refreshControl;
    
    // Creating view for extending background color
    CGRect frame = Tableview_inplay.bounds;
    frame.origin.y = -frame.size.height;
    UIView* bgView = [[UIView alloc] initWithFrame:frame];
    bgView.backgroundColor = bgRefreshColor;
    
    // Adding the view below the refresh control
    [Tableview_inplay insertSubview:bgView atIndex:0];
    self.refreshControl = self.refreshControl;
    
    self.refreshControl.tintColor = [UIColor blackColor];
    [self.refreshControl addTarget:self
                            action:@selector(PulltoRefershtable)
                  forControlEvents:UIControlEventValueChanged];
    
    [Tableview_inplay addSubview:self.refreshControl];
    [self ClienserverCommAll];
    
}
-(void)viewDidLayoutSubviews
{
    
    borderBottom_Public.backgroundColor =[UIColor colorWithRed:67/255.0 green:188/255.0 blue:255/255.0 alpha:1].CGColor;
    borderBottom_Public.frame = CGRectMake(0, Button_Public.frame.size.height-2.5, Button_Public.frame.size.width, 2.5);
    [Button_Public.layer addSublayer:borderBottom_Public];
    
    
    borderBottom_Private.backgroundColor = [UIColor colorWithRed:186/255.0 green:188/255.0 blue:190/255.0 alpha:1.0].CGColor;
    borderBottom_Private.frame = CGRectMake(0, Button_Private.frame.size.height-1, Button_Private.frame.size.width, 1);
    [Button_Private.layer addSublayer:borderBottom_Private];
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.tabBarController.tabBar.hidden=NO;
    [self ClienserverCommAll];
  
    
}

-(void)PulltoRefershtable
{
    
    [self ClienserverCommAll];
    [self.refreshControl endRefreshing];
    
}
- (void)ViewTapTapped_Public:(UITapGestureRecognizer *)recognizer
{
    label_public.textColor=[UIColor colorWithRed:65/255.0 green:65/255.0 blue:65/255.0 alpha:1];
    label_private.textColor=[UIColor colorWithRed:186/255.0 green:188/255.0 blue:190/255.0 alpha:1];
    
    Button_Public.clipsToBounds=YES;
    Button_Private.clipsToBounds=YES;
    
    
    Image_ButtonPrivate.clipsToBounds=YES;
    Image_ButtinPublic.clipsToBounds=YES;
    
    label_public.clipsToBounds=YES;
    label_private.clipsToBounds=YES;
    
    
    
    [Image_ButtinPublic setImage:[UIImage imageNamed:@"exploreworld.png"]];
    [Image_ButtonPrivate setImage:[UIImage imageNamed:@"privateinplay.png"]];
    
    
    
    borderBottom_Public.backgroundColor =[UIColor colorWithRed:67/255.0 green:188/255.0 blue:255/255.0 alpha:1].CGColor;
    borderBottom_Public.frame = CGRectMake(0, Button_Public.frame.size.height-2.5, Button_Public.frame.size.width, 2.5);
    [Button_Public.layer addSublayer:borderBottom_Public];
    
    
    
    
    borderBottom_Private.backgroundColor = [UIColor colorWithRed:186/255.0 green:188/255.0 blue:190/255.0 alpha:1.0].CGColor;
    borderBottom_Private.frame = CGRectMake(0, Button_Private.frame.size.height-1, Button_Private.frame.size.width, 1);
    [Button_Private.layer addSublayer:borderBottom_Private];
    
    Button_Public.tag=100;
    cellChecking=@"public";
    [Tableview_inplay reloadData];
    [self ClienserverCommAll];
    

    
}

- (void)ViewTapTapped_Private:(UITapGestureRecognizer *)recognizer
{
    label_public.textColor=[UIColor colorWithRed:186/255.0 green:188/255.0 blue:190/255.0 alpha:1] ;
    label_private.textColor=[UIColor colorWithRed:65/255.0 green:65/255.0 blue:65/255.0 alpha:1];
    
    Button_Public.clipsToBounds=YES;
    Button_Private.clipsToBounds=YES;
    
    
    Image_ButtonPrivate.clipsToBounds=YES;
    Image_ButtinPublic.clipsToBounds=YES;
    
    label_public.clipsToBounds=YES;
    label_private.clipsToBounds=YES;
    
    
    
    [Image_ButtinPublic setImage:[UIImage imageNamed:@"exploreworld1.png"]];
    [Image_ButtonPrivate setImage:[UIImage imageNamed:@"privateinplay1.png"]];
    
    
    
    borderBottom_Private.backgroundColor =[UIColor colorWithRed:67/255.0 green:188/255.0 blue:255/255.0 alpha:1].CGColor;
    borderBottom_Private.frame = CGRectMake(0, Button_Private.frame.size.height-2.5, Button_Private.frame.size.width, 2.5);
    [Button_Private.layer addSublayer:borderBottom_Private];
    
    
    
    
    borderBottom_Public.backgroundColor = [UIColor colorWithRed:186/255.0 green:188/255.0 blue:190/255.0 alpha:1.0].CGColor;
    borderBottom_Public.frame = CGRectMake(0, Button_Public.frame.size.height-1, Button_Public.frame.size.width, 1);
    [Button_Public.layer addSublayer:borderBottom_Public];
    cellChecking=@"private";
    Button_Private.tag=101;
     [Tableview_inplay reloadData];
    [self ClienserverCommAll];
  
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
                                                         [Tableview_inplay reloadData];
                                                         
                                                     }
                                                     
                                                     if ([ResultString isEqualToString:@"nochallenges"])
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
                                                       view_CreateChallenges.hidden=YES;
                                                 }
                                                 
                                             }
                                             else if(error)
                                             {
                                                  view_CreateChallenges.hidden=YES;
                                                 NSLog(@"error login2.......%@",error.description);
                                                 
                                             }
                                         }];
        [dataTask resume];
    }
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
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
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    
    static NSString *cellId2=@"CellPublic";
    static NSString *cellId3=@"CellPrivate";
    
    
    
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
                 cell_Public.Label_Mypleges.text=[NSString stringWithFormat:@"%@%@",@"$",[dic_worldexp valueForKey:@"mypledge"]];
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
                
                 cell_Private.Label_Mypleges.text=[NSString stringWithFormat:@"%@%@",@"$",[dic_worldexp valueForKey:@"mypledge"]];
                
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
    
    // return nil;
    abort();  
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return 1;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
   
        return 140;
    
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
        ContributeDaetailPageViewController * set=[self.storyboard instantiateViewControllerWithIdentifier:@"ContributeDaetailPageViewController"];
        
        AcceptContributeDetailViewController * set2=[self.storyboard instantiateViewControllerWithIdentifier:@"AcceptContributeDetailViewController"];
        
        
        NSDictionary *  didselectDic;
        NSMutableArray * Array_new=[[NSMutableArray alloc]init];
        if ([[NSString stringWithFormat:@"%@",cellChecking] isEqualToString:@"public"])
        {
            didselectDic=[Array_Public  objectAtIndex:indexPath.row];
            cell_Public = [Tableview_inplay cellForRowAtIndexPath:indexPath];
            
            [Array_new addObject:didselectDic];
            if ([[NSString stringWithFormat:@"%@",[didselectDic valueForKey:@"accepted"] ]isEqualToString:@"yes"])
            {
                //set.ProfileImgeData =cell_Public.Image_Profile.image;
                set.AllArrayData =Array_new;
                [self.navigationController pushViewController:set animated:YES];
                
            }
            else
            {
                // set2.ProfileImgeData =cell_Public.Image_Profile.image;
                set2.AllArrayData =Array_new;
                [self.navigationController pushViewController:set2 animated:YES];
            }
            
            
        }
        if ([cellChecking isEqualToString:@"private"])
        {
            didselectDic=[Array_Private  objectAtIndex:indexPath.row];
            cell_Private = [Tableview_inplay cellForRowAtIndexPath:indexPath];
            [Array_new addObject:didselectDic];
            
            if ([[didselectDic valueForKey:@"accepted"]isEqualToString:@"yes"])
            {
                
                // set.ProfileImgeData =cell_Private.Image_Profile.image;
                set.AllArrayData =Array_new;
                [self.navigationController pushViewController:set animated:YES];
                
            }
            else
            {
                //set2.ProfileImgeData =cell_Private.Image_Profile.image;
                set2.AllArrayData =Array_new;
                [self.navigationController pushViewController:set2 animated:YES];
            }
        }
        
        
        NSLog(@"Array_new11=%@",Array_new);;
        
        
        
        
        NSLog(@"Array_new22=%@",Array_new);;
        NSLog(@"indexPathrow=%ld",(long)indexPath.row);;
        
        
    
    
}
@end
