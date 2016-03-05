//
//  CLMuiscTool.h
//  Demo-MusicPlayer
//
//  Created by Aspmcll on 16/1/4.
//  Copyright © 2016年 Aspmcll. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#import "CLMusic.h"
@class CLArtist;
@class CLBoardList;


@interface CLMuiscTool : NSObject<AVAudioPlayerDelegate>


+(instancetype)musicManager;
-(NSMutableArray *)musicArray;

//本地音乐管理
+(CLMusicOnBaiDuIcon *)getCurrentMusic;
+(void)setPlayingMusci:(CLMusicOnBaiDuIcon *)musci;
+(CLMusicOnBaiDuIcon *)nextMusic:(CLMusicOnBaiDuIcon *)music;
+(CLMusicOnBaiDuIcon *)forworadMusic:(CLMusicOnBaiDuIcon *)music;
-(void)removeMusicFromLocal:(CLMusicOnBaiDuIcon *)music;



//在线音乐管理
+(CLMusicOnBaiDuIcon *)getOnlineCurrentMusic;
+(void)setOnlinePlayingMusci:(CLMusicOnBaiDuIcon *)music;
+(CLMusicOnBaiDuIcon *)nextOnlineMusic:(CLMusicOnBaiDuIcon *)music;
+(CLMusicOnBaiDuIcon *)forworadOnlineMusic:(CLMusicOnBaiDuIcon *)music;


//+(NSArray *)onlineFirstMusci:(NSArray *)arrar;
//+(NSArray *)onlineMusci:(NSArray *)array;
+(NSArray *)onlineFirstMusci:(NSDictionary *)dic;
-(NSArray *)onlineMusciByMusicID:(NSDictionary *)musicStr;

+(void)addMusicForPlit:(CLMusicOnBaiDuIcon *)music withlocation:(NSString *)location;
+(void)addMusicForLoaction:(CLMusicOnBaiDuIcon *)music withlocation:(NSString *)location;
+(void)deleteMuiscForPlist:(CLMusicOnBaiDuIcon *)music;


-(BOOL)searchMusicFromLocal:(CLMusicOnBaiDuIcon *)muisc;
+(NSString *)getLocatPath:(CLMusicOnBaiDuIcon *)muisc;

//根据传入的数组获得音乐列表
+(NSArray *)muiscList:(NSArray *)array;
-(NSArray *)muiscListForContens:(NSDictionary *)dic;

//正在下载音乐管理
-(void)addDownloadMusic:(CLMusicOnBaiDuIcon *)music;
-(CLMusicOnBaiDuIcon *)getDonloadMuisc:(NSString *)urlString;
-(void)deleteFailureMusic:(NSString *)urlString;
-(NSArray *)getAllDownloadMusic;
-(void)downloadMuisc:(CLMusicOnBaiDuIcon *)music;

//根据歌手得到其对应的歌曲

-(NSArray *)getALLArtistMessage;

-(void)getMusicByArtistAndBoardList:(CLArtist *)artist
                     andBoardList:(CLBoardList *)list andLimits:(NSInteger)num
                     andResultBlock:(void(^)(CLMusicOnBaiDuIcon *muisc))aritstBlock
                     andFirstFailer:(void(^)(id response,NSError *error ))firstFailer
                     andSecondError:(void(^)(id response, NSError *error))secondErrorr;



-(void)removeAllSearchMuisc;

///搜索本地音乐
-(void)searchLocalMusicOnPc:(NSString *)searchPath;

-(NSArray *)getRecentPlayMusic;

-(BOOL)addMusicForRecentPlay:(CLMusicOnBaiDuIcon *)music;

-(void)deleteMusicForRecentPlay:(CLMusicOnBaiDuIcon *)music;





@end
