//
//  Cell.h
//  a
//
//  Created by zwm on 16/7/23.
//  Copyright © 2016年 zwm. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Cell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *titleLbl;
@property (weak, nonatomic) IBOutlet UIView *backView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *centerLayout;

@end
