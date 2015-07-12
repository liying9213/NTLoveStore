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
#define NTGrayColor @"#F5F5F5"


#define thePlaceholderImage [[UIImage imageNamed:@"picple.png"] stretchableImageWithLeftCapWidth:2 topCapHeight:2]

static NSString * loginBaseURL=@"http://aihunhui.kfrig.net/home/app/login";

static NSString * catalogBaseURL=@"http://aihunhui.kfrig.net/home/app/getallcat";

static NSString * listBaseURL=@"http://aihunhui.kfrig.net/home/app/getcatgod";

static NSString * detileBaseURL=@"http://aihunhui.kfrig.net/Home/App/detile";

static NSString * hotListBaseURL=@"http://aihunhui.kfrig.net/Home/App/get7";

static NSString * adBaseURL=@"http://aihunhui.kfrig.net/home/app/indeximg";

static NSString * addItemBaseURL=@"http://aihunhui.kfrig.net/Home/App/addItem";

static NSString * delItemBaseURL=@"http://aihunhui.kfrig.net/Home/App/reitem";

static NSString * shopcartBaseUR=@"http://aihunhui.kfrig.net/Home/App/get_shopcart";

static NSString * dropBaseUR=@"http://aihunhui.kfrig.net/Home/App/delItem";



#endif
