//
//  AVApplication.m
//  TestAtrinity
//
//  Created by aiuar on 26.10.16.
//  Copyright © 2016 A.V. All rights reserved.
//

#import "AVApplication.h"

@implementation AVApplication

- (id)initWithServerResponse:(NSDictionary *)responseObject
{
    self = [super init];
    
    if(self){
        
        if([responseObject objectForKey:@"RequestID"]){
            self.requestID = [responseObject objectForKey:@"RequestID"];
        }
        if([responseObject objectForKey:@"RequestNumber"]){
            self.requestNumber = [responseObject objectForKey:@"RequestNumber"];
        }
        if([responseObject objectForKey:@"Name"]){
            self.name = [responseObject objectForKey:@"Name"];
        }
        if([responseObject objectForKey:@"CreatedAt"]){
            
            self.createdAt = [responseObject objectForKey:@"CreatedAt"];
        }
        if([responseObject objectForKey:@"Priority"]){
            self.priority = [[responseObject objectForKey:@"Priority"] integerValue];
        }
        if([responseObject objectForKey:@"Status"]){
            self.status = [[responseObject objectForKey:@"Status"] integerValue];
        }
        if([responseObject objectForKey:@"StatusDisplayName"]){
            self.statusDisplayName = [responseObject objectForKey:@"StatusDisplayName"];
        }
        if([responseObject objectForKey:@"ObjectCode"]){
            self.objectCode = [[responseObject objectForKey:@"ObjectCode"] integerValue];
        }
    }
    
    return self;
}

- (void)addDetailedInfoWithRequest:(NSDictionary *)requestInfo
                       andUserInfo:(NSDictionary *)userInfo{
    
    if([requestInfo objectForKey:@"StatusText"]){
        self.detailedStatusText = [requestInfo objectForKey:@"StatusText"];
    }
    if([requestInfo objectForKey:@"Description"]){
        self.detailedDescription = [requestInfo objectForKey:@"Description"];
    }
    if([requestInfo objectForKey:@"SolutionDescription"]){
        self.detailedSolutionDescription = [requestInfo objectForKey:@"SolutionDescription"];
    }
    if([requestInfo objectForKey:@"CreatedAt"]){
        self.detailedCreatedAt = [requestInfo objectForKey:@"CreatedAt"];
    }
    if([requestInfo objectForKey:@"SLAReceoveryTime"]){
        self.detailedSLARecoveryTime = [requestInfo objectForKey:@"SLAReceoveryTime"];
    }
    if([requestInfo objectForKey:@"ActualRecoveryTime"]){
        self.detailedActualRecoveryTime = [requestInfo objectForKey:@"ActualRecoveryTime"];
    }
    if([userInfo objectForKey:@"FullName"]){
        self.detailedFullName = [userInfo objectForKey:@"FullName"];
    }
}

@end
