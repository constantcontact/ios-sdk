//
//  ContactCustomFieldsViewController.h
//  CTCTContact
//
//  Created by Vasile Gales on 4/17/13.
//  Copyright (c) 2013 OSF Global. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ContactCustomFieldsViewController : UIViewController <UIScrollViewDelegate, UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *customField1;
@property (weak, nonatomic) IBOutlet UITextField *customField2;
@property (weak, nonatomic) IBOutlet UITextField *customField3;
@property (weak, nonatomic) IBOutlet UITextField *customField4;
@property (weak, nonatomic) IBOutlet UITextField *customField5;
@property (weak, nonatomic) IBOutlet UITextField *customField6;
@property (weak, nonatomic) IBOutlet UITextField *customField7;
@property (weak, nonatomic) IBOutlet UITextField *customField8;
@property (weak, nonatomic) IBOutlet UITextField *customField9;
@property (weak, nonatomic) IBOutlet UITextField *customField10;
@property (weak, nonatomic) IBOutlet UITextField *customField11;
@property (weak, nonatomic) IBOutlet UITextField *customField12;
@property (weak, nonatomic) IBOutlet UITextField *customField13;
@property (weak, nonatomic) IBOutlet UITextField *customField14;
@property (weak, nonatomic) IBOutlet UITextField *customField15;

@property (nonatomic, strong) NSMutableArray *customFieldsArray;

- (void)clearAll;

@end
