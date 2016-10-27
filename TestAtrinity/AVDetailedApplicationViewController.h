//
//  AVDetailedApplicationViewController.h
//  TestAtrinity
//
//  Created by aiuar on 26.10.16.
//  Copyright © 2016 A.V. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AVApplication;

@interface AVDetailedApplicationViewController : UITableViewController

@property (strong, nonatomic) AVApplication *application;

- (void) getDetailedApplicationInfo;

@end
