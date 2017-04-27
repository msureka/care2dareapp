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
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <Bolts/Bolts.h>
#import <FBSDKShareKit/FBSDKShareKit.h>
#import "LoginPageViewController.h"
#import <MessageUI/MessageUI.h>
#import <Messages/Messages.h>
#import "MainnavigationViewController.h"
@interface AccountSettViewController ()<UIAlertViewDelegate,MFMessageComposeViewControllerDelegate>
{
    NSArray *Array_Title1,*Array_Title2,*Array_Title3,*Array_Title4,*Array_Gender2,*Array_Images;
    UIView *sectionView;
    NSUserDefaults *defaults;
    
 
    NSDictionary *urlplist;
    NSURLConnection *Connection_Delete,*Connection_ChangeproInfo;
    NSMutableData *webData_Delete,*webData_ChangeproInfo;
    NSMutableArray *Array_Delete,*Array_ChangeproInfo;
   
    NSString *EnglishStr,*ArabicStr;
   
}

@end

@implementation AccountSettViewController
@synthesize onecell,Twocell2,Threecell3,HeadTopView;
- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    CALayer *borderBottom = [CALayer layer];
    borderBottom.backgroundColor = [UIColor colorWithRed:186/255.0 green:188/255.0 blue:190/255.0 alpha:1.0].CGColor;
    borderBottom.frame = CGRectMake(0, HeadTopView.frame.size.height - 1, HeadTopView.frame.size.width, 1);
    [HeadTopView.layer addSublayer:borderBottom];
    
    NSString *plistPath = [[NSBundle mainBundle]pathForResource:@"UrlName" ofType:@"plist"];
    urlplist = [NSDictionary dictionaryWithContentsOfFile:plistPath];

    
  
    Array_Title1=[[NSArray alloc]initWithObjects:@"Facebook Friends",@"Twitter Friends",@"Contacts", nil];
Array_Images=[[NSArray alloc]initWithObjects:@"setting_facebook.png",@"setting_twitter.png",@"setting_contacts.png", nil];
 
    Array_Title2=[[NSArray alloc]initWithObjects:@"Edit Profile",@"Change Password",@"Block Users",@"Push Notification Settings",@"Only Friends can dare me",nil];
    
    
    
    Array_Title3=[[NSArray alloc]initWithObjects:@"Report a Problem",@"Terms",@"About",@"Log Out",nil];
    
   
    
    
    defaults=[[NSUserDefaults alloc]init];
    // Creating refresh control

    [TableView_Setting reloadData];
  
}
-(void)viewWillAppear:(BOOL)animated
{
       [TableView_Setting reloadData];
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
                Twocell2 = (AccTwoTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellId2 forIndexPath:indexPath];
                Twocell2.layer.borderColor=[UIColor groupTableViewBackgroundColor].CGColor;
                Twocell2.layer.borderWidth=1.0f;
                
                Twocell2.LabelVal.text=[Array_Title2 objectAtIndex:indexPath.row];
                if (indexPath.row == Array_Title2.count-1)
                {
                    Twocell2.switchOutlet.hidden=NO;
                }
                else
                {
                    Twocell2.switchOutlet.hidden=YES;
                }
                               return Twocell2;
                
            }
                break;
                
                
                
                case 2:
                
            {
                
                
                Threecell3 = (AccThreeTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellId3 forIndexPath:indexPath];
                
                
              
                Threecell3.layer.borderColor=[UIColor groupTableViewBackgroundColor].CGColor;
                Threecell3.layer.borderWidth=1.0f;
                
                Threecell3.LabelVal.text=[Array_Title3 objectAtIndex:indexPath.row];
                
                
                return Threecell3;
                
            }
                
                break;
        }
    return nil;
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
        return 4;
    
    
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
        Label1.text=@"If checked.only your friends will be able to send you dare request";
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
        Label1.text=@"Support";
        [sectionView addSubview:Label1];
        sectionView.tag=section;
        
        
    }
    
    if (section==3)
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
//- (void)appInviteDialog:(FBSDKAppInviteDialog *)appInviteDialog didFailWithError:(NSError *)error
//{
//    
//}
//- (void)appInviteDialog:(FBSDKAppInviteDialog *)appInviteDialog didCompleteWithResults:(NSDictionary *)results
//{
//    NSLog(@"RESUltssssInvite==%@",results);
//}
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
  
//    FBSDKAppInviteContent *content =[[FBSDKAppInviteContent alloc] init];
//    NSString *urlString = @"https://fb.me/1317286481660217";
//    content.appLinkURL = [NSURL URLWithString:urlString];
//    [FBSDKAppInviteDialog showWithContent:content delegate:self];

    
    
  
    if (indexPath.section == 0)
    {
        
        if (indexPath.row==0)
        {
//        UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
//        
//  SettingGenderViewController * set=[mainStoryboard instantiateViewControllerWithIdentifier:@"SettingGenderViewController"];
//        
//        [self.navigationController pushViewController:set animated:YES];
        }
        
        if (indexPath.row==1)
        {


            
        }
        
        if (indexPath.row==2)
        {
 
        }
        
    }
    if (indexPath.section == 1)
    {
        if (indexPath.row==0)
        {
            

  
        }
        if (indexPath.row==1)
        {
            

        }
        if (indexPath.row==2)
        {
            
    
      
        }
        if (indexPath.row==3)
        {
       
         
        }
        
        
    }
    if (indexPath.section == 2)
    {
        if (indexPath.row==0)
        {
            
            
            
        }
        if (indexPath.row==1)
        {
            
            
        }
        if (indexPath.row==2)
        {
            
            
            
        }
        if (indexPath.row==3)
        {
            [self LogoutAccount];
            
        }
        
        
    }



}


-(void)LogoutAccount
{
    [defaults setObject:@"no" forKey:@"LoginView"];
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
    
    MainnavigationViewController *loginController=[[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"MainnavigationViewController"];
    
    //self.window.rootViewController=loginController;

//    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
//    LoginPageViewController *   Home_add= [mainStoryboard instantiateViewControllerWithIdentifier:@"LoginPageViewController"];
    [[UIApplication sharedApplication].keyWindow setRootViewController:loginController];
 
}
- (IBAction)DoneButton:(id)sender;
{
    
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




@end
