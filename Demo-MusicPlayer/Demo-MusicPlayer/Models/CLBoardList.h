//
//  CLBoardList.h
//  Demo-MusicPlayer
//
//  Created by Aspmcll on 16/1/17.
//  Copyright © 2016年 Aspmcll. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CLBoardList : NSObject
@property (nonatomic,strong) NSString *billboard_type;
@property (nonatomic,strong) NSString *billboard_no;
@property (nonatomic,strong) NSString *update_date;
@property (nonatomic,assign) NSInteger havemore;
@property (nonatomic,strong) NSString *name;
@property (nonatomic,strong) NSString *comment;
@property (nonatomic,strong) NSString *pic_s640;
@property (nonatomic,strong) NSString *pic_s444;
@property (nonatomic,strong) NSString *pic_s260;
@property (nonatomic,strong) NSString *pic_s210;
@property (nonatomic,strong) NSString *web_url;

/*
"billboard_type": "1",
"billboard_no": "1710",
"update_date": "2016-01-16",
"havemore": 1,
"name": "新歌榜",
"comment": "该榜单是根据百度音乐平台歌曲每日播放量自动生成的数据榜单，统计范围为近期发行的歌曲，每日更新一次",
"pic_s640": "http://c.hiphotos.baidu.com/ting/pic/item/f7246b600c33874495c4d089530fd9f9d62aa0c6.jpg",
"pic_s444": "http://d.hiphotos.baidu.com/ting/pic/item/78310a55b319ebc4845c84eb8026cffc1e17169f.jpg",
"pic_s260": "http://b.hiphotos.baidu.com/ting/pic/item/e850352ac65c1038cb0f3cb0b0119313b07e894b.jpg",
"pic_s210": "http://d.hiphotos.baidu.com/ting/pic/item/c8ea15ce36d3d5393654e23b3887e950342ab0d9.jpg",
"web_url": "http://music.baidu.com/top/new" */


@end
