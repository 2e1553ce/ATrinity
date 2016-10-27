//
//  AVApplicationCell.h
//  TestAtrinity
//
//  Created by aiuar on 26.10.16.
//  Copyright © 2016 A.V. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AVApplicationCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *createdAt;
@property (weak, nonatomic) IBOutlet UILabel *requestNumber;

@end
