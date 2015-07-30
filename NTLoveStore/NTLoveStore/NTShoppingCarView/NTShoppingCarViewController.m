//
//  NTShoppingCarViewController.m
//  NTLoveStore
//
//  Created by liying on 15/6/17.
//  Copyright (c) 2015年 liying. All rights reserved.
//

#import "NTShoppingCarViewController.h"
#import "NTShopcarTableViewCell.h"
#import "NTAsynService.h"
@interface NTShoppingCarViewController ()

@end

@implementation NTShoppingCarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self getTheShopCartData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)getTheShopCartData{
    if (![share()userIsLogin]) {
        [self showEndViewWithText:@"请登录账号！"];
        return;
    }
    [self showWaitingViewWithText:nil];
    __weak typeof(self) __weakself=self;
    NSDictionary *dic=@{@"uid":[share()userUid],
                        @"token":[share()userToken]};
    [NTAsynService requestWithHead:shopcartBaseUR WithBody:dic completionHandler:^(BOOL success, id finishData, NSError *connectionError) {
        if (success) {
            [self changeData:finishData];
            [self resetView];
            [self hideWaitingView];
        }
        else{
            __strong typeof(self) self=__weakself;
            if (![share()userIsLogin]) {
                [self showEndViewWithText:@"请登录账号！"];
            }
            else{
                [self showEndViewWithText:@"网络请求失败！"];
            }
        }
    }];
    dic=nil;
}

- (void)changeData:(id)finishData{
    _allPrice=[finishData objectForKey:@"mtotal"];
    NSMutableDictionary *dic=[[NSMutableDictionary alloc] initWithDictionary:finishData];
    [dic removeObjectForKey:@"mtotal"];
    _shopcartData=[self getTheValuesWithKey:[[dic allKeys] sortedArrayUsingSelector:@selector(caseInsensitiveCompare:)] withData:dic];
    dic=nil;
}

- (NSMutableArray *)getTheValuesWithKey:(NSArray *)keyAry withData:(NSMutableDictionary *)dic{
    NSMutableArray *ary=[[NSMutableArray array] init];
    for (NSString *str in keyAry) {
        [ary addObject:[dic objectForKey:str]];
    }
    return ary;
}

- (void)resetView{
    if (_isSelectAll) {
        _selectNumLabel.text=[NSString stringWithFormat:@"已选商品%lu件",(unsigned long)_shopcartData.count];
        _totalPricesLabel.text=[NSString stringWithFormat:@"合计：%.2lf",[_allPrice floatValue]];
    }
    else{
        _selectNumLabel.text=[NSString stringWithFormat:@"已选商品%lu件",(unsigned long)_selectAry.count];
       NSString *price= [self getTheSelectPrice];
        _totalPricesLabel.text=[NSString stringWithFormat:@"合计：%.2lf",[price floatValue]];
    }
    [_tableView reloadData];
}

#pragma mark - tableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_shopcartData count];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * _cellIdentify = @"cell";
    NTShopcarTableViewCell * iCell = [tableView dequeueReusableCellWithIdentifier:_cellIdentify];
    if (iCell == nil){
        [tableView registerNib:[UINib nibWithNibName:@"NTShopcarTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
        iCell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    }
    iCell.leftImagView.imageURL=[NSURL URLWithString:[[_shopcartData objectAtIndex:indexPath.row] objectForKey:@"cover_id"]];
    iCell.commodityName.text=[[_shopcartData objectAtIndex:indexPath.row] objectForKey:@"title"];
    iCell.price.text=[NSString stringWithFormat:@"%@/元",[[_shopcartData objectAtIndex:indexPath.row] objectForKey:@"price"]];
    iCell.allPrice.text=[NSString stringWithFormat:@"%@元",[[_shopcartData objectAtIndex:indexPath.row] objectForKey:@"tprice"]];
    [iCell.selectBtn addTarget:self action:@selector(selectOne:) forControlEvents:UIControlEventTouchUpInside];
    iCell.selectBtn.tag=indexPath.row;
    if (_isSelectAll) {
        iCell.selectBtn.selected=YES;
    }
    else{
        iCell.selectBtn.selected=[self isSelectINDataWithTag:indexPath.row];
    }
    if ([[[_shopcartData objectAtIndex:indexPath.row] objectForKey:@"parameters"] length]>4) {
        iCell.dateLabel.hidden=NO;
        iCell.dateLabel.text=[[_shopcartData objectAtIndex:indexPath.row] objectForKey:@"parameters"];
        iCell.contView.hidden=YES;
    }
    else{
        iCell.dateLabel.hidden=YES;
        iCell.contView.hidden=NO;
        iCell.numLabel.text=[[_shopcartData objectAtIndex:indexPath.row] objectForKey:@"num"];
        iCell.delBtn.enabled=YES;
        iCell.delBtn.layer.borderWidth=1;
        iCell.delBtn.layer.borderColor=[[UIColor lightGrayColor] CGColor];
        [iCell.delBtn addTarget:self action:@selector(delAction:) forControlEvents:UIControlEventTouchUpInside];
        iCell.delBtn.tag=indexPath.row;
        iCell.addBtn.enabled=YES;
        iCell.addBtn.layer.borderWidth=1;
        iCell.addBtn.layer.borderColor=[[UIColor lightGrayColor] CGColor];
        [iCell.addBtn addTarget:self action:@selector(addAction:) forControlEvents:UIControlEventTouchUpInside];
        iCell.addBtn.tag=indexPath.row;
        if ([[[_shopcartData objectAtIndex:indexPath.row] objectForKey:@"pet"] intValue]==1) {
            iCell.delBtn.enabled=NO;
            iCell.addBtn.enabled=NO;
        }

    }
    iCell.delectBtn.tag=indexPath.row;
    [iCell.delectBtn addTarget:self action:@selector(delectOneAction:) forControlEvents:UIControlEventTouchUpInside];
    return iCell;
}


- (void)delectOneAction:(id)sender{
    if (![share()userIsLogin]) {
        [self showEndViewWithText:@"请登录账号！"];
        return;
    }
    UIButton *btn=(UIButton *)sender;
    [self showWaitingViewWithText:@"正在删除..."];
    __weak typeof(self) __weakself=self;

    NSDictionary *dic=@{@"uid":[share()userUid],
                        @"token":[share()userToken],
                        @"id":[[_shopcartData objectAtIndex:btn.tag] objectForKey:@"goodid"],
                        @"price":[[_shopcartData objectAtIndex:btn.tag] objectForKey:@"price"],
                        @"sort":[[_shopcartData objectAtIndex:btn.tag] objectForKey:@"sort"],
                        @"parameters":[[_shopcartData objectAtIndex:btn.tag] objectForKey:@"parameters"],
                        @"pet":[[_shopcartData objectAtIndex:btn.tag] objectForKey:@"pet"],
                        @"key":@"2"};
    [NTAsynService requestWithHead:delItemBaseURL WithBody:dic completionHandler:^(BOOL success, id finishData, NSError *connectionError) {
        if (success) {
            __strong typeof(self) self=__weakself;
            [self changeData:finishData];
            [self resetView];
            [self hideWaitingView];
        }
        else{
            __strong typeof(self) self=__weakself;
            if (![share()userIsLogin]) {
                [self showEndViewWithText:@"请登录账号！"];
            }
            else{
                [self showEndViewWithText:@"网络请求失败！"];
            }
        }
    }];
    dic=nil;
}

- (void)delAction:(id)sender{
    if (![share()userIsLogin]) {
        [self showEndViewWithText:@"请登录账号！"];
        return;
    }
    UIButton *btn=(UIButton *)sender;
    [self showWaitingViewWithText:@"正在删除..."];
    __weak typeof(self) __weakself=self;
    
    NSDictionary *dic=@{@"uid":[share()userUid],
                        @"token":[share()userToken],
                        @"id":[[_shopcartData objectAtIndex:btn.tag] objectForKey:@"goodid"],
                        @"price":[[_shopcartData objectAtIndex:btn.tag] objectForKey:@"price"],
                        @"sort":[[_shopcartData objectAtIndex:btn.tag] objectForKey:@"sort"],
                        @"parameters":[[_shopcartData objectAtIndex:btn.tag] objectForKey:@"parameters"],
                        @"pet":[[_shopcartData objectAtIndex:btn.tag] objectForKey:@"pet"],
                        @"key":@"1"};
    [NTAsynService requestWithHead:delItemBaseURL WithBody:dic completionHandler:^(BOOL success, id finishData, NSError *connectionError) {
        if (success) {
            __strong typeof(self) self=__weakself;
            [self changeData:finishData];
            [self resetView];
            [self hideWaitingView];
        }
        else{
            __strong typeof(self) self=__weakself;
            if (![share()userIsLogin]) {
                [self showEndViewWithText:@"请登录账号！"];
            }
            else{
                [self showEndViewWithText:@"网络请求失败！"];
            }
        }
    }];
    dic=nil;
}

- (void)addAction:(id)sender{
    if (![share()userIsLogin]) {
        [self showEndViewWithText:@"请登录账号！"];
        return;
    }
    UIButton *btn=(UIButton *)sender;
    [self showWaitingViewWithText:@"正在添加..."];
    __weak typeof(self) __weakself=self;
    
    NSDictionary *dic=@{@"uid":[share()userUid],
                        @"token":[share()userToken],
                        @"id":[[_shopcartData objectAtIndex:btn.tag] objectForKey:@"goodid"],
                        @"price":[[_shopcartData objectAtIndex:btn.tag] objectForKey:@"price"],
                        @"sort":[[_shopcartData objectAtIndex:btn.tag] objectForKey:@"sort"],
                        @"num":@"1",
                        @"pet":[[_shopcartData objectAtIndex:btn.tag] objectForKey:@"pet"],
                        @"parameters":[[_shopcartData objectAtIndex:btn.tag] objectForKey:@"parameters"]};

    [NTAsynService requestWithHead:addItemBaseURL WithBody:dic completionHandler:^(BOOL success, id finishData, NSError *connectionError) {
        if (success) {
            __strong typeof(self) self=__weakself;
            [self changeData:finishData];
            [self resetView];
            [self hideWaitingView];
        }
        else{
            __strong typeof(self) self=__weakself;
            if (![share()userIsLogin]) {
                [self showEndViewWithText:@"请登录账号！"];
            }
            else{
                [self showEndViewWithText:@"网络请求失败！"];
            }
        }
    }];
    dic=nil;
}

/*
 user	yes	string	用户名
 pass	yes	string	密码
 goods	yes	obj	｛0｛num:” ”，id:” ”，parameters:” ”，sort:” ”，price:” ”｝，1｛num:” ”，id:” ”，parameters:” ”，sort:” ”，price:” ”｝
 date	yes	string	结婚日期
 name	yes	string	联系人名字
 phone	yes	string	联系人电话
 address	yes	String	住址
 email	yes	string	联系人email
 typ	yes	string	是否勾选50%订金
 */

- (void)subOrderAction{
    if (![share()userIsLogin]) {
        [self showEndViewWithText:@"请登录账号！"];
        return;
    }
    
    [self showWaitingViewWithText:@"正在添加..."];
    __weak typeof(self) __weakself=self;
    NSDictionary *dic=@{@"uid":[share()userUid],
                        @"token":[share()userToken],
                        @"date":_dateBtn.titleLabel.text,
                        @"name":_nameTextField.text,
                        @"phone":_telTextField.text,
                        @"address":_adessTextField.text,
                        @"email":_emailTextField.text,
                        @"goods":@"",
                        @"typ":[NSString stringWithFormat:@"%d",_subscriptionBtn.selected]};
    
    [NTAsynService requestWithHead:subOrderBaseUR WithBody:dic completionHandler:^(BOOL success, id finishData, NSError *connectionError) {
        if (success) {
            __strong typeof(self) self=__weakself;
            [self changeData:finishData];
            [self resetView];
            [self hideWaitingView];
        }
        else{
            __strong typeof(self) self=__weakself;
            if (![share()userIsLogin]) {
                [self showEndViewWithText:@"请登录账号！"];
            }
            else{
                [self showEndViewWithText:@"网络请求失败！"];
            }
        }
    }];
    dic=nil;
}

- (IBAction)submitInfo:(id)sender {
    if (!_dateBtn.titleLabel.text) {
        [self showEndViewWithText:@"请选择婚期"];
        return;
    }
    if (!_nameTextField.text.length>0) {
        [self showEndViewWithText:@"请填写姓名"];
        return;
    }
    if (!_telTextField.text.length>0) {
        [self showEndViewWithText:@"请填写电话"];
        return;
    }
    if (!_adessTextField.text.length>0) {
        [self showEndViewWithText:@"请填写地址"];
        return;
    }
    if (!_emailTextField.text.length>0) {
        [self showEndViewWithText:@"请填写邮箱"];
        return;
    }
    [self colseTheView:nil];
    [self subOrderAction];
    [self showEndViewWithText:@"支付功能正在完善！"];
}

- (IBAction)dateAction:(id)sender {
    if (!_dateView) {
        UIViewController *viewcontroller=[[UIViewController alloc] init];
        [viewcontroller.view addSubview:_datePicker];
        viewcontroller.view.frame=CGRectMake(0, CGRectGetHeight(_infoDataView.frame)-162, CGRectGetWidth(_infoDataView.frame), 162);
        _datePicker.frame=CGRectMake(0, 0, CGRectGetWidth(_infoDataView.frame), 162);
        viewcontroller.view.backgroundColor=[UIColor whiteColor];
        _dateView=viewcontroller.view;
        [_infoDataView addSubview:_dateView];
        _dateView.hidden=YES;
    }
    if (_dateView.hidden) {
        _dateView.hidden=NO;
    }
    else{
        [self getTheDate];
    }
}

- (NSString *)getTheSelectPrice{
    float price =0;
    for (NSNumber *num in _selectAry) {
        NSDictionary *dic=[_shopcartData objectAtIndex:[num intValue]];
        price +=[[dic objectForKey:@"tprice"] floatValue];
    }
    return [NSString stringWithFormat:@"%f",price];
}

- (BOOL)isSelectINDataWithTag:(NSInteger)tag{
    if (!_selectAry) {
        return NO;
    }
    return [_selectAry containsObject:[NSNumber numberWithInteger:tag]];
}

- (void)selectOne:(id)sender{
    if (!_selectAry) {
        _selectAry=[[NSMutableArray alloc] init];
    }
    UIButton *btn=(UIButton *)sender;
    btn.selected=!btn.selected;
    if (btn.selected) {
        [_selectAry addObject:[NSNumber numberWithInteger:btn.tag]];
    }
    else{
        _selectAllBtn.selected=NO;
        _selectBtn1.selected=NO;
        _isSelectAll=NO;
        [_selectAry removeObject:[NSNumber numberWithInteger:btn.tag]];
    }
    if ([_selectAry count]==[_shopcartData count]) {
        _selectAllBtn.selected=YES;
        _selectBtn1.selected=YES;
        _isSelectAll=YES;
    }
    [self resetView];
}

- (IBAction)selectAllAction:(id)sender {
    _selectAllBtn.selected=!_selectAllBtn.selected;
    _selectBtn1.selected=!_selectBtn1.selected;
    _isSelectAll=_selectBtn1.selected;
    if (!_isSelectAll) {
        [_selectAry removeAllObjects];
    }
    [self resetView];
}

- (IBAction)subscriptionAction:(id)sender {
    UIButton *btn=(UIButton *)sender;
    btn.selected=!btn.selected;
    NSString *str=[_totalPricesLabel.text substringFromIndex:3];
    if (btn.selected) {
       _totalPricesLabel.text=[NSString stringWithFormat:@"合计：%.2lf",[str floatValue]/2];
    }
    else{
       _totalPricesLabel.text=[NSString stringWithFormat:@"合计：%.2lf",[str floatValue]*2];
    }
}

- (IBAction)payAction:(id)sender {
    if(_infoVIew.hidden){
        _infoVIew.hidden=NO;
    }
    else{
        UITapGestureRecognizer *panGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(colseTheView:)];
        panGestureRecognizer.delegate=self;
        [_infoVIew addGestureRecognizer:panGestureRecognizer];
        _infoVIew.frame=CGRectMake(0, 0, ScreenWidth, ScreenHeight);
       [[[UIApplication sharedApplication] windows][0] addSubview:_infoVIew];
        
        [_nameTextField addTarget:self action:@selector(textField:) forControlEvents:UIControlEventEditingDidBegin];
        [_telTextField addTarget:self action:@selector(textField:) forControlEvents:UIControlEventEditingDidBegin];
        [_adessTextField addTarget:self action:@selector(textField:) forControlEvents:UIControlEventEditingDidBegin];
        [_emailTextField addTarget:self action:@selector(textField:) forControlEvents:UIControlEventEditingDidBegin];
    }
}

- (IBAction)delectAction:(id)sender {
    if (![share()userIsLogin]) {
        [self showEndViewWithText:@"请登录账号！"];
        return;
    }
    [self showWaitingViewWithText:@"正在清空..."];
    __weak typeof(self) __weakself=self;
    NSDictionary *dic=@{@"uid":[share()userUid],
                        @"token":[share()userToken]};
    [NTAsynService requestWithHead:dropBaseUR WithBody:dic completionHandler:^(BOOL success, id finishData, NSError *connectionError) {
        if (success) {
            __strong typeof(self) self=__weakself;
            _allPrice=@"0";
            _shopcartData=nil;
            [self resetView];
            [self hideWaitingView];
        }
        else{
            if (![share()userIsLogin]) {
                [self showEndViewWithText:@"请登录账号！"];
                return ;
            }
            __strong typeof(self) self=__weakself;
            _allPrice=@"0";
            _shopcartData=nil;
            [self resetView];
            [self hideWaitingView];
        }
    }];
    dic=nil;
}

- (void)textField:(id)sender{
    if (_dateView&&!_dateView.hidden) {
        [self getTheDate];
    }
}


#pragma mark - infoView

- (void)colseTheView:(UIPanGestureRecognizer*)paramSender{
    if (_dateView.hidden) {
        _infoVIew.hidden=YES;
    }
    else{
        [self getTheDate];
    }
}

- (void)getTheDate{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSString *str=[formatter stringFromDate:_datePicker.date];
    [_dateBtn setTitle:str forState:UIControlStateNormal];
    _dateView.hidden=YES;
}

- (void)backBtnAction:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
