//
//  CreateFundriserViewController.m
//  care2Dare
//
//  Created by MacMini2 on 21/11/17.
//  Copyright © 2017 Spiel's Macmini. All rights reserved.
//

#import "CreateFundriserViewController.h"
#import "CreateFundriserOneViewController.h"
#import "CreateChallengerTwoViewController.h"
@interface CreateFundriserViewController ()
{
    NSString *challengetypeValDonate;
    NSUserDefaults *defaults;
}
@end

@implementation CreateFundriserViewController
@synthesize Button_Image_Donate,Button_Image_Raised,Button_Label_Donate,Button_Label_Raised,Button_Dot1,Button_Dot2,Button_Dot3;
- (void)viewDidLoad {
    [super viewDidLoad];
     defaults=[[NSUserDefaults alloc]init];
    [Button_Label_Raised setTitleColor:[UIColor colorWithRed:186/255.0 green:188/255.0 blue:190/255.0 alpha:1] forState:UIControlStateNormal];
    [Button_Label_Donate setTitleColor:[UIColor colorWithRed:186/255.0 green:188/255.0 blue:190/255.0 alpha:1] forState:UIControlStateNormal];
    [Button_Image_Raised setImage:[UIImage imageNamed:@"raisegrey.png"] forState:UIControlStateNormal];
    [Button_Image_Donate setImage:[UIImage imageNamed:@"donategrey.png"] forState:UIControlStateNormal];
    challengetypeValDonate=@"";

    Button_Dot1.layer.cornerRadius=Button_Dot1.frame.size.height/2;
    Button_Dot2.layer.cornerRadius=Button_Dot2.frame.size.height/2;
    Button_Dot3.layer.cornerRadius=Button_Dot3.frame.size.height/2;
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
  challengetypeValDonate=@"";
    [Button_Label_Raised setTitleColor:[UIColor colorWithRed:186/255.0 green:188/255.0 blue:190/255.0 alpha:1] forState:UIControlStateNormal];
    [Button_Label_Donate setTitleColor:[UIColor colorWithRed:186/255.0 green:188/255.0 blue:190/255.0 alpha:1] forState:UIControlStateNormal];
    [Button_Image_Raised setImage:[UIImage imageNamed:@"raisegrey.png"] forState:UIControlStateNormal];
    [Button_Image_Donate setImage:[UIImage imageNamed:@"donategrey.png"] forState:UIControlStateNormal];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)ButtonCancel_Action:(id)sender
{
    [self.view endEditing:YES];
    [defaults setObject:@"no" forKey:@"ExpView_Update"];
    [defaults setObject:@"no" forKey:@"falg"];
    [defaults setObject:@"" forKey:@"usernames"];
    [defaults setObject:@"" forKey:@"userids"];
    [defaults synchronize];
    
  [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}


-(IBAction)ButtonChallengeDonate_Action:(id)sender
{
    
    

    
    challengetypeValDonate=@"DONATE";
  
    [Button_Image_Raised setImage:[UIImage imageNamed:@"raisegrey.png"] forState:UIControlStateNormal];
    [Button_Image_Donate setImage:[UIImage imageNamed:@"donateblue.png"] forState:UIControlStateNormal];
    [Button_Label_Donate setTitleColor:[UIColor colorWithRed:67/255.0 green:188/255.0 blue:255/255.0 alpha:1]forState:UIControlStateNormal];
   [Button_Label_Raised setTitleColor:[UIColor colorWithRed:186/255.0 green:188/255.0 blue:190/255.0 alpha:1]forState:UIControlStateNormal];
    
    
    CreateFundriserOneViewController * set=[self.storyboard instantiateViewControllerWithIdentifier:@"CreateFundriserOneViewController"];
    
 
    NSMutableDictionary * dict=[[NSMutableDictionary alloc]init];
    [dict setValue:@"DONATE" forKey:@"challengetype"];
    set.Dict_values1=dict;
    [self.navigationController pushViewController:set animated:YES];
   
  
}
-(IBAction)ButtonFundRaised_Action:(id)sender
{
    challengetypeValDonate=@"RAISE";
   
    
    
    [Button_Image_Raised setImage:[UIImage imageNamed:@"raiseblue.png"] forState:UIControlStateNormal];
    [Button_Image_Donate setImage:[UIImage imageNamed:@"donategrey.png"] forState:UIControlStateNormal];
    
    
    [Button_Label_Raised setTitleColor:[UIColor colorWithRed:67/255.0 green:188/255.0 blue:255/255.0 alpha:1] forState:UIControlStateNormal];
    [Button_Label_Donate setTitleColor:[UIColor colorWithRed:186/255.0 green:188/255.0 blue:190/255.0 alpha:1] forState:UIControlStateNormal];
    
    CreateFundriserOneViewController * set=[self.storyboard instantiateViewControllerWithIdentifier:@"CreateFundriserOneViewController"];
     NSMutableDictionary * dict=[[NSMutableDictionary alloc]init];
     [dict setValue:@"RAISE" forKey:@"challengetype"];
     set.Dict_values1=dict;
    [self.navigationController pushViewController:set animated:YES];
}

@end
