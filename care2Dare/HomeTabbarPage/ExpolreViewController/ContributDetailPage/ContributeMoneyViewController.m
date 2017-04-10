//
//  ContributeMoneyViewController.m
//  care2Dare
//
//  Created by Spiel's Macmini on 3/17/17.
//  Copyright © 2017 Spiel's Macmini. All rights reserved.
//

#import "ContributeMoneyViewController.h"
#import "SBJsonParser.h"
#import "Reachability.h"
#import "UIView+RNActivityView.h"
@interface ContributeMoneyViewController ()
{
    NSUserDefaults * defaults;
    NSDictionary * urlplist;
    NSUInteger chllengerAmt;
}
@end

@implementation ContributeMoneyViewController
@synthesize view_Topheader,Label_ContributePlayes,BottomView,Button_back,Button_Help,Button_Contribute_Send,textfield_Ammounts,total_players,Label_TotalContribute,challengerID;
- (void)viewDidLoad {
    [super viewDidLoad];
    defaults=[[NSUserDefaults alloc]init];
    NSString *plistPath = [[NSBundle mainBundle]pathForResource:@"UrlName" ofType:@"plist"];
    urlplist = [NSDictionary dictionaryWithContentsOfFile:plistPath];
    CALayer * borderBottom_topheder = [CALayer layer];
    borderBottom_topheder.backgroundColor =[UIColor colorWithRed:186/255.0 green:188/255.0 blue:190/255.0 alpha:1.0].CGColor;
    borderBottom_topheder.frame = CGRectMake(0, view_Topheader.frame.size.height-1, view_Topheader.frame.size.width,1);
    [view_Topheader.layer addSublayer:borderBottom_topheder];
    
    Button_Contribute_Send.enabled=NO;
    Button_Contribute_Send.backgroundColor=[UIColor colorWithRed:241/255.0 green:241/255.0 blue:241/255.0 alpha:1];
    [Button_Contribute_Send setTitle:@"SEND" forState:UIControlStateNormal];
    [Button_Contribute_Send setTitleColor:[UIColor colorWithRed:65/255.0 green:65/255.0 blue:65/255.0 alpha:1] forState:UIControlStateNormal];
    Label_ContributePlayes.text=[NSString stringWithFormat:@"%@%@%@",@"x",total_players,@" players"];
    [textfield_Ammounts becomeFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self subscribeToKeyboard];
    
}
- (void)subscribeToKeyboard
{
    [self an_subscribeKeyboardWithAnimations:^(CGRect keyboardRect, NSTimeInterval duration, BOOL isShowing) {
        if (isShowing) {
            self.tabBarBottomSpace.constant = CGRectGetHeight(keyboardRect);
         
            
        } else
        {
            
            self.tabBarBottomSpace.constant = 0.0f;
                   }
        [self.view layoutIfNeeded];
    } completion:nil];
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self an_unsubscribeKeyboard];
}
-(IBAction)ButtonBack_Action:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(IBAction)Button_Help_Action:(id)sender
{
    
}
-(IBAction)Button_Contribute_Send_Action:(id)sender
{
   [textfield_Ammounts resignFirstResponder];
    
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
        [self.view showActivityViewWithLabel:@"Loading"];
        
        NSString *userid= @"userid";
        NSString *useridVal =[defaults valueForKey:@"userid"];
        
        NSString *challengrid= @"challengeid";
       
        NSString *challengerPlayers= @"noofchallengers";
       
        NSString *chllengerAmount= @"payperchallenger";
     
        
        
        
        NSString *reqStringFUll=[NSString stringWithFormat:@"%@=%@&%@=%@&%@=%@&%@=%@",userid,useridVal,challengrid,challengerID,challengerPlayers,total_players,chllengerAmount,textfield_Ammounts.text];
        
        
        
#pragma mark - swipe sesion
        
        NSURLSession *session = [NSURLSession sessionWithConfiguration: [NSURLSessionConfiguration defaultSessionConfiguration] delegate: nil delegateQueue: [NSOperationQueue mainQueue]];
        
        NSURL *url;
        NSString *  urlStrLivecount=[urlplist valueForKey:@"contribute"];;
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
   if ([ResultString isEqualToString:@"nouserid"])
    {
          [self.view hideActivityViewWithAfterDelay:0];
     UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Oops" message:@"Your account does not exist or seems to have been suspended. Please contact admin." preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *actionOk = [UIAlertAction actionWithTitle:@"Ok"
    style:UIAlertActionStyleDefault handler:nil];
        [alertController addAction:actionOk];
        [self presentViewController:alertController animated:YES completion:nil];
                                                         
    }
    if ([ResultString isEqualToString:@"nullerror"])
    {
          [self.view hideActivityViewWithAfterDelay:0];
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Oops" message:@"Please enter all fields and try again." preferredStyle:UIAlertControllerStyleAlert];
             
        UIAlertAction *actionOk = [UIAlertAction actionWithTitle:@"Ok"
        style:UIAlertActionStyleDefault handler:nil];
        [alertController addAction:actionOk];
        [self presentViewController:alertController animated:YES completion:nil];
             
         }
         if ([ResultString isEqualToString:@"inserterror"])
         {
               [self.view hideActivityViewWithAfterDelay:0];
             UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Oops" message:@"We could not accept your amount due to a server error. Please try again." preferredStyle:UIAlertControllerStyleAlert];
             
             UIAlertAction *actionOk = [UIAlertAction actionWithTitle:@"Ok"
                                                                style:UIAlertActionStyleDefault handler:nil];
             [alertController addAction:actionOk];
             [self presentViewController:alertController animated:YES completion:nil];
             
         }
         if ([ResultString isEqualToString:@"amounterror"])
         {
               [self.view hideActivityViewWithAfterDelay:0];
             UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Oops" message:@"Please check the amount you have entered and try again." preferredStyle:UIAlertControllerStyleAlert];
             
             UIAlertAction *actionOk = [UIAlertAction actionWithTitle:@"Ok"
                                                                style:UIAlertActionStyleDefault handler:nil];
             [alertController addAction:actionOk];
             [self presentViewController:alertController animated:YES completion:nil];
             
         }
         if ([ResultString isEqualToString:@"done"])
         {
               [self.view hideActivityViewWithAfterDelay:0];
             UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Thank-You!" message:@"You have succeessfully contributed to the challenge! You will be notified when the challenge is complete." preferredStyle:UIAlertControllerStyleAlert];
             
             UIAlertAction *actionOk = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action)
                                    {
                [self.navigationController popToRootViewControllerAnimated:YES];
                                }];
             
             [alertController addAction:actionOk];             [self presentViewController:alertController animated:YES completion:nil];
             
         }


     }
        
  else
 {
       [self.view hideActivityViewWithAfterDelay:0];
NSLog(@" error login1 ---%ld",(long)statusCode);
                                                     
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
    
    
}
-(IBAction)textfield_Ammounts_Actions:(id)sender
{
     chllengerAmt=[textfield_Ammounts.text integerValue]*[total_players integerValue];
    if (textfield_Ammounts.text.length==0)
    {
        textfield_Ammounts.textColor=[UIColor colorWithRed:65/255.0 green:65/255.0 blue:65/255.0 alpha:1];
        Button_Contribute_Send.enabled=NO;
        Button_Contribute_Send.backgroundColor=[UIColor colorWithRed:241/255.0 green:241/255.0 blue:241/255.0 alpha:1];
        [Button_Contribute_Send setTitle:@"SEND" forState:UIControlStateNormal];
        
  
       
        [Button_Contribute_Send setTitleColor:[UIColor colorWithRed:65/255.0 green:65/255.0 blue:65/255.0 alpha:0.9] forState:UIControlStateNormal];
        
//        Label_TotalContribute.text=@"SEND";
//        Label_TotalContribute.textColor=[UIColor colorWithRed:65/255.0 green:65/255.0 blue:65/255.0 alpha:1];
//        Label_TotalContribute.backgroundColor=[UIColor colorWithRed:241/255.0 green:241/255.0 blue:241/255.0 alpha:1];
    }
    else
    {
        textfield_Ammounts.textColor=[UIColor colorWithRed:79/255.0 green:76/255.0 blue:227/255.0 alpha:1];
//        Label_TotalContribute.textColor=[UIColor whiteColor];
//        Label_TotalContribute.backgroundColor=[UIColor colorWithRed:79/255.0 green:76/255.0 blue:227/255.0 alpha:1];
        
         Button_Contribute_Send.enabled=YES;
    
        [Button_Contribute_Send setTitle:[NSString stringWithFormat:@"%@%lu",@"SEND TOTAL: $",(unsigned long)chllengerAmt] forState:UIControlStateNormal];
        
           [Button_Contribute_Send setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        Button_Contribute_Send.backgroundColor=[UIColor colorWithRed:79/255.0 green:76/255.0 blue:227/255.0 alpha:1];
        
        
//        Label_TotalContribute.text=[NSString stringWithFormat:@"%@%lu",@"SEND TOTAL: $",(unsigned long)calAmt];

    }
  
}

@end
