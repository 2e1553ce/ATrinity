//
//  AVServerManager.h
//  TestAtrinity
//
//  Created by aiuar on 26.10.16.
//  Copyright © 2016 A.V. All rights reserved.
//

#import <Foundation/Foundation.h>

@class AVUser;
@class AVApplication;

@interface AVServerManager : NSObject

@property (strong, nonatomic) AVUser *currentUser;

+ (AVServerManager *)sharedManager;

- (void) getApplicationsOnSuccess:(void(^)(NSArray *applications))success
                        onFailure:(void(^)(NSError *error, NSInteger  statusCode))failure;

- (void) getDetailedApplication:(AVApplication *)application
                  onSuccess:(void(^)(AVApplication *application))success
                  onFailure:(void(^)(NSError *error, NSInteger statusCode))failure;

@end
