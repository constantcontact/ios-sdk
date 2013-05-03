//
//  ContactCustomFieldsViewController.m
//  CTCTContact
//
//  Created by Vasile Gales on 4/17/13.
//  Copyright (c) 2013 OSF Global. All rights reserved.
//

#import "ContactCustomFieldsViewController.h"
#import "CustomField.h"

@interface ContactCustomFieldsViewController ()

@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;

@end

@implementation ContactCustomFieldsViewController

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.scrollView.delegate = self;
    self.scrollView.contentSize = CGSizeMake(self.scrollView.contentSize.width, 580);
    self.scrollView.scrollEnabled = YES;
    
    self.scrollView.userInteractionEnabled = YES;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidAppear) name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillDisappear) name:UIKeyboardWillHideNotification object:nil];
    
    self.scrollView.contentSize = CGSizeMake(320, 580);
    [self populateCustomFields];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    [super viewWillDisappear:animated];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload
{
    [self setScrollView:nil];
    [self setCustomField1:nil];
    [self setCustomField2:nil];
    [self setCustomField3:nil];
    [self setCustomField4:nil];
    [self setCustomField5:nil];
    [self setCustomField6:nil];
    [self setCustomField7:nil];
    [self setCustomField8:nil];
    [self setCustomField9:nil];
    [self setCustomField10:nil];
    [self setCustomField11:nil];
    [self setCustomField12:nil];
    [self setCustomField13:nil];
    [self setCustomField14:nil];
    [self setCustomField15:nil];
    
    [super viewDidUnload];
}

#pragma mark - UITextField delegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    CGPoint pt;
    CGRect rc = [textField bounds];
    rc = [textField convertRect:rc toView:self.scrollView];
    pt = rc.origin;
    pt.x = 0;
    pt.y -= 60;
    [self.scrollView setContentOffset:pt animated:YES];

    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    BOOL customFieldExist = NO;
    
    for (int i = 0; i < self.customFieldsArray.count; i++)
    {
        CustomField *customField = [self.customFieldsArray objectAtIndex:i];
        
        if ([customField.name isEqualToString:[NSString stringWithFormat:@"CustomField%d", textField.tag]])
        {
            customField.value = textField.text;
            customFieldExist = YES;
            
            break;
        }
    }

    if (!customFieldExist)
    {
        CustomField *customField = [[CustomField alloc] init];
        customField.name = [NSString stringWithFormat:@"CustomField%d", textField.tag];
        customField.value = textField.text;
        
        [self.customFieldsArray addObject:customField];
    }
}

#pragma mark - Keyboard notifications

- (void)keyboardDidAppear
{
    CGRect scrollRect = self.view.frame;
    scrollRect.size.height -= 216;
    self.scrollView.frame = scrollRect;
}

- (void)keyboardWillDisappear
{
    self.scrollView.frame = self.view.frame;
}

#pragma mark - Utilities

- (void)populateCustomFields
{
    for (int i = 0; i < self.customFieldsArray.count; i++)
    {
        CustomField *customField = [self.customFieldsArray objectAtIndex:i];
        
        if ([customField.name.uppercaseString isEqualToString:@"CUSTOMFIELD1"])
            self.customField1.text = customField.value;
        else if ([customField.name.uppercaseString isEqualToString:@"CUSTOMFIELD2"])
            self.customField2.text = customField.value;
        else if ([customField.name.uppercaseString isEqualToString:@"CUSTOMFIELD3"])
            self.customField3.text = customField.value;
        else if ([customField.name.uppercaseString isEqualToString:@"CUSTOMFIELD4"])
            self.customField4.text = customField.value;
        else if ([customField.name.uppercaseString isEqualToString:@"CUSTOMFIELD5"])
            self.customField5.text = customField.value;
        else if ([customField.name.uppercaseString isEqualToString:@"CUSTOMFIELD6"])
            self.customField6.text = customField.value;
        else if ([customField.name.uppercaseString isEqualToString:@"CUSTOMFIELD7"])
            self.customField7.text = customField.value;
        else if ([customField.name.uppercaseString isEqualToString:@"CUSTOMFIELD8"])
            self.customField8.text = customField.value;
        else if ([customField.name.uppercaseString isEqualToString:@"CUSTOMFIELD9"])
            self.customField9.text = customField.value;
        else if ([customField.name.uppercaseString isEqualToString:@"CUSTOMFIELD10"])
            self.customField10.text = customField.value;
        else if ([customField.name.uppercaseString isEqualToString:@"CUSTOMFIELD11"])
            self.customField11.text = customField.value;
        else if ([customField.name.uppercaseString isEqualToString:@"CUSTOMFIELD12"])
            self.customField12.text = customField.value;
        else if ([customField.name.uppercaseString isEqualToString:@"CUSTOMFIELD13"])
            self.customField13.text = customField.value;
        else if ([customField.name.uppercaseString isEqualToString:@"CUSTOMFIELD14"])
            self.customField14.text = customField.value;
        else if ([customField.name.uppercaseString isEqualToString:@"CUSTOMFIELD15"])
            self.customField15.text = customField.value;
    }
}

- (void)clearAll
{
    self.customField1.text = @"";
    self.customField2.text = @"";
    self.customField3.text = @"";
    self.customField4.text = @"";
    self.customField5.text = @"";
    self.customField6.text = @"";
    self.customField7.text = @"";
    self.customField8.text = @"";
    self.customField9.text = @"";
    self.customField10.text = @"";
    self.customField11.text = @"";
    self.customField12.text = @"";
    self.customField13.text = @"";
    self.customField14.text = @"";
    self.customField15.text = @"";
}

@end
