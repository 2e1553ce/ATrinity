//
//  AVUser.m
//  TestAtrinity
//
//  Created by aiuar on 26.10.16.
//  Copyright © 2016 A.V. All rights reserved.
//

#import "AVUser.h"

static NSString * const kUserAPIKey =       @"e8e6a311d54985a067ece5a008da280a";
static NSString * const kUserLogin =        @"d_blinov";
static NSString * const kUserPassword =     @"Passw0rd";
static NSString * const kUserObjectCode =   @"300";
static NSString * const kUserFilter =       @"3CD0E650-4B81-E511-A39A-1CC1DEAD694D";

@implementation AVUser

- (id)init{
    self = [super init];
    
    if (self) {
        self.apiKey = kUserAPIKey;
        self.login = kUserLogin;
        self.password = kUserPassword;
        self.objectCode = kUserObjectCode;
        self.filter = kUserFilter;
    }
    
    return self;
}

@end
