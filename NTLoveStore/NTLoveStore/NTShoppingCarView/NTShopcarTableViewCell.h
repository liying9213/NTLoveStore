//
//  NTShopcarTableViewCell.h
//  NTLoveStore
//
//  Created by liying on 15/7/12.
//  Copyright (c) 2015年 liying. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EGOImageView.h"
@interface NTShopcarTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet EGOImageView *leftImagView;
@property (strong, nonatomic) IBOutlet UILabel *commodityName;
@property (strong, nonatomic) IBOutlet UILabel *price;
@property (strong, nonatomic) IBOutlet UILabel *allPrice;
@property (strong, nonatomic) IBOutlet UIView *contView;
@property (strong, nonatomic) IBOutlet UIButton *delectBtn;
@property (strong, nonatomic) IBOutlet UIButton *delBtn;
@property (strong, nonatomic) IBOutlet UILabel *numLabel;
@property (strong, nonatomic) IBOutlet UIButton *addBtn;
@property (strong, nonatomic) IBOutlet UILabel *dateLabel;
@property (strong, nonatomic) IBOutlet UIButton *selectBtn;

@end
