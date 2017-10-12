//
//  TutorialViewController.m
//  care2Dare
//
//  Created by MacMini2 on 12/10/17.
//  Copyright © 2017 Spiel's Macmini. All rights reserved.
//

#import "TutorialViewController.h"
#import "IntroViewOne.h"
#import "IntroViewTwo.h"
#import "IntroViewThree.h"
#import "IntroViewFour.h"
#import "HelpScreenViewController.h"
@interface TutorialViewController ()
{
    int indexOfPage;
    UIScrollView *scrollView;
}
@end

@implementation TutorialViewController

@synthesize PageControl,Button_Skip,Button_next1,Button_next2;
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    scrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    [self.view addSubview:scrollView];
    scrollView.delegate=self;
    scrollView.bounces=NO;
    [scrollView setShowsHorizontalScrollIndicator:NO];
    [scrollView setShowsVerticalScrollIndicator:NO];
    [self.view bringSubviewToFront:PageControl];
    [self.view bringSubviewToFront:Button_next2];
    [self.view bringSubviewToFront:Button_next1];
    scrollView.pagingEnabled=YES;
    //    [self.view bringSubviewToFront:Button_Skip];
    
    PageControl.currentPage=0;
   
    indexOfPage=0;
    IntroViewOne *view1 = [[[NSBundle mainBundle] loadNibNamed:@"IntroViewOne" owner:self options:nil] objectAtIndex:0];
    IntroViewTwo *view2 = [[[NSBundle mainBundle] loadNibNamed:@"IntroViewTwo" owner:self options:nil]objectAtIndex:0];;
    IntroViewThree *view3 = [[[NSBundle mainBundle] loadNibNamed:@"IntroViewThree" owner:self options:nil]objectAtIndex:0];
    IntroViewFour *view4 = [[[NSBundle mainBundle] loadNibNamed:@"IntroViewFour" owner:self options:nil]objectAtIndex:0];
    
    [view1 setFrame:CGRectMake(0, 0, self.view.frame.size.width, scrollView.frame.size.height)];
    [view2 setFrame:CGRectMake(0, 0, self.view.frame.size.width, scrollView.frame.size.height)];
    [view3 setFrame:CGRectMake(0, 0, self.view.frame.size.width, scrollView.frame.size.height)];
    [view4 setFrame:CGRectMake(0, 0, self.view.frame.size.width, scrollView.frame.size.height)];
    
    view4.Button_getstared.layer.cornerRadius=view4.Button_getstared.frame.size.height/2;
    [view4.Button_getstared addTarget:self action:@selector(Button_getstared_Action:) forControlEvents:UIControlEventTouchUpInside];
    CGRect frame;
    frame = view1.frame;
    frame.origin.x = 0;
    view1.frame = frame;
    
    frame = view2.frame;
    frame.origin.x = view1.frame.size.width + view1.frame.origin.x ;
    view2.frame = frame;
    
    frame = view3.frame;
    frame.origin.x = view2.frame.size.width + view2.frame.origin.x;
    view3.frame = frame;
    
    frame = view4.frame;
    frame.origin.x = view3.frame.size.width + view3.frame.origin.x;
    view4.frame = frame;
    
    [scrollView addSubview:view1];
    [scrollView addSubview:view2];
    [scrollView addSubview:view3];
    [scrollView addSubview:view4];
    // [self.view bringSubviewToFront:PageControl];
    scrollView.contentSize = CGSizeMake(scrollView.frame.size.width*4, scrollView.frame.size.height);
    //    UIImageView *verticalIndicator = ((UIImageView *)[scrollView.subviews objectAtIndex:0]);
    //    //set color to vertical indicator
    //    [verticalIndicator setHidden:YES];
    [scrollView setShowsHorizontalScrollIndicator:NO];
    [scrollView setShowsVerticalScrollIndicator:NO];
}
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView1
{
    
    //    UIImageView *verticalIndicator = ((UIImageView *)[scrollView.subviews objectAtIndex:(scrollView.subviews.count-1)]);
    //    //set color to vertical indicator
    //    [verticalIndicator setHidden:YES];
    
    indexOfPage = scrollView1.contentOffset.x / scrollView1.frame.size.width;
    NSLog(@"Page index==%d",indexOfPage);
    PageControl.currentPage=indexOfPage;
    if (indexOfPage==3)
    {
        
        
        Button_next1.hidden=YES;
        Button_next2.hidden=YES;
    }
    else
    {
        
        Button_next1.hidden=NO;
        Button_next2.hidden=NO;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


- (IBAction)Button_Skip_Action:(id)sender
{
    
}
- (IBAction)Button_getstared_Action:(id)sender
{
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    HelpScreenViewController * set=[mainStoryboard instantiateViewControllerWithIdentifier:@"HelpScreenViewController"];
    set.Str_CloseView=@"yes";
    [self.navigationController pushViewController:set animated:NO];
    
}
- (IBAction)Button_Next_Action:(id)sender
{
    
    
    
    
    CGRect frame = scrollView.frame;
    frame.origin.x = frame.size.width * (indexOfPage+1);
    
    frame.origin.y = 0;
    [scrollView scrollRectToVisible:frame animated:YES];
    PageControl.currentPage=indexOfPage+1;
    if (indexOfPage==2)
    {
        
        indexOfPage=0;
        Button_next1.hidden=YES;
        Button_next2.hidden=YES;
    }
    else
    {
        
        Button_next1.hidden=NO;
        Button_next2.hidden=NO;
        indexOfPage=indexOfPage+1;
    }
    
    
}

@end
