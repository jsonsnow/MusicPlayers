//
//  CLMusic.h
//  Demo-MusicPlayer
//
//  Created by Aspmcll on 16/1/4.
//  Copyright © 2016年 Aspmcll. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CLMusicOnlie : NSObject

@property (nonatomic,strong) NSString *song;
@property (nonatomic,strong) NSString *lrc;
@property (nonatomic,assign) NSNumber *artist_id;
@property (nonatomic,assign) NSNumber *sid;
@property (nonatomic,assign) NSNumber *aid;
@property (nonatomic,strong) NSString *cover;
@property (nonatomic,strong) NSString *thumb;
@property (nonatomic,strong) NSString *name;



@end

@interface CLMusicOnBaiDu : NSObject
@property (nonatomic,strong) NSString *bitrate_fee;
@property (nonatomic,strong) NSString *yyr_artist;
@property (nonatomic,strong) NSString *songname;
@property (nonatomic,strong) NSString *artistname;
@property (nonatomic,strong) NSString *control;
@property (nonatomic,strong) NSString *songid;
@property (nonatomic,strong) NSString *has_mv;
@property (nonatomic,strong) NSString *encrypted_songid;
//@property (nonatomic,strong) NSString *iconurl;

/*
"bitrate_fee": "{\"0\":\"0|0\",\"1\":\"0|0\"}",
"yyr_artist": "1",
"songname": "平凡之路",
"artistname": "新声带音乐工作室",
"control": "0000000000",
"songid": "74012204",
"has_mv": "0",
"encrypted_songid": ""
 */
@end

@interface CLMusicOnBaiDuIcon : NSObject


@property (nonatomic,strong) NSString *songPicSmall;
@property (nonatomic,strong) NSString *songPicBig;
@property (nonatomic,strong) NSString *songLink;
@property (nonatomic,strong) NSString *songName;
@property (nonatomic,strong) NSString *artistName;
@property (nonatomic,strong) NSString *lrcLink;
@property (nonatomic,strong) NSString *songId;
@property (nonatomic,getter=isDownload) BOOL download;
@property (nonatomic,getter=isSearchMusic,assign) BOOL searchMusic;
@property (nonatomic,strong) NSDate *playDate;

@end
/*
"songPicSmall": "http://musicdata.baidu.com/data2/pic/88582728/88582728.jpg",
"songPicBig": "http://musicdata.baidu.com/data2/pic/88582715/88582715.jpg",
"songPicRadio": "http://musicdata.baidu.com/data2/pic/88582707/88582707.jpg",
"lrcLink": "/data2/lrc/238975978/238975978.lrc",
"version": "",
"copyType": 1,
"time": 322,
"linkCode": 22000,
"songLink": "http://file.qianqian.com//data2/music/238976206/238976206.mp3?xcode=cb6ae7c53ef7a1fd766f476e85847328&src=\"http%3A%2F%2Fpan.baidu.com%2Fshare%2Flink%3Fshareid%3D275831144%26uk%3D1716766033\"",
 */

//@interface CLMusicOnlieCover : NSObject
//@property (nonatomic,strong) NSString *song;
//@property (nonatomic,strong) NSString *lrc;
//@property (nonatomic,strong) NSString *sid;
//@property (nonatomic,strong) NSString *aid;
//@property (nonatomic,strong) NSString *cover;
//@property (nonatomic,strong) NSString *thumb;
//@property (nonatomic,strong) NSString *name;
//
//@end


@interface CLMusicOnBaiDuList : NSObject
@property (nonatomic,strong) NSString *pic_big;
@property (nonatomic,strong) NSString *pic_small;

@end


@interface CLMusic : NSObject

@property (nonatomic,strong) NSString *name;
@property (nonatomic,strong) NSString *filename;
@property (nonatomic,strong) NSString *singer;
@property (nonatomic,strong) NSString *singerIcon;
@property (nonatomic,strong) NSString *icon;



@end
