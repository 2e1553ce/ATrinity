//
//  AVDetailedWithImageView.h
//  TestAtrinity
//
//  Created by aiuar on 27.10.16.
//  Copyright © 2016 A.V. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AVDetailedWithImageView : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *graphicImageView;

@property (weak, nonatomic) IBOutlet UILabel *startDate;
@property (weak, nonatomic) IBOutlet UILabel *midDate;
@property (weak, nonatomic) IBOutlet UILabel *endDate;


@end
