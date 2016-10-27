//
//  AVDetailedApplicationViewController.m
//  TestAtrinity
//
//  Created by aiuar on 26.10.16.
//  Copyright © 2016 A.V. All rights reserved.
//

#import "AVDetailedApplicationViewController.h"

#import "AVServerManager.h"
#import "AVApplication.h"

#import "AVDetailedWithLabel.h"
#import "AVDetailedWithImageView.h"
#import "AVDetailedWithTextView.h"
#import "CircleView.h"

@interface AVDetailedApplicationViewController ()

@property (strong, nonatomic) NSMutableArray *applicationInfo;
@property (assign, nonatomic) BOOL didApplicationLoad;

@property (strong, nonatomic) UIActivityIndicatorView *indicator;

@end

@implementation AVDetailedApplicationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.applicationInfo = [[NSMutableArray alloc] init];
    self.didApplicationLoad = NO;
    
    [self getDetailedApplicationInfo];
    
    self.title = self.application.requestNumber;
    
    self.indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    self.indicator.frame = CGRectMake((self.view.frame.size.width / 2) - 12, (self.view.frame.size.height / 2) - 52, 24, 24);
    [self.view addSubview:self.indicator];
    [self.indicator startAnimating];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - API

- (void) getDetailedApplicationInfo{
    
    [[AVServerManager sharedManager] getDetailedApplication:self.application
                                              onSuccess:^(AVApplication *application) {
                                                  
                                                  if(!application)
                                                      return;
                                                  
                                                  self.didApplicationLoad = YES;
                                                  self.application = application;
                                                  
                                                  NSMutableArray *arrayOfIndexPathes = [[NSMutableArray alloc] init];
                                                  
                                                  for(int i = 0; i < 5; ++i){
                                                      
                                                      [arrayOfIndexPathes addObject:[NSIndexPath indexPathForRow:i inSection:0]];
                                                  }
                                                  
                                                  [self.tableView beginUpdates];
                                                  [self.tableView insertRowsAtIndexPaths:arrayOfIndexPathes withRowAnimation:UITableViewRowAnimationFade];
                                                  [self.tableView endUpdates];
                                                  
                                                  [self.indicator stopAnimating];
                                                  
                                              }
                                              onFailure:^(NSError *error, NSInteger statusCode) {
                                                  NSLog(@"Error = %@, code = %ld", [error localizedDescription], statusCode);
                                              }
    ];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if(self.didApplicationLoad)
        return 5;
    else
        return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if(indexPath.row < 2){
        
        static NSString *cellIdetifierLabel = @"cellWithLabel";
        
        AVDetailedWithLabel *cell = [tableView dequeueReusableCellWithIdentifier:cellIdetifierLabel];
        
        if(indexPath.row == 0){
            cell.infoLabel.text = [NSString stringWithFormat:@"Статус: %@", self.application.detailedStatusText];
        } else {
            cell.infoLabel.text = [NSString stringWithFormat:@"ФИО: %@", self.application.detailedFullName];
        }
        
        return cell;
        
    } else if(indexPath.row < 4){
        
        static NSString *cellIdetifierText = @"cellWithTextView";
        
        AVDetailedWithTextView *cell = [tableView dequeueReusableCellWithIdentifier:cellIdetifierText];
        
        if(indexPath.row == 2){
            cell.descriptionTextView.text = [NSString stringWithFormat:@"Описание: %@", self.application.detailedDescription];
            cell.descriptionTextView.editable = NO;
        } else {
            cell.descriptionTextView.text = [NSString stringWithFormat:@"Решение: %@", self.application.detailedSolutionDescription];
        }
        
        return cell;
        
    } else {
        
        static NSString *cellIdetifierImage = @"cellWithImageView";
        
        AVDetailedWithImageView *cell = [tableView dequeueReusableCellWithIdentifier:cellIdetifierImage];
        
        NSString *startDate = self.application.detailedCreatedAt;
        NSString *middleDate = self.application.detailedSLARecoveryTime;
        NSString *endDate = self.application.detailedActualRecoveryTime;
        
        cell.startDate.text = [NSString stringWithFormat:@"Создано: %@", startDate];
        if(middleDate && ![middleDate isEqualToString:@""] && ![middleDate isEqualToString:@" "]){
            cell.midDate.text = [NSString stringWithFormat:@"Дата окончания(план): %@", middleDate];
        } else {
            cell.midDate.text = @"Окончание(план): не установлена";
        }
        cell.endDate.text = [NSString stringWithFormat:@"Окончание(факт): %@", endDate];
        
        // *******
        
        return cell;
        
    }
    
    return nil;
}

#pragma mark - UITableViewDelegate

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 2) {
        
        NSString *text = self.application.detailedDescription;
        
        CGFloat height = [AVDetailedWithTextView heightForText:text];
        
        if(height < 44)
            return 44;
        
        return height;
        
    } else if (indexPath.row == 3){
        
        NSString *text = self.application.detailedFullName;
        
        CGFloat height = [AVDetailedWithTextView heightForText:text];
        
        if(height < 44)
            return 44;
    
        return height;
        
    } else if(indexPath.row == 4){
        
        return 58.f;
    } else {
        
        return 44.f;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
