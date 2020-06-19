//
//  BookController.m
//  a
//
//  Created by zwm on 16/7/25.
//  Copyright © 2016年 zwm. All rights reserved.
//

#import "BookController.h"
#import "BookCell.h"

@interface BookController ()

@end

@implementation BookController

+ (BookController *)getVC
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    BookController *vc = [storyboard instantiateViewControllerWithIdentifier:@"BookController"];
    return vc;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.layer.cornerRadius = 5;
    self.view.layer.masksToBounds = YES;
    [self.view setNeedsLayout];
    [self.view layoutIfNeeded];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (IBAction)backBtnAction:(UIButton *)sender
{
    if (_delegate) {
        [_delegate closeBookVC];
    }
}

#pragma mark - UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"BookCell";

    BookCell *cell = (BookCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];

    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
