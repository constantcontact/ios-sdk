//
//  ScheduleEmailCampaignViewController.h
//  CTCTEmailCampaign
//
//  Created by Vasile Gales on 4/19/13.
//  Copyright (c) 2013 Vasile Gales. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CampaignScheduleService.h"

@interface ScheduleEmailCampaignViewController : UIViewController <UIAlertViewDelegate>

@property (nonatomic, strong) IBOutlet UIDatePicker* datePickerInputView;
@property (nonatomic, strong) NSString *campaignId;

@end
