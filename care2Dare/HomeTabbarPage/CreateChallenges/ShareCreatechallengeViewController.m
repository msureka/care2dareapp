//
//  ShareCreatechallengeViewController.m
//  care2Dare
//
//  Created by MacMini2 on 22/11/17.
//  Copyright © 2017 Spiel's Macmini. All rights reserved.
//

#import "ShareCreatechallengeViewController.h"

@interface ShareCreatechallengeViewController ()
{
    NSString * str_Challenge_Status;
}
@end

@implementation ShareCreatechallengeViewController
@synthesize Button_share,Button_finish,Label_desc,Array_Values;
- (void)viewDidLoad {
    [super viewDidLoad];
    Button_share.layer.cornerRadius=Button_share.frame.size .height/2;
    Button_share.layer.borderWidth=1.0f;
    Button_share.layer.borderColor=[UIColor colorWithRed:186/255.0 green:188/255.0 blue:190/255.0 alpha:1].CGColor;
     Button_finish.layer.cornerRadius=Button_finish.frame.size .height/2;
    Button_finish.layer.borderWidth=1.0f;
    Button_finish.layer.borderColor=[UIColor colorWithRed:67/255.0 green:188/255.0 blue:255/255.0 alpha:1].CGColor;
    
    
    
    
    
    
    if ([[[Array_Values objectAtIndex:0]valueForKey:@"contributiontype"] isEqualToString:@"RAISE"])
    {
        Label_desc.text=@"Your fundraiser has been created!";
        str_Challenge_Status=@"fundraiser";
    }
    else
    {
      Label_desc.text=@"Your challenge has been created!";
         str_Challenge_Status=@"challenge";
    }
    
    
//    challengeid = C20171124050209S8NO;
//    challengetype = PRIVATE;
//    contributiontype = DONATE;
//    createdate = "2017-11-24 05:02:09";
//    creatorname = "Mohit Sureka";
//    enddate = "2017-12-24 05:02:09";
//    mediathumbnailurl = "http://www.care2dareapp.com/app/challengemedia/C20171124050209S8NO-thumbnail.jpg";
//    mediatype = IMAGE;
//    mediaurl = "http://www.care2dareapp.com/app/challengemedia/C20171124050209S8NO.jpg";
//    noofchallengers = 1;
//    payperchallenger = 100;
//    title = Test;

    
    NSString * texttoshare=[NSString stringWithFormat:@"%@%@%@%@%@%@%@%@%@%@%@",@"Hey,\n\nYour friend - ",[[Array_Values objectAtIndex:0]valueForKey:@"creatorname"],@" has posted a new ",str_Challenge_Status,@" on Care2Dare App!\n\nTitle: ",[[Array_Values objectAtIndex:0]valueForKey:@"title"],@"\n\nMedia: ",[[Array_Values objectAtIndex:0]valueForKey:@"mediaurl"],@"\n\nTo contribute to this ",str_Challenge_Status,@" download the app now - http://www.care2dareapp.com!\n\nThanks!"];
    
    
    NSArray *activityItems1=@[texttoshare];
    NSArray *activityItems =@[UIActivityTypePrint,UIActivityTypeAirDrop,UIActivityTypeAssignToContact,UIActivityTypeAddToReadingList,UIActivityTypeOpenInIBooks];
    UIActivityViewController *activityViewControntroller = [[UIActivityViewController alloc] initWithActivityItems:activityItems1 applicationActivities:nil];
    activityViewControntroller.excludedActivityTypes = activityItems;
    [self presentViewController:activityViewControntroller animated:YES completion:nil];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
   
}



- (IBAction)Button_Share_Action:(id)sender
{
    
    NSString * texttoshare=[NSString stringWithFormat:@"%@%@%@%@%@%@%@%@%@%@%@",@"Hey,\n\nYour friend - ",[[Array_Values objectAtIndex:0]valueForKey:@"creatorname"],@" has posted a new ",str_Challenge_Status,@" on Care2Dare App!\n\nTitle: ",[[Array_Values objectAtIndex:0]valueForKey:@"title"],@"\n\nMedia: ",[[Array_Values objectAtIndex:0]valueForKey:@"mediaurl"],@"\n\nTo contribute to this ",str_Challenge_Status,@" download the app now - http://www.care2dareapp.com!\n\nThanks!"];
    
    
    NSArray *activityItems1=@[texttoshare];
    NSArray *activityItems =@[UIActivityTypePrint,UIActivityTypeAirDrop,UIActivityTypeAssignToContact,UIActivityTypeAddToReadingList,UIActivityTypeOpenInIBooks];
    UIActivityViewController *activityViewControntroller = [[UIActivityViewController alloc] initWithActivityItems:activityItems1 applicationActivities:nil];
    activityViewControntroller.excludedActivityTypes = activityItems;
    [self presentViewController:activityViewControntroller animated:YES completion:nil];
    
//    [activityViewControntroller setCompletionHandler:^(NSString *act, BOOL success)
//     {
//         NSLog(@"post type==%@",act);
//         NSString *result = nil;
//         
//         //
//         
//         if ( [act isEqualToString:@"net.whatsapp.WhatsApp.ShareExtension"] )  result = @"POST-SHARED-SUCCESSFULLY";
//         if ( [act isEqualToString:@"com.apple.mobilenotes.SharingExtension"] )  result = @"POST-SHARED-SUCCESSFULLY";
//         if ( [act isEqualToString:@"com.apple.UIKit.activity.Mail"] )  result = @"POST-SHARED-SUCCESSFULLY";
//         
//         if ( [act isEqualToString:UIActivityTypePrint] )  result = @"POST-SHARED-SUCCESSFULLY";
//         if ( [act isEqualToString:UIActivityTypeAirDrop] )  result = @"POST-SHARED-SUCCESSFULLY";
//         if ( [act isEqualToString:UIActivityTypeAssignToContact] )  result = @"POST-SHARED-SUCCESSFULLY";
//         if ( [act isEqualToString:UIActivityTypeAddToReadingList] )  result = @"POST-SHARED-SUCCESSFULLY";
//         if ( [act isEqualToString:UIActivityTypeOpenInIBooks] )  result = @"POST-SHARED-SUCCESSFULLY";
//         if ( [act isEqualToString:UIActivityTypePostToTwitter] )  result = @"POST-SHARED-SUCCESSFULLY";
//         if ( [act isEqualToString:UIActivityTypePostToFacebook] ) result = @"POST-SHARED-SUCCESSFULLY";
//         
//         if (success)
//         {
//             
//             [self.view hideActivityViewWithAfterDelay:0];                                                  [self dismissViewControllerAnimated:YES completion:nil];
//         }
//         else
//         {
//             
//             [self.view hideActivityViewWithAfterDelay:0];
//             
//             [self dismissViewControllerAnimated:YES completion:nil];
//         }
//     }];
}

- (IBAction)Button_Finish_Action:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
