//
//  MainViewController.h
//  CTCTEmailCampaign
//
//  Created by Vasile Gales on 4/18/13.
//  Copyright (c) 2013 Vasile Gales. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EmailCampaign.h"
#import "ListsTableViewController.h"

@interface MainViewController : UIViewController<UITextFieldDelegate, UINavigationControllerDelegate, UIAlertViewDelegate>

@property (nonatomic, strong) EmailCampaign *emailCampaign;
@property (nonatomic, strong) ListsTableViewController *listsVC;

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *fromNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *fromEmailAddressTextField;
@property (weak, nonatomic) IBOutlet UITextField *replyToEmailAddressTextField;
@property (weak, nonatomic) IBOutlet UITextField *emailContentTextField;
@property (weak, nonatomic) IBOutlet UITextField *textContentTextField;
@property (weak, nonatomic) IBOutlet UITextField *subjectTextField;
@property (weak, nonatomic) IBOutlet UITextField *listTextField;
@property (weak, nonatomic) IBOutlet UITextField *organizationNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *address1TextField;
@property (weak, nonatomic) IBOutlet UITextField *address2TextField;
@property (weak, nonatomic) IBOutlet UITextField *address3TextField;
@property (weak, nonatomic) IBOutlet UITextField *stateTextField;
@property (weak, nonatomic) IBOutlet UITextField *postalCodeTextField;
@property (weak, nonatomic) IBOutlet UITextField *countryTextField;
@property (weak, nonatomic) IBOutlet UITextField *cityTextField;


@end
