//
//  BookController.h
//  a
//
//  Created by zwm on 16/7/25.
//  Copyright © 2016年 zwm. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol BookControllerDelegate <NSObject>

@required
- (void)closeBookVC;

@end

@interface BookController : UIViewController

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIView *backView;
@property (weak, nonatomic) IBOutlet UIButton *backBtn;
@property (weak, nonatomic) IBOutlet UILabel *titleLbl;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leftLayout;

@property (nonatomic, weak) id<BookControllerDelegate> delegate;

+ (BookController *)getVC;

@end
