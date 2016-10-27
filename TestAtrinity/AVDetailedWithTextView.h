//
//  AVDetailedWithTextView.h
//  TestAtrinity
//
//  Created by aiuar on 27.10.16.
//  Copyright © 2016 A.V. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AVDetailedWithTextView : UITableViewCell

@property (weak, nonatomic) IBOutlet UITextView *descriptionTextView;

 + (CGFloat)heightForText:(NSString *)text;

@end

