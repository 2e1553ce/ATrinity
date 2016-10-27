//
//  AVUser.h
//  TestAtrinity
//
//  Created by aiuar on 26.10.16.
//  Copyright © 2016 A.V. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AVUser : NSObject

@property (strong, nonatomic) NSString  *apiKey;
@property (strong, nonatomic) NSString  *login;
@property (strong, nonatomic) NSString  *password;
@property (assign, nonatomic) NSString  *objectCode;
@property (strong, nonatomic) NSString  *action;
@property (strong, nonatomic) NSString  *filter;

- (id)init;

@end
