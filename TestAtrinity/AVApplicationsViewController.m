//
//  AVApplicationsViewController.m
//  TestAtrinity
//
//  Created by aiuar on 26.10.16.
//  Copyright © 2016 A.V. All rights reserved.
//

#import "AVApplicationsViewController.h"

#import "AVServerManager.h"
#import "AVApplication.h"
#import "AVApplicationCell.h"
#import "AVDetailedApplicationViewController.h"

@interface AVApplicationsViewController ()

@property (nonatomic, strong) NSMutableArray *arrayOfApplications;
@property (strong, nonatomic) UIActivityIndicatorView *indicator;

@end

@implementation AVApplicationsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.arrayOfApplications = [[NSMutableArray alloc] init];
    
    self.indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    self.indicator.frame = CGRectMake((self.view.frame.size.width / 2) - 12, (self.view.frame.size.height / 2) - 52, 24, 24);
    [self.view addSubview:self.indicator];
    [self.indicator startAnimating];
    [[UIApplication sharedApplication] beginIgnoringInteractionEvents];
    
    [self getApplicationsFromServer];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - API

- (void)getApplicationsFromServer{
    
    [[AVServerManager sharedManager] getApplicationsOnSuccess:^(NSArray *applications) {
        
                                                    if([applications count] == 0)
                                                        return;
        
                                                    [self.arrayOfApplications addObjectsFromArray:applications];
        
                                                    NSMutableArray *arrayOfIndexPathes = [[NSMutableArray alloc] init];
        
                                                    for(int i = (int)[self.arrayOfApplications count] - (int)[applications count]; i < [self.arrayOfApplications count]; ++i){
            
                                                        [arrayOfIndexPathes addObject:[NSIndexPath indexPathForRow:i inSection:0]];
                                                    }
        
                                                    [self.tableView beginUpdates];
                                                    [self.tableView insertRowsAtIndexPaths:arrayOfIndexPathes withRowAnimation:UITableViewRowAnimationFade];
                                                    [self.tableView endUpdates];

                                                    [self.indicator stopAnimating];
                                                    [[UIApplication sharedApplication] endIgnoringInteractionEvents];
        
                                                    }
                                                    onFailure:^(NSError *error, NSInteger statusCode) {
                                                        
                                                        NSLog(@"Error = %@, code = %ld", [error localizedDescription], statusCode);
                                                        [self.indicator stopAnimating];
                                                        [[UIApplication sharedApplication] endIgnoringInteractionEvents];
                                                        
                                                        if(statusCode == 408){
                                                         
                                                            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Время истекло" message:@"Нет ответа от сервера" preferredStyle:UIAlertControllerStyleAlert];
                                                            UIAlertAction *defaultAction = [UIAlertAction actionWithTitle:@"Ок" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
                                                                //enter code here
                                                            }];
                                                            [alert addAction:defaultAction];
                                                            //Present action where needed
                                                            [self presentViewController:alert animated:YES completion:nil];
                                                            
                                                        }
                                                    }
    ];

}


#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [self.arrayOfApplications count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellIdetifier = @"applicationCell";
    
    AVApplicationCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdetifier];
    
    AVApplication *app = [self.arrayOfApplications objectAtIndex:indexPath.row];
    
    cell.name.text = [NSString stringWithFormat:@"Тема: %@", app.name];
    cell.createdAt.text = [NSString stringWithFormat:@"Дата: %@", app.createdAt];;
    cell.requestNumber.text = [NSString stringWithFormat:@"Номер: %@", app.requestNumber];;
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - Segues

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    if ([segue.identifier isEqualToString:@"detailedApplicationSegue"])
    {
        NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
        
        AVApplication *app = [self.arrayOfApplications objectAtIndex:indexPath.row];
        
        AVDetailedApplicationViewController *destViewController = segue.destinationViewController;
        destViewController.application = app;
    }
}


@end
