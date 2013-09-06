//
//  CTCTGlobal.h
//  CTCTContact
//
//  Created by Sergiu Grigoriev on 3/28/13.
//  Copyright (c) 2013 OSF Global. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CTCTGlobal : NSObject

+ (CTCTGlobal*)shared;

@property (nonatomic, strong) NSString *token;
@property (nonatomic, strong) NSString *email;

@end
