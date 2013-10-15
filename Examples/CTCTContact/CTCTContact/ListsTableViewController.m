//
//  ListsTableViewController.m
//  CTCTContact
//
//  Created by Sergiu Grigoriev on 3/28/13.
//  Copyright (c) 2013 OSF Global. All rights reserved.
//

#import "ListsTableViewController.h"
#import "ContactsCollection.h"
#import "ListsCollection.h"
#import "LoadingView.h"
#import "CTCTGlobal.h"

@interface ListsTableViewController ()

@property (nonatomic, strong) NSArray *lists;
@property (nonatomic, strong) LoadingView *loadingView;

@end

@implementation ListsTableViewController

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.loadingView = [[LoadingView alloc] initWithFrame:self.view.frame];
    self.lists = nil;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self getListsFromServer];
}

#pragma mark - Server calls

- (void)getListsFromServer
{
    [self showLoading];
    
    dispatch_queue_t callService = dispatch_queue_create("callService", nil);
    dispatch_async(callService, ^{
        
        
        HttpResponse* response = [ListsCollection listsWithAccessToken:[CTCTGlobal shared].token andModificationDate:nil];
        
        if(response.statusCode != 200)
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:((HttpError*)[response.errors objectAtIndex:0]).message delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
            [alert show];
        }
        else
        {
            self.lists = response.data;
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [self.tableView reloadData];
            [self hideLoading];
            
        });
    });
    dispatch_release(callService);
}

#pragma mark - UITableView delegate and DataSource

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    if (cell.accessoryType == UITableViewCellAccessoryNone)
    {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
        
        ContactList *list = [self.lists objectAtIndex:indexPath.row];
        
        [self addList:list];
    }
    else
    {
        cell.accessoryType = UITableViewCellAccessoryNone;

        ContactList *list = [self.lists objectAtIndex:indexPath.row];

        [self removeListWithId:list.listId];
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.lists.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    ContactList *list = [self.lists objectAtIndex:indexPath.row];
    cell.textLabel.text = list.name;
    
    if ([self existsListWithId:list.listId])
    {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    else
    {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    return cell;
}

#pragma mark - Utilities

- (void)removeListWithId:(NSString*)listId
{
    for (int i = 0; i < self.selectedLists.count; i++)
    {
        ContactList *list = [self.selectedLists objectAtIndex:i];
        
        if ([list.listId isEqualToString:listId])
        {
            [self.selectedLists removeObjectAtIndex:i];
            break;
        }
    }
}

- (void)addList:(ContactList*)selectedList
{
    BOOL exists = NO;
    
    for (int i = 0; i < self.selectedLists.count; i++)
    {
        ContactList *list = [self.selectedLists objectAtIndex:i];
        
        if ([list.listId isEqualToString:selectedList.listId])
        {
            exists = YES;
        }
    }
    
    if (!exists)
    {
        [self.selectedLists addObject:selectedList];
    }
}

- (BOOL)existsListWithId:(NSString*)listId
{
    BOOL exists = NO;
    
    for (int i = 0; i < self.selectedLists.count; i++)
    {
        ContactList *list = [self.selectedLists objectAtIndex:i];
        
        if ([list.listId isEqualToString:listId])
        {
            exists = YES;
            break;
        }
    }
    
    return exists;
}

#pragma mark - Loading

- (void)showLoading
{
    [self.loadingView showLoadingInView:self.view];
}

- (void)hideLoading
{
    [self.loadingView hideLoading];
}

@end
