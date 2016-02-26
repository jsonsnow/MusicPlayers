//
//  CLMusicGroupTool.h
//  Demo-MusicPlayer
//
//  Created by Aspmcll on 16/1/22.
//  Copyright © 2016年 Aspmcll. All rights reserved.
//

#import <Foundation/Foundation.h>
@class CLMusicOnBaiDuIcon;

@interface CLMusicGroupTool : NSObject

+(instancetype)managerGroup;
-(NSArray *)getALLMusicGroup;
-(NSArray *)getAllRecentPlayMusic;

/// 增加音乐的时候 为音乐组也增加
-(void)addMusicFromOnceGroup:(CLMusicOnBaiDuIcon *)music;
/// 点击音乐 给最近播放中增加
-(void)addMusicFormRecentPlayArray:(CLMusicOnBaiDuIcon *)music;
///删除音乐的时候相应删除组中的音乐
-(void)deleteMusicFromOnceGroup:(CLMusicOnBaiDuIcon *)music;

@end
