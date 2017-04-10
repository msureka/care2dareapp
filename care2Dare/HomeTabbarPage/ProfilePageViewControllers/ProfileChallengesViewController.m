//
//  ProfileChallengesViewController.m
//  care2Dare
//
//  Created by Spiel's Macmini on 3/7/17.
//  Copyright © 2017 Spiel's Macmini. All rights reserved.
//

#import "ProfileChallengesViewController.h"

@interface ProfileChallengesViewController ()
{
 
    NSString * SeachCondCheck;
}
@end

@implementation ProfileChallengesViewController
@synthesize cell_Challenges,Lable_TitleChallenges,Button_Back,Button_Search,Textfield_Search,Tableview_Challenges,view_Topheader;
- (void)viewDidLoad {
    [super viewDidLoad];
    Textfield_Search.hidden=YES;
    SeachCondCheck=@"no";
    Textfield_Search.delegate=self;
    CALayer*  borderBottom_topheder = [CALayer layer];
    borderBottom_topheder.backgroundColor =[UIColor colorWithRed:186/255.0 green:188/255.0 blue:190/255.0 alpha:1.0].CGColor;
    borderBottom_topheder.frame = CGRectMake(0, view_Topheader.frame.size.height-1, view_Topheader.frame.size.width,1);
    [view_Topheader.layer addSublayer:borderBottom_topheder];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

-(IBAction)ButtonBack_Action:(id)sender
{
    if ([SeachCondCheck isEqualToString:@"yes"])
    {
        [Textfield_Search resignFirstResponder];
        Lable_TitleChallenges.hidden=NO;
        Textfield_Search.hidden=YES;
        Button_Search.hidden=NO;
        SeachCondCheck=@"no";
    }
    else
    {
        [Textfield_Search resignFirstResponder];
        [self.navigationController popViewControllerAnimated:YES];
    }
    
}
-(IBAction)ButtonSearch_Action:(id)sender
{
    [Textfield_Search becomeFirstResponder];
    SeachCondCheck=@"yes";
    Lable_TitleChallenges.hidden=YES;
    Textfield_Search.hidden=NO;
    Button_Search.hidden=YES;
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
  return 20;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    static NSString *mycellid2=@"CellCh";
  
    
    
    
   
            
            cell_Challenges = (ChallengesTableViewCell*)[tableView dequeueReusableCellWithIdentifier:mycellid2 forIndexPath:indexPath];
            
    CALayer*  borderBottom_topheder = [CALayer layer];
    borderBottom_topheder.backgroundColor =[UIColor colorWithRed:241/255.0 green:241/255.0 blue:241/255.0 alpha:1.0].CGColor;
    borderBottom_topheder.frame = CGRectMake(0, cell_Challenges.frame.size.height-1, cell_Challenges.frame.size.width,1);
    [cell_Challenges.layer addSublayer:borderBottom_topheder];
    
            return cell_Challenges;
            
    
    
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return 1;
    
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    return 94;
   
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [Textfield_Search resignFirstResponder];
    return YES;
}
@end
