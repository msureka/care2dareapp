//
//  FavoritePageViewController.m
//  care2Dare
//
//  Created by Spiel's Macmini on 3/6/17.
//  Copyright © 2017 Spiel's Macmini. All rights reserved.
//

#import "FavoritePageViewController.h"
#import "Reachability.h"
#import "SBJsonParser.h"
#import "UIImageView+WebCache.h"
#import "ContributeDaetailPageViewController.h"
#define BlueColor [UIColor colorWithRed:79/255.0 green:76/255.0 blue:227/255.0 alpha:1].CGColor
#define GrayColor [UIColor colorWithRed:186/255.0 green:188/255.0 blue:190/255.0 alpha:1].CGColor
#define GreenColor [UIColor colorWithRed:20/255.0 green:245/255.0 blue:115/255.0 alpha:1.0].CGColor
@interface FavoritePageViewController ()
{
    CALayer *borderBottom_world,*borderBottom_ExpFrnd,*bootomBorder_Cell,*Bottomborder_Cell2;
    NSString * cellChecking;
    UIView *sectionView;
    NSMutableArray * Array_Plaeges,*Array_Faourite;
    NSDictionary *urlplist;
    NSUserDefaults * defaults;
    NSURLSessionDataTask *dataTaskPleg,*dataTaskFav;
}
@end

@implementation FavoritePageViewController
@synthesize cell_Pledge,cell_Favorite,View_ExpFavorite,view_ExpPledges,Tableview_Favorites,Label_Pledges,Label_Favorite,Label_JsonResult;
- (void)viewDidLoad
{
    [super viewDidLoad];
//favourite-show
    defaults=[[NSUserDefaults alloc]init];
    NSString *plistPath = [[NSBundle mainBundle]pathForResource:@"UrlName" ofType:@"plist"];
    urlplist = [NSDictionary dictionaryWithContentsOfFile:plistPath];
    
    
borderBottom_world = [CALayer layer];
borderBottom_ExpFrnd = [CALayer layer];

UITapGestureRecognizer *ViewTap11 =[[UITapGestureRecognizer alloc] initWithTarget:self
                                                                           action:@selector(ViewTapTapped_Expworld:)];
[view_ExpPledges addGestureRecognizer:ViewTap11];
//[image_ExpWorld addGestureRecognizer:ViewTap11];

UITapGestureRecognizer *ViewTap22 =[[UITapGestureRecognizer alloc] initWithTarget:self
                                                                           action:@selector(ViewTapTapped_Expfriend:)];
[View_ExpFavorite addGestureRecognizer:ViewTap22];
// [image_ExpFriend addGestureRecognizer:ViewTap22];


    Label_JsonResult.hidden=YES;

UIColor *bgRefreshColor = [UIColor whiteColor];

// Creating refresh control
self.refreshControl = [[UIRefreshControl alloc] init];

[self.refreshControl setBackgroundColor:bgRefreshColor];
self.refreshControl = self.refreshControl;

// Creating view for extending background color
CGRect frame = Tableview_Favorites.bounds;
frame.origin.y = -frame.size.height;
UIView* bgView = [[UIView alloc] initWithFrame:frame];
bgView.backgroundColor = bgRefreshColor;

// Adding the view below the refresh control
[Tableview_Favorites insertSubview:bgView atIndex:0];
self.refreshControl = self.refreshControl;

self.refreshControl.tintColor = [UIColor blackColor];
[self.refreshControl addTarget:self
                        action:@selector(PulltoRefershtable)
              forControlEvents:UIControlEventValueChanged];

    [self ClienserverComm_Pledges];
   // [self ClienserverComm_Favourite];
    

}
- (void) viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    
    cellChecking=@"Pledges";
    
    view_ExpPledges .clipsToBounds=YES;
    View_ExpFavorite.clipsToBounds=YES;
    
    
    borderBottom_world.backgroundColor = [UIColor colorWithRed:79/255.0 green:76/255.0 blue:227/255.0 alpha:1].CGColor;//[UIColor colorWithRed:20/255.0 green:245/255.0 blue:115/255.0 alpha:1.0].CGColor;
   // borderBottom_world.frame=view_ExpPledges.bounds;
    borderBottom_world.frame = CGRectMake(0, view_ExpPledges.frame.size.height-2.5,  view_ExpPledges.frame.size.width, 2.5);
    [view_ExpPledges.layer addSublayer:borderBottom_world];
    
    Label_Favorite.textColor=[UIColor colorWithRed:186/255.0 green:188/255.0 blue:190/255.0 alpha:1];
    Label_Pledges.textColor=[UIColor colorWithRed:65/255.0 green:65/255.0 blue:65/255.0 alpha:1];
    
    
    
    
 
    borderBottom_ExpFrnd.backgroundColor = [UIColor colorWithRed:186/255.0 green:188/255.0 blue:190/255.0 alpha:1.0].CGColor;
    borderBottom_ExpFrnd.frame = CGRectMake(0, View_ExpFavorite.frame.size.height-1, View_ExpFavorite.frame.size.width, 1);
    [View_ExpFavorite.layer addSublayer:borderBottom_ExpFrnd];
}

-(void)ClienserverComm_Pledges
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
        
        
        
        
        NSString *reqStringFUll=[NSString stringWithFormat:@"%@=%@",userid,useridVal];
        
        
        
#pragma mark - swipe sesion
        
        NSURLSession *session = [NSURLSession sessionWithConfiguration: [NSURLSessionConfiguration defaultSessionConfiguration] delegate: nil delegateQueue: [NSOperationQueue mainQueue]];
        
        NSURL *url;
        NSString *  urlStrLivecount=[urlplist valueForKey:@"pledges"];;
        url =[NSURL URLWithString:urlStrLivecount];
        
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
        
        [request setHTTPMethod:@"POST"];//Web API Method
        
        [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
        
        request.HTTPBody = [reqStringFUll dataUsingEncoding:NSUTF8StringEncoding];
        
        
        
        dataTaskPleg =[session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error)
                                         {
                                             
                                             if(data)
                                             {
                                                 NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
                                                 NSInteger statusCode = httpResponse.statusCode;
                                                 if(statusCode == 200)
                                                 {
                                                    
                                                     Array_Plaeges=[[NSMutableArray alloc]init];
                                                     SBJsonParser *objSBJsonParser = [[SBJsonParser alloc]init];
                                                     Array_Plaeges =[objSBJsonParser objectWithData:data];
                                                     
                                                  
                                                     NSString * ResultString=[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
                                                     //        Array_LodingPro=[NSJSONSerialization JSONObjectWithData:webData_Swipe options:kNilOptions error:nil];
                                                     
                                                     ResultString = [ResultString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
                                                     ResultString = [ResultString stringByReplacingOccurrencesOfString:@"\t" withString:@""];
                                                     
                                                     NSLog(@"Array_Plaeges %@",Array_Plaeges);
                                                     
                                                     
                                                     NSLog(@"Array_WorldExp ResultString %@",ResultString);
                                                     if ([ResultString isEqualToString:@"nouserid"])
                                                     {
                                                         
                                                         UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Oops" message:@"Your account does not exist or seems to have been suspended. Please contact admin." preferredStyle:UIAlertControllerStyleAlert];
                                                         
                                                         UIAlertAction *actionOk = [UIAlertAction actionWithTitle:@"Ok"
                                                                                                            style:UIAlertActionStyleDefault
                                                                                                          handler:nil];
                                                         [alertController addAction:actionOk];
                                                         [self presentViewController:alertController animated:YES completion:nil];
                                                         
                                                         
                                                     }
                                                     
                                                     
                                                     if ([ResultString isEqualToString:@"done"])
                                                     {
                                                         
                                                         
                                                         
                                                         
                                                     }
                        if (Array_Plaeges.count !=0)
                            {
                        Label_JsonResult.hidden=YES;
                        [Tableview_Favorites reloadData];
                                                     }
                                                     else
                                                     {
            Label_JsonResult.text=@"All the challenges in which you have contributed will be shown here.";
                        Label_JsonResult.hidden=NO;
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
        [dataTaskPleg resume];
    }
    
}
-(void)ClienserverComm_Favourite
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
        
        
        
        
        NSString *reqStringFUll=[NSString stringWithFormat:@"%@=%@",userid,useridVal];
        
        
        
#pragma mark - swipe sesion
        
        NSURLSession *session = [NSURLSession sessionWithConfiguration: [NSURLSessionConfiguration defaultSessionConfiguration] delegate: nil delegateQueue: [NSOperationQueue mainQueue]];
        
        NSURL *url;
        NSString *  urlStrLivecount=[urlplist valueForKey:@"favourite-show"];;
        url =[NSURL URLWithString:urlStrLivecount];
        
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
        
        [request setHTTPMethod:@"POST"];//Web API Method
        
        [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
        
        request.HTTPBody = [reqStringFUll dataUsingEncoding:NSUTF8StringEncoding];
        
        
        
        dataTaskFav =[session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error)
                                         {
                                             if(data)
                                             {
                                                 NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
                                                 NSInteger statusCode = httpResponse.statusCode;
                                                 if(statusCode == 200)
                                                 {
                                                     
                                                     Array_Faourite=[[NSMutableArray alloc]init];
                                                     SBJsonParser *objSBJsonParser = [[SBJsonParser alloc]init];
            Array_Faourite=[objSBJsonParser objectWithData:data];
                                                     
                                                     
                                                     NSString * ResultString=[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
                                                     //        Array_LodingPro=[NSJSONSerialization JSONObjectWithData:webData_Swipe options:kNilOptions error:nil];
                                                     
                                                     ResultString = [ResultString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
                                                     ResultString = [ResultString stringByReplacingOccurrencesOfString:@"\t" withString:@""];
                                                     
                                                     NSLog(@"Array_Faourite %@",Array_Faourite);
                                                     
                                                     
    NSLog(@"Array_WorldExp ResultString %@",ResultString);
        if ([ResultString isEqualToString:@"nouserid"])
                                                     {
                                                         
                                                         UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Oops" message:@"Your account does not exist or seems to have been suspended. Please contact admin." preferredStyle:UIAlertControllerStyleAlert];
                                                         
                                                         UIAlertAction *actionOk = [UIAlertAction actionWithTitle:@"Ok"
                                                                                                            style:UIAlertActionStyleDefault
                                                                                                          handler:nil];
                                                         [alertController addAction:actionOk];
                                                         [self presentViewController:alertController animated:YES completion:nil];
                                                         
                                                         
                                                     }
                                                     
                                                     
                                                     if ([ResultString isEqualToString:@"nochallenges"])
                                                     {
                                                         
                                                         
                                                         
                                                         
                                                     }
                            if (Array_Faourite.count !=0)
                                    {
                                        Label_JsonResult.hidden=YES;
                        [Tableview_Favorites reloadData];
                        }
                                    else
                            {
        Label_JsonResult.text=@"All the challenges which you tag as favourite will be shown here.";
                        Label_JsonResult.hidden=NO;
                    
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
        [dataTaskFav resume];
    }
    
}
-(void)viewWillAppear:(BOOL)animated

{

    [super viewWillAppear:animated];
   
    if ([cellChecking isEqualToString:@"Pledges"])
    {
       [self ClienserverComm_Pledges];
    }
    if ([cellChecking isEqualToString:@"Favorites"])
    {
        [self ClienserverComm_Favourite];
    }
    [Tableview_Favorites reloadData];
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)ViewTapTapped_Expworld:(UITapGestureRecognizer *)recognizer
{
     Label_JsonResult.hidden=YES;
    [dataTaskFav cancel];
    cellChecking=@"Pledges";
   
    view_ExpPledges.clipsToBounds=YES;
    view_ExpPledges.clipsToBounds=YES;
   
    Label_Favorite.textColor=[UIColor colorWithRed:186/255.0 green:188/255.0 blue:190/255.0 alpha:1];
    Label_Pledges.textColor=[UIColor colorWithRed:65/255.0 green:65/255.0 blue:65/255.0 alpha:1];
    
    borderBottom_world.backgroundColor =[UIColor colorWithRed:79/255.0 green:76/255.0 blue:227/255.0 alpha:1].CGColor;// [UIColor colorWithRed:20/255.0 green:245/255.0 blue:115/255.0 alpha:1.0].CGColor;
    borderBottom_world.frame = CGRectMake(0, view_ExpPledges.frame.size.height-2.5, view_ExpPledges.frame.size.width, 2.5);
    [view_ExpPledges.layer addSublayer:borderBottom_world];
    
    
    
    View_ExpFavorite.clipsToBounds=YES;
    
    
    borderBottom_ExpFrnd.backgroundColor = [UIColor colorWithRed:186/255.0 green:188/255.0 blue:190/255.0 alpha:1.0].CGColor;
    borderBottom_ExpFrnd.frame = CGRectMake(0, View_ExpFavorite.frame.size.height-1, View_ExpFavorite.frame.size.width, 1);
    [View_ExpFavorite.layer addSublayer:borderBottom_ExpFrnd];
    [self ClienserverComm_Pledges];
    if (Array_Plaeges.count==0)
    {
        Label_JsonResult.hidden=NO;
    }
    else
    {
        Label_JsonResult.hidden=YES;
    }
    [Tableview_Favorites reloadData];
}
- (void)ViewTapTapped_Expfriend:(UITapGestureRecognizer *)recognizer
{
    
     Label_JsonResult.hidden=YES;
    [dataTaskPleg cancel];
    cellChecking=@"Favorites";
    view_ExpPledges.clipsToBounds=YES;
   
    Label_Pledges.textColor=[UIColor colorWithRed:186/255.0 green:188/255.0 blue:190/255.0 alpha:1];
    Label_Favorite.textColor=[UIColor colorWithRed:65/255.0 green:65/255.0 blue:65/255.0 alpha:1];
    
    borderBottom_world.backgroundColor = [UIColor colorWithRed:186/255.0 green:188/255.0 blue:190/255.0 alpha:1.0].CGColor;
    borderBottom_world.frame = CGRectMake(0, view_ExpPledges.frame.size.height-1, view_ExpPledges.frame.size.width, 1);
    [view_ExpPledges.layer addSublayer:borderBottom_world];
    
    
    
    View_ExpFavorite.clipsToBounds=YES;

    
    
    borderBottom_ExpFrnd.backgroundColor =[UIColor colorWithRed:79/255.0 green:76/255.0 blue:227/255.0 alpha:1].CGColor;// [UIColor colorWithRed:20/255.0 green:245/255.0 blue:115/255.0 alpha:1.0].CGColor;
    borderBottom_ExpFrnd.frame = CGRectMake(0, View_ExpFavorite.frame.size.height-2.5, View_ExpFavorite.frame.size.width, 2.5);
    [View_ExpFavorite.layer addSublayer:borderBottom_ExpFrnd];
    
    
     [self ClienserverComm_Favourite];
    [Tableview_Favorites reloadData];
    if (Array_Faourite.count==0)
    {
        Label_JsonResult.hidden=NO;
    }
    else
    {
        Label_JsonResult.hidden=YES;
    }
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    
    
    if ([cellChecking isEqualToString:@"Pledges"])
    {
        return Array_Plaeges.count;
    }
    else if ([cellChecking isEqualToString:@"Favorites"])
    {
        return Array_Faourite.count;
    }
    
    return 0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    static NSString *cellIdW1=@"CellP";
    static NSString *cellIdF1=@"CellF";
    
    
    if ([cellChecking isEqualToString:@"Pledges"])
    {
        
        cell_Pledge = [[[NSBundle mainBundle]loadNibNamed:@"PledgeTableViewCell" owner:self options:nil] objectAtIndex:0];
        
        
        
        
        if (cell_Pledge == nil)
        {
            
            cell_Pledge = [[PledgeTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdW1];
            
            
        }
        
        
        NSDictionary * dic_worldexp=[Array_Plaeges objectAtIndex:indexPath.row];
        cell_Pledge.Label_Raised.text=[NSString stringWithFormat:@"%@%@",@"$",[dic_worldexp valueForKey:@"backamount"]];
        cell_Pledge.Label_Backer.text=[NSString stringWithFormat:@"%@",[dic_worldexp valueForKey:@"backers"]];
        cell_Pledge.Label_Titile.text=[NSString stringWithFormat:@"%@",[dic_worldexp valueForKey:@"title"]];
        
        cell_Pledge.Label_PlegesAmt.text=[NSString stringWithFormat:@"%@%@",@"$",[dic_worldexp valueForKey:@"mypledge"]];
        
        NSString *text=[NSString stringWithFormat:@"%@",[dic_worldexp valueForKey:@"title"]];
        
        
        CGRect textRect = [text boundingRectWithSize:cell_Pledge.Label_Titile.frame.size options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:cell_Pledge.Label_Titile.font} context:nil];
        
        int numberOfLines = textRect.size.height / cell_Pledge.Label_Titile.font.pointSize;;
        if (numberOfLines==1)
        {
            [cell_Pledge.Label_Titile setFrame:CGRectMake(cell_Pledge.Label_Titile.frame.origin.x, cell_Pledge.Label_Titile.frame.origin.y, cell_Pledge.Label_Titile.frame.size.width, cell_Pledge.Label_Titile.frame.size.height/2)];
        }
        
        Bottomborder_Cell2 = [CALayer layer];
        Bottomborder_Cell2.backgroundColor = [UIColor colorWithRed:241/255.0 green:241/255.0 blue:241/255.0 alpha:1.0].CGColor;
        Bottomborder_Cell2.frame = CGRectMake(0, cell_Pledge.frame.size.height-1, cell_Pledge.frame.size.width, 1);
        [cell_Pledge.layer addSublayer:Bottomborder_Cell2];
        
        NSLog(@"number of lines=%d",numberOfLines);
        
        cell_Pledge.Label_Time.text=[NSString stringWithFormat:@"%@",[dic_worldexp valueForKey:@"createtime"]];
        // cell_WorldExp.Label_Time.text=[dic_worldexp valueForKey:@"challengeid"];
        // cell_WorldExp.Label_Time.text=[dic_worldexp valueForKey:@"challengerdetails"];
        
        //cell_WorldExp.Label_Time.text=[dic_worldexp valueForKey:@"mediatype"];
        // cell_WorldExp.Label_Time.text=[dic_worldexp valueForKey:@"mediaurl"];
        // cell_WorldExp.Label_Time.text=[dic_worldexp valueForKey:@"noofchallengers"];
        // cell_WorldExp.Label_Time.text=[dic_worldexp valueForKey:@"payperchallenger"];
        cell_Pledge.Image_Profile.tag=indexPath.row;
        
        if ([[dic_worldexp valueForKey:@"mediatype"] isEqualToString:@"IMAGE"])
        {
            cell_Pledge.Image_PalyBuutton.hidden=YES;
            
            NSURL *url=[NSURL URLWithString:[dic_worldexp valueForKey:@"mediaurl"]];
            
            [cell_Pledge.Image_Profile sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"DefaultImg.jpg"] options:SDWebImageRefreshCached];
        }
        else
        {
            
            NSURL *url=[NSURL URLWithString:[dic_worldexp valueForKey:@"mediathumbnailurl"]];
            
            [cell_Pledge.Image_Profile sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"DefaultImg.jpg"] options:SDWebImageRefreshCached];
            cell_Pledge.Image_PalyBuutton.hidden=NO;
            
            
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
        
        
        cell_Pledge.Label_Changename.attributedText = aAttrString;
        
        
        
        return cell_Pledge;
        
    }
    if ([cellChecking isEqualToString:@"Favorites"])
    {
        
        cell_Favorite = [[[NSBundle mainBundle]loadNibNamed:@"FavriteTableViewCell" owner:self options:nil] objectAtIndex:0];
       
        
        if (cell_Favorite == nil)
        {
            
            cell_Favorite = [[FavriteTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdF1];
        }
        
        bootomBorder_Cell = [CALayer layer];
        bootomBorder_Cell.backgroundColor = [UIColor colorWithRed:241/255.0 green:241/255.0 blue:241/255.0 alpha:1.0].CGColor;
        bootomBorder_Cell.frame = CGRectMake(0, cell_Favorite.frame.size.height-1, cell_Favorite.frame.size.width, 1);
        [cell_Favorite.layer addSublayer:bootomBorder_Cell];

        NSDictionary * dic_worldexp=[Array_Faourite objectAtIndex:indexPath.row];
        cell_Favorite.Label_Raised.text=[NSString stringWithFormat:@"%@%@",@"$",[dic_worldexp valueForKey:@"backamount"]];
        cell_Favorite.Label_Backer.text=[NSString stringWithFormat:@"%@",[dic_worldexp valueForKey:@"backers"]];
        cell_Favorite.Label_Titile.text=[NSString stringWithFormat:@"%@",[dic_worldexp valueForKey:@"title"]];
        NSString *text=[NSString stringWithFormat:@"%@",[dic_worldexp valueForKey:@"title"]];
        
        
        CGRect textRect = [text boundingRectWithSize:cell_Favorite.Label_Titile.frame.size options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:cell_Favorite.Label_Titile.font} context:nil];
        
        int numberOfLines = textRect.size.height / cell_Favorite.Label_Titile.font.pointSize;;
        if (numberOfLines==1)
        {
            [cell_Favorite.Label_Titile setFrame:CGRectMake(cell_Favorite.Label_Titile.frame.origin.x, cell_Favorite.Label_Titile.frame.origin.y, cell_Favorite.Label_Titile.frame.size.width, cell_Favorite.Label_Titile.frame.size.height/2)];
        }
        
        
        
        NSLog(@"number of lines=%d",numberOfLines);
        
        cell_Favorite.Label_Time.text=[NSString stringWithFormat:@"%@",[dic_worldexp valueForKey:@"createtime"]];
        // cell_WorldExp.Label_Time.text=[dic_worldexp valueForKey:@"challengeid"];
        // cell_WorldExp.Label_Time.text=[dic_worldexp valueForKey:@"challengerdetails"];
        
        //cell_WorldExp.Label_Time.text=[dic_worldexp valueForKey:@"mediatype"];
        // cell_WorldExp.Label_Time.text=[dic_worldexp valueForKey:@"mediaurl"];
        // cell_WorldExp.Label_Time.text=[dic_worldexp valueForKey:@"noofchallengers"];
        // cell_WorldExp.Label_Time.text=[dic_worldexp valueForKey:@"payperchallenger"];
        
        
        if ([[dic_worldexp valueForKey:@"mediatype"] isEqualToString:@"IMAGE"])
        {
            cell_Favorite.Image_PalyBuutton.hidden=YES;
            
            NSURL *url=[NSURL URLWithString:[dic_worldexp valueForKey:@"mediaurl"]];
            
            [cell_Favorite.Image_Profile sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"DefaultImg.jpg"] options:SDWebImageRefreshCached];
        }
        else
        {
            
            NSURL *url=[NSURL URLWithString:[dic_worldexp valueForKey:@"mediathumbnailurl"]];
            
            [cell_Favorite.Image_Profile sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"DefaultImg.jpg"] options:SDWebImageRefreshCached];
            cell_Favorite.Image_PalyBuutton.hidden=NO;
            
            
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
        
        
        cell_Favorite.Label_Changename.attributedText = aAttrString;
        
        return cell_Favorite;
        
        
    }
    return nil;
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return 1;
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
   
    
        if ([cellChecking isEqualToString:@"Pledges"])
        {
            return 137;
        }
        if ([cellChecking isEqualToString:@"Favorites"])
        {
            return 100;
        }
    
    
    return 0;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ContributeDaetailPageViewController * set=[self.storyboard instantiateViewControllerWithIdentifier:@"ContributeDaetailPageViewController"];
    NSDictionary *  didselectDic;
    if ([cellChecking isEqualToString:@"Pledges"])
    {
        didselectDic=[Array_Plaeges  objectAtIndex:indexPath.row];
        cell_Pledge = [Tableview_Favorites cellForRowAtIndexPath:indexPath];
         set.ProfileImgeData =cell_Pledge.Image_Profile;
    }
    if ([cellChecking isEqualToString:@"Favorites"])
    {
        didselectDic=[Array_Faourite  objectAtIndex:indexPath.row];
        cell_Favorite = [Tableview_Favorites cellForRowAtIndexPath:indexPath];
         set.ProfileImgeData =cell_Favorite.Image_Profile;
    }
    
    NSMutableArray * Array_new=[[NSMutableArray alloc]init];
    [Array_new addObject:didselectDic];
    set.AllArrayData =Array_new;
    NSLog(@"Array_new11=%@",Array_new);;
    
    
    
    
    NSLog(@"Array_new22=%@",Array_new);;
    NSLog(@"indexPathrow=%ld",(long)indexPath.row);;
   
    [self.navigationController pushViewController:set animated:YES];
    NSLog(@"Array_new33=%@",Array_new);;
}

@end
