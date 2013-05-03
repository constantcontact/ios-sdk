//
//  ScheduleEmailCampaignViewController.m
//  CTCTEmailCampaign
//
//  Created by Vasile Gales on 4/19/13.
//  Copyright (c) 2013 Vasile Gales. All rights reserved.
//

#import "ScheduleEmailCampaignViewController.h"
#import "CTCTGlobal.h"
#import "LoadingView.h"

@interface ScheduleEmailCampaignViewController ()

@property (nonatomic, strong) Schedule *schedule;
@property (nonatomic, strong) LoadingView *loadingView;

@end

@implementation ScheduleEmailCampaignViewController

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.schedule = [[Schedule alloc] init];
    self.loadingView = [[LoadingView alloc] initWithFrame:self.view.frame];
}

- (void)viewDidUnload
{
    self.schedule = nil;
    self.loadingView = nil;
    
    [super viewDidUnload];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.navigationItem setHidesBackButton:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
    self.schedule = nil;
    self.loadingView = nil;
}

#pragma mark - IB

- (IBAction)onScheduleAction:(id)sender
{
    
    [self showLoading];
    
    __block NSString *msg = @"";
    __block int tag = 0;
    
    dispatch_queue_t callService = dispatch_queue_create("callService", nil);
    dispatch_async(callService, ^{
        
        
        HttpResponse *response = [CampaignScheduleService addScheduleWithAccesToken:[CTCTGlobal shared].token campaignId:self.campaignId andSchedule:self.schedule];
        
        if(response.statusCode != 201)
        {
            msg = ((HttpError*)[response.errors objectAtIndex:0]).message;
        }
        else
        {
            msg = @"Schedule was added";
            tag = 1;
        }
        
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [self hideLoading];
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:msg delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
            alert.tag = tag;
            [alert show];
            
        });
    });
}

- (IBAction) onTimeChanged: (id) sender
{
    self.schedule.scheduledDate = [self dateString:self.datePickerInputView.date];
}

#pragma mark - Utilities

- (NSString*)dateString:(NSDate*)date
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSSZ"];
    return  [dateFormatter stringFromDate:date];
}

#pragma mark - UIAlertView delegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 1)
        [self.navigationController popToRootViewControllerAnimated:YES];
}

#pragma mark - LoadingView

- (void)showLoading
{
    [self.loadingView showLoadingInView:self.view];
}

- (void)hideLoading
{
    [self.loadingView hideLoading];
}

@end
