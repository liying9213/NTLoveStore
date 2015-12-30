//
//  NTShoppingCarViewController.h
//  NTLoveStore
//
//  Created by NTTian on 15/6/17.
//  Copyright (c) 2015年 NTTian. All rights reserved.
//

#import "NTParentViewController.h"

@interface NTShoppingCarViewController : NTParentViewController <UITableViewDataSource,UITableViewDelegate,UIPopoverControllerDelegate,UIGestureRecognizerDelegate,UITextFieldDelegate,UIAlertViewDelegate>
@property (strong, nonatomic) IBOutlet UIButton *selectAllBtn;
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UIButton *selectBtn1;
@property (strong, nonatomic) IBOutlet UIButton *subscriptionBtn;
@property (strong, nonatomic) IBOutlet UILabel *selectNumLabel;
@property (strong, nonatomic) IBOutlet UILabel *totalPricesLabel;
@property (strong, nonatomic) IBOutlet UIButton *payBtn;
@property (strong, nonatomic) IBOutlet UIButton *delectBtn;
@property (strong, nonatomic) NSString *allPrice;
@property (strong, nonatomic) NSMutableArray *shopcartData;
@property (strong, nonatomic) IBOutlet UIView *infoVIew;
@property (strong, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (weak, nonatomic) IBOutlet UIView *infoDataView;

@property (strong, nonatomic) IBOutlet UIButton *dateBtn;
@property (strong, nonatomic) IBOutlet UITextField *nameTextField;
@property (strong, nonatomic) IBOutlet UITextField *telTextField;
@property (strong, nonatomic) IBOutlet UITextField *adessTextField;
@property (strong, nonatomic) IBOutlet UITextField *emailTextField;
@property (strong, nonatomic) UIPopoverController *popoverView;
@property (strong, nonatomic) NSMutableDictionary *selectDic;
@property (nonatomic) NSUInteger allDataCount;
@property (nonatomic) BOOL isSelectAll;
@property (nonatomic, strong) UIView *dateView;
@property (nonatomic) NSInteger payType;//-1 线上 1线下
@property (nonatomic) CGRect infoViewFrame;
@property (nonatomic, strong) NTButton * needDeleteBtn;

- (IBAction)submitInfo:(id)sender;

- (IBAction)dateAction:(id)sender;

- (IBAction)selectAllAction:(id)sender;

- (IBAction)subscriptionAction:(id)sender;

- (IBAction)closeView:(id)sender;

- (IBAction)payAction:(id)sender;

- (IBAction)delectAction:(id)sender;

@end
