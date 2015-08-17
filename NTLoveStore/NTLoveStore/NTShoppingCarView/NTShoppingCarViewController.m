//
//  NTShoppingCarViewController.m
//  NTLoveStore
//
//  Created by liying on 15/6/17.
//  Copyright (c) 2015年 liying. All rights reserved.
//

#import "NTShoppingCarViewController.h"
#import "NTShopcarTableViewCell.h"
#import "NTTextField.h"
#import "NTAsynService.h"
#import "NTPayCodeView.h"
@interface NTShoppingCarViewController ()

@end

@implementation NTShoppingCarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self getTheShopCartData];
    _tableView.backgroundView = nil;
    _tableView.backgroundColor = [UIColor clearColor];
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
        finishData=nil;
    }];
    dic=nil;
}

- (void)changeData:(id)finishData{
    _allPrice=[finishData objectForKey:@"mtotal"];
    NSMutableDictionary *dic=[[NSMutableDictionary alloc] initWithDictionary:finishData];
    [dic removeObjectForKey:@"mtotal"];
    NSArray *ary=[self getTheValuesWithKey:[[dic allKeys] sortedArrayUsingSelector:@selector(caseInsensitiveCompare:)] withData:dic];
    NSMutableDictionary *idic=[[NSMutableDictionary alloc] init];
    for (int i=0; i<ary.count; i++) {
        if ([idic allKeys].count>0&&[[idic allKeys] containsObject:[ary[i] objectForKey:@"sort"]]) {
            NSMutableDictionary *theDic=[[NSMutableDictionary alloc] initWithDictionary:[idic objectForKey:[ary[i] objectForKey:@"sort"]]];
            NSMutableArray *objAry=[[NSMutableArray alloc] initWithArray:[theDic objectForKey:@"obj"]];
            [objAry addObject:ary[i]];
            [theDic setObject:objAry forKey:@"obj"];
            [idic setObject:theDic forKey:[ary[i] objectForKey:@"sort"]];
            objAry=nil;
            theDic=nil;
        }
        else
        {
            [idic setObject:@{@"name":[ary[i] objectForKey:@"sort"],@"obj":@[ary[i]]} forKey:[ary[i] objectForKey:@"sort"]];
        }
    }
    _allDataCount=[ary count];
    _shopcartData=[self getTheValuesWithKey:[idic allKeys] withData:idic];
    idic=nil;
    ary=nil;
    dic=nil;
}

- (void)resetView{
    if (_isSelectAll) {
        _selectNumLabel.text=[NSString stringWithFormat:@"已选商品%lu件",(unsigned long)_allDataCount];
        _totalPricesLabel.text=[NSString stringWithFormat:@"合计：%.2lf",[_allPrice floatValue]];
    }
    else{
        _selectNumLabel.text=[NSString stringWithFormat:@"已选商品%lu件",(unsigned long)[self getSelectCount]];
       NSString *price= [self getTheSelectPrice];
        _totalPricesLabel.text=[NSString stringWithFormat:@"合计：%.2lf",[price floatValue]];
    }
    [_tableView reloadData];
}

#pragma mark - tableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 30;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view=[[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 30)];
    view.backgroundColor=[NTColor colorWithHexString:NTGrayColor];
    NTButton *selectBtn=[NTButton buttonWithType:UIButtonTypeCustom];
    selectBtn.section=section;
    selectBtn.frame=CGRectMake(22, 7.5, 15, 15);
    [selectBtn addTarget:self action:@selector(selectSectionAction:) forControlEvents:UIControlEventTouchUpInside];
    [selectBtn setImage:[UIImage imageNamed:@"disSelect"] forState:UIControlStateNormal];
    [selectBtn setImage:[UIImage imageNamed:@"select"] forState:UIControlStateSelected];
    selectBtn.selected=[self isSelectALlSection:section];
    [view addSubview:selectBtn];
    
    UILabel *label=[[UILabel alloc] initWithFrame:CGRectMake(52, 7.5, ScreenWidth-50, 15)];
    label.font=[UIFont systemFontOfSize:15];
    label.text=[_shopcartData[section] objectForKey:@"name"];
    label.textAlignment=NSTextAlignmentLeft;
    [view addSubview:label];

    return view;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger value=[[_shopcartData[section] objectForKey:@"obj"] count];
    
    return value;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return [_shopcartData count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * _cellIdentify = @"cell";
    NTShopcarTableViewCell * iCell = [tableView dequeueReusableCellWithIdentifier:_cellIdentify];
    if (iCell == nil){
        [tableView registerNib:[UINib nibWithNibName:@"NTShopcarTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
        iCell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    }
    [iCell.leftImagView sd_setImageWithURL:[NSURL URLWithString:[[[_shopcartData[indexPath.section] objectForKey:@"obj"] objectAtIndex:indexPath.row] objectForKey:@"cover_id"]] placeholderImage:[NTImage imageWithFileName:@"picple.png"]];
    iCell.commodityName.text=[[[_shopcartData[indexPath.section] objectForKey:@"obj"] objectAtIndex:indexPath.row] objectForKey:@"title"];
    iCell.price.text=[NSString stringWithFormat:@"%@/元",[[[_shopcartData[indexPath.section] objectForKey:@"obj"] objectAtIndex:indexPath.row] objectForKey:@"price"]];
    iCell.allPrice.text=[NSString stringWithFormat:@"%@元",[[[_shopcartData[indexPath.section] objectForKey:@"obj"] objectAtIndex:indexPath.row] objectForKey:@"tprice"]];
    [iCell.selectBtn addTarget:self action:@selector(selectOne:) forControlEvents:UIControlEventTouchUpInside];
    iCell.numLabel.textAlignment = NSTextAlignmentCenter;
    iCell.numLabel.delegate=self;
    iCell.selectBtn.section=indexPath.section;
    iCell.selectBtn.tag=indexPath.row;
    if (_isSelectAll) {
        iCell.selectBtn.selected=YES;
    }
    else{
        iCell.selectBtn.selected=[self isSelectINDataWithTag:iCell.selectBtn];
    }
    if ([[[[_shopcartData[indexPath.section] objectForKey:@"obj"] objectAtIndex:indexPath.row] objectForKey:@"parameters"] length]>4) {
        iCell.dateLabel.hidden=NO;
        iCell.dateLabel.text=[[[_shopcartData[indexPath.section] objectForKey:@"obj"] objectAtIndex:indexPath.row] objectForKey:@"parameters"];
        iCell.contView.hidden=YES;
    }
    else{
        iCell.dateLabel.hidden=YES;
        iCell.contView.hidden=NO;
        iCell.numLabel.text=[[[_shopcartData[indexPath.section] objectForKey:@"obj"] objectAtIndex:indexPath.row] objectForKey:@"num"];
        iCell.numLabel.tag=indexPath.row;
        iCell.numLabel.section=indexPath.section;
        iCell.delBtn.enabled=YES;
        iCell.delBtn.layer.borderWidth=1;
        iCell.delBtn.layer.borderColor=[[UIColor lightGrayColor] CGColor];
        [iCell.delBtn addTarget:self action:@selector(delAction:) forControlEvents:UIControlEventTouchUpInside];
        iCell.delBtn.tag=indexPath.row;
        iCell.delBtn.section=indexPath.section;
        iCell.addBtn.enabled=YES;
        iCell.addBtn.layer.borderWidth=1;
        iCell.addBtn.layer.borderColor=[[UIColor lightGrayColor] CGColor];
        [iCell.addBtn addTarget:self action:@selector(addAction:) forControlEvents:UIControlEventTouchUpInside];
        iCell.addBtn.tag=indexPath.row;
        iCell.addBtn.section=indexPath.section;
        if ([[[[_shopcartData[indexPath.section] objectForKey:@"obj"] objectAtIndex:indexPath.row] objectForKey:@"pet"] intValue]==1) {
            iCell.delBtn.enabled=NO;
            iCell.addBtn.enabled=NO;
        }

    }
    iCell.delectBtn.tag=indexPath.row;
    iCell.delectBtn.section=indexPath.section;
    [iCell.delectBtn addTarget:self action:@selector(delectOneAction:) forControlEvents:UIControlEventTouchUpInside];
    return iCell;
}


- (void)delectOneAction:(id)sender{
    if (![share()userIsLogin]) {
        [self showEndViewWithText:@"请登录账号！"];
        return;
    }
    NTButton *btn=(NTButton *)sender;
    [self showWaitingViewWithText:@"正在删除..."];
    __weak typeof(self) __weakself=self;
    NSDictionary *dic=@{@"uid":[share()userUid],
                        @"token":[share()userToken],
                        @"id":[[[_shopcartData[btn.section]objectForKey:@"obj"] objectAtIndex:btn.tag] objectForKey:@"goodid"],
                        @"price":[[[_shopcartData[btn.section]objectForKey:@"obj"] objectAtIndex:btn.tag] objectForKey:@"price"],
                        @"sort":[[[_shopcartData[btn.section]objectForKey:@"obj"] objectAtIndex:btn.tag] objectForKey:@"sort"],
                        @"parameters":[[[_shopcartData[btn.section]objectForKey:@"obj"] objectAtIndex:btn.tag] objectForKey:@"parameters"],
                        @"pet":[[[_shopcartData[btn.section]objectForKey:@"obj"] objectAtIndex:btn.tag] objectForKey:@"pet"],
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
        finishData=nil;
    }];
    dic=nil;
}

- (void)delAction:(id)sender{
    if (![share()userIsLogin]) {
        [self showEndViewWithText:@"请登录账号！"];
        return;
    }
    NTButton *btn=(NTButton *)sender;
    [self delActionWith:btn.section WithRow:btn.tag with:1];
}

- (void)delActionWith:(NSInteger)section WithRow:(NSInteger)row with:(int)num{
    [self showWaitingViewWithText:@"正在删除..."];
    __weak typeof(self) __weakself=self;
    
    NSDictionary *dic=@{@"uid":[share()userUid],
                        @"token":[share()userToken],
                        @"id":[[[_shopcartData[section]objectForKey:@"obj"] objectAtIndex:row] objectForKey:@"goodid"],
                        @"price":[[[_shopcartData[section]objectForKey:@"obj"] objectAtIndex:row] objectForKey:@"price"],
                        @"sort":[[[_shopcartData[section]objectForKey:@"obj"] objectAtIndex:row] objectForKey:@"sort"],
                        @"parameters":[[[_shopcartData[section]objectForKey:@"obj"] objectAtIndex:row] objectForKey:@"parameters"],
                        @"pet":[[[_shopcartData[section]objectForKey:@"obj"] objectAtIndex:row] objectForKey:@"pet"],
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
    NTButton *btn=(NTButton *)sender;
    [self addActionWith:btn.section WithRow:btn.tag with:1];
}

- (void)addActionWith:(NSInteger)section WithRow:(NSInteger)row with:(int)num{
    [self showWaitingViewWithText:@"正在添加..."];
    __weak typeof(self) __weakself=self;
    
    NSDictionary *dic=@{@"uid":[share()userUid],
                        @"token":[share()userToken],
                        @"id":[[[_shopcartData[section]objectForKey:@"obj"] objectAtIndex:row] objectForKey:@"goodid"],
                        @"price":[[[_shopcartData[section]objectForKey:@"obj"] objectAtIndex:row] objectForKey:@"price"],
                        @"sort":[[[_shopcartData[section]objectForKey:@"obj"] objectAtIndex:row] objectForKey:@"sort"],
                        @"num":[NSNumber numberWithInt:num],
                        @"pet":[[[_shopcartData[section]objectForKey:@"obj"] objectAtIndex:row] objectForKey:@"pet"],
                        @"parameters":[[[_shopcartData[section]objectForKey:@"obj"] objectAtIndex:row] objectForKey:@"parameters"]};
    
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

- (NSMutableDictionary *)getTheSelectDic{
    NSMutableDictionary *dic=[[NSMutableDictionary alloc] init];
    int i=0;
    for (NSNumber *section in [_selectDic allKeys]) {
        for (NSNumber * row in [_selectDic objectForKey:section]) {
            NSDictionary *data=[[_shopcartData objectAtIndex:[section intValue]] objectForKey:@"obj"][row.intValue];
            NSDictionary *onedic=@{@"num":[data objectForKey:@"num"],@"id":[data objectForKey:@"goodid"],@"parameters":[data objectForKey:@"parameters"],@"sort":[data objectForKey:@"sort"],@"price":[data objectForKey:@"price"]};
            [dic setObject:onedic forKey:[NSNumber numberWithInt:i]];
            data=nil;
            onedic=nil;
            i++;
        }
    }
    return dic;
}

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
                        @"goods":[self getTheSelectDic],
                        @"typ":[NSString stringWithFormat:@"%d",_subscriptionBtn.selected]};
    
    [NTAsynService requestWithHead:subOrderBaseUR WithBody:dic completionHandler:^(BOOL success, id finishData, NSError *connectionError) {
        if (success) {
            __strong typeof(self) self=__weakself;
            [self showPayCodeViewWithImagePath:[finishData objectForKey:@"pic"]];
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

- (void)showPayCodeViewWithImagePath:(NSString *)imagePath{
    NTPayCodeView *view=[[NSBundle mainBundle]loadNibNamed:@"NTPayCodeView" owner:self options:nil][0];
    view.frame=CGRectMake(0, 0, ScreenWidth, ScreenHeight);
    view.imagePath=imagePath;
    [view showThepayCodeView];
    view.closeBlock=^(){
        [self.navigationController popViewControllerAnimated:YES];
    };
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
    [self showWaitingViewWithText:@"正在提交..."];
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
    for (NSNumber * section in [_selectDic allKeys]) {
        for (NSNumber * row in [_selectDic objectForKey:section]){
            NSDictionary *dic=[[_shopcartData[section.intValue] objectForKey:@"obj"] objectAtIndex:row.intValue];
            price +=[[dic objectForKey:@"tprice"] floatValue];
        }
    }
    return [NSString stringWithFormat:@"%f",price];
}



- (BOOL)isSelectINDataWithTag:(id)sender{
    NTButton *btn=(NTButton *)sender;
    if (!_selectDic) {
        return NO;
    }
    return [[_selectDic objectForKey:[NSNumber numberWithInteger:btn.section]] containsObject:[NSNumber numberWithInteger:btn.tag]];
}

- (void)selectSectionAction:(id)sender{
    NTButton *btn=(NTButton *)sender;
    btn.selected=!btn.selected;
    if (btn.selected) {
        if (!_selectDic) {
            _selectDic=[[NSMutableDictionary alloc] init];
        }
        NSMutableArray *ary=[[NSMutableArray alloc] init];
        for (int j=0; j<[[_shopcartData[btn.section] objectForKey:@"obj"] count];j++) {
            [ary addObject:[NSNumber numberWithInt:j]];
        }
        [_selectDic setObject:ary forKey:[NSNumber numberWithInteger :btn.section]];
        NSUInteger selectCount=[self getSelectCount];
        if (selectCount==_allDataCount) {
            _selectAllBtn.selected=YES;
            _selectBtn1.selected=YES;
            _isSelectAll=YES;
        }
    }
    else{
        if ([_selectDic objectForKey:[NSNumber numberWithInteger:btn.section]]) {
            [_selectDic removeObjectForKey:[NSNumber numberWithInteger:btn.section]];
        }
        _selectAllBtn.selected=NO;
        _selectBtn1.selected=NO;
        _isSelectAll=NO;
    }
    [self resetView];
    
    
}

- (void)selectOne:(id)sender{
    if (!_selectDic) {
        _selectDic=[[NSMutableDictionary alloc] init];
    }
    NTButton *btn=(NTButton *)sender;
    btn.selected=!btn.selected;
    if (btn.selected) {
        if ([[_selectDic allKeys] count]>0&&[[_selectDic allKeys] containsObject:[NSNumber numberWithInteger:btn.section]]) {
            NSMutableArray *ary=[[NSMutableArray alloc] initWithArray:[_selectDic objectForKey:[NSNumber numberWithInteger:btn.section]]];
            [ary addObject:[NSNumber numberWithInteger:btn.tag]];
            [_selectDic setObject:ary forKey:[NSNumber numberWithInteger:btn.section]];
        }
        else{
            NSArray *ary=@[[NSNumber numberWithInteger:btn.tag]];
            [_selectDic setObject:ary forKey:[NSNumber numberWithInteger:btn.section]];
        }
    }
    else{
        if ([[_selectDic allKeys] count]>0&&[[_selectDic allKeys] containsObject:[NSNumber numberWithInteger:btn.section]]) {
            NSMutableArray *ary=[[NSMutableArray alloc] initWithArray:[_selectDic objectForKey:[NSNumber numberWithInteger:btn.section]]];
            [ary removeObject:[NSNumber numberWithInteger:btn.tag]];
            [_selectDic setObject:ary forKey:[NSNumber numberWithInteger:btn.section]];
            
        }
        _selectAllBtn.selected=NO;
        _selectBtn1.selected=NO;
        _isSelectAll=NO;
    }
    NSUInteger selectCount=[self getSelectCount];
    if (selectCount==_allDataCount) {
        _selectAllBtn.selected=YES;
        _selectBtn1.selected=YES;
        _isSelectAll=YES;
    }
    [self resetView];
}

- (BOOL)isSelectALlSection:(NSInteger)section{
    if ([_selectDic objectForKey:[NSNumber numberWithInteger:section]]) {
        NSUInteger selectcount= [[_selectDic objectForKey:[NSNumber numberWithInteger:section]] count];
        NSUInteger allcount=[[_shopcartData[section] objectForKey:@"obj"] count];
        if (selectcount==allcount) {
            return YES;
        }
        return NO;
        
    }
    return NO;
}

-(NSUInteger)getSelectCount{
    NSArray *ary=[self getTheValuesWithKey:[_selectDic allKeys] withData:_selectDic];
    NSInteger selectCount=0;
    for (int i=0; i<ary.count; i++) {
        selectCount+=[ary[i] count];
    }
    return selectCount;
}

- (IBAction)selectAllAction:(id)sender {
    _selectAllBtn.selected=!_selectAllBtn.selected;
    _selectBtn1.selected=!_selectBtn1.selected;
    _isSelectAll=_selectBtn1.selected;
    if (!_isSelectAll) {
        [_selectDic removeAllObjects];
    }
    else{
        if (!_selectDic) {
            _selectDic=[[NSMutableDictionary alloc] init];
        }
        else
            [_selectDic removeAllObjects];
        for (int i=0; i<_shopcartData.count; i++) {
            NSMutableArray *ary=[[NSMutableArray alloc] init];
            for (int j=0; j<[[_shopcartData[i] objectForKey:@"obj"] count];j++) {
                [ary addObject:[NSNumber numberWithInt:j]];
            }
            [_selectDic setObject:ary forKey:[NSNumber numberWithInt:i]];
        }
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

- (IBAction)closeView:(id)sender {
    [self colseTheView:nil];
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

- (void)textFieldDidBeginEditing:(NTTextField *)textField{
    float heigh=0;
    for (int i=0; i<=textField.section; i++) {
        if (textField.section==i) {
            heigh+=100*(textField.tag+1);
        }
        else{
            heigh+=100*[[_shopcartData[textField.section] objectForKey:@"obj"] count];
        }
    }
     [_tableView setContentOffset:CGPointMake(0, heigh)];
    float ContentHeight=_tableView.contentSize.height;
    [_tableView setContentSize:CGSizeMake(0, ContentHeight+250)];
}

- (void)textFieldDidEndEditing:(NTTextField *)textField{
    [_tableView setContentOffset:CGPointMake(0, 0)];
    float ContentHeight=_tableView.contentSize.height;
    [_tableView setContentSize:CGSizeMake(0, ContentHeight-250)];
    textField.text=[NSString stringWithFormat:@"%d",[self changeNumWith:textField]];
}

- (BOOL)textFieldShouldReturn:(NTTextField *)textField{
    textField.text=[NSString stringWithFormat:@"%d",[self changeNumWith:textField]];
    [textField resignFirstResponder];
    return YES;
}

- (int)changeNumWith:(NTTextField *)textField{
    int value=[textField.text intValue];
    int normal= [[[[_shopcartData[textField.section] objectForKey:@"obj"] objectAtIndex:textField.tag] objectForKey:@"num"] intValue];
    if (normal<value){
        [self addActionWith:textField.section WithRow:textField.tag with:value-normal];
        return value;
    }
    else{
//        textField.text=[NSString stringWithFormat:@"%d",normal];
        return normal;
    }
    
}


#pragma mark - infoView

- (void)colseTheView:(UIPanGestureRecognizer*)paramSender{
    if (!_dateView||_dateView.hidden) {
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
