//
//  ProfileNotificationViewController.m
//  care2Dare
//
//  Created by Spiel's Macmini on 3/8/17.
//  Copyright © 2017 Spiel's Macmini. All rights reserved.
//

#import "ProfileNotificationViewController.h"

@interface ProfileNotificationViewController ()
{
    UIView *sectionView;
    NSString * SeachCondCheck,*CheckedTabbedButtons;
    CALayer*  borderBottom_challenges,*borderBottom_Contribution,*borderBottom_Vedios;
}
@end

@implementation ProfileNotificationViewController

@synthesize cell_PublicNoti,cell_PrivateNoti,cell_VedioNoti,cell_PlegeOutNoti,cell_PlegeIncoNoti,Lable_Titlenotif,Button_Back,Button_Search,Textfield_Search,Tableview_Notif,view_Topheader,Button_Videos,Button_Challenges,Button_Contribution;
- (void)viewDidLoad {
    [super viewDidLoad];
    Textfield_Search.hidden=YES;
    
    SeachCondCheck=@"no";
    CheckedTabbedButtons=@"Challenges";
    Textfield_Search.delegate=self;
    CALayer*  borderBottom_topheder = [CALayer layer];
    borderBottom_topheder.backgroundColor =[UIColor colorWithRed:186/255.0 green:188/255.0 blue:190/255.0 alpha:1.0].CGColor;
    borderBottom_topheder.frame = CGRectMake(0, view_Topheader.frame.size.height-1, view_Topheader.frame.size.width,1);
    [view_Topheader.layer addSublayer:borderBottom_topheder];
    
   
    
    
    
      borderBottom_challenges= [CALayer layer];
    borderBottom_challenges.backgroundColor =[UIColor colorWithRed:20/255.0 green:245/255.0 blue:115/255.0 alpha:1.0].CGColor;
    borderBottom_challenges.frame = CGRectMake(0, Button_Challenges.frame.size.height-2.5, Button_Challenges.frame.size.width,2.5);
    [Button_Challenges.layer addSublayer:borderBottom_challenges];
    
      borderBottom_Contribution = [CALayer layer];
    borderBottom_Contribution.backgroundColor =[UIColor colorWithRed:241/255.0 green:241/255.0 blue:241/255.0 alpha:1.0].CGColor;
    borderBottom_Contribution.frame = CGRectMake(0, Button_Contribution.frame.size.height-1, Button_Contribution.frame.size.width,1);
    [Button_Contribution.layer addSublayer:borderBottom_Contribution];
    
      borderBottom_Vedios = [CALayer layer];
    borderBottom_Vedios.backgroundColor =[UIColor colorWithRed:241/255.0 green:241/255.0 blue:241/255.0 alpha:1.0].CGColor;
    borderBottom_Vedios.frame = CGRectMake(0, Button_Videos.frame.size.height-1, Button_Videos.frame.size.width,1);
    [Button_Videos.layer addSublayer:borderBottom_Vedios];
    
     [Button_Challenges setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
     [Button_Contribution setTitleColor:[UIColor colorWithRed:65/255.0 green:65/255.0 blue:65/255.0 alpha:1] forState:UIControlStateNormal];
     [Button_Videos setTitleColor:[UIColor colorWithRed:65/255.0 green:65/255.0 blue:65/255.0 alpha:1] forState:UIControlStateNormal];    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

-(IBAction)ButtonBack_Action:(id)sender
{
    if ([SeachCondCheck isEqualToString:@"yes"])
    {
        [Textfield_Search resignFirstResponder];
        Lable_Titlenotif.hidden=NO;
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
    Lable_Titlenotif.hidden=YES;
    Textfield_Search.hidden=NO;
    Button_Search.hidden=YES;
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([CheckedTabbedButtons isEqualToString:@"Challenges"])
    {
        if(section==0)
        {
            
            
            return 2;
            
        }
        if(section==1)
        {
            
            
            return 20;
        
        }
  
    }
    if ([CheckedTabbedButtons isEqualToString:@"Contribution"])
    {
        if(section==0)
        {
            
            
            return 5;
            
        }
        if(section==1)
        {
            
            
            return 15;
            
        }
        
    }
    if ([CheckedTabbedButtons isEqualToString:@"Vedio"])
    {
        
    return 4;
        
    }
    
    
    return 0;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    static NSString *mycellid2=@"CellPublic";
    static NSString *cellId2=@"CellPrivate";
    
    static NSString *mycellid33=@"CellPI";
    static NSString *mycellid44=@"CellPO";
    
    static NSString *mycellid55=@"CellV";

    
    if ([CheckedTabbedButtons isEqualToString:@"Challenges"])
    {
        
    
    switch (indexPath.section)
    {
            
        case 0:
        {
            
            cell_PublicNoti = (PublicChallengesTableViewCell*)[tableView dequeueReusableCellWithIdentifier:mycellid2 forIndexPath:indexPath];
            
           
            return cell_PublicNoti;
            
            
        }
            break;
        case 1:
            
        {
            
            cell_PrivateNoti =(PrivateChallengesTableViewCell*)[tableView dequeueReusableCellWithIdentifier:cellId2 forIndexPath:indexPath];
            
            
            
            
            
            return cell_PrivateNoti;
            
            
            
            
            
        }
            
            break;
    }
    }

if([CheckedTabbedButtons isEqualToString:@"Contribution"])
{
    switch (indexPath.section)
    {
            
        case 0:
        {
            
            cell_PlegeIncoNoti = [[[NSBundle mainBundle]loadNibNamed:@"PlegeIncomingTableViewCell" owner:self options:nil] objectAtIndex:0];

            
            if (cell_PlegeIncoNoti == nil)
            {
                
                cell_PlegeIncoNoti = [[PlegeIncomingTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:mycellid33];
                
                
            }
            return cell_PlegeIncoNoti;
            
            
        }
            break;
        case 1:
            
        {
            
            cell_PlegeOutNoti = [[[NSBundle mainBundle]loadNibNamed:@"PledgeOutoingTableViewCell" owner:self options:nil] objectAtIndex:0];
            
            if (cell_PlegeOutNoti == nil)
            {
                
                cell_PlegeOutNoti = [[PledgeOutoingTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:mycellid44];
                
                
            }

            
            return cell_PlegeOutNoti;

            
            
        }
            
            break;
    }
    }

if ([CheckedTabbedButtons isEqualToString:@"Vedio"])
{
    cell_VedioNoti = [[[NSBundle mainBundle]loadNibNamed:@"VedioNotiTableViewCell" owner:self options:nil] objectAtIndex:0];
    
    if (cell_VedioNoti == nil)
    {
        
        cell_VedioNoti = [[VedioNotiTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:mycellid55];
        
        
    }

    
      return cell_VedioNoti;
    
    
}
    return nil;

}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if ([CheckedTabbedButtons isEqualToString:@"Challenges"] ||[CheckedTabbedButtons isEqualToString:@"Contribution"])
    {
      return 2;
    }
    
    if ([CheckedTabbedButtons isEqualToString:@"Vedio"])
    {
        
        return 1;
        
    }
    return 0;
    
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
   
    if ([CheckedTabbedButtons isEqualToString:@"Vedio"])
    {
        
        sectionView=[[UIView alloc]initWithFrame:CGRectMake(0, 0,self.view.frame.size.width,44)];
        [sectionView setBackgroundColor:[UIColor whiteColor]];
        UILabel * Label1=[[UILabel alloc]initWithFrame:CGRectMake(20, 5, self.view.frame.size.width-40, sectionView.frame.size.height-5)];
        Label1.backgroundColor=[UIColor whiteColor];
        Label1.textColor=[UIColor lightGrayColor];
        Label1.font=[UIFont fontWithName:@"SanFranciscoDisplay-Medium" size:15.0f];
        Label1.text=@"New Vedios";
        [sectionView addSubview:Label1];
        
        CALayer*  borderBottom_topheder = [CALayer layer];
        borderBottom_topheder.backgroundColor =[UIColor colorWithRed:241/255.0 green:241/255.0 blue:241/255.0 alpha:1.0].CGColor;
        borderBottom_topheder.frame = CGRectMake(0, sectionView.frame.size.height-1, sectionView.frame.size.width,1);
        [sectionView.layer addSublayer:borderBottom_topheder];
        
        sectionView.tag=section;
        
    }
    if ([CheckedTabbedButtons isEqualToString:@"Challenges"] || [CheckedTabbedButtons isEqualToString:@"Contribution"])
    {
        
    if (section==0)
    {
        sectionView=[[UIView alloc]initWithFrame:CGRectMake(0, 0,self.view.frame.size.width,44)];
        [sectionView setBackgroundColor:[UIColor whiteColor]];
        UILabel * Label1=[[UILabel alloc]initWithFrame:CGRectMake(20, 5, self.view.frame.size.width-40, sectionView.frame.size.height-5)];
        Label1.backgroundColor=[UIColor whiteColor];
        Label1.textColor=[UIColor lightGrayColor];
        Label1.font=[UIFont fontWithName:@"SanFranciscoDisplay-Medium" size:15.0f];
        if ([CheckedTabbedButtons isEqualToString:@"Challenges"])
        {
         Label1.text=@"Public Challenges";
        }
        if ([CheckedTabbedButtons isEqualToString:@"Contribution"])
        {
           Label1.text=@"Pledge(Incoming)";
        }
        
        [sectionView addSubview:Label1];
        
        CALayer*  borderBottom_topheder = [CALayer layer];
        borderBottom_topheder.backgroundColor =[UIColor colorWithRed:241/255.0 green:241/255.0 blue:241/255.0 alpha:1.0].CGColor;
        borderBottom_topheder.frame = CGRectMake(0, sectionView.frame.size.height-1, sectionView.frame.size.width,1);
        [sectionView.layer addSublayer:borderBottom_topheder];
        
        sectionView.tag=section;
        
    }
    if (section==1)
    {
        
        sectionView=[[UIView alloc]initWithFrame:CGRectMake(0, 0,self.view.frame.size.width,44)];
        [sectionView setBackgroundColor:[UIColor whiteColor]];
        
        UILabel * Label1=[[UILabel alloc]initWithFrame:CGRectMake(20,5, self.view.frame.size.width-40, sectionView.frame.size.height-5)];
        Label1.backgroundColor=[UIColor whiteColor];
        Label1.textColor=[UIColor lightGrayColor];
        Label1.font=[UIFont fontWithName:@"SanFranciscoDisplay-Medium" size:15.0f];
        if ([CheckedTabbedButtons isEqualToString:@"Challenges"])
        {
             Label1.text=@"Private Challenges";
        }
        if ([CheckedTabbedButtons isEqualToString:@"Contribution"])
        {
            Label1.text=@"Pledge(Outgoing)";
        }
       
        [sectionView addSubview:Label1];
        
        CALayer*  borderBottom_topheder = [CALayer layer];
        borderBottom_topheder.backgroundColor =[UIColor colorWithRed:241/255.0 green:241/255.0 blue:241/255.0 alpha:1.0].CGColor;
        borderBottom_topheder.frame = CGRectMake(0, sectionView.frame.size.height-1, sectionView.frame.size.width,1);
        [sectionView.layer addSublayer:borderBottom_topheder];
        
        sectionView.tag=section;
        
    }
    }
    return  sectionView;
    
    
    
}





- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 44;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if ([CheckedTabbedButtons isEqualToString:@"Challenges"])
    {
      return 80;
    }
    if([CheckedTabbedButtons isEqualToString:@"Contribution"])
    {
        return 80;
    }
    
    if ([CheckedTabbedButtons isEqualToString:@"Vedio"])
    {

    return 80;
    }
    
    return 0;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if ([CheckedTabbedButtons isEqualToString:@"Challenges"])
    {
        
    }
    if([CheckedTabbedButtons isEqualToString:@"Contribution"])
    {
 
    }
    
    if ([CheckedTabbedButtons isEqualToString:@"Vedio"])
    {
        
        
    }
    
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [Textfield_Search resignFirstResponder];
    return YES;
}
-(IBAction)ButtonChallenges_Action:(id)sender
{
    
    CheckedTabbedButtons=@"Challenges";
   
    
    [Button_Challenges setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [Button_Contribution setTitleColor:[UIColor colorWithRed:65/255.0 green:65/255.0 blue:65/255.0 alpha:1] forState:UIControlStateNormal];
    [Button_Videos setTitleColor:[UIColor colorWithRed:65/255.0 green:65/255.0 blue:65/255.0 alpha:1] forState:UIControlStateNormal];
    
   // borderBottom_challenges= [CALayer layer];
    borderBottom_challenges.backgroundColor =[UIColor colorWithRed:20/255.0 green:245/255.0 blue:115/255.0 alpha:1.0].CGColor;
    borderBottom_challenges.frame = CGRectMake(0, Button_Challenges.frame.size.height-2.5, Button_Challenges.frame.size.width,2.5);
    [Button_Challenges.layer addSublayer:borderBottom_challenges];
    
    //borderBottom_Contribution = [CALayer layer];
    borderBottom_Contribution.backgroundColor =[UIColor colorWithRed:241/255.0 green:241/255.0 blue:241/255.0 alpha:1.0].CGColor;
    borderBottom_Contribution.frame = CGRectMake(0, Button_Contribution.frame.size.height-1, Button_Contribution.frame.size.width,1);
    [Button_Contribution.layer addSublayer:borderBottom_Contribution];
    
   // borderBottom_Vedios = [CALayer layer];
    borderBottom_Vedios.backgroundColor =[UIColor colorWithRed:241/255.0 green:241/255.0 blue:241/255.0 alpha:1.0].CGColor;
    borderBottom_Vedios.frame = CGRectMake(0, Button_Videos.frame.size.height-1, Button_Videos.frame.size.width,1);
    [Button_Videos.layer addSublayer:borderBottom_Vedios];
    [Tableview_Notif reloadData];
}
-(IBAction)ButtonContribution_Action:(id)sender
{
    
    CheckedTabbedButtons=@"Contribution";
    
 
    [Button_Contribution setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [Button_Challenges setTitleColor:[UIColor colorWithRed:65/255.0 green:65/255.0 blue:65/255.0 alpha:1] forState:UIControlStateNormal];
    [Button_Videos setTitleColor:[UIColor colorWithRed:65/255.0 green:65/255.0 blue:65/255.0 alpha:1] forState:UIControlStateNormal];
    
    
   // borderBottom_challenges= [CALayer layer];
    borderBottom_challenges.backgroundColor =[UIColor colorWithRed:241/255.0 green:241/255.0 blue:241/255.0 alpha:1.0].CGColor;
    borderBottom_challenges.frame = CGRectMake(0, Button_Challenges.frame.size.height-1, Button_Challenges.frame.size.width,1);
    [Button_Challenges.layer addSublayer:borderBottom_challenges];
    
   // borderBottom_Contribution = [CALayer layer];
    borderBottom_Contribution.backgroundColor =[UIColor colorWithRed:20/255.0 green:245/255.0 blue:115/255.0 alpha:1.0].CGColor;
    borderBottom_Contribution.frame = CGRectMake(0, Button_Contribution.frame.size.height-2.5, Button_Contribution.frame.size.width,2.5);
    [Button_Contribution.layer addSublayer:borderBottom_Contribution];
    
  //  borderBottom_Vedios = [CALayer layer];
    borderBottom_Vedios.backgroundColor =[UIColor colorWithRed:241/255.0 green:241/255.0 blue:241/255.0 alpha:1.0].CGColor;
    borderBottom_Vedios.frame = CGRectMake(0, Button_Videos.frame.size.height-1, Button_Videos.frame.size.width,1);
    [Button_Videos.layer addSublayer:borderBottom_Vedios];
      [Tableview_Notif reloadData];
}
-(IBAction)ButtonVedio_Action:(id)sender
{
  CheckedTabbedButtons=@"Vedio";
    
    [Button_Videos setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [Button_Contribution setTitleColor:[UIColor colorWithRed:65/255.0 green:65/255.0 blue:65/255.0 alpha:1] forState:UIControlStateNormal];
    [Button_Challenges setTitleColor:[UIColor colorWithRed:65/255.0 green:65/255.0 blue:65/255.0 alpha:1] forState:UIControlStateNormal];
    
    //borderBottom_challenges= [CALayer layer];
    borderBottom_challenges.backgroundColor =[UIColor colorWithRed:241/255.0 green:241/255.0 blue:241/255.0 alpha:1.0].CGColor;
    borderBottom_challenges.frame = CGRectMake(0, Button_Challenges.frame.size.height-1, Button_Challenges.frame.size.width,1);
    [Button_Challenges.layer addSublayer:borderBottom_challenges];
    
  //  borderBottom_Contribution = [CALayer layer];
    borderBottom_Contribution.backgroundColor =[UIColor colorWithRed:241/255.0 green:241/255.0 blue:241/255.0 alpha:1.0].CGColor;
    borderBottom_Contribution.frame = CGRectMake(0, Button_Contribution.frame.size.height-1, Button_Contribution.frame.size.width,1);
    [Button_Contribution.layer addSublayer:borderBottom_Contribution];
    
   // borderBottom_Vedios = [CALayer layer];
    borderBottom_Vedios.backgroundColor =[UIColor colorWithRed:20/255.0 green:245/255.0 blue:115/255.0 alpha:1.0].CGColor;
    borderBottom_Vedios.frame = CGRectMake(0, Button_Videos.frame.size.height-2.5, Button_Videos.frame.size.width,2.5);
    [Button_Videos.layer addSublayer:borderBottom_Vedios];
      [Tableview_Notif reloadData];
    
}
@end
