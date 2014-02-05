//
//  CTCTLoginViewController.m
//  CTCTContact
//
//  Created by Sergiu Grigoriev on 3/28/13.
//  Copyright (c) 2013 OSF Global. All rights reserved.
//

#import "CTCTLoginViewController.h"
#import "Config.h"

@interface CTCTLoginViewController () <UIWebViewDelegate>

@property (nonatomic, strong) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UINavigationBar *navBar;

- (IBAction)refresh:(id)sender;
- (IBAction)cancel:(id)sender;

@end

@implementation CTCTLoginViewController

@synthesize delegate;

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[self URLForLogin]]]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


- (void)viewDidUnload
{
    [super viewDidUnload];
    
    self.webView = nil;
}

#pragma mark - Public

- (void)reloadLogin
{
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[self URLForLogin]]]];
}

#pragma mark - UIWebView delegate

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSString *URLString = request.URL.absoluteString;
    
    NSRange range = [URLString rangeOfString:@"#access_token="];
    
    if (range.location != NSNotFound)
    {
        NSString *accessToken= [URLString substringFromIndex:range.location + 14];
        accessToken = [accessToken substringToIndex:36];
        
        [self sendResponseToDelegateWithAccestToken:accessToken];
        
    }
    else if ([URLString rangeOfString:@"#error=access_denied"].location != NSNotFound)
    {
        if ([self.delegate respondsToSelector:@selector(loginViewControllerDidDeniedAccess:)])
            [self.delegate loginViewControllerDidDeniedAccess:self];
    }

    return YES;
}

#pragma mark - IB

- (IBAction)refresh:(id)sender
{
    [self reloadLogin];
}

- (IBAction)cancel:(id)sender
{
    if ([self.delegate respondsToSelector:@selector(loginViewControllerDidCancelAuthentication:)])
        [self.delegate loginViewControllerDidCancelAuthentication:self];
}

- (CGFloat)topOfViewOffset
{
    CGFloat top = 0;
    if ([self respondsToSelector:@selector(topLayoutGuide)])
    {
        top = self.topLayoutGuide.length;
    }
    return top;
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    self.navBar.frame = CGRectMake(0, [self topOfViewOffset], self.navBar.frame.size.width, self.navBar.frame.size.height);
}

#pragma mark - Utilities

- (NSString*)URLForLogin
{
    NSString * baseURL = [Config valueForType:@"auth" key:@"base_url"];
    NSString * encoding = [NSString stringWithFormat:@"%@?response_type=token&client_id=%@&redirect_uri=%@", [Config valueForType:@"auth" key:@"authorization_endpoint"], [Config valueForType:@"config" key:@"api_key"], [Config valueForType:@"config" key:@"redirect_uri"]];
    
    NSString* url = [NSString stringWithFormat:@"%@%@", baseURL, encoding];
    
    return url;
}

- (void)sendResponseToDelegateWithAccestToken:(NSString*)accessToken
{        
    if ([self.delegate respondsToSelector:@selector(loginViewController:didLoginWithAccessToken:)])
        [self.delegate loginViewController:self didLoginWithAccessToken:accessToken];
}

@end
