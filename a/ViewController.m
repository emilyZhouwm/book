//
//  ViewController.m
//  a
//
//  Created by zwm on 16/7/23.
//  Copyright © 2016年 zwm. All rights reserved.
//

#import "ViewController.h"
#import "Cell.h"
#import "BookController.h"

@interface ViewController () <BookControllerDelegate>
{
    CGFloat _content;

    Cell *_listCell;
    CGRect _rectVC;

    BookController *_bookVC;
}

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    static NSString *cellIdentifier = @"Cell";

    Cell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];

    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    if (_bookVC) {
        return;
    }
    [self openBookVC:indexPath];
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView.contentOffset.y < 0) {
        [self changeContent:scrollView.contentOffset.y];
    } else if ((scrollView.contentSize.height > scrollView.frame.size.height) && (scrollView.contentOffset.y + scrollView.frame.size.height > scrollView.contentSize.height)) {
        CGFloat content = scrollView.contentOffset.y + scrollView.frame.size.height - scrollView.contentSize.height;
        [self changeContent:content];
    } else if ((scrollView.contentSize.height <= scrollView.frame.size.height) && scrollView.contentOffset.y > 0) {
        [self changeContent:scrollView.contentOffset.y];
    } else {
        [self changeContent:0];
    }
}

- (void)changeContent:(CGFloat)content
{
    if (_content != content) {
        _content = content;
        if (_content < 0) {
            for (NSInteger i = 0; i < [_tableView visibleCells].count; i++) {
                Cell *cell = [_tableView visibleCells][i];
                cell.centerLayout.constant = _content * 0.9 - _content * 0.1 * i;
            }
        } else if (_content > 0) {
            for (NSInteger i = [_tableView visibleCells].count - 1; i >= 0; i--) {
                Cell *cell = [_tableView visibleCells][i];
                cell.centerLayout.constant = _content * 0.9 - _content * 0.1 * ([_tableView visibleCells].count - 1 - i);
            }
        } else {
            for (Cell *cell in [_tableView visibleCells]) {
                cell.centerLayout.constant = 0;
            }
        }
    }
}

- (void)openBookVC:(NSIndexPath *)indexPath
{
    _listCell = (Cell *)[_tableView cellForRowAtIndexPath:indexPath];
    _tableView.scrollEnabled = NO;

    _rectVC = [_listCell convertRect:_listCell.backView.frame toView:nil];
    CGRect rcVC = CGRectMake(_rectVC.origin.x, 20, _rectVC.size.width, self.view.frame.size.height - 30);

    NSArray *indexUp = [_tableView indexPathsForRowsInRect:CGRectMake(0, 0, _tableView.frame.size.width, _listCell.frame.origin.y)];
    NSArray *indexDown = [_tableView indexPathsForRowsInRect:CGRectMake(0, CGRectGetMaxY(_listCell.frame), _tableView.frame.size.width, CGRectGetHeight(_tableView.frame) -  CGRectGetMaxY(_listCell.frame))];

    _bookVC = [BookController getVC];
    _bookVC.delegate = self;
    [self addChildViewController:_bookVC];
    _bookVC.view.frame = _rectVC;
    [self.view addSubview:_bookVC.view];
    [UIView animateWithDuration:0.5f animations:^{
        _bookVC.backBtn.alpha = 0.8;
        _bookVC.titleLbl.alpha = 1;
        _bookVC.leftLayout.priority = 249;

        _bookVC.view.frame = rcVC;
        [_bookVC.view setNeedsLayout];
        [_bookVC.view layoutIfNeeded];

        for (NSInteger i = indexUp.count - 1; i >= 0; i--) {
            NSIndexPath *index = indexUp[i];
            Cell *temp = [_tableView cellForRowAtIndexPath:index];

            CGRect tt = CGRectMake(40, -CGRectGetHeight(temp.frame) * (indexUp.count - i), CGRectGetWidth(_tableView.frame) - 80, CGRectGetHeight(temp.frame));

            CGRect toRT = [temp convertRect:tt fromView:nil];
            temp.backView.frame = toRT;
        }
        for (NSInteger i = 0; i < indexDown.count; i++) {
            NSIndexPath *index = indexDown[i];
            Cell *temp = [_tableView cellForRowAtIndexPath:index];

            CGRect tt = CGRectMake(40, CGRectGetHeight(_tableView.frame) + CGRectGetHeight(temp.frame) * i, CGRectGetWidth(_tableView.frame) - 80, CGRectGetHeight(temp.frame));
            CGRect toRT = [temp convertRect:tt fromView:nil];
            temp.backView.frame = toRT;
        }
    } completion:^(BOOL finished) {
    }];
}

- (void)closeBookVC
{
    [UIView animateWithDuration:0.5 animations:^{
        _bookVC.backBtn.alpha = 0;
        _bookVC.titleLbl.alpha = 0.5;
        _bookVC.leftLayout.priority = 750;

        _bookVC.view.frame = _rectVC;
        [_bookVC.view setNeedsLayout];
        [_bookVC.view layoutIfNeeded];

        for (Cell *cell in [_tableView visibleCells]) {
            [cell.backView setNeedsLayout];
            [cell.backView layoutIfNeeded];
        }
    } completion:^(BOOL finished) {
        [_bookVC.view removeFromSuperview];
        [_bookVC removeFromParentViewController];
        _bookVC = nil;
        _tableView.scrollEnabled = YES;
    }];
}

@end
