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
#import "MHFacebookImageViewer.h"
#import "UIImageView+MHFacebookImageViewer.h"
@interface ProfilepageViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    CALayer *borderBottom_topheder,*borderBottom_Public,*borderBottom_Private;
    UIImage *chosenImage;
    NSString *cellChecking,*Str_Frends,*str_challenges,*Str_name,*Str_profileurl,*SelectGallery;
    UIView *sectionView;
    
    UIImageView *Image_ButtinPublic,*Image_ButtonPrivate;
    NSUserDefaults * defaults;
    NSMutableArray * Array_AllData,* Array_Public,*Array_Private,*Array_Profile;
    NSDictionary *urlplist;
    CALayer *Bottomborder_Cell2;
    NSString * ImageNSdata,*encodedImage;
    
}
- (void) displayImage:(UIImageView*)imageView withImage:(UIImage*)image;
@end

@implementation ProfilepageViewController
@synthesize view_Topheader,cell_Profile,cell_donate,cell_complete,cell_Profileimages;
- (void)viewDidLoad {
    [super viewDidLoad];
    defaults=[[NSUserDefaults alloc]init];
      borderBottom_topheder = [CALayer layer];
    
     self.tabBarController.tabBar.hidden=NO;
      cellChecking=@"public";
    
    SelectGallery=@"no";
    
   
    
    
    
   str_challenges=[defaults valueForKey:@"challenges"];
    Str_Frends=[defaults valueForKey:@"friends"];
    Str_name=[defaults valueForKey:@"name"];
    Str_profileurl=[defaults valueForKey:@"profileimage"];
    Str_profileurl=[[Array_Profile objectAtIndex:0]valueForKey:@"profileimage"];
    
    NSString *plistPath = [[NSBundle mainBundle]pathForResource:@"UrlName" ofType:@"plist"];
    urlplist = [NSDictionary dictionaryWithContentsOfFile:plistPath];
    
    
   
    
    
    
    
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
    
[self ClientserverCommprofile];
    
}

- (void) viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    borderBottom_topheder.backgroundColor =[UIColor colorWithRed:186/255.0 green:188/255.0 blue:190/255.0 alpha:1.0].CGColor;
    borderBottom_topheder.frame = CGRectMake(0, view_Topheader.frame.size.height-1, view_Topheader.frame.size.width,1);
    [view_Topheader.layer addSublayer:borderBottom_topheder];

}
-(void)PulltoRefershtable
{
    

   [self ClientserverCommprofile];
  
    [_Tableview_Profile reloadData];
    [self.refreshControl endRefreshing];
    
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
   
     self.tabBarController.tabBar.hidden=NO;
  
    [self ClientserverCommprofile];
    
    [_Tableview_Profile reloadData];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//    if(section==0)
//    {
//    return 1;
//        
//    }
//    if(section==1)
//    {
//     return 1;
//        
//    }
//    if(section==2)
//    {
//        
//        
//        return 1;
//        
//    }
    if(section==3)
    {
        
        
        return 1;
        
    }
        
return 1;
   
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    static NSString *mycellid2=@"ProfileCell";
    static NSString *cellId2=@"CellD";
    static NSString *cellId3=@"CellC";
    static NSString *cellId4=@"CellPI";
    
    
    switch (indexPath.section)
    {
            
        case 0:
        {
            cell_Profile = (profilePageTableViewCell*)[tableView dequeueReusableCellWithIdentifier:mycellid2 forIndexPath:indexPath];
     
            
            
            
            
      
           
            
            
            
            
            cell_Profile.Label_Friends22.userInteractionEnabled=YES;
             cell_Profile.Label_Challenges11.userInteractionEnabled=YES;
            
            
            
            
    UITapGestureRecognizer *ViewTap11 =[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(ViewTapTapped_Label_Friends22:)];
            [cell_Profile.Label_Friends22 addGestureRecognizer:ViewTap11];
            
          
            
            if ([[defaults valueForKey:@"logintype"] isEqualToString:@"FACEBOOK"]|| [[defaults valueForKey:@"logintype"] isEqualToString:@"TWITTER"])
            {
                NSURL *url=[NSURL URLWithString:Str_profileurl];
                
                [cell_Profile.Image_ProfileImg sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"DefaultImg.jpg"] options:SDWebImageRefreshCached];
                 [self displayImage:cell_Profile.Image_ProfileImg withImage:cell_Profile.Image_ProfileImg.image];
                
            }
            else
            {
                
        cell_Profile.Image_ProfileImg.userInteractionEnabled=YES;
    UITapGestureRecognizer *ViewTapprofile =[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(ViewTapprofileTappedView:)];
        [cell_Profile.Image_ProfileImg addGestureRecognizer:ViewTapprofile];
                if(chosenImage ==nil)
                {
NSURL *url=[NSURL URLWithString:Str_profileurl];
                    
[cell_Profile.Image_ProfileImg sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"DefaultImg.jpg"] options:SDWebImageRefreshCached];
                }
                else
                {
                  cell_Profile.Image_ProfileImg.image=chosenImage;
                }

            }
            
            
//             [defaults setObject:[NSString stringWithFormat:@"%@",[[array_login objectAtIndex:0]valueForKey:@"regtype"]] forKey:@"logintype"];
            
            
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
            cell_donate = (DonateCharityTableViewCell*)[tableView dequeueReusableCellWithIdentifier:cellId2 forIndexPath:indexPath];
            
            
            cell_donate.Button_donate.clipsToBounds=YES;
            cell_donate.Button_donate.layer.cornerRadius=cell_donate.Button_donate.frame.size.height/2;
            
            
            
            return cell_donate;
            
            
        }
            break;
            
    case 2:
        {
            cell_complete = (CompeteChallengesTableViewCell*)[tableView dequeueReusableCellWithIdentifier:cellId3 forIndexPath:indexPath];
            
            
            cell_complete.labelcount_challenges.clipsToBounds=YES;
            cell_complete.labelcount_challenges.layer.cornerRadius=cell_complete.labelcount_challenges.frame.size.height/2;
            
            return cell_complete;
            
            
        }
            break;
            
    case 3:
        {
            cell_Profileimages = (ProfileCompletechallengesimageTableViewCell*)[tableView dequeueReusableCellWithIdentifier:cellId4 forIndexPath:indexPath];
            
            
            [cell_Profileimages.image1 setFrame:CGRectMake(0,0,self.view.frame.size.width/4, self.view.frame.size.width/4)];
            
            [cell_Profileimages.image2 setFrame:CGRectMake(cell_Profileimages.image1.frame.size.width,0,self.view.frame.size.width/4, self.view.frame.size.width/4)];
            
            [cell_Profileimages.image3 setFrame:CGRectMake(cell_Profileimages.image2.frame.origin.x+cell_Profileimages.image2.frame.size.width,0,self.view.frame.size.width/4, self.view.frame.size.width/4)];
            
            [cell_Profileimages.image4 setFrame:CGRectMake(cell_Profileimages.image3.frame.origin.x+cell_Profileimages.image3.frame.size.width,0,self.view.frame.size.width/4, self.view.frame.size.width/4)];
            
            NSLog(@"Image111===%f",cell_Profileimages.image1.frame.size.width);
             NSLog(@"Image111===%f",cell_Profileimages.image1.frame.size.height);
             NSLog(@"Image111===%f",cell_Profileimages.image1.frame.origin.x);
             NSLog(@"Image111===%f",cell_Profileimages.image1.frame.origin.y);
            
            NSLog(@"image222===%f",cell_Profileimages.image2.frame.size.width);
            NSLog(@"image222===%f",cell_Profileimages.image2.frame.size.height);
            NSLog(@"image222===%f",cell_Profileimages.image2.frame.origin.x);
            NSLog(@"image222===%f",cell_Profileimages.image2.frame.origin.y);
            
            
            NSLog(@"image333===%f",cell_Profileimages.image3.frame.size.width);
            NSLog(@"image222===%f",cell_Profileimages.image3.frame.size.height);
            NSLog(@"image222===%f",cell_Profileimages.image3.frame.origin.x);
            NSLog(@"image222===%f",cell_Profileimages.image3.frame.origin.y);
            
            
            NSLog(@"image444===%f",cell_Profileimages.image4.frame.size.width);
            NSLog(@"image444===%f",cell_Profileimages.image4.frame.size.height);
            NSLog(@"image444===%f",cell_Profileimages.image4.frame.origin.x);
            NSLog(@"image444===%f",cell_Profileimages.image4.frame.origin.y);
            
            return cell_Profileimages;
            
            
        }
            break;
        
    }
   // return nil;
  abort();  
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return 4;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section==0)
    {
        return 140;
    }
    if (indexPath.section==1)
    {
        return 108;
    }
    if (indexPath.section==2)
    {
        return 97;
    }
    if (indexPath.section==3)
    {
        return self.view.frame.size.width/4;
    }
    return 0;
    
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
  
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
- (void) displayImage:(UIImageView*)imageView withImage:(UIImage*)image  {
    
    
    [imageView setImage:image];
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    [imageView setupImageViewer];
    imageView.clipsToBounds = YES;
}
- (void)ViewTapprofileTappedView:(UITapGestureRecognizer *)recognizer
{
    UIActionSheet *popup = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Choose from gallery",@"Take a picture",nil];
    popup.tag = 777;
    [popup showInView:self.view];
}
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSLog(@"actionSheetTaggg==%ld",(long)actionSheet.tag);
    
    if ((long)actionSheet.tag == 777)
    {
        NSLog(@"INDEXAcrtionShhet==%ld",(long)buttonIndex);
        
        if (buttonIndex== 0)
        {
           
            
            
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
        else  if (buttonIndex== 1)
        {
            
            UIImagePickerController *picker = [[UIImagePickerController alloc] init];
            picker.delegate = self;
            picker.allowsEditing = NO;
            picker.sourceType = UIImagePickerControllerSourceTypeCamera;
            
            [self presentViewController:picker animated:true completion:nil];
        }
    }
}
-(void)imagePickerController:(UIImagePickerController *)picker
didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    
        
    
        chosenImage = info[UIImagePickerControllerOriginalImage];
       cell_Profile.Image_ProfileImg.image=chosenImage;
        
        NSData *imageData = UIImageJPEGRepresentation(chosenImage, 0.5);
    
        imageData = UIImageJPEGRepresentation(chosenImage, 0.5);
          ImageNSdata = [Base64 encode:imageData];
    
    
    encodedImage = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(NULL,(CFStringRef)ImageNSdata,NULL,(CFStringRef)@"!*'\"();:@&=+$,/?%#[]% ",CFStringConvertNSStringEncodingToEncoding(NSUTF8StringEncoding)));
    
    [self savepictureCommunication];
        
        [[self navigationController] dismissViewControllerAnimated:YES completion:nil];
        [picker dismissViewControllerAnimated:YES completion:NULL];
        
    
    
    
}



- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
   
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}
-(void)savepictureCommunication
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
        
        NSString *profileimage= @"profileimage";
        
  
        NSString *reqStringFUll=[NSString stringWithFormat:@"%@=%@&%@=%@",userid1,useridVal1,profileimage,encodedImage];
        
        
#pragma mark - swipe sesion
        
        NSURLSession *session = [NSURLSession sessionWithConfiguration: [NSURLSessionConfiguration defaultSessionConfiguration] delegate: nil delegateQueue: [NSOperationQueue mainQueue]];
        
        NSURL *url;
        NSString *  urlStrLivecount=[urlplist valueForKey:@"savepicture"];;
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
                     NSMutableArray * array_profilepic=[[NSMutableArray alloc]init];
                    SBJsonParser *objSBJsonParser = [[SBJsonParser alloc]init];
            array_profilepic=[objSBJsonParser objectWithData:data];
                          NSString * ResultString=[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
                                                     
      ResultString = [ResultString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    ResultString = [ResultString stringByReplacingOccurrencesOfString:@"\t" withString:@""];
              if (array_profilepic.count !=0)
              {
                  Str_profileurl=@"";
            Str_profileurl=[[array_profilepic objectAtIndex:0]valueForKey:@"profilepic"];
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
    };
    
    
}
@end
