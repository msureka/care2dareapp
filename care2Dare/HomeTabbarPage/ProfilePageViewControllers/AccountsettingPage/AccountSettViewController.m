//
//  AccountSettViewController.m
//  SprintTags_Pro
//
//  Created by Spiel's Macmini on 8/19/16.
//  Copyright © 2016 Spiel's Macmini. All rights reserved.
//

#import "AccountSettViewController.h"
#import "SBJsonParser.h"
#import "Reachability.h"
#import <Fabric/Fabric.h>
#import <TwitterKit/TwitterKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <Bolts/Bolts.h>
#import <FBSDKShareKit/FBSDKShareKit.h>
#import "LoginPageViewController.h"
#import <MessageUI/MessageUI.h>
#import <Messages/Messages.h>
#import "MainnavigationViewController.h"
#import "ContactListViewController.h"
#import "FacebookListViewController.h"
#import "TwitterListViewController.h"
#import "UIView+RNActivityView.h"
#import "ChangePasswordViewController.h"
#import "DonationHistroyViewController.h"
@interface AccountSettViewController ()<UIAlertViewDelegate,MFMessageComposeViewControllerDelegate>
{
    NSArray *Array_Title1,*Array_Title2,*Array_Title3,*Array_Title4,*Array_Gender2,*Array_Images,*Array_TitleNotif,*Array_checknotifStatus;
    UIView *sectionView;
    NSUserDefaults *defaults;
    
 
    NSDictionary *urlplist;
    NSURLConnection *Connection_Delete,*Connection_ChangeproInfo;
    NSMutableData *webData_Delete,*webData_ChangeproInfo;
    NSMutableArray *Array_Delete,*Array_ChangeproInfo;
   
    NSString *EnglishStr,*ArabicStr;
    NSString *emailFb,*DobFb,*nameFb,*genderfb,*profile_picFb,*Fbid,*regTypeVal,*EmailValidTxt,*Str_fb_friend_id,*Str_fb_friend_id_Count;
    
    NSMutableArray *fb_friend_id;
    NSString * Str_Push_Challenge,*Str_Push_Contr,*Str_Push_Vedio,*Str_Push_Friend,*Str_Push_OnlyDare;
}

@end

@implementation AccountSettViewController
@synthesize onecell,Threecell3,HeadTopView;
- (void)viewDidLoad {
    [super viewDidLoad];
    
    defaults=[[NSUserDefaults alloc]init];
    CALayer *borderBottom = [CALayer layer];
    borderBottom.backgroundColor = [UIColor colorWithRed:186/255.0 green:188/255.0 blue:190/255.0 alpha:1.0].CGColor;
    borderBottom.frame = CGRectMake(0, HeadTopView.frame.size.height - 1, HeadTopView.frame.size.width, 1);
    [HeadTopView.layer addSublayer:borderBottom];
    
    NSString *plistPath = [[NSBundle mainBundle]pathForResource:@"UrlName" ofType:@"plist"];
    urlplist = [NSDictionary dictionaryWithContentsOfFile:plistPath];

  
    
  Array_TitleNotif=[[NSArray alloc]initWithObjects:@"Challenges",@"Contributions",@"Videos",@"Friends", nil];
    Array_Title1=[[NSArray alloc]initWithObjects:@"Facebook Friends",@"Twitter Friends",@"Contacts", nil];
Array_Images=[[NSArray alloc]initWithObjects:@"setting_facebook.png",@"setting_twitter.png",@"setting_contacts.png", nil];
 
    Array_Title2=[[NSArray alloc]initWithObjects:@"Edit Profile",@"Change Password",@"Block Users",@"Donation History",@"Only Friends can dare me",nil];
    
    
    
    Array_Title3=[[NSArray alloc]initWithObjects:@"Report a Problem",@"Terms and Conditions",@"Privacy Policy",@"Log Out",@"Delete my account",nil];
   
    Str_Push_Contr=[defaults valueForKey:@"pushcontributions"];
    Str_Push_Friend=[defaults valueForKey:@"pushfriends"];
    Str_Push_Vedio=[defaults valueForKey:@"pushvideos"];
    Str_Push_Challenge=[defaults valueForKey:@"pushchallenges"];
    Str_Push_OnlyDare=[defaults valueForKey:@"onlyfriendscandare"];
   


    // Creating refresh control

   // [TableView_Setting reloadData];
    [TableView_Setting beginUpdates];
    NSRange range = NSMakeRange(0, [self numberOfSectionsInTableView:TableView_Setting]);
    NSIndexSet *sections = [NSIndexSet indexSetWithIndexesInRange:range];
    [TableView_Setting reloadSections:sections withRowAnimation:UITableViewRowAnimationFade];
    [TableView_Setting endUpdates];
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
       [TableView_Setting reloadData];
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
 
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
   
        if (section==0)
        {
            return Array_Title1.count;
        }
        if (section==1)
        {
            return Array_Title2.count;;
        }
    if (section==2)
    {
        
        return Array_TitleNotif.count;
    }

        if (section==3)
        {
            
          return Array_Title3.count;;
        }
    

    return 0;
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
   
    
            return 50;
    
    
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *Cellid1=@"OneCell";
    static NSString *cellId2=@"TwoCell";
    static NSString *cellId3=@"ThreeCell";

    
    
        switch (indexPath.section)
        {
                
                
            case 0:
            {

              

                onecell = (AccOneTableViewCell *)[tableView dequeueReusableCellWithIdentifier:Cellid1 forIndexPath:indexPath];
                
                onecell.layer.borderColor=[UIColor groupTableViewBackgroundColor].CGColor;
                onecell.layer.borderWidth=1.0f;
                onecell.LabelVal.text=[Array_Title1 objectAtIndex:indexPath.row];
            [onecell.image_View setImage:[UIImage imageNamed:[Array_Images objectAtIndex:indexPath.row]]];
                NSLog(@"Values===%@",[defaults valueForKey:@"makefriendswith"]);
                return onecell;
                
                
            }
                break;
            case 1:
                
            {
                AccTwoTableViewCell * Twocell2 = (AccTwoTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellId2 forIndexPath:indexPath];
                Twocell2.layer.borderColor=[UIColor groupTableViewBackgroundColor].CGColor;
                Twocell2.layer.borderWidth=1.0f;
                
                Twocell2.LabelVal.text=[Array_Title2 objectAtIndex:indexPath.row];
                if (indexPath.row == Array_Title2.count-1)
                {
                    Twocell2.switchOutlet.hidden=NO;
                    if ([Str_Push_OnlyDare isEqualToString:@"yes"])
                    {
                        [Twocell2.switchOutlet setOn:YES animated:YES];;
                    }
                    else
                    {
                      [Twocell2.switchOutlet setOn:NO animated:YES];;
                    }
                    
                  [Twocell2.switchOutlet addTarget: self action: @selector(Swich_OnlyDare:) forControlEvents:UIControlEventValueChanged];
                }
                else
                {
                    
                   
                    // [Twocell2.switchOutlet setOn:YES animated:YES];;
                    Twocell2.switchOutlet.hidden=YES;
                }
                
                
                if (indexPath.row == 1)
                {
                
        if ([[defaults valueForKey:@"logintype"] isEqualToString:@"FACEBOOK"]|| [[defaults valueForKey:@"logintype"] isEqualToString:@"TWITTER"])
                {
                    
                    Twocell2.LabelVal.textColor=[UIColor lightGrayColor];
                }
                else
                {
                    
                    Twocell2.LabelVal.textColor=[UIColor colorWithRed:65/255.0 green:65/255.0 blue:65/255.0 alpha:1];
                    
                }
                }
                
                               return Twocell2;
                
            }
                break;
              case 2:
            {
                AccTwoTableViewCell *Twocell22 = (AccTwoTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellId2 forIndexPath:indexPath];
                Twocell22.layer.borderColor=[UIColor groupTableViewBackgroundColor].CGColor;
                Twocell22.layer.borderWidth=1.0f;
                
                Twocell22.LabelVal.text=[Array_TitleNotif objectAtIndex:indexPath.row];
                
                   // Twocell22.switchOutlet.hidden=YES;
                Twocell22.switchOutlet.tag=indexPath.row;
                 [Twocell22.switchOutlet addTarget: self action: @selector(Swich_PushNotification:) forControlEvents:UIControlEventValueChanged];
                if (indexPath.row==0)
                {
                 
                 
                    if ([Str_Push_Challenge isEqualToString:@"no"])
                    {
                        [Twocell22.switchOutlet setOn:NO animated:YES];;
                    }
                    else
                    {
                        [Twocell22.switchOutlet setOn:YES animated:YES];;
                    }
                    
                }
                if (indexPath.row==1)
                {
                    
                    if ([Str_Push_Contr isEqualToString:@"no"])
                    {
                        [Twocell22.switchOutlet setOn:NO animated:YES];;
                    }
                    else
                    {
                        [Twocell22.switchOutlet setOn:YES animated:YES];;
                    }
                }
                if (indexPath.row==2)
                {
                     Twocell22.switchOutlet.hidden=NO;
                    if ([Str_Push_Vedio isEqualToString:@"no"])
                    {
                        [Twocell22.switchOutlet setOn:NO animated:YES];;
                    }
                    else
                    {
                        [Twocell22.switchOutlet setOn:YES animated:YES];;
                    }
                }
                if (indexPath.row==3)
                {
                    Twocell22.switchOutlet.hidden=NO;
                    if ([Str_Push_Friend isEqualToString:@"no"])
                    {
                        [Twocell22.switchOutlet setOn:NO animated:YES];;
                    }
                    else
                    {
                        [Twocell22.switchOutlet setOn:YES animated:YES];;
                    }
                }
                
              
               
                return Twocell22;
                
            }
                break;
                case 3:
                
            {
                
                
                Threecell3 = (AccThreeTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellId3 forIndexPath:indexPath];
                
                
              
                Threecell3.layer.borderColor=[UIColor groupTableViewBackgroundColor].CGColor;
                Threecell3.layer.borderWidth=1.0f;
                 Threecell3.LabelVal.text=[Array_Title3 objectAtIndex:indexPath.row];
                if (indexPath.row==4)
                {
                    Threecell3.LabelVal.textColor=[UIColor redColor];
                }
                else
                {
                  Threecell3.LabelVal.textColor=[UIColor colorWithRed:65/255.0 green:65/255.0 blue:65/255.0 alpha:1];
                }
               
                
                
                return Threecell3;
                
            }
                
                break;
        }
  //  return nil;
    abort();
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
        return 5;
    
    
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (section==1)
    {
        sectionView=[[UIView alloc]initWithFrame:CGRectMake(0,0,self.view.frame.size.width,44)];
        [sectionView setBackgroundColor:[UIColor groupTableViewBackgroundColor]];
        UILabel * Label1=[[UILabel alloc]initWithFrame:CGRectMake(20,2, self.view.frame.size.width-40, sectionView.frame.size.height-2)];
        Label1.backgroundColor=[UIColor clearColor];
        Label1.textColor=[UIColor lightGrayColor];
      
    Label1.font=[UIFont fontWithName:@"San Francisco Display" size:15.0f];
        Label1.text=@"If checked, only your friends will be able to send you dare requests";
        Label1.textAlignment = NSTextAlignmentLeft;
        Label1.numberOfLines =2;
        Label1.adjustsFontSizeToFitWidth=YES;
        Label1.minimumScaleFactor=0.5;
        [sectionView addSubview:Label1];
        sectionView.tag=section;
        
    }
    
    
    return  sectionView;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section==0)
    {
        sectionView=[[UIView alloc]initWithFrame:CGRectMake(0, 0,self.view.frame.size.width,44)];
      [sectionView setBackgroundColor:[UIColor groupTableViewBackgroundColor]];
        UILabel * Label1=[[UILabel alloc]initWithFrame:CGRectMake(20, 15, self.view.frame.size.width-40, sectionView.frame.size.height-5)];
        Label1.backgroundColor=[UIColor clearColor];
        Label1.textColor=[UIColor lightGrayColor];
        Label1.font=[UIFont fontWithName:@"SanFranciscoDisplay-Medium" size:15.0f];
        Label1.text=@"Invite";
          [sectionView addSubview:Label1];
        sectionView.tag=section;
        
    }
    if (section==1)
    {
        
        sectionView=[[UIView alloc]initWithFrame:CGRectMake(0, 0,self.view.frame.size.width,44)];
        [sectionView setBackgroundColor:[UIColor groupTableViewBackgroundColor]];
        
        UILabel * Label1=[[UILabel alloc]initWithFrame:CGRectMake(20,15, self.view.frame.size.width-40, sectionView.frame.size.height-5)];
        Label1.backgroundColor=[UIColor clearColor];
        Label1.textColor=[UIColor lightGrayColor];
        Label1.font=[UIFont fontWithName:@"SanFranciscoDisplay-Medium" size:15.0f];
        Label1.text=@"Account";
        [sectionView addSubview:Label1];
        
        
        sectionView.tag=section;
        
    }
    if (section==2)
    {
        
        sectionView=[[UIView alloc]initWithFrame:CGRectMake(0, 0,self.view.frame.size.width,44)];
        [sectionView setBackgroundColor:[UIColor groupTableViewBackgroundColor]];
        
        UILabel * Label1=[[UILabel alloc]initWithFrame:CGRectMake(20,15, self.view.frame.size.width-40, sectionView.frame.size.height-5)];
        Label1.backgroundColor=[UIColor clearColor];
        Label1.textColor=[UIColor lightGrayColor];
        Label1.font=[UIFont fontWithName:@"SanFranciscoDisplay-Medium" size:15.0f];
        Label1.text=@"Push Notification";
        [sectionView addSubview:Label1];
        sectionView.tag=section;
        
        
    }
    if (section==3)
    {
        
        sectionView=[[UIView alloc]initWithFrame:CGRectMake(0, 0,self.view.frame.size.width,44)];
        [sectionView setBackgroundColor:[UIColor groupTableViewBackgroundColor]];
        
        UILabel * Label1=[[UILabel alloc]initWithFrame:CGRectMake(20,15, self.view.frame.size.width-40, sectionView.frame.size.height-5)];
        Label1.backgroundColor=[UIColor clearColor];
        Label1.textColor=[UIColor lightGrayColor];
        Label1.font=[UIFont fontWithName:@"SanFranciscoDisplay-Medium" size:15.0f];
        Label1.text=@"Support";
        [sectionView addSubview:Label1];
        sectionView.tag=section;
        
        
    }
    
    if (section==4)
    {
        NSString * appVersionString = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
        NSString * appBuildString = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleVersion"];
        
        
        
        NSString *verBuild = [NSString stringWithFormat:@"%@.%@",appVersionString,appBuildString];
        
        sectionView=[[UIView alloc]initWithFrame:CGRectMake(0, 0,self.view.frame.size.width,44)];
        [sectionView setBackgroundColor:[UIColor groupTableViewBackgroundColor]];
        
        UILabel * Label1=[[UILabel alloc]initWithFrame:CGRectMake(20,5, self.view.frame.size.width-40, sectionView.frame.size.height-5)];
        Label1.backgroundColor=[UIColor clearColor];
        Label1.textColor=[UIColor lightGrayColor];
        Label1.font=[UIFont fontWithName:@"SanFranciscoDisplay-Medium" size:15.0f];
        
      
        Label1.text=[NSString stringWithFormat:@"Care2Dare v%@ \nchallenge your friends for a good cause",verBuild];;
        
        Label1.textAlignment = NSTextAlignmentCenter;
        Label1.numberOfLines =2;
        Label1.adjustsFontSizeToFitWidth=YES;
        Label1.minimumScaleFactor=0.5;
//        
//        Label1.textAlignment=NSTextAlignmentCenter;
//        Label1.lineBreakMode=UILineBreakModeWordWrap;
//        Label1.numberOfLines=2.0f;
        [sectionView addSubview:Label1];
        sectionView.tag=section;
        
        
    }
   
    
    return  sectionView;
    
    
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == 1)
    {
     return 45;
    }
    return 0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
    return 45;
   
}
- (void)appInviteDialog:(FBSDKAppInviteDialog *)appInviteDialog didFailWithError:(NSError *)error
{
    
}
- (void)appInviteDialog:(FBSDKAppInviteDialog *)appInviteDialog didCompleteWithResults:(NSDictionary *)results
{
    NSLog(@"RESUltssssInvite==%@",results);
}
- (void) mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    switch (result)
    {
        case MFMailComposeResultCancelled:
            NSLog(@"Mail cancelled");
            break;
        case MFMailComposeResultSaved:
            NSLog(@"Mail saved");
            break;
        case MFMailComposeResultSent:
            NSLog(@"Mail sent");
            break;
        case MFMailComposeResultFailed:
            NSLog(@"Mail sent failure: %@", [error localizedDescription]);
            break;
        default:
            break;
    }
    
    // Close the Mail Interface
    [self dismissViewControllerAnimated:YES completion:NULL];
}
- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result
{
    switch (result)
    {
        case MessageComposeResultCancelled:
            NSLog(@"Cancelled");
            break;
        case MessageComposeResultFailed:
        {
            NSLog(@"faild");
            UIAlertController *alrt=[UIAlertController alertControllerWithTitle:@"my apps" message:@"unknown error" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
                //do something when click button
            }];
            [alrt addAction:okAction];
            break;
        }
        case MessageComposeResultSent:
            break;
        default:
            break;
    }
 
  [self dismissModalViewControllerAnimated:YES];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{


    
    
  
    if (indexPath.section == 0)
    {
        
        if (indexPath.row==0)
        {
            //contact list msg sends
            //    MFMessageComposeViewController *controller = [[MFMessageComposeViewController alloc] init];
            ////    if([MFMessageComposeViewController canSendText])
            ////    {
            //        controller.body = @"Hello  sachin mokashi";
            //       // controller.recipients = [NSArray arrayWithObjects:@"+918237499204", nil];
            //
            //  controller.recipients = [NSArray arrayWithObjects:@"8850519524", @"8237499204", nil];
            //        controller.messageComposeDelegate = self;
            //           [self presentModalViewController:controller animated:YES];
            // }
            
           // facebook freindsintigration
            
//                FBSDKAppInviteContent *content =[[FBSDKAppInviteContent alloc] init];
//                NSString *urlString = @"https://fb.me/1317286481660217";
//                content.appLinkURL = [NSURL URLWithString:urlString];
//                [FBSDKAppInviteDialog showWithContent:content delegate:self];
            
  
            if (![[defaults valueForKey:@"SettingLogin"]isEqualToString:@"FACEBOOK"] ||[[defaults valueForKey:@"SettingLogin"]isEqualToString:@"EMAIL"])
            {
                if ([[defaults valueForKey:@"facebookconnect"]isEqualToString:@"yes"])
                {
                    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
                    FacebookListViewController * set=[mainStoryboard instantiateViewControllerWithIdentifier:@"FacebookListViewController"];
                    [self.navigationController pushViewController:set animated:YES];
                }
                else
                {
                [self logingWithFB];
                }
            }
            else
            {
                UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
                FacebookListViewController * set=[mainStoryboard instantiateViewControllerWithIdentifier:@"FacebookListViewController"];
                [self.navigationController pushViewController:set animated:YES];
            }
        }
        
        if (indexPath.row==1)
        {
            if (![[defaults valueForKey:@"SettingLogin"]isEqualToString:@"TWITTER"] ||[[defaults valueForKey:@"SettingLogin"]isEqualToString:@"EMAIL"])
            {
                if ([[defaults valueForKey:@"twitterconnect"]isEqualToString:@"yes"])
                {
                    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
                    TwitterListViewController * set=[mainStoryboard instantiateViewControllerWithIdentifier:@"TwitterListViewController"];
                    [self.navigationController pushViewController:set animated:YES];
                }
                else
                {
                [self loginWithTW];
                }
            }
            else
            {
            UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            TwitterListViewController * set=[mainStoryboard instantiateViewControllerWithIdentifier:@"TwitterListViewController"];
            [self.navigationController pushViewController:set animated:YES];
            }
            
        }
        
        if (indexPath.row==2)
        {
            UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            ContactListViewController * set=[mainStoryboard instantiateViewControllerWithIdentifier:@"ContactListViewController"];
            [self.navigationController pushViewController:set animated:YES];

        }
        
    }
    if (indexPath.section == 1)
    {
        if (indexPath.row==0)
        {
            

  
        }
        if (indexPath.row==1)
        {
            
                
    if ([[defaults valueForKey:@"logintype"] isEqualToString:@"FACEBOOK"]|| [[defaults valueForKey:@"logintype"] isEqualToString:@"TWITTER"])
                {
                    
                   
                }
                else
                {
                    
   UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
                    
   ChangePasswordViewController * set=[mainStoryboard instantiateViewControllerWithIdentifier:@"ChangePasswordViewController"];
                    
    [self.navigationController pushViewController:set animated:YES];
                 
                    
                }
            

        }
        if (indexPath.row==2)
        {
           
    
      
        }
        if (indexPath.row==3)
        {
            UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            
            DonationHistroyViewController * set=[mainStoryboard instantiateViewControllerWithIdentifier:@"DonationHistroyViewController"];
            
            [self.navigationController pushViewController:set animated:YES];
         
        }
        
        
    }
    if (indexPath.section == 3)
    {
        if (indexPath.row==0)
        {
            
            NSString *emailTitle = @"Report a problem";
            // Email Content
            NSString *messageBody = @"";
            NSArray *toRecipents = [NSArray arrayWithObject:@"support@care2dareapp.com"];
            
            MFMailComposeViewController *mc = [[MFMailComposeViewController alloc] init];
            mc.mailComposeDelegate = self;
            [mc setSubject:emailTitle];
            [mc setMessageBody:messageBody isHTML:YES];
            [mc setToRecipients:toRecipents];
            
            // Present mail view controller on screen
            [self presentViewController:mc animated:YES completion:NULL];  
            
        }
        if (indexPath.row==1)
        {
           [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.care2dareapp.com/terms.html"]];
            
        }
        if (indexPath.row==2)
        {
            
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.care2dareapp.com/privacy.html"]];
            
        }
        if (indexPath.row==3)
        {
            [self LogoutAccount];
            
        }
        
        if (indexPath.row==4)
        {
            {
                
                [self.view hideActivityViewWithAfterDelay:0];
                
                UIAlertController * alert=[UIAlertController alertControllerWithTitle:@"Delete Account?" message:@"Are you sure you want to delete your account? This will remove all your challenges, videos, contributions and all other details permanently."preferredStyle:UIAlertControllerStyleAlert];
                
                UIAlertAction* yesButton = [UIAlertAction actionWithTitle:@"Yes" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action)
                                            {
                                                [self DeleteAccount];
                                                
                                                
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
            
            
        }

    }



}
-(void)DeleteAccount
{
    
    
    
    //   [self.view showActivityViewWithLabel:@"Loading"];
    
    NSString *userid= @"userid";
    NSString *useridval =[defaults valueForKey:@"userid"];
    
    
    
    NSString *reqStringFUll=[NSString stringWithFormat:@"%@=%@",userid,useridval];
    
    
    
#pragma mark - swipe sesion
    
    NSURLSession *session = [NSURLSession sessionWithConfiguration: [NSURLSessionConfiguration defaultSessionConfiguration] delegate: nil delegateQueue: [NSOperationQueue mainQueue]];
    
    NSURL *url;
    NSString *  urlStrLivecount=[urlplist valueForKey:@"deleteaccount"];;
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
                                                 
                                                 
                                                 NSString * ResultString=[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
                                                 
                                                 ResultString = [ResultString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
                                                 
                                                 ResultString = [ResultString stringByReplacingOccurrencesOfString:@"\t" withString:@""];
                                                 
                                                 if ([ResultString isEqualToString:@"selecterror"]||[ResultString isEqualToString:@"nullerror"])
                                                 {
                                                     [self.view hideActivityViewWithAfterDelay:0];
                                                     UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Oops" message:@"Could not retrieve your Account Id. Please login and try again." preferredStyle:UIAlertControllerStyleAlert];
                                                     
                                                     UIAlertAction *actionOk = [UIAlertAction actionWithTitle:@"Ok"
                                                                                                        style:UIAlertActionStyleDefault
                                                                                                      handler:nil];
                                                     [alertController addAction:actionOk];
                                                     [self presentViewController:alertController animated:YES completion:nil];
                                                     
                                                     
                                                     
                                                     
                                                 }
                                                 if ([ResultString isEqualToString:@"done"])
                                                 {
                                                     
                                                     [self.view hideActivityViewWithAfterDelay:0];
                                                     
             UIAlertController * alert=[UIAlertController alertControllerWithTitle:@"Account Deleted" message:@"Your account has been permanently deleted."preferredStyle:UIAlertControllerStyleAlert];
                                                     
                  UIAlertAction* yesButton = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action)
                    {
                        [self LogoutAccount];
                     
                                                                                     
                                }];
                                
                        [alert addAction:yesButton];
                           
                        [self presentViewController:alert animated:YES completion:nil];
                                                 }
                                                 
                                                 }
                                                 
                                             
                                             
                                             else
                                             {
                                                 NSLog(@" error login1 ---%ld",(long)statusCode);
                                                 [self.view hideActivityViewWithAfterDelay:0];
                                             }
                                             
                                             
                                         }
                                         else if(error)
                                         {
                                             [self.view hideActivityViewWithAfterDelay:0];
                                             NSLog(@"error login2.......%@",error.description);
                                         }
                                         
                                         
                                     }];
    [dataTask resume];
    
}

-(void)LogoutAccount
{
    [defaults setObject:@"no" forKey:@"LoginView"];
    [defaults setObject:@"no" forKey:@"facebookconnect"];
    [defaults setObject:@"no" forKey:@"twitterconnect"];
    
        [defaults synchronize];
    NSHTTPCookie *cookie;
    NSHTTPCookieStorage *storage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    for (cookie in [storage cookies])
    {
        NSString* domainName = [cookie domain];
        NSRange domainRange = [domainName rangeOfString:@"facebook"];
        if(domainRange.length > 0)
        {
            [storage deleteCookie:cookie];
        }
    }
    [FBSDKAccessToken setCurrentAccessToken:nil];
    [FBSDKProfile setCurrentProfile:nil];
    
    
    NSString * twitterid=[defaults valueForKey:@"twitterid"];
    NSString *signedInUserID = [TWTRAPIClient clientWithCurrentUser].userID;
    if (signedInUserID)
    {
        [[[Twitter sharedInstance] sessionStore] logOutUserID:signedInUserID];
    }
    
[[[Twitter sharedInstance] sessionStore] logOutUserID:[defaults valueForKey:@"twitterid"]];
    TWTRSessionStore *store = [[Twitter sharedInstance] sessionStore];
    NSString *userID = store.session.userID;
    [store logOutUserID:userID];
    
    NSURL *url = [NSURL URLWithString:@"https://api.twitter.com"];
    NSArray *cookies = [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookiesForURL:url];
    for (NSHTTPCookie *cookie in cookies)
    {
        [[NSHTTPCookieStorage sharedHTTPCookieStorage] deleteCookie:cookie];
    }
    
    MainnavigationViewController *loginController=[[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"MainnavigationViewController"];
    
    
    

    
   //self.window.rootViewController=loginController;

//    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
//    LoginPageViewController *   Home_add= [mainStoryboard instantiateViewControllerWithIdentifier:@"LoginPageViewController"];
    [[UIApplication sharedApplication].keyWindow setRootViewController:loginController];
 
}
- (IBAction)DoneButton:(id)sender;
{
[self clientServerCommunication_Savephp];
   // self.hidesBottomBarWhenPushed = NO;
    [self.navigationController popViewControllerAnimated:YES];
       // [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)switchOutletAction:(id)sender
{
    UISwitch *switchObject = (UISwitch *)sender;
    if (switchObject.tag==0)
    {
        
    
        if ([switchObject isOn])
        {
            [switchObject setOn:NO animated:YES];
            [defaults setObject:@"OFF" forKey:@"Switch1"];
            [defaults synchronize];
        }
        else
        {
            [switchObject setOn:YES animated:YES];
            [defaults setObject:@"ON" forKey:@"Switch1"];
            [defaults synchronize];
        }
        
    }
    if (switchObject.tag==1)
    {
        
        if ([switchObject isOn])
        {
            [switchObject setOn:NO animated:YES];
            [defaults setObject:@"OFF" forKey:@"Switch2"];
            [defaults synchronize];
        }
        else
        {
            [switchObject setOn:YES animated:YES];
            [defaults setObject:@"ON" forKey:@"Switch2"];
            [defaults synchronize];
        }
    }
    
}
-(void)clientServerCommunication_Savephp
{
        
    NSString *userid= @"userid";
    NSString *useridval =[defaults valueForKey:@"userid"];
    
       NSString *onlyfriendscandare=@"onlyfriendscandare";
       NSString *pushchallenges=@"pushchallenges";
       NSString *pushcontributions=@"pushcontributions";
       NSString *pushvideos=@"pushvideos";
       NSString *pushfriends=@"pushfriends";
   

    
    
    NSString *reqStringFUll=[NSString stringWithFormat:@"%@=%@&%@=%@&%@=%@&%@=%@&%@=%@&%@=%@",userid,useridval,onlyfriendscandare,Str_Push_OnlyDare,pushchallenges,Str_Push_Challenge,pushcontributions,Str_Push_Contr,pushvideos,Str_Push_Vedio,pushfriends,Str_Push_Friend];
    
    
    
#pragma mark - swipe sesion
    
    NSURLSession *session = [NSURLSession sessionWithConfiguration: [NSURLSessionConfiguration defaultSessionConfiguration] delegate: nil delegateQueue: [NSOperationQueue mainQueue]];
    
    NSURL *url;
    NSString *  urlStrLivecount=[urlplist valueForKey:@"savesettings"];;
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
                                                 
                                                 
                                                 NSString * ResultString=[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
                                                 
                                                 ResultString = [ResultString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
                                                 
                                                 ResultString = [ResultString stringByReplacingOccurrencesOfString:@"\t" withString:@""];
                                                 
                                                 if ([ResultString isEqualToString:@"updated"])
                                                 {
                                        [defaults setObject:Str_Push_OnlyDare forKey:@"onlyfriendscandare"];
                                                     
                                        [defaults setObject:Str_Push_Challenge forKey:@"pushchallenges"];
                                                     
                                       [defaults setObject:Str_Push_Contr forKey:@"pushcontributions"];
                                                     
                                        [defaults setObject:Str_Push_Friend forKey:@"pushfriends"];
                                                     
                                        [defaults setObject:Str_Push_Vedio forKey:@"pushvideos"];
                                                     
                                                     
                                                   [defaults synchronize];
                                                     
                                                 }
                                                 else
                                                 {
                                                UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Oops" message:@"Could not update your settings. Please try again." preferredStyle:UIAlertControllerStyleAlert];
                                                     
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
    
}
-(void)loginWithTW
{
   
    
    [self.view showActivityViewWithLabel:@"Loading"];
    
    /*   [[Twitter sharedInstance] logInWithCompletion:^(TWTRSession *session, NSError *error) {
     if (session) {
     NSLog(@"signed in as %@", [session userName]);
     
     } else {
     NSLog(@"error: %@", [error localizedDescription]);
     }
     }];
     */
    
    [[Twitter sharedInstance] logInWithMethods:TWTRLoginMethodWebBased completion:^(TWTRSession *session, NSError *error)
     {
         if (session)
         {
             
             NSLog(@"signed in as %@", [session userName]);
             NSLog(@"signed in as %@", session);
             
             TWTRAPIClient *client = [TWTRAPIClient clientWithCurrentUser];
             NSURLRequest *request = [client URLRequestWithMethod:@"GET"
                                                              URL:@"https://api.twitter.com/1.1/account/verify_credentials.json"
                                                       parameters:@{@"include_email": @"true", @"skip_status": @"true"}
                                                            error:nil];
             
             //@"https://api.twitter.com/1.1/users/show.json";
             
             
             [client sendTwitterRequest:request completion:^(NSURLResponse *response, NSData *data, NSError *connectionError)
              {
                  NSLog(@"datadata in as %@", data);
                  NSString * ResultString=[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
                  NSLog(@"ResultString in as %@", ResultString);
                  NSMutableDictionary *  Array_sinupFb=[NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
                  
                  NSLog(@"Array_sinupFbArray_sinupFb in as %@", Array_sinupFb);
                  NSLog(@"emailemail in as %@", [Array_sinupFb valueForKey:@"email"]);
                  NSLog(@"location in as %@", [Array_sinupFb valueForKey:@"location"]);
                  NSLog(@"name in as %@", [Array_sinupFb valueForKey:@"name"]);
                  nameFb=[Array_sinupFb valueForKey:@"name"];
                  emailFb=[Array_sinupFb valueForKey:@"email"];
                  Fbid= [session userID];
                  [defaults setObject:Fbid forKey:@"twitterid"];
                  [defaults setObject:Fbid forKey:@"twitterids"];
                  [defaults synchronize];
                  regTypeVal =@"TWITTER";
                
                  
                  
                  [self TwitterFriendsList];
                  
                  //         [self FbTwittercommunicationServer];
                  
              }];
             
             
             
         } else
         {
             NSLog(@"error: %@", [error localizedDescription]);
             [self.view hideActivityViewWithAfterDelay:0];
         }
     }];
    
}
-(void)TwitterFriendsList
{
    
    
    TWTRAPIClient *client = [[TWTRAPIClient alloc] initWithUserID:Fbid];
    NSString *statusesShowEndpoint = @"https://api.twitter.com/1.1/friends/ids.json";
    NSDictionary *params = @{@"id" : Fbid};
    NSError *clientError;
    
    NSURLRequest *request = [client URLRequestWithMethod:@"GET" URL:statusesShowEndpoint parameters:params error:&clientError];
    
    if (request) {
        [client sendTwitterRequest:request completion:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
            if (data) {
                // handle the response data e.g.
                NSError *jsonError;
                NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
                
                NSArray *json22=[json objectForKey:@"ids"];
                
                
                NSLog(@"jsonjson: %d",json22.count);
                
                Str_fb_friend_id=[json22 componentsJoinedByString:@","];
                Str_fb_friend_id_Count=[NSString stringWithFormat:@"%d",json22.count];
                NSLog(@"Str_fb_friend_id: %@",Str_fb_friend_id);
                NSLog(@"jsonjson: %@",json22);
                
                [self FbTwittercommunicationServer];
            }
            else
            {
                NSLog(@"Error: %@", connectionError);
                
                [self TwitterFriendsList];
            }
        }];
    }
    else
    {
        NSLog(@"Error: %@", clientError);
        
        [self TwitterFriendsList];
    }
    
    
    
}
-(void)logingWithFB
{
    
        Reachability *networkReachability = [Reachability reachabilityForInternetConnection];
        NetworkStatus networkStatus = [networkReachability currentReachabilityStatus];
        if (networkStatus == NotReachable)
        {
            //        UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"No Internet" message:@"Please make sure you have internet connectivity in order to access Play:Date." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
            //        message.tag=100;
            //        [message show];
            
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"No Internet" message:@"Please make sure you have internet connectivity in order to access Care2Dare." preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction *actionOk = [UIAlertAction actionWithTitle:@"Ok"
                                                               style:UIAlertActionStyleDefault
                                                             handler:^(UIAlertAction *action)
                                       {
                                           [alertController dismissViewControllerAnimated:YES completion:nil];
                                           exit(0);
                                       }];
            
            [alertController addAction:actionOk];
            [self presentViewController:alertController animated:YES completion:nil];
            
            
            
        }
        else
        {
            [self.view showActivityViewWithLabel:@"Loading"];
            FBSDKLoginManager *login = [[FBSDKLoginManager alloc] init];
            
            
            
            [login logInWithReadPermissions: @[@"public_profile", @"email",@"user_friends"]
                         fromViewController:self
                                    handler:^(FBSDKLoginManagerLoginResult *result, NSError *error)
             {
                 NSLog(@"Process result=%@",result);
                 NSLog(@"Process error=%@",error);
                 if (error)
                 {
                     [self.view hideActivityViewWithAfterDelay:0];
                     
                     NSLog(@"Process error");
                 }
                 else if (result.isCancelled)
                 {
                     [self.view hideActivityViewWithAfterDelay:0];
                     
                     NSLog(@"Cancelled");
                 }
                 else
                 {
                     
                     
                     NSLog(@"Logged in");
                     NSLog(@"Process result123123=%@",result);
                     [[[FBSDKGraphRequest alloc] initWithGraphPath:@"me" parameters:@{ @"fields" : @"id,friends,name,first_name,last_name,gender,email,picture.width(100).height(100)"}]startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error) {
                         if (!error) {
                             if ([result isKindOfClass:[NSDictionary class]])
                             {
                                 NSLog(@"Results=%@",result);
                                 emailFb=[result objectForKey:@"email"];
                                 Fbid=[result objectForKey:@"id"];
                                 nameFb=[result objectForKey:@"name"];
                                
                                 
                                 
                                 NSArray * allKeys = [[result valueForKey:@"friends"]objectForKey:@"data"];
                                 
                                 fb_friend_id  =  [[NSMutableArray alloc]init];
                                 
                                 for (int i=0; i<[allKeys count]; i++)
                                 {
                                  [fb_friend_id addObject:[[[[result valueForKey:@"friends"]objectForKey:@"data"] objectAtIndex:i] valueForKey:@"id"]];
                                     
                                 }
                                 Str_fb_friend_id_Count=[NSString stringWithFormat:@"%d",fb_friend_id.count];
                                 Str_fb_friend_id=[fb_friend_id componentsJoinedByString:@","];
                                 ;
                                regTypeVal =@"FACEBOOK";
                                 [defaults setObject:Fbid forKey:@"facebookid"];
                                 [defaults synchronize];
                                 [self FbTwittercommunicationServer];
                                 
                             }
                             
                             
                         }
                     }];
                     
                 }
                 
             }];
        }
        
    
}
-(void)FbTwittercommunicationServer
{
    
    
    
    //   [self.view showActivityViewWithLabel:@"Loading"];
   
    NSString *userid= @"userid";
    NSString *useridval =[defaults valueForKey:@"userid"];
    
     NSString *email= @"email";
    
    NSString *fbid1;
    
    if ([regTypeVal isEqualToString:@"FACEBOOK"])
    {
        fbid1= @"fbid";
    }
    else
    {
        fbid1= @"twitterid";
    }
    
    NSString *regType= @"regtype";
   
    NSString *friendlist= @"friendlist";
    NSString *friendlistval =[NSString stringWithFormat:@"%@",Str_fb_friend_id];
    
    
    NSString *reqStringFUll=[NSString stringWithFormat:@"%@=%@&%@=%@&%@=%@&%@=%@&%@=%@",fbid1,Fbid,email,emailFb,regType,regTypeVal,userid,useridval,friendlist,friendlistval];
    
    
    
#pragma mark - swipe sesion
    
    NSURLSession *session = [NSURLSession sessionWithConfiguration: [NSURLSessionConfiguration defaultSessionConfiguration] delegate: nil delegateQueue: [NSOperationQueue mainQueue]];
    
    NSURL *url;
    NSString *  urlStrLivecount=[urlplist valueForKey:@"connect_fb_twitter"];;
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
                                                 
                        
                            NSString * ResultString=[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
                                                
                           ResultString = [ResultString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
                            
                        ResultString = [ResultString stringByReplacingOccurrencesOfString:@"\t" withString:@""];
                  
                     if ([ResultString isEqualToString:@"error"])
                                {
                        [self.view hideActivityViewWithAfterDelay:0];
                        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Oops" message:@"Could not retrieve one of the Account Ids. Please login and try again." preferredStyle:UIAlertControllerStyleAlert];
                                                     
                        UIAlertAction *actionOk = [UIAlertAction actionWithTitle:@"Ok"
                                style:UIAlertActionStyleDefault
                                            handler:nil];
                                    [alertController addAction:actionOk];
                                    [self presentViewController:alertController animated:YES completion:nil];
                                                     
                                    
                                                     
                                                     
                                }
                            if ([ResultString isEqualToString:@"anotheruser"])
                            {
                                
                            [self.view hideActivityViewWithAfterDelay:0];
                                [self.view hideActivityViewWithAfterDelay:0];
                                UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Oops" message:@"You already have another account linked with us. Please login through that or delete that account." preferredStyle:UIAlertControllerStyleAlert];
                                
                                UIAlertAction *actionOk = [UIAlertAction actionWithTitle:@"Ok"
                                                                                   style:UIAlertActionStyleDefault
                                                                                 handler:nil];
                                [alertController addAction:actionOk];
                                [self presentViewController:alertController animated:YES completion:nil];
                            }
                    if ([ResultString isEqualToString:[defaults valueForKey:@"facebookid"]])
                            {
                                 [self.view hideActivityViewWithAfterDelay:0];
                                if ([regTypeVal isEqualToString:@"FACEBOOK"])
                                {
                                    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
                                    FacebookListViewController * set=[mainStoryboard instantiateViewControllerWithIdentifier:@"FacebookListViewController"];
                                    [self.navigationController pushViewController:set animated:YES];
                                    [defaults setObject:@"yes" forKey:@"facebookconnect"];
                                    [defaults synchronize];
                                    
                                }
                            }
                    if ([ResultString isEqualToString:[defaults valueForKey:@"twitterids"]])
                        {
                             [self.view hideActivityViewWithAfterDelay:0];
                                if ([regTypeVal isEqualToString:@"TWITTER"])
                                {
                        UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
                    TwitterListViewController * set=[mainStoryboard instantiateViewControllerWithIdentifier:@"TwitterListViewController"];
                                    [self.navigationController pushViewController:set animated:YES];
                                    [defaults setObject:@"yes" forKey:@"twitterconnect"];
                                    [defaults synchronize];
                                }
                        }
                            
                                                 
                                             }
                                             
                                             else
                                             {
                                                 NSLog(@" error login1 ---%ld",(long)statusCode);
                                                 [self.view hideActivityViewWithAfterDelay:0];
                                             }
                                             
                                             
                                         }
                                         else if(error)
                                         {
                                             [self.view hideActivityViewWithAfterDelay:0];
                                             NSLog(@"error login2.......%@",error.description);
                                         }
                                         
                                         
                                     }];
    [dataTask resume];
    
}
- (IBAction)Swich_OnlyDare:(id)sender
{
    UISwitch *SwichOnoff = (UISwitch *) sender;
    NSLog(@"Swich Tag===%ld",(long)SwichOnoff.tag);
    if (SwichOnoff.on)
    {
        Str_Push_OnlyDare=@"yes";
    }
    else
    {
        Str_Push_OnlyDare=@"yes";
    }
}
- (IBAction)Swich_PushNotification:(id)sender
{
    NSString * changeString;
    UISwitch *SwichOnoff = (UISwitch *) sender;
    NSLog(@"Swich Tag===%ld",(long)SwichOnoff.tag);
    if (SwichOnoff.on)
    {
        changeString=@"yes";
    }
    else
    {
     changeString=@"no";
    }
    if ((long)SwichOnoff.tag==0)
    {
        Str_Push_Challenge=changeString;
    }
    if ((long)SwichOnoff.tag==1)
    {
      Str_Push_Contr=changeString;
    }
    if((long)SwichOnoff.tag==2)
    {
      Str_Push_Vedio=changeString;
    }
    if ((long)SwichOnoff.tag==3)
    {
      Str_Push_Friend=changeString;
    }
}




@end
