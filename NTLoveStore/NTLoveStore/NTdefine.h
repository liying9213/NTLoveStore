//
//  NTdefine.h
//  NTLoveStore
//
//  Created by 李莹 on 15/6/8.
//  Copyright (c) 2015年 liying. All rights reserved.
//

#ifndef NTLoveStore_NTdefine_h
#define NTLoveStore_NTdefine_h

#define ScreenHeight [[UIScreen mainScreen] bounds].size.height
#define ScreenWidth [[UIScreen mainScreen] bounds].size.width

#define LOCAL_PATH_PUBLIC [[NSBundle mainBundle] bundlePath]

#define NTWhiteColor @"#FFFFFF"
#define NTBlueColor @"#50ceff"
#define NTPinkColor @"#FF69B4"
#define NTGrayColor @"#E3E3E3"


#define thePlaceholderImage [[UIImage imageNamed:@"picple.png"] stretchableImageWithLeftCapWidth:2 topCapHeight:2]

static NSString * loginBaseURL=@"http://aihunhui.kfrig.net/home/app/login";

static NSString * catalogBaseURL=@"http://aihunhui.kfrig.net/home/app/getallcat";

static NSString * listBaseURL=@"http://aihunhui.kfrig.net/home/app/getcatgod";

static NSString * detileBaseURL=@"http://aihunhui.kfrig.net/Home/App/detile";

static NSString * hotListBaseURL=@"http://aihunhui.kfrig.net/Home/App/get7";

static NSString * adBaseURL=@"http://aihunhui.kfrig.net/home/app/indeximg";

static NSString * addItemBaseURL=@"http://aihunhui.kfrig.net/Home/App/addItem";

static NSString * delItemBaseURL=@"http://aihunhui.kfrig.net/Home/App/reitem";

static NSString * shopcartBaseURL=@"http://aihunhui.kfrig.net/Home/App/get_shopcart";

static NSString * dropBaseURL=@"http://aihunhui.kfrig.net/Home/App/delItem";

static NSString * subOrderBaseURL=@"http://aihunhui.kfrig.net/Home/App/order";

static NSString * allOrderBaseURL=@"http://aihunhui.kfrig.net/Home/App/getorder";

static NSString * finOrderBaseURL=@"http://aihunhui.kfrig.net/Home/App/finishedorder";

static NSString * payOrderBaseURL=@"http://aihunhui.kfrig.net/Home/App/Payorder";

static NSString * outOrderBaseURL=@"http://aihunhui.kfrig.net/Home/App/outorder";

static NSString * getodBaseURL=@"http://aihunhui.kfrig.net/Home/App/getod";

static NSString * saveOrderBaseURL=@"http://aihunhui.kfrig.net/Home/App/gorder";

static NSString * finishOrderBaseURL=@"http://aihunhui.kfrig.net/Home/App/worder";

static NSString * delOrderBaseURL=@"http://aihunhui.kfrig.net/Home/App/delorder";

static NSString * comOrderBaseURL=@"http://aihunhui.kfrig.net/home/app/comment";

static NSString * getcomOrderBaseURL=@"http://aihunhui.kfrig.net/home/app/get_com";

static NSString * zixunOrderBaseURL=@"http://aihunhui.kfrig.net/home/app/zixun";

static NSString * getDateOrderBaseURL=@"http://aihunhui.kfrig.net/home/app/get_date";


#endif
