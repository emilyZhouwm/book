//
//  Cell.m
//  a
//
//  Created by zwm on 16/7/23.
//  Copyright © 2016年 zwm. All rights reserved.
//

#import "Cell.h"

@implementation Cell

- (void)awakeFromNib
{
    [super awakeFromNib];
    _backView.layer.cornerRadius = 5;
    _backView.layer.masksToBounds = YES;
    self.backgroundColor = [UIColor clearColor];
}

@end
