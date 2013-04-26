//
//  CTCTLoginViewController.h
//  CTCTContact
//
//  Created by Sergiu Grigoriev on 3/28/13.
//  Copyright (c) 2013 OSF Global. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CTCTLoginViewController;

@protocol CTCTLoginDelegate <NSObject>
@required
- (void)loginViewController:(CTCTLoginViewController*)loginViewController didLoginWithAccessToken:(NSString*)accessToken;
- (void)loginViewControllerDidCancelAuthentication:(CTCTLoginViewController*)loginViewController;
- (void)loginViewControllerDidDeniedAccess:(CTCTLoginViewController*)loginViewController;
@end

@interface CTCTLoginViewController : UIViewController

/**
 * delegate that will respond to callbacks
 *
 * @var id
 */
@property (strong) id delegate;

/**
 * Realoads webview with authentication page
 *
 */
- (void)reloadLogin;

@end
