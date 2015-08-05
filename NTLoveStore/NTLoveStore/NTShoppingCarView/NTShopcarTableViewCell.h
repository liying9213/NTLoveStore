//
//  NTShopcarTableViewCell.h
//  NTLoveStore
//
//  Created by liying on 15/7/12.
//  Copyright (c) 2015年 liying. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NTButton.h"
@interface NTShopcarTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *leftImagView;
@property (strong, nonatomic) IBOutlet UILabel *commodityName;
@property (strong, nonatomic) IBOutlet UILabel *price;
@property (strong, nonatomic) IBOutlet UILabel *allPrice;
@property (strong, nonatomic) IBOutlet UIView *contView;
@property (strong, nonatomic) IBOutlet NTButton *delectBtn;
@property (strong, nonatomic) IBOutlet NTButton *delBtn;
@property (strong, nonatomic) IBOutlet UILabel *numLabel;
@property (strong, nonatomic) IBOutlet NTButton *addBtn;
@property (strong, nonatomic) IBOutlet UILabel *dateLabel;
@property (strong, nonatomic) IBOutlet NTButton *selectBtn;

@end
