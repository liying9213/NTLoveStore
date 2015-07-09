//
//  NTConsultViewController.h
//  NTLoveStore
//
//  Created by liying on 15/7/9.
//  Copyright (c) 2015年 liying. All rights reserved.
//

#import "NTParentViewController.h"

@interface NTConsultViewController : NTParentViewController
@property (strong, nonatomic) IBOutlet UIButton *weddingDate;
@property (strong, nonatomic) IBOutlet UITextField *deskTextField;
@property (strong, nonatomic) IBOutlet UITextField *bridegroomNameTextField;
@property (strong, nonatomic) IBOutlet UITextField *bridegroomTelTexField;
@property (strong, nonatomic) IBOutlet UITextField *bridegroomAddressTextField;
@property (strong, nonatomic) IBOutlet UITextField *bridegroomEmailTextField;
@property (strong, nonatomic) IBOutlet UITextField *budgetTextField;
@property (strong, nonatomic) IBOutlet UITextField *brideNameTextField;
@property (strong, nonatomic) IBOutlet UITextField *brideTelTextField;
@property (strong, nonatomic) IBOutlet UITextField *brideAddressTextField;
@property (strong, nonatomic) IBOutlet UIDatePicker *datePicker;

- (IBAction)selcetDate:(id)sender;
- (IBAction)submit:(id)sender;
@end
