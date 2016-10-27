//
//  AVServerManager.m
//  TestAtrinity
//
//  Created by aiuar on 26.10.16.
//  Copyright © 2016 A.V. All rights reserved.
//

#import "AVServerManager.h"

#import <AFNetworking.h>

#import "AVUser.h"
#import "AVApplication.h"

@interface AVServerManager ()

@property (strong, nonatomic) AFHTTPSessionManager *sessionManager;

@end

@implementation AVServerManager

+ (AVServerManager *)sharedManager{
    
    static AVServerManager *manager = nil;
    
    if(!manager){
        
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            
            manager = [[AVServerManager alloc] init];
        });
    }
    
    return manager;
}

- (id)init{
    
    self = [super init];
    
    if(self){
        
        NSURL *baseURL = [NSURL URLWithString:@"http://mobile.atrinity.ru/api/"];
        self.sessionManager = [[AFHTTPSessionManager alloc] initWithBaseURL:baseURL];
        [self.sessionManager.requestSerializer setTimeoutInterval:10];
        self.currentUser = [[AVUser alloc] init];
    }
    
    return self;
}

- (void) getApplicationsOnSuccess:(void(^)(NSArray *applications))success
                        onFailure:(void(^)(NSError *error, NSInteger  statusCode))failure{
    
    self.currentUser.action = @"GET_LIST";
    
    NSDictionary* params =
    [NSDictionary dictionaryWithObjectsAndKeys:
     self.currentUser.apiKey,       @"ApiKey",
     self.currentUser.login,        @"Login",
     self.currentUser.password,     @"Password",
     self.currentUser.objectCode,   @"ObjectCode",
     self.currentUser.action,       @"Action",
     self.currentUser.filter,       @"Fields[FilterID]", nil];
    
    [self.sessionManager POST:@"service" parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSArray *dictArray = responseObject;
        
        NSMutableArray *arrayOfApplications = [NSMutableArray array];
        
        for(NSDictionary *dict in dictArray){
            
            AVApplication *app = [[AVApplication alloc] initWithServerResponse:dict];
            [arrayOfApplications addObject:app];
        }

        if(success){
            success(arrayOfApplications);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"\n%@", [error description]);
        failure(error, 408);
    }];

}

- (void) getDetailedApplication:(AVApplication *)application
                  onSuccess:(void(^)(AVApplication *application))success
                  onFailure:(void(^)(NSError *error, NSInteger statusCode))failure{

    self.currentUser.action = @"GET_INFO";
    NSString *appID = application.requestID;
    
    NSDictionary* params =
    [NSDictionary dictionaryWithObjectsAndKeys:
     self.currentUser.apiKey,       @"ApiKey",
     self.currentUser.login,        @"Login",
     self.currentUser.password,     @"Password",
     self.currentUser.objectCode,   @"ObjectCode",
     self.currentUser.action,       @"Action",
     appID,                         @"Fields[RequestID]", nil];
    
    [self.sessionManager POST:@"service" parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary *dict = responseObject;
        
        // Request, UserInfo
        NSDictionary *requestInfo = [dict valueForKey:@"Request"];
        NSDictionary *userInfo = [dict valueForKey:@"UserInfo"];
       
        [application addDetailedInfoWithRequest:requestInfo andUserInfo:userInfo];
        
        if(success){
            success(application);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"\n%@", [error description]);
        failure(error, 408);
    }];

}

@end
