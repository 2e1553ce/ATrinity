//
//  AVApplication.h
//  TestAtrinity
//
//  Created by aiuar on 26.10.16.
//  Copyright © 2016 A.V. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AVApplication : NSObject

@property (strong, nonatomic) NSString      *requestID;
@property (strong, nonatomic) NSString      *requestNumber;
@property (strong, nonatomic) NSString      *name;
@property (strong, nonatomic) NSString      *createdAt;
@property (assign, nonatomic) NSInteger     priority;
@property (assign, nonatomic) NSInteger     status;
@property (strong, nonatomic) NSString      *statusDisplayName;
@property (assign, nonatomic) NSInteger     objectCode;

@property (strong, nonatomic) NSString      *detailedStatusText;
@property (strong, nonatomic) NSString      *detailedFullName;
@property (strong, nonatomic) NSString      *detailedDescription;
@property (strong, nonatomic) NSString      *detailedSolutionDescription;
@property (strong, nonatomic) NSString      *detailedCreatedAt;
@property (strong, nonatomic) NSString      *detailedSLARecoveryTime;
@property (strong, nonatomic) NSString      *detailedActualRecoveryTime;

- (id)initWithServerResponse:(NSDictionary *)responseObject;

- (void)addDetailedInfoWithRequest:(NSDictionary *)requestInfo
                       andUserInfo:(NSDictionary *)userInfo;

@end
